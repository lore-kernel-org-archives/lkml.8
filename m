Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDE2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D0820706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NhEduwSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgFWAyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:54:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44007 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731716AbgFWAyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:54:25 -0400
X-UUID: 2e9d2a6374814e77ae0f1fa196a145e9-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pUOGn8kL8Ke7ijuL0FfLWBV3LoSmmUlsqh7iKh4FAnI=;
        b=NhEduwSFomrmMlRJqUPZLEAwA1P0UUGhhz1+UZVDrDddLhdqXtY2z4ScBMb5Q+g0t62Rnq0bxTmJk6AIPpVNO8K6SpMlF27HaTIeWszIgqPl2GK4+m3Ol5rEBzStzzl14CRMw/ICDmgaVOhvnDk8VOtGieoY/lgFYVrge/QHnzs=;
X-UUID: 2e9d2a6374814e77ae0f1fa196a145e9-20200623
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1688874106; Tue, 23 Jun 2020 08:54:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 08:54:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 08:54:07 +0800
Message-ID: <1592873653.28977.1.camel@mtkswgap22>
Subject: Re: [PATCH v1 03/11] soc: mediatek: cmdq: add write_s function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Tue, 23 Jun 2020 08:54:13 +0800
In-Reply-To: <10c40f18-8620-6e9a-7bc1-3e192abbe170@gmail.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592749115-24158-4-git-send-email-dennis-yc.hsieh@mediatek.com>
         <a9c6f28a-94d1-f92b-a017-935e80d0ec26@gmail.com>
         <1592840183.1307.12.camel@mtkswgap22>
         <8bdfff5f-9fa8-7a13-79d3-dcb63d587629@gmail.com>
         <1592842372.3619.8.camel@mtkswgap22>
         <10c40f18-8620-6e9a-7bc1-3e192abbe170@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCg0KT24gTW9uLCAyMDIwLTA2LTIyIGF0IDE5OjA4ICswMjAwLCBNYXR0
aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiANCj4gT24gMjIvMDYvMjAyMCAxODoxMiwgRGVubmlzLVlD
IEhzaWVoIHdyb3RlOg0KPiA+IEhpIE1hdHRoaWFzLA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMC0w
Ni0yMiBhdCAxNzo1NCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPj4NCj4gPj4g
T24gMjIvMDYvMjAyMCAxNzozNiwgRGVubmlzLVlDIEhzaWVoIHdyb3RlOg0KPiA+Pj4gSGkgTWF0
dGhpYXMsDQo+ID4+Pg0KPiA+Pj4gdGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQo+ID4+Pg0KPiA+
Pj4gT24gTW9uLCAyMDIwLTA2LTIyIGF0IDEzOjA3ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdy
b3RlOg0KPiA+Pj4+DQo+ID4+Pj4gT24gMjEvMDYvMjAyMCAxNjoxOCwgRGVubmlzIFlDIEhzaWVo
IHdyb3RlOg0KPiA+Pj4+PiBhZGQgd3JpdGVfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5j
dGlvbnMgd2hpY2gNCj4gPj4+Pj4gd3JpdGVzIHZhbHVlIGNvbnRhaW5zIGluIGludGVybmFsIHJl
Z2lzdGVyIHRvIGFkZHJlc3MNCj4gPj4+Pj4gd2l0aCBsYXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQu
DQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlz
LXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAxOSArKysrKysrKysrKysrKysrKysr
DQo+ID4+Pj4+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAg
MSArDQo+ID4+Pj4+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwg
ICAxOSArKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDM5IGlu
c2VydGlvbnMoKykNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCj4gPj4+Pj4gaW5kZXggYmYzMmUzYjJjYTZjLi44MTdhNWE5N2RiZTUgMTAwNjQ0
DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4+Pj4+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4+
Pj4+IEBAIC0xOCw2ICsxOCwxMCBAQCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ID4+Pj4+
ICAJdW5pb24gew0KPiA+Pj4+PiAgCQl1MzIgdmFsdWU7DQo+ID4+Pj4+ICAJCXUzMiBtYXNrOw0K
PiA+Pj4+PiArCQlzdHJ1Y3Qgew0KPiA+Pj4+PiArCQkJdTE2IGFyZ19jOw0KPiA+Pj4+PiArCQkJ
dTE2IHNyY19yZWc7DQo+ID4+Pj4+ICsJCX07DQo+ID4+Pj4+ICAJfTsNCj4gPj4+Pj4gIAl1bmlv
biB7DQo+ID4+Pj4+ICAJCXUxNiBvZmZzZXQ7DQo+ID4+Pj4+IEBAIC0yMjIsNiArMjI2LDIxIEBA
IGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMs
DQo+ID4+Pj4+ICB9DQo+ID4+Pj4+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX21hc2sp
Ow0KPiA+Pj4+PiAgDQo+ID4+Pj4+ICtpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiA+Pj4+PiArCQkgICAgIHUxNiBhZGRy
X2xvdywgdTE2IHNyY19yZWdfaWR4KQ0KPiA+Pj4+PiArew0KPiA+Pj4+DQo+ID4+Pj4gRG8gSSB1
bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHdlIHVzZSBDTURRX0FERFJfSElHSChhZGRyKSBhbmQN
Cj4gPj4+PiBDTURRX0FERFJfTE9XKGFkZHIpIHRvIGNhbGN1bGF0ZSBpbiB0aGUgY2xpZW50IGhp
Z2hfYWRkcl9yZWdfaWR4IGFuZCBhZGRyX2xvdw0KPiA+Pj4+IHJlc3BlY3RpdmVseT8NCj4gPj4+
Pg0KPiA+Pj4+IEluIHRoYXQgY2FzZSBJIHRoaW5rIGEgYmV0dGVyIGludGVyZmFjZSB3b3VsZCBi
ZSB0byBwYXNzIHRoZSBhZGRyZXNzIGFuZCBkbyB0aGUNCj4gPj4+PiBoaWdoL2xvdyBjYWxjdWxh
dGlvbiBpbiB0aGUgY21kcV9wa3Rfd3JpdGVfcw0KPiA+Pj4NCj4gPj4+IE5vdCBleGFjdGx5LiBU
aGUgaGlnaF9hZGRyX3JlZ19pZHggcGFyYW1ldGVyIGlzIGluZGV4IG9mIGludGVybmFsDQo+ID4+
PiByZWdpc3RlciAod2hpY2ggc3RvcmUgYWRkcmVzcyBiaXRbNDc6MTZdKSwgbm90IHJlc3VsdCBv
Zg0KPiA+Pj4gQ01EUV9BRERSX0hJR0goYWRkcikuIA0KPiA+Pj4NCj4gPj4+IFRoZSBDTURRX0FE
RFJfSElHSCBtYWNybyB1c2UgaW4gcGF0Y2ggMDIvMTEgY21kcV9wa3RfYXNzaWduKCkgYXBpLiBU
aGlzDQo+ID4+PiBhcGkgaGVscHMgYXNzaWduIGFkZHJlc3MgYml0WzQ3OjE2XSBpbnRvIG9uZSBv
ZiBpbnRlcm5hbCByZWdpc3RlciBieQ0KPiA+Pj4gaW5kZXguIEFuZCBzYW1lIGluZGV4IGNvdWxk
IGJlIHVzZSBpbiBjbWRxX3BrdF93cml0ZV9zKCkuIFRoZSBnY2UNCj4gPj4+IGNvbWJpbmUgYml0
WzQ3OjE2XSBpbiBpbnRlcm5hbCByZWdpc3RlciBhbmQgYml0WzE1OjBdIGluIGFkZHJfbG93DQo+
ID4+PiBwYXJhbWV0ZXIgdG8gZmluYWwgYWRkcmVzcy4gU28gaXQgaXMgYmV0dGVyIHRvIGtlZXAg
aW50ZXJmYWNlIGluIHRoaXMNCj4gPj4+IHdheS4NCj4gPj4+DQo+ID4+DQo+ID4+IEdvdCBpdCwg
YnV0IHRoZW4gd2h5IGRvbid0IHdlIGNhbGwgY21kcV9wa3RfYXNzaWduKCkgaW4gY21kcV9wa3Rf
d3JpdGVfcygpPyBUaGlzDQo+ID4+IHdheSB3ZSB3b3VsZCBnZXQgYSBjbGVhbiBBUEkgZm9yIHdo
YXQgd2Ugd2FudCB0byBkby4NCj4gPj4gRG8gd2UgZXhwZWN0IG90aGVyIHVzZXJzIG9mIGNtZHFf
cGt0X2Fzc2lnbigpPyBPdGhlcndpc2Ugd2UgY291bGQga2VlcCBpdA0KPiA+PiBwcml2YXRlIHRo
ZSB0aGlzIGZpbGUgYW5kIGRvbid0IGV4cG9ydCBpdC4NCj4gPiANCj4gPiBDb25zaWRlcmluZyB0
aGlzIGNhc2U6IHdyaXRlIDIgcmVnaXN0ZXIgMHhhYWJiMDBjMCAweGFhYmIwMGQwLg0KPiA+IA0K
PiA+IElmIHdlIGNhbGwgYXNzaWduIGluc2lkZSB3cml0ZV9zIGFwaSBpdCB3aWxsIGJlOg0KPiA+
IGFzc2lnbiBhYWJiIHRvIGludGVybmFsIHJlZyAwDQo+ID4gd3JpdGUgcmVnIDAgKyAweDAwYzAN
Cj4gPiBhc3NpZ24gYWFiYiB0byBpbnRlcm5hbCByZWcgMA0KPiA+IHdyaXRlIHJlZyAwICsgMHgw
MGQwDQo+ID4gDQo+ID4gDQo+ID4gQnV0IGlmIHdlIGxldCBjbGllbnQgZGVjaWRlIHRpbWluZyB0
byBjYWxsIGFzc2lnbiwgaXQgd2lsbCBiZSBsaWtlOg0KPiA+IGFzc2lnbiBhYWJiIHRvIGludGVy
bmFsIHJlZyAwDQo+ID4gd3JpdGUgcmVnIDAgKyAweDAwYzANCj4gPiB3cml0ZSByZWcgMCArIDB4
MDBkMA0KPiA+IA0KPiANCj4gT2ssIHRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbi4gSXMgdGhpcyBz
b21ldGhpbmcgeW91IGV4ZXBlY3QgdG8gc2VlIGluIHRoZSBnY2UNCj4gY29uc3VtZXIgZHJpdmVy
Pw0KPiANCg0KeWVzIGl0IGlzLCBsZXNzIGNvbW1hbmQgbWVhbnMgYmV0dGVyIHBlcmZvcm1hbmNl
IGFuZCBzYXZlIG1lbW9yeSwgc28gaXQNCmlzIGEgZ29vZCBwcmFjdGljZSBmb3IgY29uc3VtZXIu
DQoNCj4gPiANCj4gPiBUaGUgZmlyc3Qgd2F5IHVzZXMgNCBjb21tYW5kIGFuZCBzZWNvbmQgb25l
IHVzZXMgb25seSAzIGNvbW1hbmQuDQo+ID4gVGh1cyBpdCBpcyBiZXR0ZXIgdG8gbGV0IGNsaWVu
dCBjYWxsIGFzc2lnbiBleHBsaWNpdGx5Lg0KPiA+IA0KPiA+Pg0KPiA+PiBCeSB0aGUgd2F5LCB3
aHkgZG8geW91IHBvc3RmaXggdGhlIF9zLCBJIHVuZGVyc3RhbmQgdGhhdCBpdCByZWZsZWN0cyB0
aGUgbGFyZ2UNCj4gPj4gRE1BIGFjY2VzcyBidXQgSSB3b25kZXIgd2h5IHlvdSBjaG9vc2UgJ19z
Jy4NCj4gPj4NCj4gPiANCj4gPiBUaGUgbmFtZSBvZiB0aGlzIGNvbW1hbmQgaXMgIndyaXRlX3Mi
IHdoaWNoIGlzIGhhcmR3YXJlIHNwZWMuDQo+ID4gSSdtIGp1c3QgZm9sbG93aW5nIGl0IHNpbmNl
IGl0IGlzIGEgY29tbW9uIGxhbmd1YWdlIGJldHdlZW4gZ2NlIHN3L2h3DQo+ID4gZGVzaWduZXJz
Lg0KPiA+IA0KPiANCj4gT2ssIEkgd2lsbCBwcm9iYWJseSBoYXZlIHRvIGxvb2sgdGhhdCB1cCBl
dmVyeSB0aW1lIGhhdmUgYSBsb29rIGF0IHRoZSBkcml2ZXIsDQo+IGJ1dCB0aGF0J3MgT0suDQo+
IA0KDQpvayB0aGFua3MgZm9yIHlvdXIgY29tbWVudA0KDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0K
DQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gRGVu
bmlzDQo+ID4gDQo+ID4+IFJlZ2FyZHMsDQo+ID4+IE1hdHRoaWFzDQo+ID4+DQo+ID4+Pg0KPiA+
Pj4gUmVnYXJkcywNCj4gPj4+IERlbm5pcw0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFJlZ2FyZHMs
DQo+ID4+Pj4gTWF0dGhpYXMNCj4gPj4+Pg0KPiA+Pj4+PiArCXN0cnVjdCBjbWRxX2luc3RydWN0
aW9uIGluc3QgPSB7fTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCWluc3Qub3AgPSBDTURRX0NPREVf
V1JJVEVfUzsNCj4gPj4+Pj4gKwlpbnN0LnNyY190ID0gQ01EUV9SRUdfVFlQRTsNCj4gPj4+Pj4g
KwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KPiA+Pj4+PiArCWluc3Qub2Zmc2V0ID0g
YWRkcl9sb3c7DQo+ID4+Pj4+ICsJaW5zdC5zcmNfcmVnID0gc3JjX3JlZ19pZHg7DQo+ID4+Pj4+
ICsNCj4gPj4+Pj4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsN
Cj4gPj4+Pj4gK30NCj4gPj4+Pj4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfcyk7DQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiBldmVudCkNCj4gPj4+Pj4gIHsNCj4gPj4+Pj4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlv
biBpbnN0ID0geyB7MH0gfTsNCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+ID4+Pj4+IGluZGV4IDEyMWMzYmI2ZDNkZS4uZWU2N2RkM2I4NmY1IDEwMDY0
NA0KPiA+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5o
DQo+ID4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgN
Cj4gPj4+Pj4gQEAgLTU5LDYgKzU5LDcgQEAgZW51bSBjbWRxX2NvZGUgew0KPiA+Pj4+PiAgCUNN
RFFfQ09ERV9KVU1QID0gMHgxMCwNCj4gPj4+Pj4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4g
Pj4+Pj4gIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCj4gPj4+Pj4gKwlDTURRX0NPREVfV1JJVEVf
UyA9IDB4OTAsDQo+ID4+Pj4+ICAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gPj4+Pj4gIH07
DQo+ID4+Pj4+ICANCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+
ID4+Pj4+IGluZGV4IDgzMzQwMjExZTFkMy4uZTFjNWE3NTQ5YjRmIDEwMDY0NA0KPiA+Pj4+PiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4+Pj4+ICsrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPj4+Pj4gQEAgLTEyLDYg
KzEyLDggQEANCj4gPj4+Pj4gICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KPiA+Pj4+PiAgDQo+
ID4+Pj4+ICAjZGVmaW5lIENNRFFfTk9fVElNRU9VVAkJMHhmZmZmZmZmZnUNCj4gPj4+Pj4gKyNk
ZWZpbmUgQ01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIpKCgoYWRkcikgPj4gMTYpICYgR0VOTUFT
SygzMSwgMCkpKQ0KPiA+Pj4+PiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShh
ZGRyKSB8IEJJVCgxKSkNCj4gPj4+Pj4gIA0KPiA+Pj4+PiAgc3RydWN0IGNtZHFfcGt0Ow0KPiA+
Pj4+PiAgDQo+ID4+Pj4+IEBAIC0xMDMsNiArMTA1LDIzIEBAIGludCBjbWRxX3BrdF93cml0ZV9t
YXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4+Pj4+ICAJCQl1MTYgb2Zm
c2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gPj4+Pj4gIA0KPiA+Pj4+PiAgLyoqDQo+ID4+
Pj4+ICsgKiBjbWRxX3BrdF93cml0ZV9zKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRo
ZSBDTURRIHBhY2tldA0KPiA+Pj4+PiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4+Pj4+
ICsgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNvbnRh
aW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KPiA+Pj4+PiArICogQGFkZHJfbG93Oglsb3cgYWRkcmVz
cyBvZiBwYQ0KPiA+Pj4+PiArICogQHNyY19yZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdp
c3RlciBJRCB3aGljaCBjYWNoZSBzb3VyY2UgdmFsdWUNCj4gPj4+Pj4gKyAqDQo+ID4+Pj4+ICsg
KiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQN
Cj4gPj4+Pj4gKyAqDQo+ID4+Pj4+ICsgKiBTdXBwb3J0IHdyaXRlIHZhbHVlIHRvIHBoeXNpY2Fs
IGFkZHJlc3Mgd2l0aG91dCBzdWJzeXMuIFVzZSBDTURRX0FERFJfSElHSCgpDQo+ID4+Pj4+ICsg
KiB0byBnZXQgaGlnaCBhZGRyZXNzIGFuZCBjYWxsIGNtZHFfcGt0X2Fzc2lnbigpIHRvIGFzc2ln
biB2YWx1ZSBpbnRvIGludGVybmFsDQo+ID4+Pj4+ICsgKiByZWcuIEFsc28gdXNlIENNRFFfQURE
Ul9MT1coKSB0byBnZXQgbG93IGFkZHJlc3MgZm9yIGFkZHJfbG93IHBhcmFtZXRlciB3aGVuDQo+
ID4+Pj4+ICsgKiBjYWxsIHRvIHRoaXMgZnVuY3Rpb24uDQo+ID4+Pj4+ICsgKi8NCj4gPj4+Pj4g
K2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRy
X3JlZ19pZHgsDQo+ID4+Pj4+ICsJCSAgICAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgp
Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsvKioNCj4gPj4+Pj4gICAqIGNtZHFfcGt0X3dmZSgpIC0g
YXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4+Pj4+
ICAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPj4+Pj4gICAqIEBldmVudDoJdGhlIGRlc2ly
ZWQgZXZlbnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQo+ID4+Pj4+DQo+ID4+Pg0KPiA+IA0K
DQo=

