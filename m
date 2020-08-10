Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE5E206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CVnQ6MNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgHJG6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:58:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11952 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbgHJG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:58:36 -0400
X-UUID: 096ba63b8a454e67b433807ce0f6b6e5-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Xw9BjZ4pnzLPpecBByDNDqBMr0STEN5PIXp+ijmFw1o=;
        b=CVnQ6MNdd+98Yf1QkoGZ1+qh6kLncmNYqDm6rNNlVR/CWrjaUMYFbhixEtjnukXhEsK1mJ60jLjZIuqfMEuSHAZpdmHWsY0WeLzO1LrFoc67e4nkYpq2KPLWrS8MOjuJuk9WrnIMUFezFE79wKvIn8JLEZzaGseggxiwlESZYro=;
X-UUID: 096ba63b8a454e67b433807ce0f6b6e5-20200810
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1749163730; Mon, 10 Aug 2020 14:58:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 Aug
 2020 14:58:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 14:58:24 +0800
Message-ID: <1597042656.11360.39.camel@mhfsdcap03>
Subject: Re: [v2,5/6] reset-controller: ti: Introduce force-update method
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>, "Suman Anna" <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>
Date:   Mon, 10 Aug 2020 14:57:36 +0800
In-Reply-To: <3413ca889fcef11c6dafe1d6b135e1887d84a6e4.camel@pengutronix.de>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-6-crystal.guo@mediatek.com>
         <3413ca889fcef11c6dafe1d6b135e1887d84a6e4.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 51D951749A9B482193787EAABBD8C446E680275178669CECFC7FA62C607318CF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTA0IGF0IDE1OjAzICswODAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBDcnlzdGFsLA0KPiANCj4gT24gTW9uLCAyMDIwLTA4LTAzIGF0IDE0OjE1ICswODAwLCBD
cnlzdGFsIEd1byB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgZm9yY2UtdXBkYXRlIG1ldGhvZCBmb3Ig
YXNzZXJ0IGFuZCBkZWFzc2VydCBpbnRlcmZhY2UsDQo+ID4gd2hpY2ggZm9yY2UgdGhlIHdyaXRl
IG9wZXJhdGlvbiBpbiBjYXNlIHRoZSByZWFkIGFscmVhZHkgaGFwcGVucw0KPiA+IHRvIHJldHVy
biB0aGUgY29ycmVjdCB2YWx1ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1
byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiANCj4gQWRkZWQgU3VtYW4gYW5kIEFuZHJl
dyBmb3IgY29uZmlybWF0aW9uOiBJIHRoaW5rIHdyaXRpbmcgdW5jb25kaXRpb25hbGx5DQo+IGNh
bid0IGJyZWFrIGFueSBleGlzdGluZyB1c2VyLiBKdXN0IGNoYW5naW5nIHRvIHJlZ21hcF93cml0
ZV9iaXRzKCkNCj4gaW5zdGVhZCBvZiBhZGRpbmcgdGhlIHVwZGF0ZS1mb3JjZSBwcm9wZXJ0eSBh
cyBpbiB2MSBzaG91bGQgYmUgZmluZS4NCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0KPiANCkhp
IFN1bWFuLCBBbmRyZXcsDQoNCkNhbiB5b3UgaGVscCB0byBnaXZlIHNvbWUgc3VnZ2VzdGlvbnMg
YWJvdXQgdGhpcyBjaGFuZ2UuDQpJcyB0aGlzIGNhbiBiZSBjaGFuZ2VkIHRvIHdyaXRlIHVuY29u
ZGl0aW9uYWxseSwgb3Igc2hvdWxkIEkgYWRkIGENCnVwZGF0ZS1mb3JjZSBwcm9wZXJ0eSB0byBm
b3JjZSB0aGUgd3JpdGUgb3BlcmF0aW9uLg0KDQpCZXN0IHJlZ2FyZHMNCkNyeXN0YWwuDQoNCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyB8IDE1ICsrKysrKysr
KysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNj
b24uYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gPiBpbmRleCAxYzc0YmNi
OWE2YzMuLmY0YmFmNzhhZmQxNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0
LXRpLXN5c2Nvbi5jDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0K
PiA+IEBAIC01Nyw2ICs1Nyw3IEBAIHN0cnVjdCB0aV9zeXNjb25fcmVzZXRfZGF0YSB7DQo+ID4g
IAlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2NvbnRyb2wgKmNvbnRyb2xzOw0KPiA+ICAJdW5zaWdu
ZWQgaW50IG5yX2NvbnRyb2xzOw0KPiA+ICAJYm9vbCBhc3NlcnRfZGVhc3NlcnRfdG9nZXRoZXI7
DQo+ID4gKwlib29sIHVwZGF0ZV9mb3JjZTsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICNkZWZpbmUg
dG9fdGlfc3lzY29uX3Jlc2V0X2RhdGEocmNkZXYpCVwNCj4gPiBAQCAtOTAsNyArOTEsMTAgQEAg
c3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVy
X2RldiAqcmNkZXYsDQo+ID4gIAltYXNrID0gQklUKGNvbnRyb2wtPmFzc2VydF9iaXQpOw0KPiA+
ICAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBBU1NFUlRfU0VUKSA/IG1hc2sgOiAweDA7DQo+
ID4gIA0KPiA+IC0JcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRy
b2wtPmFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gPiArCWlmIChkYXRhLT51cGRhdGVf
Zm9yY2UpDQo+ID4gKwkJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29u
dHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJl
dHVybiByZWdtYXBfdXBkYXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5hc3NlcnRfb2Zm
c2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIC8qKg0KPiA+IEBAIC0xMjEs
NyArMTI1LDEwIEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCBy
ZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gIAltYXNrID0gQklUKGNvbnRyb2wtPmRl
YXNzZXJ0X2JpdCk7DQo+ID4gIAl2YWx1ZSA9IChjb250cm9sLT5mbGFncyAmIERFQVNTRVJUX1NF
VCkgPyBtYXNrIDogMHgwOw0KPiA+ICANCj4gPiAtCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMo
ZGF0YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4g
PiArCWlmIChkYXRhLT51cGRhdGVfZm9yY2UpDQo+ID4gKwkJcmV0dXJuIHJlZ21hcF93cml0ZV9i
aXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7
DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdt
YXAsIGNvbnRyb2wtPmRlYXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiA+ICB9DQo+ID4g
IA0KPiA+ICAvKioNCj4gPiBAQCAtMjIzLDYgKzIzMCwxMCBAQCBzdGF0aWMgaW50IHRpX3N5c2Nv
bl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCWRhdGEt
PmFzc2VydF9kZWFzc2VydF90b2dldGhlciA9IHRydWU7DQo+ID4gIAllbHNlDQo+ID4gIAkJZGF0
YS0+YXNzZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyID0gZmFsc2U7DQo+ID4gKwlpZiAob2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5wLCAidXBkYXRlLWZvcmNlIikpDQo+ID4gKwkJZGF0YS0+dXBkYXRlX2Zv
cmNlID0gdHJ1ZTsNCj4gPiArCWVsc2UNCj4gPiArCQlkYXRhLT51cGRhdGVfZm9yY2UgPSBmYWxz
ZTsNCj4gPiAgDQo+ID4gIAlkYXRhLT5yY2Rldi5vcHMgPSAmdGlfc3lzY29uX3Jlc2V0X29wczsN
Cj4gPiAgCWRhdGEtPnJjZGV2Lm93bmVyID0gVEhJU19NT0RVTEU7DQo+ID4gLS0gDQo+ID4gMi4x
OC4wDQoNCg==

