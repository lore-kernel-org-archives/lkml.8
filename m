Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC89C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A620717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgGVTEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:04:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:58053 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVTEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:04:30 -0400
IronPort-SDR: 2RnBpeiNIZ63eHWWlaBIS25rwaFMwtZqDly+b8rjiuD21GXyoDCypcYka0yOmT4IIWF8GEurW4
 bEZmC8Wj9apA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="150382574"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="150382574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:04:28 -0700
IronPort-SDR: uk7n41y5v5wh//cwlohMzEkS9y4emRfmX4PTtOWL9d7oXw4qEbhk/ZvVYJOtyYylpIquDG55CW
 e/BQ3FxG3AOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="488557438"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jul 2020 12:04:28 -0700
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jul 2020 12:04:28 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Jul 2020 22:04:25 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 22 Jul 2020 22:04:25 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mei: Avoid the use of one-element arrays
Thread-Topic: [PATCH v2] mei: Avoid the use of one-element arrays
Thread-Index: AQHWWidOxN4pAYMiq02OyqLfgDEhOKkTxNMAgAA6qQA=
Date:   Wed, 22 Jul 2020 19:04:25 +0000
Message-ID: <3cac21c8798b48bdb412a5504126489f@intel.com>
References: <20200714214516.GA1040@embeddedor>
 <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
In-Reply-To: <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBGcmllbmRseSBwaW5nOiB3aG8gY2FuIHRha2UgdGhpcz8g
OikNCj4gDQo+IFRoYW5rcw0KPiAtLQ0KPiBHdXN0YXZvDQo+IA0KPiBPbiA3LzE0LzIwIDE2OjQ1
LCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPiA+IE9uZS1lbGVtZW50IGFycmF5cyBhcmUg
YmVpbmcgZGVwcmVjYXRlZFsxXS4gUmVwbGFjZSB0aGUgb25lLWVsZW1lbnQNCj4gPiBhcnJheXMg
d2l0aCBhIHNpbXBsZSB2YWx1ZSB0eXBlIHU4IHJlc2VydmVkLCBvbmNlIHRoaXMgaXMganVzdCBh
DQo+ID4gcGxhY2Vob2xkZXIgZm9yIGFsaWdubWVudC4NCj4gPg0KPiA+IEFsc28sIHdoaWxlIHRo
ZXJlLCB1c2UgdGhlIHByZWZlcnJlZCBmb3JtIGZvciBwYXNzaW5nIGEgc2l6ZSBvZiBhIHN0cnVj
dC4NCj4gPiBUaGUgYWx0ZXJuYXRpdmUgZm9ybSB3aGVyZSBzdHJ1Y3QgbmFtZSBpcyBzcGVsbGVk
IG91dCBodXJ0cw0KPiA+IHJlYWRhYmlsaXR5IGFuZCBpbnRyb2R1Y2VzIGFuIG9wcG9ydHVuaXR5
IGZvciBhIGJ1ZyB3aGVuIHRoZSB2YXJpYWJsZQ0KPiA+IHR5cGUgaXMgY2hhbmdlZCBidXQgdGhl
IGNvcnJlc3BvbmRpbmcgc2l6ZW9mIHRoYXQgaXMgcGFzc2VkIGFzIGFyZ3VtZW50IGlzDQo+IG5v
dC4NCj4gPg0KPiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNzkN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNA
a2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ICAtIFVzZSBhIG1v
cmUgY29uY2lzZSBjaGFuZ2Vsb2cgdGV4dC4NCj4gPg0KPiA+ICBkcml2ZXJzL21pc2MvbWVpL2hi
bS5jIHwgNCArKy0tDQo+ID4gIGRyaXZlcnMvbWlzYy9tZWkvaHcuaCAgfCA2ICsrKy0tLQ0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2hibS5jIGIvZHJpdmVycy9taXNjL21l
aS9oYm0uYyBpbmRleA0KPiA+IGE0NDA5NGNkYmMzNi4uZjAyMGQ1NTk0MTU0IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGJtLmMNCj4gPiArKysgYi9kcml2ZXJzL21pc2MvbWVp
L2hibS5jDQo+ID4gQEAgLTQwOCwxNCArNDA4LDE0IEBAIHN0YXRpYyBpbnQgbWVpX2hibV9hZGRf
Y2xfcmVzcChzdHJ1Y3QgbWVpX2RldmljZQ0KPiA+ICpkZXYsIHU4IGFkZHIsIHU4IHN0YXR1cykg
IHsNCj4gPiAgCXN0cnVjdCBtZWlfbXNnX2hkciBtZWlfaGRyOw0KPiA+ICAJc3RydWN0IGhibV9h
ZGRfY2xpZW50X3Jlc3BvbnNlIHJlc3A7DQo+ID4gLQljb25zdCBzaXplX3QgbGVuID0gc2l6ZW9m
KHN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNwb25zZSk7DQo+ID4gKwljb25zdCBzaXplX3QgbGVu
ID0gc2l6ZW9mKHJlc3ApOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICAJZGV2X2RiZyhkZXYt
PmRldiwgImFkZGluZyBjbGllbnQgcmVzcG9uc2VcbiIpOw0KPiA+DQo+ID4gIAltZWlfaGJtX2hk
cigmbWVpX2hkciwgbGVuKTsNCj4gPg0KPiA+IC0JbWVtc2V0KCZyZXNwLCAwLCBzaXplb2Yoc3Ry
dWN0IGhibV9hZGRfY2xpZW50X3Jlc3BvbnNlKSk7DQo+ID4gKwltZW1zZXQoJnJlc3AsIDAsIGxl
bik7DQo+ID4gIAlyZXNwLmhibV9jbWQgPSBNRUlfSEJNX0FERF9DTElFTlRfUkVTX0NNRDsNCj4g
PiAgCXJlc3AubWVfYWRkciA9IGFkZHI7DQo+ID4gIAlyZXNwLnN0YXR1cyAgPSBzdGF0dXM7DQoN
ClRoaXMgc2hvdWxkIGJlIHByb2JhYmx5IGluIGEgZGlmZmVyZW50IHBhdGNoIGl0J3Mgbm90IHJl
bGF0ZWQgdG8gdGhlIHNlY29uZCBwYXJ0Lg0KDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlz
Yy9tZWkvaHcuaCBiL2RyaXZlcnMvbWlzYy9tZWkvaHcuaCBpbmRleA0KPiA+IGIxYThkNWVjODhi
My4uOGMwMjk3ZjBlN2YzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaHcuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaHcuaA0KSSBoYXZlIHNlY29uZCB0aG91Z2h0cyBv
ZiB0aGlzIHBhcnQgYXMgYWxsIHJlc2VydmVkIGZpZWxkcyBpbiB0aGlzIGZpbGUgYXJlIG9mIGZv
cm0gdTggcmVzZXJ2ZWRbWF0sIA0Kc28gd2Ugd2lsbCBsb3NlIHRoYXQgdW5pZm9ybWl0eSB3aXRo
IHRoaXMgY2hhbmdlLCB5b3UgaGF2ZSB0byBsb29rIGF0IHRoZSBmaWxlIGFzIHdob2xlDQpub3Qg
anVzdCBhdCB0aGUgcGF0Y2guICBTbyBJIHByZWZlciB3ZSBkcm9wIHRoYXQgcGFydCBvZiB0aGUg
cGF0Y2guIA0KDQo+ID4gQEAgLTM0NiwxMyArMzQ2LDEzIEBAIHN0cnVjdCBoYm1fYWRkX2NsaWVu
dF9yZXF1ZXN0IHsNCj4gPiAgICogQGhibV9jbWQ6IGJ1cyBtZXNzYWdlIGNvbW1hbmQgaGVhZGVy
DQo+ID4gICAqIEBtZV9hZGRyOiBhZGRyZXNzIG9mIHRoZSBjbGllbnQgaW4gTUUNCj4gPiAgICog
QHN0YXR1czogaWYgSEJNU19TVUNDRVNTIHRoZW4gdGhlIGNsaWVudCBjYW4gbm93IGFjY2VwdCBj
b25uZWN0aW9ucy4NCj4gPiAtICogQHJlc2VydmVkOiByZXNlcnZlZA0KPiA+ICsgKiBAcmVzZXJ2
ZWQ6IHJlc2VydmVkIGZvciBhbGlnbm1lbnQuDQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgaGJtX2Fk
ZF9jbGllbnRfcmVzcG9uc2Ugew0KPiA+ICAJdTggaGJtX2NtZDsNCj4gPiAgCXU4IG1lX2FkZHI7
DQo+ID4gIAl1OCBzdGF0dXM7DQo+ID4gLQl1OCByZXNlcnZlZFsxXTsNCj4gPiArCXU4IHJlc2Vy
dmVkOw0KPiA+ICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC00NjEsNyArNDYx
LDcgQEAgc3RydWN0IGhibV9ub3RpZmljYXRpb24gew0KPiA+ICAJdTggaGJtX2NtZDsNCj4gPiAg
CXU4IG1lX2FkZHI7DQo+ID4gIAl1OCBob3N0X2FkZHI7DQo+ID4gLQl1OCByZXNlcnZlZFsxXTsN
Cj4gPiArCXU4IHJlc2VydmVkOw0KPiA+ICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gIC8qKg0KPiA+
DQo=
