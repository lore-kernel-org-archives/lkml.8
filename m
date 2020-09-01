Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01AC207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgIAUc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:32:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:19557 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgIAUc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:32:58 -0400
IronPort-SDR: fuDtUW2OtaJUMR7J+WeDGyy3IjVh92yj4TK58k3qC10U1xyZnIEYSPBYcssmmLvjf3IYPNF6CZ
 rZWXKyHGtQAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221486133"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="221486133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 13:32:58 -0700
IronPort-SDR: gFe5hnRXldd7fJbFc44nwSHmVrBpVDQxPgbNR4BG7BgaaJWVkVWIwMg89IkXwFGt5CqnaBottM
 K5BiW+C33tjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="297441679"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2020 13:32:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 13:32:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 13:32:43 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Tue, 1 Sep 2020 13:32:43 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [Intel-gfx] [PATCH v9 08/32] drm: i915: fix common struct
 sg_table related issues
Thread-Topic: [Intel-gfx] [PATCH v9 08/32] drm: i915: fix common struct
 sg_table related issues
Thread-Index: AQHWe3Ml/rRJPBw9lEWMq6REwJ0ovqlUN/gwgAB5zQD//4+ngA==
Date:   Tue, 1 Sep 2020 20:32:43 +0000
Message-ID: <56ae8ce4ebe6423ea669b85d6dae8318@intel.com>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063532eucas1p2a9e0215f483104d45af0560d5dbfa8e0@eucas1p2.samsung.com>
 <20200826063316.23486-9-m.szyprowski@samsung.com>
 <259df561c4bb4ef484799e3776dbb402@intel.com>
 <1825327a-efd5-b836-d57e-d9356e279762@arm.com>
In-Reply-To: <1825327a-efd5-b836-d57e-d9356e279762@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5t
dXJwaHlAYXJtLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMSwgMjAyMCAzOjU0IFBN
DQo+VG86IFJ1aGwsIE1pY2hhZWwgSiA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPjsgTWFyZWsg
U3p5cHJvd3NraQ0KPjxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+OyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOw0KPmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW5h
cm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj5DYzogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8Yi56b2xuaWVya2llQHNhbXN1bmcu
Y29tPjsgRGF2aWQgQWlybGllDQo+PGFpcmxpZWRAbGludXguaWU+OyBpbnRlbC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBDaHJpc3RvcGggSGVsbHdpZw0KPjxoY2hAbHN0LmRlPjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogUmU6IFtJbnRlbC1nZnhd
IFtQQVRDSCB2OSAwOC8zMl0gZHJtOiBpOTE1OiBmaXggY29tbW9uIHN0cnVjdA0KPnNnX3RhYmxl
IHJlbGF0ZWQgaXNzdWVzDQo+DQo+T24gMjAyMC0wOS0wMSAyMDozOCwgUnVobCwgTWljaGFlbCBK
IHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSW50ZWwt
Z2Z4IDxpbnRlbC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBP
Zg0KPj4+IE1hcmVrIFN6eXByb3dza2kNCj4+PiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyNiwg
MjAyMCAyOjMzIEFNDQo+Pj4gVG86IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPj4+IGxpbmFyby1tbS1zaWdAbGlzdHMu
bGluYXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4+IENjOiBCYXJ0bG9t
aWVqIFpvbG5pZXJraWV3aWN6IDxiLnpvbG5pZXJraWVAc2Ftc3VuZy5jb20+OyBEYXZpZCBBaXJs
aWUNCj4+PiA8YWlybGllZEBsaW51eC5pZT47IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IFJvYmluIE11cnBoeQ0KPj4+IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPjsgbGludXgtYXJtLQ0KPj4+IGtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBNYXJlayBTenlwcm93c2tpDQo+Pj4gPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4N
Cj4+PiBTdWJqZWN0OiBbSW50ZWwtZ2Z4XSBbUEFUQ0ggdjkgMDgvMzJdIGRybTogaTkxNTogZml4
IGNvbW1vbiBzdHJ1Y3Qgc2dfdGFibGUNCj4+PiByZWxhdGVkIGlzc3Vlcw0KPj4+DQo+Pj4gVGhl
IERvY3VtZW50YXRpb24vRE1BLUFQSS1IT1dUTy50eHQgc3RhdGVzIHRoYXQgdGhlIGRtYV9tYXBf
c2coKQ0KPj4+IGZ1bmN0aW9uDQo+Pj4gcmV0dXJucyB0aGUgbnVtYmVyIG9mIHRoZSBjcmVhdGVk
IGVudHJpZXMgaW4gdGhlIERNQSBhZGRyZXNzIHNwYWNlLg0KPj4+IEhvd2V2ZXIgdGhlIHN1YnNl
cXVlbnQgY2FsbHMgdG8gdGhlIGRtYV9zeW5jX3NnX2Zvcl97ZGV2aWNlLGNwdX0oKSBhbmQNCj4+
PiBkbWFfdW5tYXBfc2cgbXVzdCBiZSBjYWxsZWQgd2l0aCB0aGUgb3JpZ2luYWwgbnVtYmVyIG9m
IHRoZSBlbnRyaWVzDQo+Pj4gcGFzc2VkIHRvIHRoZSBkbWFfbWFwX3NnKCkuDQo+Pj4NCj4+PiBz
dHJ1Y3Qgc2dfdGFibGUgaXMgYSBjb21tb24gc3RydWN0dXJlIHVzZWQgZm9yIGRlc2NyaWJpbmcg
YSBub24tY29udGlndW91cw0KPj4+IG1lbW9yeSBidWZmZXIsIHVzZWQgY29tbW9ubHkgaW4gdGhl
IERSTSBhbmQgZ3JhcGhpY3Mgc3Vic3lzdGVtcy4gSXQNCj4+PiBjb25zaXN0cyBvZiBhIHNjYXR0
ZXJsaXN0IHdpdGggbWVtb3J5IHBhZ2VzIGFuZCBETUEgYWRkcmVzc2VzIChzZ2wgZW50cnkpLA0K
Pj4+IGFzIHdlbGwgYXMgdGhlIG51bWJlciBvZiBzY2F0dGVybGlzdCBlbnRyaWVzOiBDUFUgcGFn
ZXMgKG9yaWdfbmVudHMgZW50cnkpDQo+Pj4gYW5kIERNQSBtYXBwZWQgcGFnZXMgKG5lbnRzIGVu
dHJ5KS4NCj4+Pg0KPj4+IEl0IHR1cm5lZCBvdXQgdGhhdCBpdCB3YXMgYSBjb21tb24gbWlzdGFr
ZSB0byBtaXN1c2UgbmVudHMgYW5kIG9yaWdfbmVudHMNCj4+PiBlbnRyaWVzLCBjYWxsaW5nIERN
QS1tYXBwaW5nIGZ1bmN0aW9ucyB3aXRoIGEgd3JvbmcgbnVtYmVyIG9mIGVudHJpZXMgb3INCj4+
PiBpZ25vcmluZyB0aGUgbnVtYmVyIG9mIG1hcHBlZCBlbnRyaWVzIHJldHVybmVkIGJ5IHRoZSBk
bWFfbWFwX3NnKCkNCj4+PiBmdW5jdGlvbi4NCj4+Pg0KPj4+IFRoaXMgZHJpdmVyIGNyZWF0aXZl
bHkgdXNlcyBzZ190YWJsZS0+b3JpZ19uZW50cyB0byBzdG9yZSB0aGUgc2l6ZSBvZiB0aGUNCj4+
PiBhbGxvY2F0ZWQgc2NhdHRlcmxpc3QgYW5kIGlnbm9yZXMgdGhlIG51bWJlciBvZiB0aGUgZW50
cmllcyByZXR1cm5lZCBieQ0KPj4+IGRtYV9tYXBfc2cgZnVuY3Rpb24uIFRoZSBzZ190YWJsZS0+
b3JpZ19uZW50cyBpcyAobWlzKXVzZWQgdG8gcHJvcGVybHkNCj4+PiBmcmVlIHRoZSAob3Zlcilh
bGxvY2F0ZWQgc2NhdHRlcmxpc3QuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIG9ubHkgaW50cm9kdWNl
cyB0aGUgY29tbW9uIERNQS1tYXBwaW5nIHdyYXBwZXJzIG9wZXJhdGluZw0KPj4+IGRpcmVjdGx5
IG9uIHRoZSBzdHJ1Y3Qgc2dfdGFibGUgb2JqZWN0cyB0byB0aGUgZG1hYnVmIHJlbGF0ZWQgZnVu
Y3Rpb25zLA0KPj4+IHNvIHRoZSBvdGhlciBkcml2ZXJzLCB3aGljaCBtaWdodCBzaGFyZSBidWZm
ZXJzIHdpdGggaTkxNSBjb3VsZCByZWx5IG9uDQo+Pj4gdGhlIHByb3Blcmx5IHNldCBuZW50cyBh
bmQgb3JpZ19uZW50cyB2YWx1ZXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBTenlw
cm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+Pj4gLS0tDQo+Pj4gZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jICAgICAgIHwgMTEgKysrLS0tLS0tLS0N
Cj4+PiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL21vY2tfZG1hYnVmLmMgfCAg
NyArKystLS0tDQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9p
OTE1X2dlbV9kbWFidWYuYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2Vt
X2RtYWJ1Zi5jDQo+Pj4gaW5kZXggMjY3OTM4MDE1OWZjLi44YTk4ODU5MjcxNWIgMTAwNjQ0DQo+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jDQo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jDQo+Pj4gQEAg
LTQ4LDEyICs0OCw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUNCj4qaTkxNV9nZW1fbWFwX2Rt
YV9idWYoc3RydWN0DQo+Pj4gZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2htZQ0KPj4+IAkJc3Jj
ID0gc2dfbmV4dChzcmMpOw0KPj4+IAl9DQo+Pj4NCj4+PiAtCWlmICghZG1hX21hcF9zZ19hdHRy
cyhhdHRhY2htZW50LT5kZXYsDQo+Pj4gLQkJCSAgICAgIHN0LT5zZ2wsIHN0LT5uZW50cywgZGly
LA0KPj4+IC0JCQkgICAgICBETUFfQVRUUl9TS0lQX0NQVV9TWU5DKSkgew0KPj4+IC0JCXJldCA9
IC1FTk9NRU07DQo+Pg0KPj4gWW91IGhhdmUgZHJvcHBlZCB0aGlzIGVycm9yIHZhbHVlLg0KPj4N
Cj4+IERvIHlvdSBub3cgaWYgdGhpcyBpcyBhIGJlbmlnbiBsb3NzPw0KPg0KPlRydWUsIGRtYV9t
YXBfc2d0YWJsZSgpIHdpbGwgcmV0dXJuIC1FSU5WQUwgcmF0aGVyIHRoYW4gLUVOT01FTSBmb3IN
Cj5mYWlsdXJlLiBBIHF1aWNrIGxvb2sgdGhyb3VnaCBvdGhlciAubWFwX2RtYV9idWYgY2FsbGJh
Y2tzIHN1Z2dlc3RzDQo+dGhleSdyZSByZXR1cm5pbmcgYSBtb3RsZXkgbWl4IG9mIGVycm9yIHZh
bHVlcyBhbmQgTlVMTCBmb3IgZmFpbHVyZQ0KPmNhc2VzLCBzbyBJJ2QgaW1hZ2luZSB0aGF0IGlt
cG9ydGVycyBzaG91bGRuJ3QgYmUgdG9vIHNlbnNpdGl2ZSB0byB0aGUNCj5leGFjdCB2YWx1ZS4N
Cg0KSSBmb2xsb3dlZCBzb21lIG9mIG91ciBjb2RlIHRocm91Z2ggdG8gc2VlIGlmIGFueW9uZSBp
cyBjaGVja2luZyBmb3IgLUVOT01FTS4uLg0KDQpJIGhhdmUgZm91bmQgaW4gc29tZSB0ZXN0IHBh
dGhzLi4uIEhvd2V2ZXIsIGl0IGlzIG5vdCBjbGVhciB0byBtZSBpZiB3ZSBjYW4gZ2V0DQp0byB0
aG9zZSBwYXRocyBmcm9tIGhlcmUuDQoNCkFueXdheXMsDQoNClJldmlld2VkLWJ5OiBNaWNoYWVs
IEouIFJ1aGwgPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4NCg0KTWlrZQ0KDQo+Um9iaW4uDQo+
DQo+Pg0KPj4gTQ0KPj4NCj4+PiArCXJldCA9IGRtYV9tYXBfc2d0YWJsZShhdHRhY2htZW50LT5k
ZXYsIHN0LCBkaXIsDQo+Pj4gRE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7DQo+Pj4gKwlpZiAocmV0
KQ0KPj4+IAkJZ290byBlcnJfZnJlZV9zZzsNCj4+PiAtCX0NCj4+Pg0KPj4+IAlyZXR1cm4gc3Q7
DQo+Pj4NCj4+PiBAQCAtNzMsOSArNzAsNyBAQCBzdGF0aWMgdm9pZCBpOTE1X2dlbV91bm1hcF9k
bWFfYnVmKHN0cnVjdA0KPj4+IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNobWVudCwNCj4+PiB7
DQo+Pj4gCXN0cnVjdCBkcm1faTkxNV9nZW1fb2JqZWN0ICpvYmogPSBkbWFfYnVmX3RvX29iaihh
dHRhY2htZW50LQ0KPj4+PiBkbWFidWYpOw0KPj4+DQo+Pj4gLQlkbWFfdW5tYXBfc2dfYXR0cnMo
YXR0YWNobWVudC0+ZGV2LA0KPj4+IC0JCQkgICBzZy0+c2dsLCBzZy0+bmVudHMsIGRpciwNCj4+
PiAtCQkJICAgRE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7DQo+Pj4gKwlkbWFfdW5tYXBfc2d0YWJs
ZShhdHRhY2htZW50LT5kZXYsIHNnLCBkaXIsDQo+Pj4gRE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7
DQo+Pj4gCXNnX2ZyZWVfdGFibGUoc2cpOw0KPj4+IAlrZnJlZShzZyk7DQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9tb2NrX2RtYWJ1Zi5j
DQo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL21vY2tfZG1hYnVmLmMN
Cj4+PiBpbmRleCBkZWJhZjdiMThhYjUuLmJlMzBiMjdlMjkyNiAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL21vY2tfZG1hYnVmLmMNCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL21vY2tfZG1hYnVmLmMNCj4+PiBA
QCAtMjgsMTAgKzI4LDkgQEAgc3RhdGljIHN0cnVjdCBzZ190YWJsZSAqbW9ja19tYXBfZG1hX2J1
ZihzdHJ1Y3QNCj4+PiBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFjaG1lbnQsDQo+Pj4gCQlzZyA9
IHNnX25leHQoc2cpOw0KPj4+IAl9DQo+Pj4NCj4+PiAtCWlmICghZG1hX21hcF9zZyhhdHRhY2ht
ZW50LT5kZXYsIHN0LT5zZ2wsIHN0LT5uZW50cywgZGlyKSkgew0KPj4+IC0JCWVyciA9IC1FTk9N
RU07DQo+Pj4gKwllcnIgPSBkbWFfbWFwX3NndGFibGUoYXR0YWNobWVudC0+ZGV2LCBzdCwgZGly
LCAwKTsNCj4+PiArCWlmIChlcnIpDQo+Pj4gCQlnb3RvIGVycl9zdDsNCj4+PiAtCX0NCj4+Pg0K
Pj4+IAlyZXR1cm4gc3Q7DQo+Pj4NCj4+PiBAQCAtNDYsNyArNDUsNyBAQCBzdGF0aWMgdm9pZCBt
b2NrX3VubWFwX2RtYV9idWYoc3RydWN0DQo+Pj4gZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2ht
ZW50LA0KPj4+IAkJCSAgICAgICBzdHJ1Y3Qgc2dfdGFibGUgKnN0LA0KPj4+IAkJCSAgICAgICBl
bnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIpDQo+Pj4gew0KPj4+IC0JZG1hX3VubWFwX3NnKGF0
dGFjaG1lbnQtPmRldiwgc3QtPnNnbCwgc3QtPm5lbnRzLCBkaXIpOw0KPj4+ICsJZG1hX3VubWFw
X3NndGFibGUoYXR0YWNobWVudC0+ZGV2LCBzdCwgZGlyLCAwKTsNCj4+PiAJc2dfZnJlZV90YWJs
ZShzdCk7DQo+Pj4gCWtmcmVlKHN0KTsNCj4+PiB9DQo+Pj4gLS0NCj4+PiAyLjE3LjENCj4+Pg0K
Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+Pj4g
SW50ZWwtZ2Z4IG1haWxpbmcgbGlzdA0KPj4+IEludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lu
dGVsLWdmeA0K
