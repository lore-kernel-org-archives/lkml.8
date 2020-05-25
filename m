Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 02:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2719C20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 02:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A9+20zyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbgEYC1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 22:27:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26531 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388375AbgEYC1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 22:27:09 -0400
X-UUID: 4fc6df781b9b4a069b5cc16a77390c77-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iCgaqwFsUfvQyQOBvfXfyk2ReBUFB1D+FN/5yAizTjQ=;
        b=A9+20zyQu4UmAW9DpAVHlg23ZdynfSZzOahsLkXaj9IjywU/R0exT/SAOvQ+G1ZxjSwrVRtzwmk2Ed8QQV7vvX6f2RSCETJwMS88O9FUxRN6O3exb2WLAuBDn7BMJ+MJuw87j/JNBhW2/oaMZZAylBZDVSN7uyH+aAwNRr2stx4=;
X-UUID: 4fc6df781b9b4a069b5cc16a77390c77-20200525
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1671043586; Mon, 25 May 2020 10:27:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 10:27:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 10:27:00 +0800
Message-ID: <1590373621.31522.7.camel@mtkswgap22>
Subject: Re: [PATCH v5 09/13] soc: mediatek: cmdq: add write_s value function
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
Date:   Mon, 25 May 2020 10:27:01 +0800
In-Reply-To: <eb604637-28f0-fa8f-ce4b-3e87f6c944ad@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-10-git-send-email-dennis-yc.hsieh@mediatek.com>
         <f9fd9ea8-f706-ed4a-4c83-c53ad092035c@gmail.com>
         <1590341462.31286.19.camel@mtkswgap22>
         <eb604637-28f0-fa8f-ce4b-3e87f6c944ad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTdW4sIDIwMjAtMDUtMjQgYXQgMjA6MTMgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3Jv
dGU6DQo+IA0KPiBPbiAyNC8wNS8yMDIwIDE5OjMxLCBEZW5uaXMtWUMgSHNpZWggd3JvdGU6DQo+
ID4gSGkgTWF0dGhpYXMsDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQo+ID4g
DQo+ID4gT24gU2F0LCAyMDIwLTA1LTE2IGF0IDIwOjIwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2Vy
IHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiAwOC8wMy8yMDIwIDExOjUyLCBEZW5uaXMgWUMgSHNpZWgg
d3JvdGU6DQo+ID4+PiBhZGQgd3JpdGVfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlv
bnMgd2hpY2gNCj4gPj4+IHdyaXRlcyBhIGNvbnN0YW50IHZhbHVlIHRvIGFkZHJlc3Mgd2l0aCBs
YXJnZSBkbWENCj4gPj4+IGFjY2VzcyBzdXBwb3J0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPj4+
IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAyNiArKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+Pj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggIHwgMTQgKysrKysrKysrKysrKysNCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQwIGlu
c2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+Pj4gaW5kZXggMDNjMTI5MjMwY2Q3Li5hOWViYmFiYjc0MzkgMTAwNjQ0DQo+ID4+
PiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPj4+IEBAIC0yNjks
NiArMjY5LDMyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1
MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4+PiAgfQ0KPiA+Pj4gIEVYUE9SVF9TWU1CT0woY21k
cV9wa3Rfd3JpdGVfcyk7DQo+ID4+PiAgDQo+ID4+PiAraW50IGNtZHFfcGt0X3dyaXRlX3NfdmFs
dWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPj4+ICsJ
CQkgICB1MTYgYWRkcl9sb3csIHUzMiB2YWx1ZSwgdTMyIG1hc2spDQo+ID4+PiArew0KPiA+Pj4g
KwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPj4+ICsJaW50IGVy
cjsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0KPiA+Pj4gKwkJaW5z
dC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiA+Pj4gKwkJaW5zdC5tYXNrID0gfm1hc2s7DQo+ID4+
PiArCQllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+Pj4gKwkJ
aWYgKGVyciA8IDApDQo+ID4+PiArCQkJcmV0dXJuIGVycjsNCj4gPj4+ICsNCj4gPj4+ICsJCWlu
c3Qub3AgPSBDTURRX0NPREVfV1JJVEVfU19NQVNLOw0KPiA+Pj4gKwl9IGVsc2Ugew0KPiA+Pj4g
KwkJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TOw0KPiA+Pj4gKwl9DQo+ID4+PiArDQo+ID4+
PiArCWluc3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQo+ID4+DQo+ID4+IFdyaXRpbmcgdTE2
IHZhbHVlIGluIGEgNSBiaXQgd2lkZSB2YXJpYWJsZT8NCj4gPiANCj4gPiBXZSBuZWVkIG9ubHkg
NSBiaXRzIGluIHRoaXMgY2FzZS4gSSdsbCBjaGFuZ2UgaGlnaF9hZGRyX3JlZ19pZHgNCj4gPiBw
YXJhbWV0ZXIgdG8gdTguDQo+ID4gDQo+IA0KPiBPaywgcGxlYXNlIG1ha2Ugc3VyZSB0byBtYXNr
IHRoZSB2YWx1ZSwgc28gdGhhdCBpdCdzIGV4cGxpY2l0IGluIHRoZSBjb2RlIHRoYXQNCj4gd2Ug
b25seSB1c2UgdGhlIGxvd2VzdCA1IGJpdHMgb2YgaGlnaF9hZGRyX3JlZ19pZHguDQoNCklzIGl0
IG5lY2Vzc2FyeSB0byBtYXNrIHRoZSB2YWx1ZT8NClNpbmNlIHNvcCBhbHJlYWR5IGRlZmluZWQg
YXMgInU4IHNvcDo1OyIsIEkgdGhvdWdodCBpdCBpcyBleHBsaWNpdCB0aGF0DQpvbmx5IHVzZSA1
IGJpdHMgYW5kIGNvbXBpbGVyIHNob3VsZCBkbyB0aGUgcmVzdCBqb2JzLg0KDQoNClJlZ2FyZHMs
DQpEZW5uaXMNCg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQo+ID4+DQo+ID4+PiAr
CWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQo+ID4+PiArCWluc3QudmFsdWUgPSB2YWx1ZTsNCj4g
Pj4+ICsNCj4gPj4+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7
DQo+ID4+PiArfQ0KPiA+Pj4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc192YWx1ZSk7
DQo+ID4+PiArDQo+ID4+PiAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGV2ZW50KQ0KPiA+Pj4gIHsNCj4gPj4+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5z
dCA9IHsgezB9IH07DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
Pj4+IGluZGV4IDAxYjQxODRhZjMxMC4uZmVjMjkyYWFjODNjIDEwMDY0NA0KPiA+Pj4gLS0tIGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+Pj4gKysrIGIvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+Pj4gQEAgLTEzNSw2ICsxMzUsMjAg
QEAgaW50IGNtZHFfcGt0X3JlYWRfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRk
cl9yZWdfaWR4LCB1MTYgYWRkcl9sb3csDQo+ID4+PiAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPj4+ICAJCSAgICAg
dTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKTsNCj4gPj4+ICANCj4gPj4+
ICsvKioNCj4gPj4+ICsgKiBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKCkgLSBhcHBlbmQgd3JpdGVf
cyBjb21tYW5kIHdpdGggbWFzayB0byB0aGUgQ01EUQ0KPiA+Pj4gKyAqCQkJICAgICAgcGFja2V0
IHdoaWNoIHdyaXRlIHZhbHVlIHRvIGEgcGh5c2ljYWwgYWRkcmVzcw0KPiA+Pj4gKyAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KPiA+Pj4gKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwg
cmVnaXNnZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQo+ID4+DQo+ID4+
IHJlZ2lzdGVyDQo+ID4gDQo+ID4gd2lsbCBmaXgNCj4gPiANCj4gPiANCj4gPiBSZWdhcmRzLA0K
PiA+IERlbm5pcw0KPiA+IA0KPiA+Pg0KPiA+Pj4gKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mg
b2YgcGENCj4gPj4+ICsgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQo+ID4+
PiArICogQG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IG1hc2sNCj4gPj4+ICsgKg0KPiA+Pj4g
KyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5l
ZA0KPiA+Pj4gKyAqLw0KPiA+Pj4gK2ludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4+PiArCQkJICAgdTE2IGFk
ZHJfbG93LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gPj4+ICsNCj4gPj4+ICAvKioNCj4gPj4+
ICAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRo
ZSBDTURRIHBhY2tldA0KPiA+Pj4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+Pj4NCj4g
PiANCg0K

