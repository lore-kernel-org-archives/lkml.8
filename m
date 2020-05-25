Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A10C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0653B20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TFV31XXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbgEYKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:38:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46190 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389165AbgEYKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:38:51 -0400
X-UUID: 2973e26015f74616917f96fbd69d82c3-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hP4MHL5rKzsU6+cwtk/2ybNDnctT2+yEC11C/Esk5/o=;
        b=TFV31XXk0/x4ej3Ymtimxwcrrma9XVcGvxZz7avtFxr2/iH2tEeES+QIuID+MfsKKeiNzCmLdv5KLmXSNa/sCoWuR0hWAM/0de5El/Gpr/QlfSjJImfN/eGlNB8NexisAOeNIxltC0n1gsAvJx0rdeiI0YToMZEalf8Med1Sv+w=;
X-UUID: 2973e26015f74616917f96fbd69d82c3-20200525
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1601699790; Mon, 25 May 2020 18:38:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 18:38:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 18:38:44 +0800
Message-ID: <1590403125.11988.5.camel@mtkswgap22>
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
Date:   Mon, 25 May 2020 18:38:45 +0800
In-Reply-To: <68535bf6-9824-5077-4811-374c893cdc03@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-10-git-send-email-dennis-yc.hsieh@mediatek.com>
         <f9fd9ea8-f706-ed4a-4c83-c53ad092035c@gmail.com>
         <1590341462.31286.19.camel@mtkswgap22>
         <eb604637-28f0-fa8f-ce4b-3e87f6c944ad@gmail.com>
         <1590373621.31522.7.camel@mtkswgap22>
         <68535bf6-9824-5077-4811-374c893cdc03@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7C8ADAEBEC808D17B27E76EFF3A38C58E804BDAD7674469778D687D1892779672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMjAtMDUtMjUgYXQgMTA6MzkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3Jv
dGU6DQo+IA0KPiBPbiAyNS8wNS8yMDIwIDA0OjI3LCBEZW5uaXMtWUMgSHNpZWggd3JvdGU6DQo+
ID4gDQo+ID4gT24gU3VuLCAyMDIwLTA1LTI0IGF0IDIwOjEzICswMjAwLCBNYXR0aGlhcyBCcnVn
Z2VyIHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiAyNC8wNS8yMDIwIDE5OjMxLCBEZW5uaXMtWUMgSHNp
ZWggd3JvdGU6DQo+ID4+PiBIaSBNYXR0aGlhcywNCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHlv
dXIgY29tbWVudC4NCj4gPj4+DQo+ID4+PiBPbiBTYXQsIDIwMjAtMDUtMTYgYXQgMjA6MjAgKzAy
MDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBPbiAwOC8wMy8yMDIw
IDExOjUyLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4+Pj4+IGFkZCB3cml0ZV9zIGZ1bmN0
aW9uIGluIGNtZHEgaGVscGVyIGZ1bmN0aW9ucyB3aGljaA0KPiA+Pj4+PiB3cml0ZXMgYSBjb25z
dGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGggbGFyZ2UgZG1hDQo+ID4+Pj4+IGFjY2VzcyBzdXBw
b3J0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRl
bm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4+Pj4+IFJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4+Pj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTQgKysr
KysrKysrKysrKysNCj4gPj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0K
PiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+
Pj4+PiBpbmRleCAwM2MxMjkyMzBjZDcuLmE5ZWJiYWJiNzQzOSAxMDA2NDQNCj4gPj4+Pj4gLS0t
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPj4+Pj4gKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPj4+Pj4gQEAgLTI2OSw2
ICsyNjksMzIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUx
NiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPj4+Pj4gIH0NCj4gPj4+Pj4gIEVYUE9SVF9TWU1CT0wo
Y21kcV9wa3Rfd3JpdGVfcyk7DQo+ID4+Pj4+ICANCj4gPj4+Pj4gK2ludCBjbWRxX3BrdF93cml0
ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+
ID4+Pj4+ICsJCQkgICB1MTYgYWRkcl9sb3csIHUzMiB2YWx1ZSwgdTMyIG1hc2spDQo+ID4+Pj4+
ICt7DQo+ID4+Pj4+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+
ID4+Pj4+ICsJaW50IGVycjsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCWlmIChtYXNrICE9IFUzMl9N
QVgpIHsNCj4gPj4+Pj4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiA+Pj4+PiArCQlp
bnN0Lm1hc2sgPSB+bWFzazsNCj4gPj4+Pj4gKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1h
bmQocGt0LCBpbnN0KTsNCj4gPj4+Pj4gKwkJaWYgKGVyciA8IDApDQo+ID4+Pj4+ICsJCQlyZXR1
cm4gZXJyOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVf
U19NQVNLOw0KPiA+Pj4+PiArCX0gZWxzZSB7DQo+ID4+Pj4+ICsJCWluc3Qub3AgPSBDTURRX0NP
REVfV1JJVEVfUzsNCj4gPj4+Pj4gKwl9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpbnN0LnNvcCA9
IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KPiA+Pj4+DQo+ID4+Pj4gV3JpdGluZyB1MTYgdmFsdWUgaW4g
YSA1IGJpdCB3aWRlIHZhcmlhYmxlPw0KPiA+Pj4NCj4gPj4+IFdlIG5lZWQgb25seSA1IGJpdHMg
aW4gdGhpcyBjYXNlLiBJJ2xsIGNoYW5nZSBoaWdoX2FkZHJfcmVnX2lkeA0KPiA+Pj4gcGFyYW1l
dGVyIHRvIHU4Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gT2ssIHBsZWFzZSBtYWtlIHN1cmUgdG8gbWFz
ayB0aGUgdmFsdWUsIHNvIHRoYXQgaXQncyBleHBsaWNpdCBpbiB0aGUgY29kZSB0aGF0DQo+ID4+
IHdlIG9ubHkgdXNlIHRoZSBsb3dlc3QgNSBiaXRzIG9mIGhpZ2hfYWRkcl9yZWdfaWR4Lg0KPiA+
IA0KPiA+IElzIGl0IG5lY2Vzc2FyeSB0byBtYXNrIHRoZSB2YWx1ZT8NCj4gPiBTaW5jZSBzb3Ag
YWxyZWFkeSBkZWZpbmVkIGFzICJ1OCBzb3A6NTsiLCBJIHRob3VnaHQgaXQgaXMgZXhwbGljaXQg
dGhhdA0KPiA+IG9ubHkgdXNlIDUgYml0cyBhbmQgY29tcGlsZXIgc2hvdWxkIGRvIHRoZSByZXN0
IGpvYnMuDQo+IA0KPiBZZXMgYnV0IGl0IG1ha2VzIHRoZSBjb2RlIG1vcmUgZXhwbGljaXQgaWYg
d2UgaGF2ZSBhDQo+IGluc3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHggJiAweDFmOw0KPiANCj4g
V2hhdCBkbyB5b3UgdGhpbms/DQoNClRoZSB2YWx1ZSBhc3NpZ24gdG8gc29wIHdpbGwgcmVzdHJp
Y3QgYnkgaGFyZHdhcmUgc3BlYy4gQ2xpZW50cyBjYWxsDQp0aGlzIGZ1bmN0aW9uIHdpbGwgZGVm
aW5lIGNvbnN0YW50IHZhbHVlIGFuZCB1c2UgaXQgYXMgcGFyYW1ldGVyLiBTbyBJDQp0aGluayB3
ZSBkb24ndCB3b3JyeSBhYm91dCBjbGllbnQgY2FsbCB0aGlzIGFwaSB3aXRoIHdyb25nIHZhbHVl
Lg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4g
DQo+ID4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBEZW5uaXMNCj4gPiANCj4gPj4NCj4gPj4g
UmVnYXJkcywNCj4gPj4gTWF0dGhpYXMNCj4gPj4NCj4gPj4+Pg0KPiA+Pj4+PiArCWluc3Qub2Zm
c2V0ID0gYWRkcl9sb3c7DQo+ID4+Pj4+ICsJaW5zdC52YWx1ZSA9IHZhbHVlOw0KPiA+Pj4+PiAr
DQo+ID4+Pj4+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+
ID4+Pj4+ICt9DQo+ID4+Pj4+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUp
Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgZXZlbnQpDQo+ID4+Pj4+ICB7DQo+ID4+Pj4+ICAJc3RydWN0IGNtZHFfaW5zdHJ1
Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiA+Pj4+PiBpbmRleCAwMWI0MTg0YWYzMTAuLmZlYzI5MmFhYzgzYyAxMDA2NDQN
Cj4gPj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+
Pj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4+Pj4+
IEBAIC0xMzUsNiArMTM1LDIwIEBAIGludCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwgdTE2IGFkZHJfbG93LA0KPiA+Pj4+PiAgaW50
IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVn
X2lkeCwNCj4gPj4+Pj4gIAkJICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCwgdTMy
IG1hc2spOw0KPiA+Pj4+PiAgDQo+ID4+Pj4+ICsvKioNCj4gPj4+Pj4gKyAqIGNtZHFfcGt0X3dy
aXRlX3NfdmFsdWUoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgd2l0aCBtYXNrIHRvIHRoZSBD
TURRDQo+ID4+Pj4+ICsgKgkJCSAgICAgIHBhY2tldCB3aGljaCB3cml0ZSB2YWx1ZSB0byBhIHBo
eXNpY2FsIGFkZHJlc3MNCj4gPj4+Pj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+Pj4+
PiArICogQGhpZ2hfYWRkcl9yZWdfaWR4OglpbnRlcm5hbCByZWdpc2dlciBJRCB3aGljaCBjb250
YWlucyBoaWdoIGFkZHJlc3Mgb2YgcGENCj4gPj4+Pg0KPiA+Pj4+IHJlZ2lzdGVyDQo+ID4+Pg0K
PiA+Pj4gd2lsbCBmaXgNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+IERlbm5p
cw0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiArICogQGFkZHJfbG93Oglsb3cgYWRkcmVzcyBvZiBw
YQ0KPiA+Pj4+PiArICogQHZhbHVlOgl0aGUgc3BlY2lmaWVkIHRhcmdldCB2YWx1ZQ0KPiA+Pj4+
PiArICogQG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IG1hc2sNCj4gPj4+Pj4gKyAqDQo+ID4+
Pj4+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0
dXJuZWQNCj4gPj4+Pj4gKyAqLw0KPiA+Pj4+PiAraW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPj4+Pj4gKwkJ
CSAgIHUxNiBhZGRyX2xvdywgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ID4+Pj4+ICsNCj4gPj4+
Pj4gIC8qKg0KPiA+Pj4+PiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZl
bnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPj4+Pj4gICAqIEBwa3Q6CXRoZSBDTURR
IHBhY2tldA0KPiA+Pj4+Pg0KPiA+Pj4NCj4gPiANCg0K

