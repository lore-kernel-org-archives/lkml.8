Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA861C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8075206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gKCFbTxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgFPNeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:34:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9708 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726799AbgFPNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:34:29 -0400
X-UUID: a93284516823496d9943aeb6d4ff9a41-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oLbLrR0m/1qxRAz5VyE7CHtP9X+jYQJwihIxHEwerpY=;
        b=gKCFbTxLHeDewPXDc3DfC+/tCScAvqkCtOnKau2m3L/28reTPLdBkLwghmkOxT2l00rIyzGZhIrNPE79lK3oJk5iXLDMifvx2AbH/EhePr26MmB4xAalAq/wNu42msdHetTfvivIL2zrRCznYe7mzE7IdR3RxnzHDBiqgpz7IAg=;
X-UUID: a93284516823496d9943aeb6d4ff9a41-20200616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1294132693; Tue, 16 Jun 2020 21:34:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 21:34:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 21:34:18 +0800
Message-ID: <1592314461.6256.18.camel@mtkswgap22>
Subject: Re: [PATCH v5 6/6] arm64: dts: add dts nodes for MT6779
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <devicetree@vger.kernel.org>
Date:   Tue, 16 Jun 2020 21:34:21 +0800
In-Reply-To: <3751b55b-07a7-7985-a8d9-5414a4ca0d24@gmail.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
         <1585128694-13881-7-git-send-email-hanks.chen@mediatek.com>
         <3751b55b-07a7-7985-a8d9-5414a4ca0d24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDE3OjM5ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjUvMDMvMjAyMCAxMDozMSwgSGFua3MgQ2hlbiB3cm90ZToNCj4gPiB0aGlz
IGFkZHMgaW5pdGlhbCBNVDY3NzkgZHRzIHNldHRpbmdzIGZvIGJvYXJkIHN1cHBvcnQsDQo+IA0K
PiAiZm9yIGJvYXJkIHN1cHBvcnQiDQo+IA0KPiA+IGluY2x1ZGluZyBjcHUsIGdpYywgdGltZXIs
IGNjZiwgcGluY3RybCwgdWFydC4uLmV0Yy4NCj4gDQo+IFRoZSBldGMgaXMgUE1VIGFuZCBQU0NJ
IGFuZCBzeXNpcnEsIGNvcnJlY3Q/IExldCdzIGxpc3QgYXQgbGVhc3Qgc3lzaXJxIGFzIHRoaXMN
Cj4gaXMgc29tZXRoaW5nIE1lZGlhVGVrIHNwZWNpZmljLg0KPiANCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBIYW5rcyBDaGVuIDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8ICAgIDEgKw0K
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzIHwgICAzMSAr
KysrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgICAgfCAg
MjY1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI5
NyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gaW5kZXggNDU4YmJjNC4uNTNmMWM2MSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01ha2VmaWxlDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IEBAIC0xLDYg
KzEsNyBAQA0KPiA+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gIGR0
Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDI3MTItZXZiLmR0Yg0KPiA+ICBkdGItJChD
T05GSUdfQVJDSF9NRURJQVRFSykgKz0gbXQ2NzU1LWV2Yi5kdGINCj4gPiArZHRiLSQoQ09ORklH
X0FSQ0hfTUVESUFURUspICs9IG10Njc3OS1ldmIuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNI
X01FRElBVEVLKSArPSBtdDY3OTUtZXZiLmR0Yg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9NRURJ
QVRFSykgKz0gbXQ2Nzk3LWV2Yi5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUsp
ICs9IG10Njc5Ny14MjAtZGV2LmR0Yg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDY3NzktZXZiLmR0cw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAw
MDAwMC4uMTY0ZjVjYg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzDQo+ID4gQEAgLTAsMCArMSwzMSBAQA0KPiA+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gPiArLyoNCj4gPiArICog
Q29weXJpZ2h0IChjKSAyMDE5IE1lZGlhVGVrIEluYy4NCj4gPiArICogQXV0aG9yOiBNYXJzLkMg
PG1hcnMuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKg0KPiA+ICsgKi8NCj4gPiArDQo+ID4g
Ky9kdHMtdjEvOw0KPiA+ICsjaW5jbHVkZSAibXQ2Nzc5LmR0c2kiDQo+ID4gKw0KPiA+ICsvIHsN
Cj4gPiArCW1vZGVsID0gIk1lZGlhVGVrIE1UNjc3OSBFVkIiOw0KPiA+ICsJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDY3NzktZXZiIiwgIm1lZGlhdGVrLG10Njc3OSI7DQo+ID4gKw0KPiA+ICsJ
YWxpYXNlcyB7DQo+ID4gKwkJc2VyaWFsMCA9ICZ1YXJ0MDsNCj4gPiArCX07DQo+ID4gKw0KPiA+
ICsJbWVtb3J5QDQwMDAwMDAwIHsNCj4gPiArCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiA+
ICsJCXJlZyA9IDwwIDB4NDAwMDAwMDAgMCAweDFlODAwMDAwPjsNCj4gPiArCX07DQo+ID4gKw0K
PiA+ICsJY2hvc2VuIHsNCj4gPiArCQlzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjkyMTYwMG44IjsN
Cj4gPiArCX07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmdWFydDAgew0KPiA+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiA+ICt9Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210Njc3OS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3Nzku
ZHRzaQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uNDIyZmY1
Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210Njc3OS5kdHNpDQo+ID4gQEAgLTAsMCArMSwyNjUgQEANCj4gWy4uLl0NCj4gPiArDQo+
ID4gKwl1YXJ0X2NsazogZHVtbXkyNm0gew0KPiA+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xv
Y2siOw0KPiA+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNjAwMDAwMD47DQo+ID4gKwkJI2Nsb2Nr
LWNlbGxzID0gPDA+Ow0KPiA+ICsJfTsNCj4gDQo+IE5vIHJlYWwgY2xvY2tzIGZvciB1YXJ0PyBX
aGF0IGFib3V0IENMS19JTkZSQV9VQVJUeD8NCg0Kc29ycnksIEkgbWlzcyB0aGUgY2xvY2tzIGZv
ciB1YXJ0DQpJJ2xsIGFkZCAiYmF1ZCIgYW5kICJidXMiIGluIG5leHQgdmVyc2lvbi4NCg0KY2xv
Y2tzID0gPCZjbGsyNm0+LCA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9VQVJUMD47DQpjbG9jay1u
YW1lcyA9ICJiYXVkIiwgImJ1cyI7DQoNCg0KPiANCj4gPiArDQo+ID4gKwl0aW1lciB7DQo+ID4g
KwkJY29tcGF0aWJsZSA9ICJhcm0sYXJtdjgtdGltZXIiOw0KPiA+ICsJCWludGVycnVwdC1wYXJl
bnQgPSA8JmdpYz47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDEzIElSUV9UWVBFX0xF
VkVMX0xPVyAwPiwNCj4gPiArCQkJICAgICA8R0lDX1BQSSAxNCBJUlFfVFlQRV9MRVZFTF9MT1cg
MD4sDQo+ID4gKwkJCSAgICAgPEdJQ19QUEkgMTEgSVJRX1RZUEVfTEVWRUxfTE9XIDA+LA0KPiA+
ICsJCQkgICAgIDxHSUNfUFBJIDEwIElSUV9UWVBFX0xFVkVMX0xPVyAwPjsNCj4gPiArCX07DQo+
ID4gKw0KPiA+ICsJc29jIHsNCj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArCQkj
c2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+
ICsJCXJhbmdlczsNCj4gPiArDQo+IFsuLi5dDQo+ID4gKw0KPiA+ICsJCXVhcnQwOiBzZXJpYWxA
MTEwMDIwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS11YXJ0IiwN
Cj4gPiArCQkJCSAgICAgIm1lZGlhdGVrLG10NjU3Ny11YXJ0IjsNCj4gPiArCQkJcmVnID0gPDAg
MHgxMTAwMjAwMCAwIDB4NDAwPjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDExNSBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnVhcnRfY2xrPjsNCj4gPiAr
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQl1YXJ0MTog
c2VyaWFsQDExMDAzMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3Nzkt
dWFydCIsDQo+ID4gKwkJCQkgICAgICJtZWRpYXRlayxtdDY1NzctdWFydCI7DQo+ID4gKwkJCXJl
ZyA9IDwwIDB4MTEwMDMwMDAgMCAweDQwMD47DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSAxMTYgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiArCQkJY2xvY2tzID0gPCZ1YXJ0X2Nsaz47
DQo+ID4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gDQo+IFNvQyBoYXMg
b25seSB0d28gVUFSVHMgYnV0IGNsb2NrIGRyaXZlciBoYXMgdGhyZWUsIGhvdyBjb21lcz8NCj4g
DQoNCkluIG10Njc3OSBTb0MsIHdlIGhhdmUgZm91ciBVQVJUcy4NCmJ1dCB3ZSBvbmx5IHVzZSBV
QVJUMCBhbmQgVUFSVDEgYXMgc3RhbmRhcmQgc2VyaWFsIHBvcnRzIGZvciBBUE1DVS5UaGUNCm90
aGVycyBmb3IgbW9kZW0gc2lkZS4NCnNvIHdlIGFkZCB0d28gVUFSVHMgaW4gZHRzLg0KDQo+ID4g
Kw0KPiA+ICsJCWF1ZGlvOiBjbG9jay1jb250cm9sbGVyQDExMjEwMDAwIHsNCj4gPiArCQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktYXVkaW8iLCAic3lzY29uIjsNCj4gPiArCQkJcmVn
ID0gPDAgMHgxMTIxMDAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCSNjbG9jay1jZWxscyA9IDwxPjsN
Cj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQltZmdjZmc6IGNsb2NrLWNvbnRyb2xsZXJAMTNmYmYw
MDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1tZmdjZmciLCAic3lz
Y29uIjsNCj4gPiArCQkJcmVnID0gPDAgMHgxM2ZiZjAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCSNj
bG9jay1jZWxscyA9IDwxPjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQltbXN5czogY2xvY2st
Y29udHJvbGxlckAxNDAwMDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2
Nzc5LW1tc3lzIiwgInN5c2NvbiI7DQo+ID4gKwkJCXJlZyA9IDwwIDB4MTQwMDAwMDAgMCAweDEw
MDA+Ow0KPiA+ICsJCQkjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKwkJfTsNCj4gDQo+IFBsZWFz
ZSBiZXdhcmUgdGhhdCB3ZSBhcmUgcmVmYWN0b3JpbmcgdGhlIG1tc3lzIHJpZ2h0IG5vdy4gUGxl
YXNlIHVzZSB0aGlzIG5ldw0KPiBhcHByb2FjaCBhcyB0aGlzIHdpbGwgZ28gdXBzdHJlYW0gc29v
bi4NCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRp
YXRlay9saXN0Lz9zZXJpZXM9MjU0ODk3DQo+IA0KR290IGl0LCBJJ2xsIHVwZGF0ZSBuZXcgYXBw
cm9hY2ggaW4gbmV4dCB2ZXJzaW9uLg0KVGhhbmtzIQ0KDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFz
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW1lZGlhdGVrDQoNCg==

