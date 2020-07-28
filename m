Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228C82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgG1W3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:29:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:35818 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgG1W3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:29:43 -0400
IronPort-SDR: P6vDK5PVa7zR0vZOUauDNRNfpblVxLtqBqPe9LeyPjeJB2YtrmR4LaWpXyTNaB5YYlJWnGzisD
 Ps71iRkp84cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="130884738"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="130884738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 15:29:42 -0700
IronPort-SDR: IYYk60G1TvjuzT0BlteS91vd1DPWEQhg79HdGHoWW0Cemsnt8tOWHDZTKZEXgk+CiiInaKfVB/
 iAxjIIC/9Vew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="320548791"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2020 15:29:42 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 15:29:42 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 01:29:39 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 01:29:39 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: RE: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Topic: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Index: AQHWZSfolBoy0+Wd50OY4DSCzkXDIakdV1+AgAAxzgD//9MtAIAAMULwgAAExRA=
Date:   Tue, 28 Jul 2020 22:29:39 +0000
Message-ID: <6736aefa05e84b30bcc91003b55c7644@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
 <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
 <8ec7601780b542c2bc0168e03749ec0e@intel.com>
 <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
 <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
In-Reply-To: <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
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

PiA+ID4+DQo+ID4gPj4gSGkgVG9tYXMsDQo+ID4gPj4NCj4gPiA+PiBPbiA3LzI4LzIwIDE2OjQx
LCBUb21hcyBXaW5rbGVyIHdyb3RlOg0KPiA+ID4+PiBHcmVnIHBsZWFzZSByZXZlcnQsIHRoaXMg
Y29tbWl0IGl0IGNoYW5nZXMgc2l6ZSBvZiBzdHJ1Y3QNCj4gPiA+Pj4gd2lyZWRfY21kX3JlcGVh
dGVyX2F1dGhfc3RyZWFtX3JlcV9pbiwgdGhpcyBpcyBub3Qgd2hhdCBmaXJtd2FyZQ0KPiA+ID4+
PiBpcyBleHBlY3RpbmcuDQo+ID4gPj4NCj4gPiA+PiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHdo
YXQncyB0aGUgZmlybXdhcmUgZXhwZWN0aW5nLCBleGFjdGx5Pw0KPiA+ID4gc3RydWN0IHdpcmVk
X2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4gew0KPiA+ID4gICAtCXN0cnVjdCBoZGNw
Ml9zdHJlYW1pZF90eXBlCXN0cmVhbXNbMV07DQo+ID4gPiAgICsgCXN0cnVjdCBoZGNwMl9zdHJl
YW1pZF90eXBlCXN0cmVhbXNbXTsNCj4gPiA+IH0NCj4gPiA+DQo+ID4gPiBCdXQgdGhlbiB5b3Ug
aGF2ZSwgd2hpY2ggeW91IGhhdmVuJ3QgY2hhbmdlZCB0byArIDEgYnl0ZSA9DQo+ID4gPiBtZWlf
Y2xkZXZfc2VuZChjbGRldiwgKHU4ICopJnZlcmlmeV9tcHJpbWVfaW4sDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YodmVyaWZ5X21wcmltZV9pbikpOw0KPiA+ID4N
Cj4gPg0KPiA+IEkgc2VlLCB0aGlzIGlzIHRoZSBraW5kIG9mIGZlZWRiYWNrIEkgbmVlZCBmcm9t
IHBlb3BsZSB0aGF0IGtub3dzIHRoZQ0KPiA+IGNvZGUgYmV0dGVyLiBUaGFua3MhDQo+ID4NCj4g
PiA+IEJ1dCB0aGF0J3Mgbm90IHRoZSBtYWpvciBwb2ludC4gUG9pbnQgaXMgdGhhdCB3ZSBzaG91
bGQgYmUgYWJsZSB0bw0KPiA+ID4gcmV2aWV3IGFuZCB0ZXN0IHRoZSBjb2RlIGJlZm9yZSBpdCBp
cyBtZXJnZWQuICBZb3UgaGF2ZW4ndCBydW4gaXQsIHJpZ2h0Pw0KPiA+ID4gVGhlcmUgaXMgTUFJ
TlRBSU5FUlMgZmlsZSBmb3IgYSByZWFzb24uDQo+ID4gPg0KPiA+DQo+ID4gSSdtIHVzaW5nIHRo
aXMgY29tbWFuZDoNCj4gPg0KPiA+ICQgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLW5va2V5
d29yZHMgLS1ub2dpdCAtLW5vZ2l0LWZhbGxiYWNrDQo+ID4NCj4gPiBhbmQgdGhpcyBpcyB0aGUg
b3V0cHV0IGZvciBib3RoIGZpbGVzOg0KPiA+DQo+ID4gJCBzY3JpcHRzL2dldF9tYWludGFpbmVy
LnBsIC0tbm9rZXl3b3JkcyAtLW5vZ2l0IC0tbm9naXQtZmFsbGJhY2sNCj4gPiBkcml2ZXJzL21p
c2MvbWVpL2hkY3AvbWVpX2hkY3AuYyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+
IChzdXBwb3J0ZXI6Q0hBUiBhbmQgTUlTQyBEUklWRVJTKSBHcmVnIEtyb2FoLUhhcnRtYW4NCj4g
PiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IChzdXBwb3J0ZXI6Q0hBUiBhbmQgTUlTQyBE
UklWRVJTKSBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3QpICQg
c2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbA0KPiA+IC0tbm9rZXl3b3JkcyAtLSBub2dpdCAtLW5v
Z2l0LWZhbGxiYWNrDQo+ID4gZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNwLmggQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gPiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJ
VkVSUykgR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
PiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJVkVSUykgbGludXgtDQo+ID4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZyAob3BlbiBsaXN0KQ0KPiANCj4gDQo+ID4gRm9yIHNvbWUgcmVhc29uIHlv
dSBkb24ndCBhcHBlYXIgb24gdGhlIGxpc3QgYWJvdmUuIERvIHlvdSBzZWUNCj4gPiBhbnl0aGlu
ZyB3cm9uZyB3aXRoIHRoZSBjb21tYW5kIEknbSBydW5uaW5nIHRvIGdldCB0aGUgbWFpbnRhaW5l
cnMgYW5kDQo+IGxpc3RzPw0KPiANCj4gTm90IHN1cmUsIGl0IHNob3VsZCBiZSBjYXVnaHQgYnkg
ZHJpdmVycy9taXNjL21laS8qID8NCj4gTWF5YmUgaXQgaXMgbm90IHJlY3Vyc2l2ZT8gTmVlZCB0
byBjaGVjayB0aGUgc2NyaXB0LCBmcmFua2x5IEkgdXN1YWxseSBjaGVjayB0aGlzDQo+IG1hbnVh
bGx5Lg0KPiANCj4gSU5URUwgTUFOQUdFTUVOVCBFTkdJTkUgKG1laSkNCj4gTTogICAgICBUb21h
cyBXaW5rbGVyIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gTDogICAgICBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFM6ICAgICAgU3VwcG9ydGVkDQo+IEY6ICAgICAgRG9jdW1l
bnRhdGlvbi9kcml2ZXItYXBpL21laS8qDQo+IEY6ICAgICAgZHJpdmVycy9taXNjL21laS8qDQo+
IEY6ICAgICAgZHJpdmVycy93YXRjaGRvZy9tZWlfd2R0LmMNCj4gRjogICAgICBpbmNsdWRlL2xp
bnV4L21laV9jbF9idXMuaA0KPiBGOiAgICAgIGluY2x1ZGUvdWFwaS9saW51eC9tZWkuaA0KPiBG
OiAgICAgIHNhbXBsZXMvbWVpLyoNCj4gDQoNCkl0J3Mgbm90IHJlY3Vyc2l2ZSwgd2hlbiBJIGFk
ZCBkcml2ZXJzL21pc2MvbWVpL2hkY3AvKiAuIEl0IHdvcmtzIGNvcnJlY3RseSANCkkgd2lsbCBw
b3N0IGEgcGF0Y2guDQoNClRoYW5rcw0KVG9tYXMNCg0KDQo+IA0KPiA+DQo+ID4gVGhhbmtzDQo+
ID4gLS0NCj4gPiBHdXN0YXZvDQo+ID4NCj4gPiA+Pg0KPiA+ID4+PiBJIHJlYWxseSBkbyBub3Qg
YXBwcmVjaWF0ZSB0aGF0IHRoZSBjb2RlIGlzIGJ5cGFzc2luZyBkcml2ZXINCj4gPiA+Pj4gbWFp
bnRhbmVyIHJldmlldywgSSB0aGluayB0aGlzIGlzIGEgbWluaW11bSB3ZSBjYW4gYXNrIGZvciwg
dGhpcw0KPiA+ID4+PiBpcyBub3QgZm9yIGEgZmlyc3QgdGltZS4NCj4gPiA+Pj4NCj4gPiA+Pj4g
VGhpcyByZXZlcnRzIGNvbW1pdCBjNTY5NjdkNjc0ZTM2MWViZTcxNmU2Njk5MmUzYzUzMzJiMjVh
YzFmLg0KPiA+ID4+Pg0KPiA+ID4+PiBDYzogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fy
c0BrZXJuZWwub3JnPg0KPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21h
cy53aW5rbGVyQGludGVsLmNvbT4NCj4gPiA+Pj4gLS0tDQo+ID4gPj4+ICBkcml2ZXJzL21pc2Mv
bWVpL2hkY3AvbWVpX2hkY3AuYyB8IDIgKy0NCj4gPiA+Pj4gZHJpdmVycy9taXNjL21laS9oZGNw
L21laV9oZGNwLmggfCAyICstDQo+ID4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gPj4+IGIvZHJpdmVycy9taXNjL21laS9o
ZGNwL21laV9oZGNwLmMNCj4gPiA+Pj4gaW5kZXggZDFkM2UwMjVjYTBlLi5lNmMzZGM1OTU2MTcg
MTAwNjQ0DQo+ID4gPj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+
ID4gPj4+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gPj4+IEBA
IC01NzIsNyArNTcyLDcgQEAgc3RhdGljIGludCBtZWlfaGRjcF92ZXJpZnlfbXByaW1lKHN0cnVj
dA0KPiA+ID4+PiBkZXZpY2UNCj4gPiA+PiAqZGV2LA0KPiA+ID4+PiAgCSAgICAgICBIRENQXzJf
Ml9NUFJJTUVfTEVOKTsNCj4gPiA+Pj4gIAlkcm1faGRjcF9jcHVfdG9fYmUyNCh2ZXJpZnlfbXBy
aW1lX2luLnNlcV9udW1fbSwgZGF0YS0NCj4gPiBzZXFfbnVtX20pOw0KPiA+ID4+PiAgCW1lbWNw
eSh2ZXJpZnlfbXByaW1lX2luLnN0cmVhbXMsIGRhdGEtPnN0cmVhbXMsDQo+ID4gPj4+IC0JICAg
ICAgIGFycmF5X3NpemUoZGF0YS0+aywgc2l6ZW9mKCpkYXRhLT5zdHJlYW1zKSkpOw0KPiA+ID4+
PiArCSAgICAgICAoZGF0YS0+ayAqIHNpemVvZihzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZSkp
KTsNCj4gPiA+Pj4NCj4gPiA+Pj4gIAl2ZXJpZnlfbXByaW1lX2luLmsgPSBjcHVfdG9fYmUxNihk
YXRhLT5rKTsNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkv
aGRjcC9tZWlfaGRjcC5oDQo+ID4gPj4+IGIvZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNw
LmgNCj4gPiA+Pj4gaW5kZXggODM0NzU3ZjVlMDcyLi4xOGZmYzc3M2ZhMTggMTAwNjQ0DQo+ID4g
Pj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oDQo+ID4gPj4+ICsrKyBi
L2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oDQo+ID4gPj4+IEBAIC0zNTgsNyArMzU4
LDcgQEAgc3RydWN0DQo+IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4NCj4g
PiB7DQo+ID4gPj4+ICAJdTgNCj4gPiA+PiAJc2VxX251bV9tW0hEQ1BfMl8yX1NFUV9OVU1fTEVO
XTsNCj4gPiA+Pj4gIAl1OAkJCQltX3ByaW1lW0hEQ1BfMl8yX01QUklNRV9MRU5dOw0KPiA+ID4+
PiAgCV9fYmUxNgkJCQlrOw0KPiA+ID4+PiAtCXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlCXN0
cmVhbXNbXTsNCj4gPiA+Pj4gKwlzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZQlzdHJlYW1zWzFd
Ow0KPiA+ID4+PiAgfSBfX3BhY2tlZDsNCj4gPiA+Pj4NCj4gPiA+Pj4gIHN0cnVjdCB3aXJlZF9j
bWRfcmVwZWF0ZXJfYXV0aF9zdHJlYW1fcmVxX291dCB7DQo+ID4gPj4+DQo=
