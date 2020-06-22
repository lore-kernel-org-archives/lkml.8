Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558002071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kh07k9mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgFVPga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:36:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42271 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728911AbgFVPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:36:29 -0400
X-UUID: 953dfad5722f44c9a217319518176f26-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qdItIghJblrh+db3nUEdEkdirsZuBwUJohdvjwiFA2g=;
        b=Kh07k9mIL6TjTltkdT1EqxEwMOXT7Lz3joV7xWNrJ3KwrfRNiPQW6KUIPeynAHRzEBxEyOeZDiR0admpp+yqpKqRdTGJCaZaoBJsXLkwi8Ax1GQZQp/uFrYOpqKwBoc+pE2eTdn6xQ74iOtpp2blVbcFizKdDxecHZwiX0ETk+E=;
X-UUID: 953dfad5722f44c9a217319518176f26-20200622
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2018445330; Mon, 22 Jun 2020 23:36:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 23:36:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 23:36:19 +0800
Message-ID: <1592840183.1307.12.camel@mtkswgap22>
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
Date:   Mon, 22 Jun 2020 23:36:23 +0800
In-Reply-To: <a9c6f28a-94d1-f92b-a017-935e80d0ec26@gmail.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592749115-24158-4-git-send-email-dennis-yc.hsieh@mediatek.com>
         <a9c6f28a-94d1-f92b-a017-935e80d0ec26@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBNb24sIDIwMjAt
MDYtMjIgYXQgMTM6MDcgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAy
MS8wNi8yMDIwIDE2OjE4LCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gYWRkIHdyaXRlX3Mg
ZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQo+ID4gd3JpdGVzIHZhbHVl
IGNvbnRhaW5zIGluIGludGVybmFsIHJlZ2lzdGVyIHRvIGFkZHJlc3MNCj4gPiB3aXRoIGxhcmdl
IGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgIDE5ICsrKysrKysrKysrKysr
KysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAg
IDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAx
OSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4g
aW5kZXggYmYzMmUzYjJjYTZjLi44MTdhNWE5N2RiZTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0xOCw2ICsxOCwxMCBAQCBzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiB7DQo+ID4gIAl1bmlvbiB7DQo+ID4gIAkJdTMyIHZhbHVlOw0KPiA+
ICAJCXUzMiBtYXNrOw0KPiA+ICsJCXN0cnVjdCB7DQo+ID4gKwkJCXUxNiBhcmdfYzsNCj4gPiAr
CQkJdTE2IHNyY19yZWc7DQo+ID4gKwkJfTsNCj4gPiAgCX07DQo+ID4gIAl1bmlvbiB7DQo+ID4g
IAkJdTE2IG9mZnNldDsNCj4gPiBAQCAtMjIyLDYgKzIyNiwyMSBAQCBpbnQgY21kcV9wa3Rfd3Jp
dGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+ICB9DQo+ID4gIEVY
UE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfbWFzayk7DQo+ID4gIA0KPiA+ICtpbnQgY21kcV9w
a3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0K
PiA+ICsJCSAgICAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgpDQo+ID4gK3sNCj4gDQo+
IERvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB3ZSB1c2UgQ01EUV9BRERSX0hJR0goYWRk
cikgYW5kDQo+IENNRFFfQUREUl9MT1coYWRkcikgdG8gY2FsY3VsYXRlIGluIHRoZSBjbGllbnQg
aGlnaF9hZGRyX3JlZ19pZHggYW5kIGFkZHJfbG93DQo+IHJlc3BlY3RpdmVseT8NCj4gDQo+IElu
IHRoYXQgY2FzZSBJIHRoaW5rIGEgYmV0dGVyIGludGVyZmFjZSB3b3VsZCBiZSB0byBwYXNzIHRo
ZSBhZGRyZXNzIGFuZCBkbyB0aGUNCj4gaGlnaC9sb3cgY2FsY3VsYXRpb24gaW4gdGhlIGNtZHFf
cGt0X3dyaXRlX3MNCg0KTm90IGV4YWN0bHkuIFRoZSBoaWdoX2FkZHJfcmVnX2lkeCBwYXJhbWV0
ZXIgaXMgaW5kZXggb2YgaW50ZXJuYWwNCnJlZ2lzdGVyICh3aGljaCBzdG9yZSBhZGRyZXNzIGJp
dFs0NzoxNl0pLCBub3QgcmVzdWx0IG9mDQpDTURRX0FERFJfSElHSChhZGRyKS4gDQoNClRoZSBD
TURRX0FERFJfSElHSCBtYWNybyB1c2UgaW4gcGF0Y2ggMDIvMTEgY21kcV9wa3RfYXNzaWduKCkg
YXBpLiBUaGlzDQphcGkgaGVscHMgYXNzaWduIGFkZHJlc3MgYml0WzQ3OjE2XSBpbnRvIG9uZSBv
ZiBpbnRlcm5hbCByZWdpc3RlciBieQ0KaW5kZXguIEFuZCBzYW1lIGluZGV4IGNvdWxkIGJlIHVz
ZSBpbiBjbWRxX3BrdF93cml0ZV9zKCkuIFRoZSBnY2UNCmNvbWJpbmUgYml0WzQ3OjE2XSBpbiBp
bnRlcm5hbCByZWdpc3RlciBhbmQgYml0WzE1OjBdIGluIGFkZHJfbG93DQpwYXJhbWV0ZXIgdG8g
ZmluYWwgYWRkcmVzcy4gU28gaXQgaXMgYmV0dGVyIHRvIGtlZXAgaW50ZXJmYWNlIGluIHRoaXMN
CndheS4NCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFz
DQo+IA0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0KPiA+ICsNCj4g
PiArCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCj4gPiArCWluc3Quc3JjX3QgPSBDTURR
X1JFR19UWVBFOw0KPiA+ICsJaW5zdC5zb3AgPSBoaWdoX2FkZHJfcmVnX2lkeDsNCj4gPiArCWlu
c3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQo+ID4gKwlpbnN0LnNyY19yZWcgPSBzcmNfcmVnX2lkeDsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsN
Cj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KPiA+ICsNCj4g
PiAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KPiA+
ICB7DQo+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBpbmRleCAxMjFjM2Ji
NmQzZGUuLmVlNjdkZDNiODZmNSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC01OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsN
Cj4gPiAgCUNNRFFfQ09ERV9KVU1QID0gMHgxMCwNCj4gPiAgCUNNRFFfQ09ERV9XRkUgPSAweDIw
LA0KPiA+ICAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQo+ID4gKwlDTURRX0NPREVfV1JJVEVfUyA9
IDB4OTAsDQo+ID4gIAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiA+ICB9Ow0KPiA+ICANCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA4MzM0MDIxMWUx
ZDMuLmUxYzVhNzU0OWI0ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiA+IEBAIC0xMiw2ICsxMiw4IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC90aW1l
ci5oPg0KPiA+ICANCj4gPiAgI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1DQo+
ID4gKyNkZWZpbmUgQ01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIpKCgoYWRkcikgPj4gMTYpICYg
R0VOTUFTSygzMSwgMCkpKQ0KPiA+ICsjZGVmaW5lIENNRFFfQUREUl9MT1coYWRkcikJKCh1MTYp
KGFkZHIpIHwgQklUKDEpKQ0KPiA+ICANCj4gPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiA+ICANCj4g
PiBAQCAtMTAzLDYgKzEwNSwyMyBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+ICAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUz
MiBtYXNrKTsNCj4gPiAgDQo+ID4gIC8qKg0KPiA+ICsgKiBjbWRxX3BrdF93cml0ZV9zKCkgLSBh
cHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAcGt0Ogl0
aGUgQ01EUSBwYWNrZXQNCj4gPiArICogQGhpZ2hfYWRkcl9yZWdfaWR4OglpbnRlcm5hbCByZWdp
c3RlciBJRCB3aGljaCBjb250YWlucyBoaWdoIGFkZHJlc3Mgb2YgcGENCj4gPiArICogQGFkZHJf
bG93Oglsb3cgYWRkcmVzcyBvZiBwYQ0KPiA+ICsgKiBAc3JjX3JlZ19pZHg6CXRoZSBDTURRIGlu
dGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KPiA+ICsgKg0KPiA+
ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJu
ZWQNCj4gPiArICoNCj4gPiArICogU3VwcG9ydCB3cml0ZSB2YWx1ZSB0byBwaHlzaWNhbCBhZGRy
ZXNzIHdpdGhvdXQgc3Vic3lzLiBVc2UgQ01EUV9BRERSX0hJR0goKQ0KPiA+ICsgKiB0byBnZXQg
aGlnaCBhZGRyZXNzIGFuZCBjYWxsIGNtZHFfcGt0X2Fzc2lnbigpIHRvIGFzc2lnbiB2YWx1ZSBp
bnRvIGludGVybmFsDQo+ID4gKyAqIHJlZy4gQWxzbyB1c2UgQ01EUV9BRERSX0xPVygpIHRvIGdl
dCBsb3cgYWRkcmVzcyBmb3IgYWRkcl9sb3cgcGFyYW1ldGVyIHdoZW4NCj4gPiArICogY2FsbCB0
byB0aGlzIGZ1bmN0aW9uLg0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiArCQkgICAgIHUx
NiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4KTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICAgKiBj
bWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURR
IHBhY2tldA0KPiA+ICAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQGV2ZW50Ogl0
aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCj4gPiANCg0K

