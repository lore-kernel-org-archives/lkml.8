Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0E207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bx3/hFA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHEDOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:14:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6703 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgHEDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:14:21 -0400
X-UUID: 2a24126d4b0440638222c85524322c78-20200805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=et9EAKGQ+wvN9/4s+WLRmGJE+vHZKpAba9xuq5FFsmI=;
        b=Bx3/hFA/zXC1jrzapxoBLyQ/XMsneLCT+n0z+Nqxo/O0SAaC46FPBonzlAuZ7DKMtRqeXKDKE0ylYwLNXGkadU0dnRrP8XB/AMo7mutB3JRYtHcCQMIjQjTQQWKicN7ueYh9rGIGpXXQ6sABK2novuiLmkkpIDMMHiRnlY5sUXI=;
X-UUID: 2a24126d4b0440638222c85524322c78-20200805
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1194545868; Wed, 05 Aug 2020 11:14:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 5 Aug 2020 11:14:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Aug 2020 11:14:12 +0800
Message-ID: <1596597253.31794.7.camel@mtksdaap41>
Subject: Re: [v2,5/6] reset-controller: ti: Introduce force-update method
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Crystal Guo <crystal.guo@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>
Date:   Wed, 5 Aug 2020 11:14:13 +0800
In-Reply-To: <20200803061511.29555-6-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-6-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
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
dXBkYXRlX2ZvcmNlID0gZmFsc2U7DQoNCllvdSBhcmUgdXNpbmcgJ2ZvcmNlLXVwZGF0ZScgaW4g
Y29tbWl0IG1lc3NhZ2UsIGFuZCBJIHRoaW5rIHRoYXQgYQ0KYmV0dGVyIG9uZS4NClBsZWFzZSBj
aGFuZ2UgaXQgaWYgd2Ugc3RpbGwgbmVlZCB0aGlzIG9uZQ0KDQpKb2UuQw0K

