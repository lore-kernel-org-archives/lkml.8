Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1728F22BED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgGNT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:57:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:1672 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGNT5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:57:55 -0400
IronPort-SDR: Vcs2KtrI8/vCeP5MBy+yI6L8pqpUmCIocSjpmOfbKZhvNZIqQFbsyDeBiwEdx6Q5U3325JIk4z
 1yCcjE/KgYfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="146527842"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="146527842"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:57:54 -0700
IronPort-SDR: vgJEtswW57bMM9d6eV3f7gTpEkb2BRG+DouUyWMEbshmio6JShLrV6B3l49Pxkqbw4zr/HKk4N
 gtAB7HM0I5Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="485996588"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 12:57:54 -0700
Received: from hasmsx601.ger.corp.intel.com (10.184.107.141) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 12:57:53 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX601.ger.corp.intel.com (10.184.107.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jul 2020 22:57:51 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 14 Jul 2020 22:57:51 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] mei: Avoid the use of one-element arrays
Thread-Topic: [PATCH][next] mei: Avoid the use of one-element arrays
Thread-Index: AQHWWgYBVMvTEO76bk+MJBte9XQfr6kHWu4Q///SZ4CAAE7REA==
Date:   Tue, 14 Jul 2020 19:57:51 +0000
Message-ID: <32f85e185c2244a19a1705d0db315c69@intel.com>
References: <20200714174644.GA30158@embeddedor>
 <fe3b8d4a4eb04ead83ffcefe12fd218e@intel.com>
 <20200714180855.GA31158@embeddedor>
In-Reply-To: <20200714180855.GA31158@embeddedor>
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

PiANCj4gT24gVHVlLCBKdWwgMTQsIDIwMjAgYXQgMDU6NTQ6MzJQTSArMDAwMCwgV2lua2xlciwg
VG9tYXMgd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhlcmUgaXMgYSByZWd1bGFyIG5lZWQgaW4gdGhl
IGtlcm5lbCB0byBwcm92aWRlIGEgd2F5IHRvIGRlY2xhcmUNCj4gPiA+IGhhdmluZyBhIGR5bmFt
aWNhbGx5IHNpemVkIHNldCBvZiB0cmFpbGluZyBlbGVtZW50cyBpbiBhIHN0cnVjdHVyZS4NCj4g
PiA+IEtlcm5lbCBjb2RlIHNob3VsZCBhbHdheXMgdXNlIOKAnGZsZXhpYmxlIGFycmF5IG1lbWJl
cnPigJ1bMV0gZm9yIHRoZXNlDQo+ID4gPiBjYXNlcyBvciwgYXMgaW4gdGhpcyBwYXJ0aWN1bGFy
IGNhc2UsIHJlcGxhY2UgdGhlIG9uZS1lbGVtZW50IGFycmF5DQo+ID4gPiB3aXRoIGEgc2ltcGxl
IHZhbHVlIHR5cGUgdTggcmVzZXJ2ZWQgb25jZSB0aGlzIGlzIGp1c3QgYSBwbGFjZWhvbGRlcg0K
PiA+ID4gZm9yIGFsaWdubWVudC4gVGhlIG9sZGVyIHN0eWxlIG9mIG9uZS1lbGVtZW50IG9yIHpl
cm8tbGVuZ3RoIGFycmF5cw0KPiBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWRbMl0uDQo+ID4gPg0K
PiA+ID4gQWxzbywgd2hpbGUgdGhlcmUsIHVzZSB0aGUgcHJlZmVycmVkIGZvcm0gZm9yIHBhc3Np
bmcgYSBzaXplIG9mIGEgc3RydWN0Lg0KPiA+ID4gVGhlIGFsdGVybmF0aXZlIGZvcm0gd2hlcmUg
c3RydWN0IG5hbWUgaXMgc3BlbGxlZCBvdXQgaHVydHMNCj4gPiA+IHJlYWRhYmlsaXR5IGFuZCBp
bnRyb2R1Y2VzIGFuIG9wcG9ydHVuaXR5IGZvciBhIGJ1ZyB3aGVuIHRoZQ0KPiA+ID4gdmFyaWFi
bGUgdHlwZSBpcyBjaGFuZ2VkIGJ1dCB0aGUgY29ycmVzcG9uZGluZyBzaXplb2YgdGhhdCBpcyBw
YXNzZWQgYXMNCj4gYXJndW1lbnQgaXMgbm90Lg0KPiA+ID4NCj4gPiA+IFsxXSBodHRwczovL2Vu
Lndpa2lwZWRpYS5vcmcvd2lraS9GbGV4aWJsZV9hcnJheV9tZW1iZXINCj4gPiA+IFsyXSBodHRw
czovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNzkNCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+ID4g
SSdtIG9rYXkgd2l0aCB0aGUgcGF0Y2ggYnV0IGluIHRoaXMgY2FzZSB0aGUgZGVzY3JpcHRpb24g
aXMgYSBiaXQgb2ZmLg0KPiA+IEluIHRoaXMgY2FzZSB0aGVyZSB3YXMgbm8gaW50ZW50aW9uIGZv
ciBhIGZsZXhpYmxlIGFycmF5cyBpdHMganVzdCBhIHJlc2VydmVkDQo+IGZpZWxkLg0KPiA+DQo+
IA0KPiBUaGUgcmVzZXJ2ZWQgZmllbGQgaXMgYWN0dWFsbHkgbWVudGlvbmVkIGluIHRoZSBkZXNj
cmlwdGlvbjoNCj4gDQo+ICIuLi4gb3IsIGFzIGluIHRoaXMgcGFydGljdWxhciBjYXNlLCByZXBs
YWNlIHRoZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGEgc2ltcGxlDQo+IHZhbHVlIHR5cGUgdTgg
cmVzZXJ2ZWQgb25jZSB0aGlzIGlzIGp1c3QgYSBwbGFjZWhvbGRlciBmb3IgYWxpZ25tZW50LiIN
Cg0KUmlnaHQsIGJ1dCBpdCBsb29rcyBub3QgY29ubmVjdGVkIHRvIG92ZXJhbGwgY29udGV4dCwg
aXQgbG9va3MgbGlrZSBub3QgdmVyeSBjbGVhbiByZXVzZSBvZiBhIGNvbW1pdCBtZXNzYWdlLg0K
SSB3b3VsZCBzYXkgdGhhdCB0aGlzIHJlc2VydmVkWzFdIHJhdGhlciBoYWQgY29uZnVzZWQgdGhl
IGRldGVjdGlvbiBzY3JpcHRzIHlvdSBhcmUgdXNpbmcgZm9yIHRoZSAgY2xlYW51cCB5b3UgYXJl
IGRvaW5nLiANCkFnYWluLCBJJ20gb2theSB3aXRoIHRoZSBwYXRjaCwgYnV0IGlmIHlvdSBjYW4g
IHJld29yZCB0aGUgY29tbWl0IG1lc3NhZ2UgaXQgd291bGQgYmUgZXZlbiBtb3JlIG9rYXkuDQoN
Cj4gDQo+IFRoYW5rcw0KPiAtLQ0KPiBHdXN0YXZvDQo+IA0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9taXNjL21laS9oYm0uYyB8IDQgKystLQ0KPiA+ID4gIGRyaXZlcnMvbWlzYy9tZWkvaHcu
aCAgfCA2ICsrKy0tLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVp
L2hibS5jIGIvZHJpdmVycy9taXNjL21laS9oYm0uYyBpbmRleA0KPiA+ID4gYTQ0MDk0Y2RiYzM2
Li5mMDIwZDU1OTQxNTQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2hibS5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2hibS5jDQo+ID4gPiBAQCAtNDA4LDE0ICs0
MDgsMTQgQEAgc3RhdGljIGludCBtZWlfaGJtX2FkZF9jbF9yZXNwKHN0cnVjdA0KPiA+ID4gbWVp
X2RldmljZSAqZGV2LCB1OCBhZGRyLCB1OCBzdGF0dXMpICB7DQo+ID4gPiAgCXN0cnVjdCBtZWlf
bXNnX2hkciBtZWlfaGRyOw0KPiA+ID4gIAlzdHJ1Y3QgaGJtX2FkZF9jbGllbnRfcmVzcG9uc2Ug
cmVzcDsNCj4gPiA+IC0JY29uc3Qgc2l6ZV90IGxlbiA9IHNpemVvZihzdHJ1Y3QgaGJtX2FkZF9j
bGllbnRfcmVzcG9uc2UpOw0KPiA+ID4gKwljb25zdCBzaXplX3QgbGVuID0gc2l6ZW9mKHJlc3Ap
Ow0KPiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4NCj4gPiA+ICAJZGV2X2RiZyhkZXYtPmRldiwgImFk
ZGluZyBjbGllbnQgcmVzcG9uc2VcbiIpOw0KPiA+ID4NCj4gPiA+ICAJbWVpX2hibV9oZHIoJm1l
aV9oZHIsIGxlbik7DQo+ID4gPg0KPiA+ID4gLQltZW1zZXQoJnJlc3AsIDAsIHNpemVvZihzdHJ1
Y3QgaGJtX2FkZF9jbGllbnRfcmVzcG9uc2UpKTsNCj4gPiA+ICsJbWVtc2V0KCZyZXNwLCAwLCBs
ZW4pOw0KPiA+ID4gIAlyZXNwLmhibV9jbWQgPSBNRUlfSEJNX0FERF9DTElFTlRfUkVTX0NNRDsN
Cj4gPiA+ICAJcmVzcC5tZV9hZGRyID0gYWRkcjsNCj4gPiA+ICAJcmVzcC5zdGF0dXMgID0gc3Rh
dHVzOw0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaHcuaCBiL2RyaXZlcnMv
bWlzYy9tZWkvaHcuaCBpbmRleA0KPiA+ID4gYjFhOGQ1ZWM4OGIzLi44YzAyOTdmMGU3ZjMgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2h3LmgNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvbWlzYy9tZWkvaHcuaA0KPiA+ID4gQEAgLTM0NiwxMyArMzQ2LDEzIEBAIHN0cnVjdCBoYm1f
YWRkX2NsaWVudF9yZXF1ZXN0IHsNCj4gPiA+ICAgKiBAaGJtX2NtZDogYnVzIG1lc3NhZ2UgY29t
bWFuZCBoZWFkZXINCj4gPiA+ICAgKiBAbWVfYWRkcjogYWRkcmVzcyBvZiB0aGUgY2xpZW50IGlu
IE1FDQo+ID4gPiAgICogQHN0YXR1czogaWYgSEJNU19TVUNDRVNTIHRoZW4gdGhlIGNsaWVudCBj
YW4gbm93IGFjY2VwdA0KPiBjb25uZWN0aW9ucy4NCj4gPiA+IC0gKiBAcmVzZXJ2ZWQ6IHJlc2Vy
dmVkDQo+ID4gPiArICogQHJlc2VydmVkOiByZXNlcnZlZCBmb3IgYWxpZ25tZW50Lg0KPiA+ID4g
ICAqLw0KPiA+ID4gIHN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNwb25zZSB7DQo+ID4gPiAgCXU4
IGhibV9jbWQ7DQo+ID4gPiAgCXU4IG1lX2FkZHI7DQo+ID4gPiAgCXU4IHN0YXR1czsNCj4gPiA+
IC0JdTggcmVzZXJ2ZWRbMV07DQo+ID4gPiArCXU4IHJlc2VydmVkOw0KPiA+ID4gIH0gX19wYWNr
ZWQ7DQo+ID4gPg0KPiA+ID4gIC8qKg0KPiA+ID4gQEAgLTQ2MSw3ICs0NjEsNyBAQCBzdHJ1Y3Qg
aGJtX25vdGlmaWNhdGlvbiB7DQo+ID4gPiAgCXU4IGhibV9jbWQ7DQo+ID4gPiAgCXU4IG1lX2Fk
ZHI7DQo+ID4gPiAgCXU4IGhvc3RfYWRkcjsNCj4gPiA+IC0JdTggcmVzZXJ2ZWRbMV07DQo+ID4g
PiArCXU4IHJlc2VydmVkOw0KPiA+ID4gIH0gX19wYWNrZWQ7DQo+ID4gPg0KPiA+ID4gIC8qKg0K
PiA+ID4gLS0NCj4gPiA+IDIuMjcuMA0KPiA+DQo=
