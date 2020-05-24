Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6562C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C799920899
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M0cdk5PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgEXR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:26:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387707AbgEXR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:26:37 -0400
X-UUID: 8b2eaaaa314b4b85bb3a52b298e5eeb4-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Q7+n5IyoAxLjcdQC+D0mViZArPAyMtYuaRQrQ0r48VI=;
        b=M0cdk5PVc6rciqm7qEZ2lhccJ4xoWVs3eRekMKtmPiIkQtJElWFAcpTHnclyfB/sG1FarVmZgYqlidbZdWJoJhxDm5nNw0N/0gPqWyiHYUAyFP/e3+a1JU/7vePKBeKBwq504BvGIn0QkfEUMVdNlDpBu3Lf158ayk9diXP4lws=;
X-UUID: 8b2eaaaa314b4b85bb3a52b298e5eeb4-20200525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 483365700; Mon, 25 May 2020 01:26:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:26:23 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:26:23 +0800
Message-ID: <1590341186.31286.16.camel@mtkswgap22>
Subject: Re: [PATCH v5 07/13] soc: mediatek: cmdq: add write_s function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 25 May 2020 01:26:26 +0800
In-Reply-To: <58575c2c-0b5a-55c0-f3b0-082bfd4b6144@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-8-git-send-email-dennis-yc.hsieh@mediatek.com>
         <58575c2c-0b5a-55c0-f3b0-082bfd4b6144@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8E1590C94D6BBEE4965E4561F86ED76CB9E64840B3A46FD7D8D95E317159995C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGlhcywNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCk9uIFNhdCwgMjAyMC0w
NS0xNiBhdCAyMDoxNCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDA4
LzAzLzIwMjAgMTE6NTIsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBhZGQgd3JpdGVfcyBm
dW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2gNCj4gPiB3cml0ZXMgdmFsdWUg
Y29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0KPiA+IHdpdGggbGFyZ2Ug
ZG1hIGFjY2VzcyBzdXBwb3J0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBI
c2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ0sg
SHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDIgKysNCj4gPiAg
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDIwICsrKysrKysrKysr
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5k
ZXggMzMxNTNkMTdjOWQ5Li45MGYxZmYyYjRiMDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0xOCw2ICsxOCwxMCBAQCBzdHJ1Y3QgY21k
cV9pbnN0cnVjdGlvbiB7DQo+ID4gIAl1bmlvbiB7DQo+ID4gIAkJdTMyIHZhbHVlOw0KPiA+ICAJ
CXUzMiBtYXNrOw0KPiA+ICsJCXN0cnVjdCB7DQo+ID4gKwkJCXUxNiBhcmdfYzsNCj4gPiArCQkJ
dTE2IHNyY19yZWc7DQo+ID4gKwkJfTsNCj4gPiAgCX07DQo+ID4gIAl1bmlvbiB7DQo+ID4gIAkJ
dTE2IG9mZnNldDsNCj4gPiBAQCAtMjksNyArMzMsNyBAQCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlv
biB7DQo+ID4gIAkJc3RydWN0IHsNCj4gPiAgCQkJdTggc29wOjU7DQo+ID4gIAkJCXU4IGFyZ19j
X3Q6MTsNCj4gPiAtCQkJdTggYXJnX2JfdDoxOw0KPiA+ICsJCQl1OCBzcmNfdDoxOw0KPiANCj4g
Zml4aW5nIHBhdGNoIDYvMTMgcGxlYXNlLiBzZWVtcyB0aGUgc3RydWN0IHNob3VsZCBiZSBhZGRl
ZCBpbiB0aGlzIHBhdGNoLg0KDQpvaywgd2lsbCBtb3ZlIHRvIHRoaXMgcGF0Y2guDQoNCj4gDQo+
ID4gIAkJCXU4IGRzdF90OjE7DQo+ID4gIAkJfTsNCj4gPiAgCX07DQo+ID4gQEAgLTIyMiw2ICsy
MjYsMzQgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4
IHN1YnN5cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX21hc2sp
Ow0KPiA+ICANCj4gPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiArCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNy
Y19yZWdfaWR4LCB1MzIgbWFzaykNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gaW5zdCA9IHsgezB9IH07DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWlmIChtYXNr
ICE9IFUzMl9NQVgpIHsNCj4gPiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX01BU0s7DQo+ID4gKwkJ
aW5zdC5tYXNrID0gfm1hc2s7DQo+ID4gKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQo
cGt0LCBpbnN0KTsNCj4gPiArCQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4g
PiArDQo+ID4gKwkJaW5zdC5tYXNrID0gMDsNCj4gPiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dS
SVRFX1NfTUFTSzsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9X
UklURV9TOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWluc3Quc3JjX3QgPSBDTURRX1JFR19UWVBF
Ow0KPiANCj4gTm90IGRlZmluZWQuDQo+IFBsZWFzZSBtYWtlIHN1cmUgdGhhdCBldmVyeSBwYXRj
aCBjb21waWxlcyBvbiBpdCdzIG93biBhbmQgZG9lcyBub3QgYWRkIGENCj4gcmVncmVzc2lvbi4g
VGhpcyBpcyB2ZXJ5IGhlbHBmdWwgaWYgd2UgaGF2ZSB0byBiaXNlY3QgdGhlIGtlcm5lbCBpbiB0
aGUgZnV0dXJlLg0KDQpNYXkgSSBrbm93IHdoaWNoIHBhcnQgbm90IGRlZmluZWQ/IFRoZSBzcmNf
dCBkZWZpbmVkIG9uIHRvcCBvZiB0aGlzDQpwYXRjaCBhbmQgQ01EUV9SRUdfVFlQRSBkZWZpbmVk
IGluIGxhc3QgcGF0YyAoc2VlIDA2LzEzKS4NCg0KPiANCj4gPiArCWluc3Quc29wID0gaGlnaF9h
ZGRyX3JlZ19pZHg7DQo+ID4gKwlpbnN0Lm9mZnNldCA9IGFkZHJfbG93Ow0KPiA+ICsJaW5zdC5z
cmNfcmVnID0gc3JjX3JlZ19pZHg7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVu
ZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF93cml0ZV9zKTsNCj4gPiArDQo+ID4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
aW5zdCA9IHsgezB9IH07DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oDQo+ID4gaW5kZXggMTIxYzNiYjZkM2RlLi44ZWY4N2UxYmQwM2IgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBAQCAtNTksNiArNTks
OCBAQCBlbnVtIGNtZHFfY29kZSB7DQo+ID4gIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQo+ID4g
IAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gPiAgCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KPiA+
ICsJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KPiA+ICsJQ01EUV9DT0RFX1dSSVRFX1NfTUFT
SyA9IDB4OTEsDQo+ID4gIAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiA+ICB9Ow0KPiA+ICAN
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA4MzM0MDIx
MWUxZDMuLmM3MmQ4MjZkODkzNCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KPiA+IEBAIC0xMiw2ICsxMiw4IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC90
aW1lci5oPg0KPiA+ICANCj4gPiAgI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1
DQo+ID4gKyNkZWZpbmUgQ01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIpKCgoYWRkcikgPj4gMTYp
ICYgR0VOTUFTSygzMSwgMCkpKQ0KPiA+ICsjZGVmaW5lIENNRFFfQUREUl9MT1coYWRkcikJKCh1
MTYpKGFkZHIpIHwgQklUKDEpKQ0KPiA+ICANCj4gPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiA+ICAN
Cj4gPiBAQCAtMTAyLDYgKzEwNCwyNCBAQCBpbnQgY21kcV9wa3Rfd3JpdGUoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHU4IHN1YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCj4gPiAgaW50IGNt
ZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAg
CQkJdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ID4gIA0KPiA+ICsvKioNCj4g
PiArICogY21kcV9wa3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB0byB0aGUg
Q01EUSBwYWNrZXQNCj4gPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEBoaWdo
X2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBh
ZGRyZXNzIG9mIHBhDQo+IA0KPiBzL3JlZ2lzZ2VyL3JlZ2lzdGVyDQoNCndpbGwgZml4DQoNCj4g
DQo+ID4gKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGENCj4gPiArICogQHNyY19yZWdf
aWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjYWNoZSBzb3VyY2UgdmFs
dWUNCj4gPiArICogQG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNl
IFUzMl9NQVggaWYgbm8gbmVlZA0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nl
c3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gPiArICoNCj4gPiArICogU3Vw
cG9ydCB3cml0ZSB2YWx1ZSB0byBwaHlzaWNhbCBhZGRyZXNzIHdpdGhvdXQgc3Vic3lzLiBVc2Ug
Q01EUV9BRERSX0hJR0goKQ0KPiA+ICsgKiB0byBnZXQgaGlnaCBhZGRyZWVzIGFuZCBjYWxsIGNt
ZHFfcGt0X2Fzc2lnbigpIHRvIGFzc2lnbiB2YWx1ZSBpbnRvIGludGVybmFsDQo+IA0KPiBzL2Fk
ZHJlZXMvYWRkcmVzcw0KDQp3aWxsIGZpeA0KDQo+IA0KPiA+ICsgKiByZWcuIEFsc28gdXNlIENN
RFFfQUREUl9MT1coKSB0byBnZXQgbG93IGFkZHJlc3MgZm9yIGFkZHJfbG93IHBhcmFtZXRlcndo
ZW4NCj4gDQo+IHMvcGFyYW1ldGVyd2hlbi9wYXJhbWV0ZXIgd2hlbg0KDQp3aWxsIGZpeA0KDQo+
IA0KPiA+ICsgKiBjYWxsIHRvIHRoaXMgZnVuY3Rpb24uDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21k
cV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4
LA0KPiA+ICsJCSAgICAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKTsN
Cj4gPiArDQo+IA0KPiBJbiBnZW5lcmFsIEkgd29uZGVyIGlmIHdlIHNob3VsZG4ndCBwcm92aWRl
IHR3byBmdW5jdGlvbnMsIG9uZSB0aGF0IHdyaXRlcyBhDQo+IG1hc2sgYW5kIG9uIGZvciB0aGUg
ZWxzZSBjYXNlLg0KDQpvaywgSSdsbCBzZXBhcmF0ZSB0aGlzIGZ1bmN0aW9uIHRvIGNtZHFfcGt0
X3dyaXRlX3MgYW5kDQpjbWRxX3BrdF93cml0ZV9zX21hc2suIExldCB0aGUgY2xpZW50IGNob29z
ZSB3aGljaCBjYXNlIGlzIG1vcmUNCnN1aXRhYmxlLg0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1h
dHRoaWFzDQo+IA0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2Fp
dCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhl
IENNRFEgcGFja2V0DQo+ID4gDQoNCg==

