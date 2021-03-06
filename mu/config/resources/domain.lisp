(in-package :mu-cl-resources)

(define-resource catalog ()
  :class (s-prefix "dcat:Catalog")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description"))
                (:issued :string ,(s-prefix "dct:issued"))
                (:modified :string ,(s-prefix "dct:modified"))
                (:language :string ,(s-prefix "dct:language"))
                (:license :string ,(s-prefix "dct:license"))
                (:rights :string ,(s-prefix "dct:rights"))
                (:spatial :string ,(s-prefix "dct:spatial"))
                (:homepage :string ,(s-prefix "foaf:homepage")))
  :has-one `((publisher :via ,(s-prefix "dct:publisher")
                        :as "publisher")
             (concept-scheme :via ,(s-prefix "dcat:themeTaxonomy")
                             :as "theme-taxonomy")
             (catalog-record :via ,(s-prefix "dcat:record")
                             :as "record"))
  :has-many `((dataset :via ,(s-prefix "dcat:dataset")
                       :as "datasets"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/catalogs/")
  :on-path "catalogs")

(define-resource dataset ()
  :class (s-prefix "dcat:Dataset")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description"))
                (:issued :string ,(s-prefix "dct:issued"))
                (:modified :string ,(s-prefix "dct:modified"))
                (:identifier :string ,(s-prefix "dct:identifier"))
                (:keyword :string ,(s-prefix "dct:keyword"))
                (:language :string ,(s-prefix "dct:language"))
                (:contact-point :string ,(s-prefix "dct:contactPoint"))
                (:temporal :string ,(s-prefix "dct:temporal"))
                (:accrual-periodicity :string ,(s-prefix "dct:accrualPeriodicity"))
                (:landing-page :string ,(s-prefix "dcat:landingPage")))
  :has-one `((publisher :via ,(s-prefix "dct:publisher")
                        :as "publisher")
             (catalog :via ,(s-prefix "dcat:dataset")
                      :inverse t
                      :as "catalog")
             (catalog-record :via ,(s-prefix "foaf:primaryTopic")
                             :inverse t
                             :as "primary-topic"))
  :has-many `((concept :via ,(s-prefix "dcat:theme")
                       :as "themes")
              (distribution :via ,(s-prefix "dcat:distribution")
                            :as "distributions"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/datasets/")
  :on-path "datasets")

(define-resource distribution ()
  :class (s-prefix "dcat:Distribution")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description"))
                (:issued :string ,(s-prefix "dct:issued"))
                (:modified :string ,(s-prefix "dct:modified"))
                (:license :string ,(s-prefix "dct:license"))
                (:rights :string ,(s-prefix "dct:rights"))
                (:access-url :string ,(s-prefix "dcat:accessURL"))
                (:download-url :string ,(s-prefix "dcat:downloadURL"))
                (:media-type :string ,(s-prefix "dcat:mediaType"))
                (:byte-size :string ,(s-prefix "dcat:byteSize")))
  :has-one `((dataset :via ,(s-prefix "dcat:distribution")
                      :inverse t
                      :as "dataset")
             (format :via ,(s-prefix "dct:format")
                     :as "format"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/distributions/")
  :on-path "distributions")

(define-resource catalog-record ()
  :class (s-prefix "dcat:CatalogRecord")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description"))
                (:issued :string ,(s-prefix "dct:issued"))
                (:modified :string ,(s-prefix "dct:modified")))
  :has-one `((catalog :via ,(s-prefix "dcat:record")
                      :inverse t
                      :as "catalog")
             (dataset :via ,(s-prefix "foaf:primaryTopic")
                      :as "primary-topic"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/catalog-records/")
  :on-path "catalog-records")

(define-resource concept ()
  :class (s-prefix "skos:Concept")
  :has-many `((dataset :via ,(s-prefix "dcat:theme")
                       :inverse t
                       :as "datasets"))
  :has-one `((concept-scheme :via ,(s-prefix "skos:inScheme")
                             :as "concept-scheme"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/concepts/")
  :on-path "concepts")

(define-resource concept-scheme ()
  :class (s-prefix "skos:ConceptScheme")
  :resource-base (s-url "http://webcat.tmp.tenforce.com/concept-schemes/")
  :has-many `((catalog :via ,(s-prefix "dcat:themeTaxonomy")
                       :inverse t
                       :as "catalogs")
              (concept :via ,(s-prefix "skos:inScheme")
                       :inverse t
                       :as "concepts"))
  :on-path "concept-schemes")

(define-resource agent ()
  :class (s-prefix "foaf:Agent")
  :has-many `((catalog :via ,(s-prefix "dct:publisher")
                       :inverse t
                       :as "catalogs")
              (dataset :via ,(s-prefix "dct:publisher")
                       :inverse t
                       :as "datasets"))
  :resource-base (s-url "http://webcat.tmp.tenforce.com/agents/")
  :on-path "agents")

(define-resource format ()
  :class (s-prefix "dct:MediaTypeOrExtent")
  :properties `((:name :string ,(s-prefix "rdfs:label")))
  :has-many `((distributions :via ,(s-prefix "dct:format")
                             :inverse t
                             :as "distributions"))
  :on-path "formats")
