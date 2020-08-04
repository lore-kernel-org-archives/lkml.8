Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02FB2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QnKE1/cY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgHDEVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:21:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728622AbgHDEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:21:04 -0400
X-UUID: 39e593388b1e4787a80afa44b08ab321-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Yktds26mQO27rxfVid1topcTCyi1DOqMyji8rDcAx+Q=;
        b=QnKE1/cYdNQA4DxtVCekO5SKeeupV1mNbU70SFh1b+aZHbsQP/aB5HjKo2ep0xmHDtGQlc28C7IVP9hMPiWrFzOo5tPUkTirUzKdtxaBOc1f66RV/AQUDZ2pmiB74nXBUmfM47ZaLYGYR0JFNAf/T3MZrzOu5VPlARZEUPR/qEw=;
X-UUID: 39e593388b1e4787a80afa44b08ab321-20200804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 727586110; Tue, 04 Aug 2020 12:15:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 12:15:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 12:15:46 +0800
Message-ID: <1596514546.32283.29.camel@mtkswgap22>
Subject: Re: [v2,5/6] reset-controller: ti: Introduce force-update method
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Crystal Guo <crystal.guo@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>
Date:   Tue, 4 Aug 2020 12:15:46 +0800
In-Reply-To: <20200803061511.29555-6-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-6-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F731C297E4C566B4F072E2A72C27549312D9B54D96BA0768F50EF657855B62E32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTAzIGF0IDE0OjE1ICswODAwLCBDcnlzdGFsIEd1byB3cm90ZToNCj4g
SW50cm9kdWNlIGZvcmNlLXVwZGF0ZSBtZXRob2QgZm9yIGFzc2VydCBhbmQgZGVhc3NlcnQgaW50
ZXJmYWNlLA0KPiB3aGljaCBmb3JjZSB0aGUgd3JpdGUgb3BlcmF0aW9uIGluIGNhc2UgdGhlIHJl
YWQgYWxyZWFkeSBoYXBwZW5zDQo+IHRvIHJldHVybiB0aGUgY29ycmVjdCB2YWx1ZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyB8IDE1ICsrKysrKysrKysr
KystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyBiL2Ry
aXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gaW5kZXggMWM3NGJjYjlhNmMzLi5mNGJh
Zjc4YWZkMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMN
Cj4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiBAQCAtNTcsNiArNTcs
NyBAQCBzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgew0KPiAgCXN0cnVjdCB0aV9zeXNjb25f
cmVzZXRfY29udHJvbCAqY29udHJvbHM7DQo+ICAJdW5zaWduZWQgaW50IG5yX2NvbnRyb2xzOw0K
PiAgCWJvb2wgYXNzZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyOw0KPiArCWJvb2wgdXBkYXRlX2ZvcmNl
Ow0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSB0b190aV9zeXNjb25fcmVzZXRfZGF0YShyY2RldikJ
XA0KPiBAQCAtOTAsNyArOTEsMTAgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0
KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ICAJbWFzayA9IEJJVChjb250
cm9sLT5hc3NlcnRfYml0KTsNCj4gIAl2YWx1ZSA9IChjb250cm9sLT5mbGFncyAmIEFTU0VSVF9T
RVQpID8gbWFzayA6IDB4MDsNCj4gIA0KPiAtCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoZGF0
YS0+cmVnbWFwLCBjb250cm9sLT5hc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ICsJaWYg
KGRhdGEtPnVwZGF0ZV9mb3JjZSkNCj4gKwkJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEt
PnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiArCWVsc2UN
Cj4gKwkJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmFz
c2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IEBAIC0xMjEs
NyArMTI1LDEwIEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCBy
ZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ICAJbWFzayA9IEJJVChjb250cm9sLT5kZWFz
c2VydF9iaXQpOw0KPiAgCXZhbHVlID0gKGNvbnRyb2wtPmZsYWdzICYgREVBU1NFUlRfU0VUKSA/
IG1hc2sgOiAweDA7DQo+ICANCj4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJl
Z21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ICsJaWYgKGRh
dGEtPnVwZGF0ZV9mb3JjZSkNCj4gKwkJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJl
Z21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ICsJZWxzZQ0K
PiArCQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVh
c3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBAQCAtMjIz
LDYgKzIzMCwxMCBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlkYXRhLT5hc3NlcnRfZGVhc3NlcnRfdG9nZXRoZXIg
PSB0cnVlOw0KPiAgCWVsc2UNCj4gIAkJZGF0YS0+YXNzZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyID0g
ZmFsc2U7DQo+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgInVwZGF0ZS1mb3JjZSIp
KQ0KPiArCQlkYXRhLT51cGRhdGVfZm9yY2UgPSB0cnVlOw0KPiArCWVsc2UNCj4gKwkJZGF0YS0+
dXBkYXRlX2ZvcmNlID0gZmFsc2U7DQo+ICANCj4gIAlkYXRhLT5yY2Rldi5vcHMgPSAmdGlfc3lz
Y29uX3Jlc2V0X29wczsNCj4gIAlkYXRhLT5yY2Rldi5vd25lciA9IFRISVNfTU9EVUxFOw0KDQpU
aGlzIHBhdGNoIGlzIGdvb2QgdG8gaGVscCBNZWRpYVRlayBkcml2ZXJzJyB0cmFuc2l0aW9uIHRv
IHVzZQ0KdGktc3lzY29uLXJlc2V0LWNvbnRyb2xsZXIsIGFsc28gbm90IGhhdmUgc2lkZSBlZmZl
Y3QgdG8gZXhpc3RlZCB1c2Vycy4NCg0KQWNrZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNo
dUBtZWRpYXRlay5jb20+DQoNCg0K

