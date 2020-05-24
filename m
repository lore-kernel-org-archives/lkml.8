Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09169C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE51207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PtnRGiXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgEXRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:01:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46885 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728847AbgEXRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:01:42 -0400
X-UUID: c1861f6630564397b9c51b0e36a43069-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VWg9xLHl1hZCSOAWL6vw6qKUNe5aIY7KvlZ9nTgIkD0=;
        b=PtnRGiXHGb9NjV39BtEj1gEVvO0QO4zL0yD9hrYcKyZi2pXyb/GoETvF3vJA+kOuJAR8hXMrqQEGDM15Ky/xJm8ZHF065bRAkPVIVOPyT+C7D7yK5SbTJBmqwXb2v3jVMAtuO1W7+Q9PKuCFS2EsPd/TXdq/usJAifzL/OKdxHw=;
X-UUID: c1861f6630564397b9c51b0e36a43069-20200525
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1331326202; Mon, 25 May 2020 01:01:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:01:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:01:31 +0800
Message-ID: <1590339695.31286.4.camel@mtkswgap22>
Subject: Re: [PATCH v5 06/13] soc: mediatek: cmdq: add assign function
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
Date:   Mon, 25 May 2020 01:01:35 +0800
In-Reply-To: <c671ea8a-07fa-a050-4679-c7aa15d19a9d@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-7-git-send-email-dennis-yc.hsieh@mediatek.com>
         <c671ea8a-07fa-a050-4679-c7aa15d19a9d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2DF60E4E6D76568CECD68ACA0056E41726E257DA51C8FFE651A6CBAA28A26BFD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBTYXQsIDIwMjAt
MDUtMTYgYXQgMTk6NTkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAw
OC8wMy8yMDIwIDExOjUyLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gQWRkIGFzc2lnbiBm
dW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQgdmFsdWUgaW50bw0K
PiA+IGludGVybmFsIHJlZ2lzdGVyIGJ5IGluZGV4Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDI0ICsrKysrKysrKysrKysrKysr
KysrKysrLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwg
IDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTQg
KysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiBpbmRleCA5OGYyM2JhM2JhNDcuLjMzMTUzZDE3YzlkOSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTEyLDYgKzEyLDcgQEAN
Cj4gPiAgI2RlZmluZSBDTURRX1dSSVRFX0VOQUJMRV9NQVNLCUJJVCgwKQ0KPiA+ICAjZGVmaW5l
IENNRFFfUE9MTF9FTkFCTEVfTUFTSwlCSVQoMCkNCj4gPiAgI2RlZmluZSBDTURRX0VPQ19JUlFf
RU4JCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTENCj4gPiAgDQo+ID4gIHN0
cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPiAgCXVuaW9uIHsNCj4gPiBAQCAtMjEsOCArMjIs
MTcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KPiA+ICAJdW5pb24gew0KPiA+ICAJCXUx
NiBvZmZzZXQ7DQo+ID4gIAkJdTE2IGV2ZW50Ow0KPiA+ICsJCXUxNiByZWdfZHN0Ow0KPiA+ICsJ
fTsNCj4gPiArCXVuaW9uIHsNCj4gPiArCQl1OCBzdWJzeXM7DQo+ID4gKwkJc3RydWN0IHsNCj4g
PiArCQkJdTggc29wOjU7DQo+ID4gKwkJCXU4IGFyZ19jX3Q6MTsNCj4gPiArCQkJdTggYXJnX2Jf
dDoxOw0KPiA+ICsJCQl1OCBkc3RfdDoxOw0KPiA+ICsJCX07DQo+IA0KPiBUaGlzIHVuaW9uIHNl
ZW1zIHdpdGhvdXQgY29udGV4dCBpbiB0aGlzIHBhdGNoLiBQbGVhc2UgZHJvcC4NCj4gDQoNClRo
ZSBkc3RfdCB1c2UgaW4gY21kcV9wa3RfYXNzaWduIGZ1bmN0aW9uIHNvIGhvdyBhYm91dCBtZXJn
ZSBvdGhlcg0KdmFyaWFibGVzIHRvIHJlc2VydmVkIGFuZCBsZWF2ZSBkc3RfdCA/DQoNCnN0cnVj
dCB7DQoJdTggcmVzZXJ2ZWRfdDo3Ow0KCXU4IGRzdF90OjE7DQp9Ow0KDQoNClJlZ2FyZHMsDQpE
ZW5uaXMNCg0KDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+ICAJfTsNCj4gPiAtCXU4
IHN1YnN5czsNCj4gPiAgCXU4IG9wOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiBAQCAtMjc3LDYgKzI4
NywxOCBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBz
dWJzeXMsDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9wb2xsX21hc2spOw0K
PiA+ICANCj4gPiAraW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gaW5zdCA9IHsgezB9IH07DQo+ID4gKw0KPiA+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9MT0dJ
QzsNCj4gPiArCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiA+ICsJaW5zdC5yZWdfZHN0
ID0gcmVnX2lkeDsNCj4gPiArCWluc3QudmFsdWUgPSB2YWx1ZTsNCj4gPiArCXJldHVybiBjbWRx
X3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1C
T0woY21kcV9wa3RfYXNzaWduKTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgY21kcV9wa3RfZmlu
YWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBjbWRxX2lu
c3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaA0KPiA+IGluZGV4IGRmZTViMmViODVjYy4uMTIxYzNiYjZkM2RlIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gQEAg
LTU5LDYgKzU5LDcgQEAgZW51bSBjbWRxX2NvZGUgew0KPiA+ICAJQ01EUV9DT0RFX0pVTVAgPSAw
eDEwLA0KPiA+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+ID4gIAlDTURRX0NPREVfRU9DID0g
MHg0MCwNCj4gPiArCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQo+ID4gIH07DQo+ID4gIA0KPiA+
ICBlbnVtIGNtZHFfY2Jfc3RhdHVzIHsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gPiBpbmRleCBhNzRjMWQ1YWNkZjMuLjgzMzQwMjExZTFkMyAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0xNTIsNiArMTUyLDIw
IEBAIGludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+
ID4gICAqLw0KPiA+ICBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1OCBzdWJzeXMsDQo+ID4gIAkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1h
c2spOw0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X2Fzc2lnbigpIC0gQXBwZW5k
IGxvZ2ljIGFzc2lnbiBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRQ0KPiA+ICsg
KgkJICAgICAgIHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBzZXQgYSBjb25zdGFudCB2
YWx1ZSBpbnRvDQo+ID4gKyAqCQkgICAgICAgaW50ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2
YWx1ZSwgbWFzayBvciBhZGRyZXNzIGluDQo+ID4gKyAqCQkgICAgICAgcmVhZC93cml0ZSBpbnN0
cnVjdGlvbi4NCj4gPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEByZWdfaWR4
Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRA0KPiA+ICsgKiBAdmFsdWU6CXRoZSBzcGVj
aWZpZWQgdmFsdWUNCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNl
IHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3Rf
YXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4g
PiArDQo+ID4gIC8qKg0KPiA+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBD
TURRIHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gPiAgICogICAgICAgICAg
ICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBw
YWNrZXQNCj4gPiANCg0K

