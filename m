Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB481C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950C42086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbgGVWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:40:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:6667 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgGVWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:40:09 -0400
IronPort-SDR: zzPEE8sM5bIWwcq/IpHOL1JpgfrOfQmsUukG0oaewqxJGC/pjCgztcWVuZcDsH5gHYiP6juIW0
 7IAU4eCj0dmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="130507861"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="130507861"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 15:40:08 -0700
IronPort-SDR: +ln7UjrmUKdtuFRJC/pq0DsbH8SdOOHBbsVqQlRd/UdpQgpIWFSKF6BXWfihPRduUiW2aG4TEL
 JzZAoV68vbaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="284375256"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2020 15:40:08 -0700
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jul 2020 15:40:07 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jul 2020 01:40:05 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 23 Jul 2020 01:40:05 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH v2] mei: Avoid the use of one-element arrays
Thread-Topic: [PATCH v2] mei: Avoid the use of one-element arrays
Thread-Index: AQHWWidOxN4pAYMiq02OyqLfgDEhOKkTxNMAgAA6qQD//9a8AIAAX8xA
Date:   Wed, 22 Jul 2020 22:40:05 +0000
Message-ID: <071940a8c76c4652b4fd58195719c471@intel.com>
References: <20200714214516.GA1040@embeddedor>
 <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
 <3cac21c8798b48bdb412a5504126489f@intel.com>
 <b79bbb51-50e4-6437-b485-eaecdb3fa18e@embeddedor.com>
In-Reply-To: <b79bbb51-50e4-6437-b485-eaecdb3fa18e@embeddedor.com>
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

PiANCj4gSGkgVG9tYXMsDQo+IA0KPiBQbGVhc2UsIHNlZSBteSBjb21tZW50cyBiZWxvdy4uLg0K
PiANCj4gT24gNy8yMi8yMCAxNDowNCwgV2lua2xlciwgVG9tYXMgd3JvdGU6DQo+ID4NCj4gPj4N
Cj4gPj4gSGkgYWxsLA0KPiA+Pg0KPiA+PiBGcmllbmRseSBwaW5nOiB3aG8gY2FuIHRha2UgdGhp
cz8gOikNCj4gPj4NCj4gPj4gVGhhbmtzDQo+ID4+IC0tDQo+ID4+IEd1c3Rhdm8NCj4gPj4NCj4g
Pj4gT24gNy8xNC8yMCAxNjo0NSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gPj4+IE9u
ZS1lbGVtZW50IGFycmF5cyBhcmUgYmVpbmcgZGVwcmVjYXRlZFsxXS4gUmVwbGFjZSB0aGUgb25l
LWVsZW1lbnQNCj4gPj4+IGFycmF5cyB3aXRoIGEgc2ltcGxlIHZhbHVlIHR5cGUgdTggcmVzZXJ2
ZWQsIG9uY2UgdGhpcyBpcyBqdXN0IGENCj4gPj4+IHBsYWNlaG9sZGVyIGZvciBhbGlnbm1lbnQu
DQo+ID4+Pg0KPiA+Pj4gQWxzbywgd2hpbGUgdGhlcmUsIHVzZSB0aGUgcHJlZmVycmVkIGZvcm0g
Zm9yIHBhc3NpbmcgYSBzaXplIG9mIGEgc3RydWN0Lg0KPiA+Pj4gVGhlIGFsdGVybmF0aXZlIGZv
cm0gd2hlcmUgc3RydWN0IG5hbWUgaXMgc3BlbGxlZCBvdXQgaHVydHMNCj4gPj4+IHJlYWRhYmls
aXR5IGFuZCBpbnRyb2R1Y2VzIGFuIG9wcG9ydHVuaXR5IGZvciBhIGJ1ZyB3aGVuIHRoZQ0KPiA+
Pj4gdmFyaWFibGUgdHlwZSBpcyBjaGFuZ2VkIGJ1dCB0aGUgY29ycmVzcG9uZGluZyBzaXplb2Yg
dGhhdCBpcyBwYXNzZWQNCj4gPj4+IGFzIGFyZ3VtZW50IGlzDQo+ID4+IG5vdC4NCj4gPj4+DQo+
ID4+PiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzc5DQo+ID4+Pg0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJu
ZWwub3JnPg0KPiA+Pj4gLS0tDQo+ID4+PiBDaGFuZ2VzIGluIHYyOg0KPiA+Pj4gIC0gVXNlIGEg
bW9yZSBjb25jaXNlIGNoYW5nZWxvZyB0ZXh0Lg0KPiA+Pj4NCj4gPj4+ICBkcml2ZXJzL21pc2Mv
bWVpL2hibS5jIHwgNCArKy0tDQo+ID4+PiAgZHJpdmVycy9taXNjL21laS9ody5oICB8IDYgKysr
LS0tDQo+ID4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaGJtLmMgYi9k
cml2ZXJzL21pc2MvbWVpL2hibS5jIGluZGV4DQo+ID4+PiBhNDQwOTRjZGJjMzYuLmYwMjBkNTU5
NDE1NCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGJtLmMNCj4gPj4+ICsr
KyBiL2RyaXZlcnMvbWlzYy9tZWkvaGJtLmMNCj4gPj4+IEBAIC00MDgsMTQgKzQwOCwxNCBAQCBz
dGF0aWMgaW50IG1laV9oYm1fYWRkX2NsX3Jlc3Aoc3RydWN0DQo+ID4+PiBtZWlfZGV2aWNlICpk
ZXYsIHU4IGFkZHIsIHU4IHN0YXR1cykgIHsNCj4gPj4+ICAJc3RydWN0IG1laV9tc2dfaGRyIG1l
aV9oZHI7DQo+ID4+PiAgCXN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNwb25zZSByZXNwOw0KPiA+
Pj4gLQljb25zdCBzaXplX3QgbGVuID0gc2l6ZW9mKHN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNw
b25zZSk7DQo+ID4+PiArCWNvbnN0IHNpemVfdCBsZW4gPSBzaXplb2YocmVzcCk7DQo+ID4+PiAg
CWludCByZXQ7DQo+ID4+Pg0KPiA+Pj4gIAlkZXZfZGJnKGRldi0+ZGV2LCAiYWRkaW5nIGNsaWVu
dCByZXNwb25zZVxuIik7DQo+ID4+Pg0KPiA+Pj4gIAltZWlfaGJtX2hkcigmbWVpX2hkciwgbGVu
KTsNCj4gPj4+DQo+ID4+PiAtCW1lbXNldCgmcmVzcCwgMCwgc2l6ZW9mKHN0cnVjdCBoYm1fYWRk
X2NsaWVudF9yZXNwb25zZSkpOw0KPiA+Pj4gKwltZW1zZXQoJnJlc3AsIDAsIGxlbik7DQo+ID4+
PiAgCXJlc3AuaGJtX2NtZCA9IE1FSV9IQk1fQUREX0NMSUVOVF9SRVNfQ01EOw0KPiA+Pj4gIAly
ZXNwLm1lX2FkZHIgPSBhZGRyOw0KPiA+Pj4gIAlyZXNwLnN0YXR1cyAgPSBzdGF0dXM7DQo+ID4N
Cj4gPiBUaGlzIHNob3VsZCBiZSBwcm9iYWJseSBpbiBhIGRpZmZlcmVudCBwYXRjaCBpdCdzIG5v
dCByZWxhdGVkIHRvIHRoZSBzZWNvbmQNCj4gcGFydC4NCg0KDQpGcmFua2x5IEkgd2lsbCBwb3N0
IG90aGVyIHZlcnNpb24gb2YgdGhpcyB0aGF0IGNsZWFucyB0aGUgd2hvbGUgZmlsZS4gDQoNCj4g
Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaHcuaCBiL2RyaXZlcnMvbWlz
Yy9tZWkvaHcuaCBpbmRleA0KPiA+Pj4gYjFhOGQ1ZWM4OGIzLi44YzAyOTdmMGU3ZjMgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2h3LmgNCj4gPj4+ICsrKyBiL2RyaXZlcnMv
bWlzYy9tZWkvaHcuaA0KPiA+IEkgaGF2ZSBzZWNvbmQgdGhvdWdodHMgb2YgdGhpcyBwYXJ0IGFz
IGFsbCByZXNlcnZlZCBmaWVsZHMgaW4gdGhpcw0KPiA+IGZpbGUgYXJlIG9mIGZvcm0gdTggcmVz
ZXJ2ZWRbWF0sIHNvIHdlIHdpbGwgbG9zZSB0aGF0IHVuaWZvcm1pdHkgd2l0aA0KPiA+IHRoaXMg
Y2hhbmdlLCB5b3UgaGF2ZSB0byBsb29rIGF0IHRoZSBmaWxlIGFzIHdob2xlIG5vdCBqdXN0IGF0
IHRoZSBwYXRjaC4gIFNvIEkNCj4gcHJlZmVyIHdlIGRyb3AgdGhhdCBwYXJ0IG9mIHRoZSBwYXRj
aC4NCj4gPg0KPiANCj4gVGhpcyBpcyBhY3R1YWxseSB0aGUgbWFpbiBwb2ludCBvZiB0aGlzIHBh
dGNoOiB0aGUgcmVtb3ZhbCBvZiBvbmUtZWxlbWVudA0KPiBhcnJheXMuDQo+IEFuZCB5ZWFoLCBl
dmVyeSBwbGFjZSBpbiB0aGUga2VybmVsIHRoYXQgdXNlcyB0aGUgZm9ybSB0aGF0IHlvdSBtZW50
aW9uIHdpbGwNCj4gc2VlIGl0J3MgdW5pZm9ybWl0eSBzbGlnaHRseSBtb2RpZmllZCwgYW5kIHRo
YXQncyBmb3IgYSBnb29kIGNhdXNlOiB0aGUgcmVtb3ZhbA0KPiBvZiBvbmUtZWxlbWVudCBhcnJh
eXMsIHNvIHdlIGNhbiBlbmFibGUgYm91bmRzIGNoZWNraW5nLg0KDQpJIHdhcyBnb2luZyBvdmVy
IGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy83OSwgSSdtIG5vdCBzdXJlIHRo
aXMgYWxsIHJlbGF0ZWQgIHRvIGZsZXhpYmxlIGFycmF5cywNCnRob3NlIGFyZSBqdXN0IHJlc2Vy
dmVkIHN0cnVjdCBtZW1iZXJzLiBTbyBiZWNhdXNlIGl0J3MgaGFyZCB0byBpZGVudGlmeSBhIGxl
Z2l0aW1hdGUgdXNhZ2Ugb2Ygc2luZ2xlIGVsZW1lbnQgYXJyYXlzDQp3ZSBhcmUgZ29pbmcgdG8g
a2lsbCB0aGVtIGFsbD8gSXQncyBtb3JlIGVzdGhldGljIC8gcmVhZGFiaWxpdHkgaXNzdWUgaGVy
ZSBidXQgdGhlcmUgbWlnaHQgYmUgc29tZSBsZWdpdCB1c2UgY2FzZSBmb3Igb25lIGVsZW1lbnQg
YXJyYXksIG5vPw0KDQoNCj4gDQo+IFRoYW5rcw0KPiAtLQ0KPiBHdXN0YXZvDQo+IA0KPiA+Pj4g
QEAgLTM0NiwxMyArMzQ2LDEzIEBAIHN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXF1ZXN0IHsNCj4g
Pj4+ICAgKiBAaGJtX2NtZDogYnVzIG1lc3NhZ2UgY29tbWFuZCBoZWFkZXINCj4gPj4+ICAgKiBA
bWVfYWRkcjogYWRkcmVzcyBvZiB0aGUgY2xpZW50IGluIE1FDQo+ID4+PiAgICogQHN0YXR1czog
aWYgSEJNU19TVUNDRVNTIHRoZW4gdGhlIGNsaWVudCBjYW4gbm93IGFjY2VwdA0KPiBjb25uZWN0
aW9ucy4NCj4gPj4+IC0gKiBAcmVzZXJ2ZWQ6IHJlc2VydmVkDQo+ID4+PiArICogQHJlc2VydmVk
OiByZXNlcnZlZCBmb3IgYWxpZ25tZW50Lg0KPiA+Pj4gICAqLw0KPiA+Pj4gIHN0cnVjdCBoYm1f
YWRkX2NsaWVudF9yZXNwb25zZSB7DQo+ID4+PiAgCXU4IGhibV9jbWQ7DQo+ID4+PiAgCXU4IG1l
X2FkZHI7DQo+ID4+PiAgCXU4IHN0YXR1czsNCj4gPj4+IC0JdTggcmVzZXJ2ZWRbMV07DQo+ID4+
PiArCXU4IHJlc2VydmVkOw0KPiA+Pj4gIH0gX19wYWNrZWQ7DQo+ID4+Pg0KPiA+Pj4gIC8qKg0K
PiA+Pj4gQEAgLTQ2MSw3ICs0NjEsNyBAQCBzdHJ1Y3QgaGJtX25vdGlmaWNhdGlvbiB7DQo+ID4+
PiAgCXU4IGhibV9jbWQ7DQo+ID4+PiAgCXU4IG1lX2FkZHI7DQo+ID4+PiAgCXU4IGhvc3RfYWRk
cjsNCj4gPj4+IC0JdTggcmVzZXJ2ZWRbMV07DQo+ID4+PiArCXU4IHJlc2VydmVkOw0KPiA+Pj4g
IH0gX19wYWNrZWQ7DQo+ID4+Pg0KPiA+Pj4gIC8qKg0KPiA+Pj4NCg==
