Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E8C2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgG1XHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:07:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:56598 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgG1XHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:07:25 -0400
IronPort-SDR: VZYw3cSM+0qXb4YmhkQCEKnyxiLMoB7qzX+DO6JGnkibcjfuJ68Ov1Y+e4GMmtDo2hZCFjj/6Y
 s6fjo4zo1MQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="150497802"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="150497802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 16:07:22 -0700
IronPort-SDR: 8rmib+mzmSc7yq4eaHaspcCSnafAdNi5kGUq3TRKcIUF95+N0YXCjLgT9BWg/fovHytepT7gMn
 y177JzgNzTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="286329768"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2020 16:07:22 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 16:07:21 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 02:07:19 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 02:07:19 +0300
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
Thread-Index: AQHWZSfolBoy0+Wd50OY4DSCzkXDIakdV1+AgAAxzgD//9MtAIAAMULwgAAExRD//9feAIAAMmHA
Date:   Tue, 28 Jul 2020 23:07:18 +0000
Message-ID: <238dfc3f02b24b81a2334d645527aa0e@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
 <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
 <8ec7601780b542c2bc0168e03749ec0e@intel.com>
 <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
 <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
 <6736aefa05e84b30bcc91003b55c7644@intel.com>
 <c4a93287-6010-8ea4-cab2-09efa49e3391@embeddedor.com>
In-Reply-To: <c4a93287-6010-8ea4-cab2-09efa49e3391@embeddedor.com>
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

DQo+IA0KPiBUb21hcywNCj4gDQo+IFBsZWFzZSwgc2VlIHNvbWUgY29tbWVudHMgYmVsb3cuLi4N
Cj4gDQo+IE9uIDcvMjgvMjAgMTc6MjksIFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBIaSBUb21hcywNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gNy8yOC8yMCAxNjo0MSwgVG9t
YXMgV2lua2xlciB3cm90ZToNCj4gPj4+Pj4+IEdyZWcgcGxlYXNlIHJldmVydCwgdGhpcyBjb21t
aXQgaXQgY2hhbmdlcyBzaXplIG9mIHN0cnVjdA0KPiA+Pj4+Pj4gd2lyZWRfY21kX3JlcGVhdGVy
X2F1dGhfc3RyZWFtX3JlcV9pbiwgdGhpcyBpcyBub3Qgd2hhdCBmaXJtd2FyZQ0KPiA+Pj4+Pj4g
aXMgZXhwZWN0aW5nLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHdo
YXQncyB0aGUgZmlybXdhcmUgZXhwZWN0aW5nLCBleGFjdGx5Pw0KPiA+Pj4+IHN0cnVjdCB3aXJl
ZF9jbWRfcmVwZWF0ZXJfYXV0aF9zdHJlYW1fcmVxX2luIHsNCj4gPj4+PiAgIC0Jc3RydWN0IGhk
Y3AyX3N0cmVhbWlkX3R5cGUJc3RyZWFtc1sxXTsNCj4gPj4+PiAgICsgCXN0cnVjdCBoZGNwMl9z
dHJlYW1pZF90eXBlCXN0cmVhbXNbXTsNCj4gPj4+PiB9DQo+ID4+Pj4NCj4gPj4+PiBCdXQgdGhl
biB5b3UgaGF2ZSwgd2hpY2ggeW91IGhhdmVuJ3QgY2hhbmdlZCB0byArIDEgYnl0ZSA9DQo+ID4+
Pj4gbWVpX2NsZGV2X3NlbmQoY2xkZXYsICh1OCAqKSZ2ZXJpZnlfbXByaW1lX2luLA0KPiA+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih2ZXJpZnlfbXByaW1lX2luKSk7
DQo+ID4+Pj4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhlIGZpeCBmb3IgdGhpcyBpcyB0byBhZGQg
MSBieXRlLCBpZiBhbnksIGl0IHNlZW1zIHRvIGJlIHNpemVvZigqZGF0YS0NCj4gPnN0cmVhbXMp
LCBvciBzaXplb2Yoc3RydWN0IGhkY3AyX3N0cmVhbWlkX3R5cGUpIHdoYXQgbmVlZHMgdG8gYmUg
YWRkZWQuDQo+IA0KPiBCdXQgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGNvZGUgc29tZXRoaW5nIGxp
a2UgdGhpcywgaW5zdGVhZDoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2hk
Y3AvbWVpX2hkY3AuYw0KPiBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+IGlu
ZGV4IGU2YzNkYzU5NTYxNy4uN2ZlNjNjOTE1NTQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21p
c2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVp
X2hkY3AuYw0KPiBAQCAtNTcyLDEyICs1NzIsMTIgQEAgc3RhdGljIGludCBtZWlfaGRjcF92ZXJp
ZnlfbXByaW1lKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwNCj4gICAgICAgICAgICAgICAgSERDUF8y
XzJfTVBSSU1FX0xFTik7DQo+ICAgICAgICAgZHJtX2hkY3BfY3B1X3RvX2JlMjQodmVyaWZ5X21w
cmltZV9pbi5zZXFfbnVtX20sIGRhdGEtDQo+ID5zZXFfbnVtX20pOw0KPiAgICAgICAgIG1lbWNw
eSh2ZXJpZnlfbXByaW1lX2luLnN0cmVhbXMsIGRhdGEtPnN0cmVhbXMsDQo+IC0gICAgICAgICAg
ICAgIChkYXRhLT5rICogc2l6ZW9mKHN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlKSkpOw0KPiAr
ICAgICAgICAgICAgICAoZGF0YS0+ayAqIHNpemVvZigqZGF0YS0+c3RyZWFtcykpKTsNCj4gDQo+
ICAgICAgICAgdmVyaWZ5X21wcmltZV9pbi5rID0gY3B1X3RvX2JlMTYoZGF0YS0+ayk7DQo+IA0K
PiAgICAgICAgIGJ5dGUgPSBtZWlfY2xkZXZfc2VuZChjbGRldiwgKHU4ICopJnZlcmlmeV9tcHJp
bWVfaW4sDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih2ZXJpZnlfbXBy
aW1lX2luKSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdF9zaXplKCZ2
ZXJpZnlfbXByaW1lX2luLCBzdHJlYW1zLA0KPiArIGRhdGEtPmspKTsNCj4gICAgICAgICBpZiAo
Ynl0ZSA8IDApIHsNCj4gICAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAibWVpX2NsZGV2X3Nl
bmQgZmFpbGVkLiAlemRcbiIsIGJ5dGUpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGJ5dGU7
DQo+IA0KPiBzdHJ1Y3Rfc2l6ZSgmdmVyaWZ5X21wcmltZV9pbiwgc3RyZWFtcywgZGF0YS0+aykg
d2lsbCBnaXZlIHVzIHRoZSBzaXplLCBpbg0KPiBieXRlcywgb2Ygc3RydWN0IHdpcmVkX2NtZF9y
ZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4gcGx1cyB0aGUgc2l6ZSBpbg0KPiBieXRlcyBmb3Ig
dGhlIHN0cmVhbXNbXSBmbGV4aWJsZS1hcnJheSwgd2hpY2ggaXMgZGV0ZXJtaW5lZCBieSBzdHJ1
Y3QNCj4gaGRjcDJfc3RyZWFtaWRfdHlwZSBhbmQNCj4gZGF0YS0+ay4NCj4gDQo+IFdoYXQgZG8g
eW91IHRoaW5rPw0KSSB0aGluayBJIHdpbGwgdGFsayB0byB0aGUgZmlybXdhcmUgZ3V5cyB0b21v
cnJvdyBtb3JuaW5nLi4uIA0KDQo+IA0KPiBTZWUgbW9yZSBjb21tZW50cyBiZWxvdy4uLg0KPiAN
Cj4gPj4+DQo+ID4+PiBJIHNlZSwgdGhpcyBpcyB0aGUga2luZCBvZiBmZWVkYmFjayBJIG5lZWQg
ZnJvbSBwZW9wbGUgdGhhdCBrbm93cw0KPiA+Pj4gdGhlIGNvZGUgYmV0dGVyLiBUaGFua3MhDQo+
ID4+Pg0KPiA+Pj4+IEJ1dCB0aGF0J3Mgbm90IHRoZSBtYWpvciBwb2ludC4gUG9pbnQgaXMgdGhh
dCB3ZSBzaG91bGQgYmUgYWJsZSB0bw0KPiA+Pj4+IHJldmlldyBhbmQgdGVzdCB0aGUgY29kZSBi
ZWZvcmUgaXQgaXMgbWVyZ2VkLiAgWW91IGhhdmVuJ3QgcnVuIGl0LCByaWdodD8NCj4gPj4+PiBU
aGVyZSBpcyBNQUlOVEFJTkVSUyBmaWxlIGZvciBhIHJlYXNvbi4NCj4gPj4+Pg0KPiA+Pj4NCj4g
Pj4+IEknbSB1c2luZyB0aGlzIGNvbW1hbmQ6DQo+ID4+Pg0KPiA+Pj4gJCBzY3JpcHRzL2dldF9t
YWludGFpbmVyLnBsIC0tbm9rZXl3b3JkcyAtLW5vZ2l0IC0tbm9naXQtZmFsbGJhY2sNCj4gPj4+
DQo+ID4+PiBhbmQgdGhpcyBpcyB0aGUgb3V0cHV0IGZvciBib3RoIGZpbGVzOg0KPiA+Pj4NCj4g
Pj4+ICQgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLW5va2V5d29yZHMgLS1ub2dpdCAtLW5v
Z2l0LWZhbGxiYWNrDQo+ID4+PiBkcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYyBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+Pj4gKHN1cHBvcnRlcjpDSEFSIGFuZCBNSVND
IERSSVZFUlMpIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA+Pj4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJVkVSUykNCj4gPj4+IGxpbnV4LSBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3QpICQNCj4gPj4+IHNjcmlwdHMvZ2V0X21h
aW50YWluZXIucGwgLS1ub2tleXdvcmRzIC0tIG5vZ2l0IC0tbm9naXQtZmFsbGJhY2sNCj4gPj4+
IGRyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oIEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+DQo+ID4+PiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJVkVSUykgR3JlZyBLcm9h
aC1IYXJ0bWFuDQo+ID4+PiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IChzdXBwb3J0ZXI6
Q0hBUiBhbmQgTUlTQyBEUklWRVJTKQ0KPiA+Pj4gbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcgKG9wZW4gbGlzdCkNCj4gPj4NCj4gPj4NCj4gPj4+IEZvciBzb21lIHJlYXNvbiB5b3UgZG9u
J3QgYXBwZWFyIG9uIHRoZSBsaXN0IGFib3ZlLiBEbyB5b3Ugc2VlDQo+ID4+PiBhbnl0aGluZyB3
cm9uZyB3aXRoIHRoZSBjb21tYW5kIEknbSBydW5uaW5nIHRvIGdldCB0aGUgbWFpbnRhaW5lcnMN
Cj4gPj4+IGFuZA0KPiA+PiBsaXN0cz8NCj4gPj4NCj4gPj4gTm90IHN1cmUsIGl0IHNob3VsZCBi
ZSBjYXVnaHQgYnkgZHJpdmVycy9taXNjL21laS8qID8NCj4gPj4gTWF5YmUgaXQgaXMgbm90IHJl
Y3Vyc2l2ZT8gTmVlZCB0byBjaGVjayB0aGUgc2NyaXB0LCBmcmFua2x5IEkNCj4gPj4gdXN1YWxs
eSBjaGVjayB0aGlzIG1hbnVhbGx5Lg0KPiA+Pg0KPiA+PiBJTlRFTCBNQU5BR0VNRU5UIEVOR0lO
RSAobWVpKQ0KPiA+PiBNOiAgICAgIFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwu
Y29tPg0KPiA+PiBMOiAgICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gUzog
ICAgICBTdXBwb3J0ZWQNCj4gPj4gRjogICAgICBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbWVp
LyoNCj4gPj4gRjogICAgICBkcml2ZXJzL21pc2MvbWVpLyoNCj4gPj4gRjogICAgICBkcml2ZXJz
L3dhdGNoZG9nL21laV93ZHQuYw0KPiA+PiBGOiAgICAgIGluY2x1ZGUvbGludXgvbWVpX2NsX2J1
cy5oDQo+ID4+IEY6ICAgICAgaW5jbHVkZS91YXBpL2xpbnV4L21laS5oDQo+ID4+IEY6ICAgICAg
c2FtcGxlcy9tZWkvKg0KPiA+Pg0KPiA+DQo+ID4gSXQncyBub3QgcmVjdXJzaXZlLCB3aGVuIEkg
YWRkIGRyaXZlcnMvbWlzYy9tZWkvaGRjcC8qIC4gSXQgd29ya3MNCj4gPiBjb3JyZWN0bHkgSSB3
aWxsIHBvc3QgYSBwYXRjaC4NCj4gPg0KPiANCj4gR3JlYXQuIEknbSBnbGFkIHdlIGdvdCB0byB0
aGUgcm9vdCBjYXVzZSBvZiB0aGlzIGlzc3VlLiA6KQ0KPiANCj4gVGhhbmtzDQo+IC0tDQo+IEd1
c3Rhdm8NCj4gDQo+ID4gVGhhbmtzDQo+ID4gVG9tYXMNCj4gPg0KPiA+DQo+ID4+DQo+ID4+Pg0K
PiA+Pj4gVGhhbmtzDQo+ID4+PiAtLQ0KPiA+Pj4gR3VzdGF2bw0KPiA+Pj4NCj4gPj4+Pj4NCj4g
Pj4+Pj4+IEkgcmVhbGx5IGRvIG5vdCBhcHByZWNpYXRlIHRoYXQgdGhlIGNvZGUgaXMgYnlwYXNz
aW5nIGRyaXZlcg0KPiA+Pj4+Pj4gbWFpbnRhbmVyIHJldmlldywgSSB0aGluayB0aGlzIGlzIGEg
bWluaW11bSB3ZSBjYW4gYXNrIGZvciwgdGhpcw0KPiA+Pj4+Pj4gaXMgbm90IGZvciBhIGZpcnN0
IHRpbWUuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCBjNTY5NjdkNjc0
ZTM2MWViZTcxNmU2Njk5MmUzYzUzMzJiMjVhYzFmLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IENjOiBH
dXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+ID4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gPj4+
Pj4+IC0tLQ0KPiA+Pj4+Pj4gIGRyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jIHwgMiAr
LQ0KPiA+Pj4+Pj4gZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNwLmggfCAyICstDQo+ID4+
Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlf
aGRjcC5jDQo+ID4+Pj4+PiBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4+
Pj4+PiBpbmRleCBkMWQzZTAyNWNhMGUuLmU2YzNkYzU5NTYxNyAxMDA2NDQNCj4gPj4+Pj4+IC0t
LSBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4+Pj4+PiArKysgYi9kcml2
ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+Pj4+Pj4gQEAgLTU3Miw3ICs1NzIsNyBA
QCBzdGF0aWMgaW50IG1laV9oZGNwX3ZlcmlmeV9tcHJpbWUoc3RydWN0DQo+ID4+Pj4+PiBkZXZp
Y2UNCj4gPj4+Pj4gKmRldiwNCj4gPj4+Pj4+ICAJICAgICAgIEhEQ1BfMl8yX01QUklNRV9MRU4p
Ow0KPiA+Pj4+Pj4gIAlkcm1faGRjcF9jcHVfdG9fYmUyNCh2ZXJpZnlfbXByaW1lX2luLnNlcV9u
dW1fbSwgZGF0YS0NCj4gPj4+IHNlcV9udW1fbSk7DQo+ID4+Pj4+PiAgCW1lbWNweSh2ZXJpZnlf
bXByaW1lX2luLnN0cmVhbXMsIGRhdGEtPnN0cmVhbXMsDQo+ID4+Pj4+PiAtCSAgICAgICBhcnJh
eV9zaXplKGRhdGEtPmssIHNpemVvZigqZGF0YS0+c3RyZWFtcykpKTsNCj4gPj4+Pj4+ICsJICAg
ICAgIChkYXRhLT5rICogc2l6ZW9mKHN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlKSkpOw0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+ICAJdmVyaWZ5X21wcmltZV9pbi5rID0gY3B1X3RvX2JlMTYoZGF0YS0+
ayk7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaGRj
cC9tZWlfaGRjcC5oDQo+ID4+Pj4+PiBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5o
DQo+ID4+Pj4+PiBpbmRleCA4MzQ3NTdmNWUwNzIuLjE4ZmZjNzczZmExOCAxMDA2NDQNCj4gPj4+
Pj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oDQo+ID4+Pj4+PiArKysg
Yi9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuaA0KPiA+Pj4+Pj4gQEAgLTM1OCw3ICsz
NTgsNyBAQCBzdHJ1Y3QNCj4gPj4gd2lyZWRfY21kX3JlcGVhdGVyX2F1dGhfc3RyZWFtX3JlcV9p
bg0KPiA+Pj4gew0KPiA+Pj4+Pj4gIAl1OA0KPiA+Pj4+PiAJc2VxX251bV9tW0hEQ1BfMl8yX1NF
UV9OVU1fTEVOXTsNCj4gPj4+Pj4+ICAJdTgNCj4gCW1fcHJpbWVbSERDUF8yXzJfTVBSSU1FX0xF
Tl07DQo+ID4+Pj4+PiAgCV9fYmUxNgkJCQlrOw0KPiA+Pj4+Pj4gLQlzdHJ1Y3QgaGRjcDJfc3Ry
ZWFtaWRfdHlwZQlzdHJlYW1zW107DQo+ID4+Pj4+PiArCXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90
eXBlCXN0cmVhbXNbMV07DQo+ID4+Pj4+PiAgfSBfX3BhY2tlZDsNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiAgc3RydWN0IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfb3V0IHsNCj4gPj4+
Pj4+DQo=
