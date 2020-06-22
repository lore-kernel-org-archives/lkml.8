Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52896C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1409120716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jCcqeqWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgFVQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:13:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21124 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729275AbgFVQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:12:59 -0400
X-UUID: c557e0dc835144f1b10ce311e1b0fd89-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+hGMYQ5BeneB1BgmJmHHunz9V/JO0f6iK6J28OXcnV8=;
        b=jCcqeqWWx+R7jfddcukPXPBphvdK4ExueFOlsghv0JWpo56cBDxBtaiX+LpTx92qV3xgoSVBWKRvHGIJ2kZiJVNEJa2qIjOPYy3FlOXkazKU66TZjLJpUeyE51uYrqcWha43mdg+l1IOoQkPfgW4rmx1XY3SiXI8SQs7f69Oh8I=;
X-UUID: c557e0dc835144f1b10ce311e1b0fd89-20200623
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 202892470; Tue, 23 Jun 2020 00:12:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 00:12:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 00:12:48 +0800
Message-ID: <1592842372.3619.8.camel@mtkswgap22>
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
Date:   Tue, 23 Jun 2020 00:12:52 +0800
In-Reply-To: <8bdfff5f-9fa8-7a13-79d3-dcb63d587629@gmail.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592749115-24158-4-git-send-email-dennis-yc.hsieh@mediatek.com>
         <a9c6f28a-94d1-f92b-a017-935e80d0ec26@gmail.com>
         <1592840183.1307.12.camel@mtkswgap22>
         <8bdfff5f-9fa8-7a13-79d3-dcb63d587629@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCk9uIE1vbiwgMjAyMC0wNi0yMiBhdCAxNzo1NCArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDIyLzA2LzIwMjAgMTc6MzYsIERlbm5pcy1ZQyBI
c2llaCB3cm90ZToNCj4gPiBIaSBNYXR0aGlhcywNCj4gPiANCj4gPiB0aGFua3MgZm9yIHlvdXIg
Y29tbWVudC4NCj4gPiANCj4gPiBPbiBNb24sIDIwMjAtMDYtMjIgYXQgMTM6MDcgKzAyMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDIxLzA2LzIwMjAgMTY6MTgsIERl
bm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPj4+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEg
aGVscGVyIGZ1bmN0aW9ucyB3aGljaA0KPiA+Pj4gd3JpdGVzIHZhbHVlIGNvbnRhaW5zIGluIGlu
dGVybmFsIHJlZ2lzdGVyIHRvIGFkZHJlc3MNCj4gPj4+IHdpdGggbGFyZ2UgZG1hIGFjY2VzcyBz
dXBwb3J0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVu
bmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgIDE5ICsrKysrKysrKysrKysrKysrKysN
Cj4gPj4+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSAr
DQo+ID4+PiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTkg
KysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9u
cygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4+PiBpbmRleCBiZjMyZTNiMmNhNmMuLjgxN2E1YTk3ZGJlNSAxMDA2NDQNCj4gPj4+IC0tLSBh
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4+PiArKysgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+Pj4gQEAgLTE4LDYgKzE4LDEw
IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPj4+ICAJdW5pb24gew0KPiA+Pj4gIAkJ
dTMyIHZhbHVlOw0KPiA+Pj4gIAkJdTMyIG1hc2s7DQo+ID4+PiArCQlzdHJ1Y3Qgew0KPiA+Pj4g
KwkJCXUxNiBhcmdfYzsNCj4gPj4+ICsJCQl1MTYgc3JjX3JlZzsNCj4gPj4+ICsJCX07DQo+ID4+
PiAgCX07DQo+ID4+PiAgCXVuaW9uIHsNCj4gPj4+ICAJCXUxNiBvZmZzZXQ7DQo+ID4+PiBAQCAt
MjIyLDYgKzIyNiwyMSBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTggc3Vic3lzLA0KPiA+Pj4gIH0NCj4gPj4+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0
X3dyaXRlX21hc2spOw0KPiA+Pj4gIA0KPiA+Pj4gK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4+PiArCQkgICAgIHUx
NiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4KQ0KPiA+Pj4gK3sNCj4gPj4NCj4gPj4gRG8gSSB1
bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHdlIHVzZSBDTURRX0FERFJfSElHSChhZGRyKSBhbmQN
Cj4gPj4gQ01EUV9BRERSX0xPVyhhZGRyKSB0byBjYWxjdWxhdGUgaW4gdGhlIGNsaWVudCBoaWdo
X2FkZHJfcmVnX2lkeCBhbmQgYWRkcl9sb3cNCj4gPj4gcmVzcGVjdGl2ZWx5Pw0KPiA+Pg0KPiA+
PiBJbiB0aGF0IGNhc2UgSSB0aGluayBhIGJldHRlciBpbnRlcmZhY2Ugd291bGQgYmUgdG8gcGFz
cyB0aGUgYWRkcmVzcyBhbmQgZG8gdGhlDQo+ID4+IGhpZ2gvbG93IGNhbGN1bGF0aW9uIGluIHRo
ZSBjbWRxX3BrdF93cml0ZV9zDQo+ID4gDQo+ID4gTm90IGV4YWN0bHkuIFRoZSBoaWdoX2FkZHJf
cmVnX2lkeCBwYXJhbWV0ZXIgaXMgaW5kZXggb2YgaW50ZXJuYWwNCj4gPiByZWdpc3RlciAod2hp
Y2ggc3RvcmUgYWRkcmVzcyBiaXRbNDc6MTZdKSwgbm90IHJlc3VsdCBvZg0KPiA+IENNRFFfQURE
Ul9ISUdIKGFkZHIpLiANCj4gPiANCj4gPiBUaGUgQ01EUV9BRERSX0hJR0ggbWFjcm8gdXNlIGlu
IHBhdGNoIDAyLzExIGNtZHFfcGt0X2Fzc2lnbigpIGFwaS4gVGhpcw0KPiA+IGFwaSBoZWxwcyBh
c3NpZ24gYWRkcmVzcyBiaXRbNDc6MTZdIGludG8gb25lIG9mIGludGVybmFsIHJlZ2lzdGVyIGJ5
DQo+ID4gaW5kZXguIEFuZCBzYW1lIGluZGV4IGNvdWxkIGJlIHVzZSBpbiBjbWRxX3BrdF93cml0
ZV9zKCkuIFRoZSBnY2UNCj4gPiBjb21iaW5lIGJpdFs0NzoxNl0gaW4gaW50ZXJuYWwgcmVnaXN0
ZXIgYW5kIGJpdFsxNTowXSBpbiBhZGRyX2xvdw0KPiA+IHBhcmFtZXRlciB0byBmaW5hbCBhZGRy
ZXNzLiBTbyBpdCBpcyBiZXR0ZXIgdG8ga2VlcCBpbnRlcmZhY2UgaW4gdGhpcw0KPiA+IHdheS4N
Cj4gPiANCj4gDQo+IEdvdCBpdCwgYnV0IHRoZW4gd2h5IGRvbid0IHdlIGNhbGwgY21kcV9wa3Rf
YXNzaWduKCkgaW4gY21kcV9wa3Rfd3JpdGVfcygpPyBUaGlzDQo+IHdheSB3ZSB3b3VsZCBnZXQg
YSBjbGVhbiBBUEkgZm9yIHdoYXQgd2Ugd2FudCB0byBkby4NCj4gRG8gd2UgZXhwZWN0IG90aGVy
IHVzZXJzIG9mIGNtZHFfcGt0X2Fzc2lnbigpPyBPdGhlcndpc2Ugd2UgY291bGQga2VlcCBpdA0K
PiBwcml2YXRlIHRoZSB0aGlzIGZpbGUgYW5kIGRvbid0IGV4cG9ydCBpdC4NCg0KQ29uc2lkZXJp
bmcgdGhpcyBjYXNlOiB3cml0ZSAyIHJlZ2lzdGVyIDB4YWFiYjAwYzAgMHhhYWJiMDBkMC4NCg0K
SWYgd2UgY2FsbCBhc3NpZ24gaW5zaWRlIHdyaXRlX3MgYXBpIGl0IHdpbGwgYmU6DQphc3NpZ24g
YWFiYiB0byBpbnRlcm5hbCByZWcgMA0Kd3JpdGUgcmVnIDAgKyAweDAwYzANCmFzc2lnbiBhYWJi
IHRvIGludGVybmFsIHJlZyAwDQp3cml0ZSByZWcgMCArIDB4MDBkMA0KDQoNCkJ1dCBpZiB3ZSBs
ZXQgY2xpZW50IGRlY2lkZSB0aW1pbmcgdG8gY2FsbCBhc3NpZ24sIGl0IHdpbGwgYmUgbGlrZToN
CmFzc2lnbiBhYWJiIHRvIGludGVybmFsIHJlZyAwDQp3cml0ZSByZWcgMCArIDB4MDBjMA0Kd3Jp
dGUgcmVnIDAgKyAweDAwZDANCg0KDQpUaGUgZmlyc3Qgd2F5IHVzZXMgNCBjb21tYW5kIGFuZCBz
ZWNvbmQgb25lIHVzZXMgb25seSAzIGNvbW1hbmQuDQpUaHVzIGl0IGlzIGJldHRlciB0byBsZXQg
Y2xpZW50IGNhbGwgYXNzaWduIGV4cGxpY2l0bHkuDQoNCj4gDQo+IEJ5IHRoZSB3YXksIHdoeSBk
byB5b3UgcG9zdGZpeCB0aGUgX3MsIEkgdW5kZXJzdGFuZCB0aGF0IGl0IHJlZmxlY3RzIHRoZSBs
YXJnZQ0KPiBETUEgYWNjZXNzIGJ1dCBJIHdvbmRlciB3aHkgeW91IGNob29zZSAnX3MnLg0KPiAN
Cg0KVGhlIG5hbWUgb2YgdGhpcyBjb21tYW5kIGlzICJ3cml0ZV9zIiB3aGljaCBpcyBoYXJkd2Fy
ZSBzcGVjLg0KSSdtIGp1c3QgZm9sbG93aW5nIGl0IHNpbmNlIGl0IGlzIGEgY29tbW9uIGxhbmd1
YWdlIGJldHdlZW4gZ2NlIHN3L2h3DQpkZXNpZ25lcnMuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0K
DQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gRGVu
bmlzDQo+ID4gDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IE1hdHRoaWFzDQo+ID4+DQo+ID4+
PiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7fTsNCj4gPj4+ICsNCj4gPj4+ICsJ
aW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TOw0KPiA+Pj4gKwlpbnN0LnNyY190ID0gQ01EUV9S
RUdfVFlQRTsNCj4gPj4+ICsJaW5zdC5zb3AgPSBoaWdoX2FkZHJfcmVnX2lkeDsNCj4gPj4+ICsJ
aW5zdC5vZmZzZXQgPSBhZGRyX2xvdzsNCj4gPj4+ICsJaW5zdC5zcmNfcmVnID0gc3JjX3JlZ19p
ZHg7DQo+ID4+PiArDQo+ID4+PiArCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3Qs
IGluc3QpOw0KPiA+Pj4gK30NCj4gPj4+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3Mp
Ow0KPiA+Pj4gKw0KPiA+Pj4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiBldmVudCkNCj4gPj4+ICB7DQo+ID4+PiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oDQo+ID4+PiBpbmRleCAxMjFjM2JiNmQzZGUuLmVlNjdkZDNiODZmNSAxMDA2NDQNCj4gPj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPj4+ICsr
KyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPj4+IEBAIC01
OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gPj4+ICAJQ01EUV9DT0RFX0pVTVAgPSAw
eDEwLA0KPiA+Pj4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gPj4+ICAJQ01EUV9DT0RFX0VP
QyA9IDB4NDAsDQo+ID4+PiArCUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCj4gPj4+ICAJQ01E
UV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gPj4+ICB9Ow0KPiA+Pj4gIA0KPiA+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4+PiBpbmRleCA4MzM0MDIxMWUxZDMuLmUxYzVh
NzU0OWI0ZiAxMDA2NDQNCj4gPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCj4gPj4+IEBAIC0xMiw2ICsxMiw4IEBADQo+ID4+PiAgI2luY2x1ZGUgPGxpbnV4L3RpbWVy
Lmg+DQo+ID4+PiAgDQo+ID4+PiAgI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1
DQo+ID4+PiArI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAx
NikgJiBHRU5NQVNLKDMxLCAwKSkpDQo+ID4+PiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIp
CSgodTE2KShhZGRyKSB8IEJJVCgxKSkNCj4gPj4+ICANCj4gPj4+ICBzdHJ1Y3QgY21kcV9wa3Q7
DQo+ID4+PiAgDQo+ID4+PiBAQCAtMTAzLDYgKzEwNSwyMyBAQCBpbnQgY21kcV9wa3Rfd3JpdGVf
bWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+Pj4gIAkJCXUxNiBvZmZz
ZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KPiA+Pj4gIA0KPiA+Pj4gIC8qKg0KPiA+Pj4gKyAq
IGNtZHFfcGt0X3dyaXRlX3MoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEg
cGFja2V0DQo+ID4+PiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4+PiArICogQGhpZ2hf
YWRkcl9yZWdfaWR4OglpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjb250YWlucyBoaWdoIGFk
ZHJlc3Mgb2YgcGENCj4gPj4+ICsgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNzIG9mIHBhDQo+ID4+
PiArICogQHNyY19yZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBj
YWNoZSBzb3VyY2UgdmFsdWUNCj4gPj4+ICsgKg0KPiA+Pj4gKyAqIFJldHVybjogMCBmb3Igc3Vj
Y2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiA+Pj4gKyAqDQo+ID4+PiAr
ICogU3VwcG9ydCB3cml0ZSB2YWx1ZSB0byBwaHlzaWNhbCBhZGRyZXNzIHdpdGhvdXQgc3Vic3lz
LiBVc2UgQ01EUV9BRERSX0hJR0goKQ0KPiA+Pj4gKyAqIHRvIGdldCBoaWdoIGFkZHJlc3MgYW5k
IGNhbGwgY21kcV9wa3RfYXNzaWduKCkgdG8gYXNzaWduIHZhbHVlIGludG8gaW50ZXJuYWwNCj4g
Pj4+ICsgKiByZWcuIEFsc28gdXNlIENNRFFfQUREUl9MT1coKSB0byBnZXQgbG93IGFkZHJlc3Mg
Zm9yIGFkZHJfbG93IHBhcmFtZXRlciB3aGVuDQo+ID4+PiArICogY2FsbCB0byB0aGlzIGZ1bmN0
aW9uLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4+PiArCQkgICAgIHUxNiBhZGRy
X2xvdywgdTE2IHNyY19yZWdfaWR4KTsNCj4gPj4+ICsNCj4gPj4+ICsvKioNCj4gPj4+ICAgKiBj
bWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURR
IHBhY2tldA0KPiA+Pj4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+Pj4gICAqIEBldmVu
dDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQo+ID4+Pg0KPiA+
IA0KDQo=

