Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84165207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oX5oBBIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFJGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:20:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5450 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbgFJGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:20:28 -0400
X-UUID: a55210abbffe40579b4dbf2a384f3bf8-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hdgI+fXHtKacXru8/dXUuE3zpRMIWvgQyNSpZ1nA1Ys=;
        b=oX5oBBIM4ItBDoymUnE0/6Ay/jMClwsCW0zcdpVwWlHcroH8SnaiXS4UDX9U1pbj0zHmh3I5UPHZQFmC/pSh0ZE9uOn0IViBRKLJysjidN2K2usrJIEdg6qDHYAtblwOWUhX0w2W3c/vYaROCN/FKVdANnZ6ozdXGuB0qUD95wk=;
X-UUID: a55210abbffe40579b4dbf2a384f3bf8-20200610
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <tiffany.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 670896255; Wed, 10 Jun 2020 14:20:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 14:20:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 14:20:19 +0800
Message-ID: <1591770020.5047.5.camel@mtksdaap41>
Subject: Re: [PATCH v4 09/17] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From:   Tiffany Lin <tiffany.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <Maoguang.Meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <eizan@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <ming-fan.chen@mediatek.com>,
        <anan.sun@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
        <acourbot@chromium.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 10 Jun 2020 14:20:20 +0800
In-Reply-To: <1591768038.527.6.camel@mtksdaap41>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
         <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
         <1591768038.527.6.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTEwIGF0IDEzOjQ3ICswODAwLCBDSyBIdSB3cm90ZToNCj4gKyBUaWZm
YW55ICYgTWFvZ3VhbmcuDQo+IA0KPiBPbiBTYXQsIDIwMjAtMDUtMzAgYXQgMTY6MTAgKzA4MDAs
IFlvbmcgV3Ugd3JvdGU6DQo+ID4gTWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgdGhl
IGRldmljZV9saW5rIGJldHdlZW4gdGhlIGNvbnN1bWVyDQo+ID4gYW5kIHNtaS1sYXJiIGRldmlj
ZS4gSWYgdGhlIHZjb2RlYyBkZXZpY2UgY2FsbCB0aGUgcG1fcnVudGltZV9nZXRfc3luYywNCj4g
PiB0aGUgc21pLWxhcmIncyBwbV9ydW50aW1lX2dldF9zeW5jIGFsc28gYmUgY2FsbGVkIGF1dG9t
YXRpY2FsbHkuDQo+ID4gDQoNCkFja2VkLWJ5OiBUaWZmYW55IExpbiA8dGlmZmFueS5saW5AbWVk
aWF0ZWsuY29tPg0KDQo+ID4gQ0M6IFRpZmZhbnkgTGluIDx0aWZmYW55LmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0KPiA+IC0t
LQ0KPiA+ICAuLi4vbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2RlY19wbS5j
ICB8IDE5IC0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12
Y29kZWMvbXRrX3Zjb2RlY19kcnYuaCB8ICAzIC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19lbmMuYyB8ICAxIC0NCj4gPiAgLi4uL21lZGlhL3Bs
YXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19lbmNfcG0uYyAgfCAyNyAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNv
ZGVjX2RlY19wbS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29k
ZWNfZGVjX3BtLmMNCj4gPiBpbmRleCAzNmRmZTNmLi4xZDdkMTRkIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2RlY19wbS5jDQo+
ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVj
X3BtLmMNCj4gPiBAQCAtOCwxNCArOCwxMiBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRk
cmVzcy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAtI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWku
aD4NCj4gPiAgDQo+ID4gICNpbmNsdWRlICJtdGtfdmNvZGVjX2RlY19wbS5oIg0KPiA+ICAjaW5j
bHVkZSAibXRrX3Zjb2RlY191dGlsLmgiDQo+ID4gIA0KPiA+ICBpbnQgbXRrX3Zjb2RlY19pbml0
X2RlY19wbShzdHJ1Y3QgbXRrX3Zjb2RlY19kZXYgKm10a2RldikNCj4gPiAgew0KPiA+IC0Jc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlOw0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
djsNCj4gPiAgCXN0cnVjdCBtdGtfdmNvZGVjX3BtICpwbTsNCj4gPiAgCXN0cnVjdCBtdGtfdmNv
ZGVjX2NsayAqZGVjX2NsazsNCj4gPiBAQCAtMjYsMTggKzI0LDcgQEAgaW50IG10a192Y29kZWNf
aW5pdF9kZWNfcG0oc3RydWN0IG10a192Y29kZWNfZGV2ICptdGtkZXYpDQo+ID4gIAlwbSA9ICZt
dGtkZXYtPnBtOw0KPiA+ICAJcG0tPm10a2RldiA9IG10a2RldjsNCj4gPiAgCWRlY19jbGsgPSAm
cG0tPnZkZWNfY2xrOw0KPiA+IC0Jbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUocGRldi0+ZGV2Lm9m
X25vZGUsICJtZWRpYXRlayxsYXJiIiwgMCk7DQo+ID4gLQlpZiAoIW5vZGUpIHsNCj4gPiAtCQlt
dGtfdjRsMl9lcnIoIm9mX3BhcnNlX3BoYW5kbGUgbWVkaWF0ZWssbGFyYiBmYWlsISIpOw0KPiA+
IC0JCXJldHVybiAtMTsNCj4gPiAtCX0NCj4gPiAgDQo+ID4gLQlwZGV2ID0gb2ZfZmluZF9kZXZp
Y2VfYnlfbm9kZShub2RlKTsNCj4gPiAtCW9mX25vZGVfcHV0KG5vZGUpOw0KPiA+IC0JaWYgKFdB
Uk5fT04oIXBkZXYpKSB7DQo+ID4gLQkJcmV0dXJuIC0xOw0KPiA+IC0JfQ0KPiA+IC0JcG0tPmxh
cmJ2ZGVjID0gJnBkZXYtPmRldjsNCj4gPiAgCXBkZXYgPSBtdGtkZXYtPnBsYXRfZGV2Ow0KPiA+
ICAJcG0tPmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gIA0KPiA+IEBAIC0xMTMsMTEgKzEwMCw2IEBA
IHZvaWQgbXRrX3Zjb2RlY19kZWNfY2xvY2tfb24oc3RydWN0IG10a192Y29kZWNfcG0gKnBtKQ0K
PiA+ICAJCX0NCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlyZXQgPSBtdGtfc21pX2xhcmJfZ2V0KHBt
LT5sYXJidmRlYyk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJbXRrX3Y0bDJfZXJyKCJtdGtf
c21pX2xhcmJfZ2V0IGxhcmJ2ZGVjIGZhaWwgJWQiLCByZXQpOw0KPiA+IC0JCWdvdG8gZXJyb3I7
DQo+ID4gLQl9DQo+ID4gIAlyZXR1cm47DQo+ID4gIA0KPiA+ICBlcnJvcjoNCj4gPiBAQCAtMTMw
LDcgKzExMiw2IEBAIHZvaWQgbXRrX3Zjb2RlY19kZWNfY2xvY2tfb2ZmKHN0cnVjdCBtdGtfdmNv
ZGVjX3BtICpwbSkNCj4gPiAgCXN0cnVjdCBtdGtfdmNvZGVjX2NsayAqZGVjX2NsayA9ICZwbS0+
dmRlY19jbGs7DQo+ID4gIAlpbnQgaSA9IDA7DQo+ID4gIA0KPiA+IC0JbXRrX3NtaV9sYXJiX3B1
dChwbS0+bGFyYnZkZWMpOw0KPiA+ICAJZm9yIChpID0gZGVjX2Nsay0+Y2xrX251bSAtIDE7IGkg
Pj0gMDsgaS0tKQ0KPiA+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZWNfY2xrLT5jbGtfaW5m
b1tpXS52Y29kZWNfY2xrKTsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kcnYuaCBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Rydi5oDQo+ID4gaW5kZXggNTJkMWNlMS4uN2Qz
OTY2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMv
bXRrX3Zjb2RlY19kcnYuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZj
b2RlYy9tdGtfdmNvZGVjX2Rydi5oDQo+ID4gQEAgLTE5MCwxMCArMTkwLDcgQEAgc3RydWN0IG10
a192Y29kZWNfY2xrIHsNCj4gPiAgICovDQo+ID4gIHN0cnVjdCBtdGtfdmNvZGVjX3BtIHsNCj4g
PiAgCXN0cnVjdCBtdGtfdmNvZGVjX2Nsawl2ZGVjX2NsazsNCj4gPiAtCXN0cnVjdCBkZXZpY2UJ
KmxhcmJ2ZGVjOw0KPiA+IC0NCj4gPiAgCXN0cnVjdCBtdGtfdmNvZGVjX2Nsawl2ZW5jX2NsazsN
Cj4gPiAtCXN0cnVjdCBkZXZpY2UJKmxhcmJ2ZW5jOw0KPiA+ICAJc3RydWN0IGRldmljZQkqZGV2
Ow0KPiA+ICAJc3RydWN0IG10a192Y29kZWNfZGV2CSptdGtkZXY7DQo+ID4gIH07DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Vu
Yy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMN
Cj4gPiBpbmRleCA1MzAxZGNhLi4xODAyNWY3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuYy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMNCj4gPiBAQCAtOCw3
ICs4LDYgQEANCj4gPiAgI2luY2x1ZGUgPG1lZGlhL3Y0bDItZXZlbnQuaD4NCj4gPiAgI2luY2x1
ZGUgPG1lZGlhL3Y0bDItbWVtMm1lbS5oPg0KPiA+ICAjaW5jbHVkZSA8bWVkaWEvdmlkZW9idWYy
LWRtYS1jb250aWcuaD4NCj4gPiAtI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAgDQo+ID4gICNpbmNsdWRlICJtdGtf
dmNvZGVjX2Rydi5oIg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay12Y29kZWMvbXRrX3Zjb2RlY19lbmNfcG0uYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRr
LXZjb2RlYy9tdGtfdmNvZGVjX2VuY19wbS5jDQo+ID4gaW5kZXggMDFjNmE1NS4uMDQ3OTE5ZSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zj
b2RlY19lbmNfcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2Rl
Yy9tdGtfdmNvZGVjX2VuY19wbS5jDQo+ID4gQEAgLTgsNDQgKzgsMjUgQEANCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3Jt
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gLSNpbmNsdWRlIDxz
b2MvbWVkaWF0ZWsvc21pLmg+DQo+ID4gIA0KPiA+ICAjaW5jbHVkZSAibXRrX3Zjb2RlY19lbmNf
cG0uaCINCj4gPiAgI2luY2x1ZGUgIm10a192Y29kZWNfdXRpbC5oIg0KPiA+ICANCj4gPiAgaW50
IG10a192Y29kZWNfaW5pdF9lbmNfcG0oc3RydWN0IG10a192Y29kZWNfZGV2ICptdGtkZXYpDQo+
ID4gIHsNCj4gPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gPiAgCXN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ID4gIAlzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG07DQo+ID4g
IAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmVuY19jbGs7DQo+ID4gIAlzdHJ1Y3QgbXRrX3Zjb2Rl
Y19jbGtfaW5mbyAqY2xrX2luZm87DQo+ID4gIAlpbnQgcmV0ID0gMCwgaSA9IDA7DQo+ID4gLQlz
dHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gIA0KPiA+ICAJcGRldiA9IG10a2Rldi0+cGxhdF9kZXY7
DQo+ID4gIAlwbSA9ICZtdGtkZXYtPnBtOw0KPiA+ICAJbWVtc2V0KHBtLCAwLCBzaXplb2Yoc3Ry
dWN0IG10a192Y29kZWNfcG0pKTsNCj4gPiAgCXBtLT5tdGtkZXYgPSBtdGtkZXY7DQo+ID4gIAlw
bS0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAtCWRldiA9ICZwZGV2LT5kZXY7DQo+ID4gIAllbmNf
Y2xrID0gJnBtLT52ZW5jX2NsazsNCj4gPiAgDQo+ID4gLQlub2RlID0gb2ZfcGFyc2VfcGhhbmRs
ZShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxsYXJiIiwgMCk7DQo+ID4gLQlpZiAoIW5vZGUpIHsN
Cj4gPiAtCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVrLGxhcmIgZm91bmQiKTsNCj4gPiAtCQly
ZXR1cm4gLUVOT0RFVjsNCj4gPiAtCX0NCj4gPiAtCXBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9u
b2RlKG5vZGUpOw0KPiA+IC0Jb2Zfbm9kZV9wdXQobm9kZSk7DQo+ID4gLQlpZiAoIXBkZXYpIHsN
Cj4gPiAtCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVrLGxhcmIgZGV2aWNlIGZvdW5kIik7DQo+
ID4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gLQl9DQo+ID4gLQlwbS0+bGFyYnZlbmMgPSAmcGRl
di0+ZGV2Ow0KPiA+IC0JcGRldiA9IG10a2Rldi0+cGxhdF9kZXY7DQo+ID4gLQlwbS0+ZGV2ID0g
JnBkZXYtPmRldjsNCj4gPiAtDQo+ID4gIAllbmNfY2xrLT5jbGtfbnVtID0gb2ZfcHJvcGVydHlf
Y291bnRfc3RyaW5ncyhwZGV2LT5kZXYub2Zfbm9kZSwNCj4gPiAgCQkiY2xvY2stbmFtZXMiKTsN
Cj4gPiAgCWlmIChlbmNfY2xrLT5jbGtfbnVtID4gMCkgew0KPiA+IEBAIC05MywxMyArNzQsNiBA
QCB2b2lkIG10a192Y29kZWNfZW5jX2Nsb2NrX29uKHN0cnVjdCBtdGtfdmNvZGVjX3BtICpwbSkN
Cj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+IC0JcmV0ID0gbXRrX3NtaV9sYXJiX2dldChw
bS0+bGFyYnZlbmMpOw0KPiA+IC0JaWYgKHJldCkgew0KPiA+IC0JCW10a192NGwyX2VycigibXRr
X3NtaV9sYXJiX2dldCBsYXJiMyBmYWlsICVkIiwgcmV0KTsNCj4gPiAtCQlnb3RvIGNsa2VycjsN
Cj4gPiAtCX0NCj4gPiAtCXJldHVybjsNCj4gPiAtDQo+ID4gIGNsa2VycjoNCj4gPiAgCWZvciAo
aSAtPSAxOyBpID49IDA7IGktLSkNCj4gPiAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZW5jX2Ns
ay0+Y2xrX2luZm9baV0udmNvZGVjX2Nsayk7DQo+ID4gQEAgLTExMCw3ICs4NCw2IEBAIHZvaWQg
bXRrX3Zjb2RlY19lbmNfY2xvY2tfb2ZmKHN0cnVjdCBtdGtfdmNvZGVjX3BtICpwbSkNCj4gPiAg
CXN0cnVjdCBtdGtfdmNvZGVjX2NsayAqZW5jX2NsayA9ICZwbS0+dmVuY19jbGs7DQo+ID4gIAlp
bnQgaSA9IDA7DQo+ID4gIA0KPiA+IC0JbXRrX3NtaV9sYXJiX3B1dChwbS0+bGFyYnZlbmMpOw0K
PiA+ICAJZm9yIChpID0gZW5jX2Nsay0+Y2xrX251bSAtIDE7IGkgPj0gMDsgaS0tKQ0KPiA+ICAJ
CWNsa19kaXNhYmxlX3VucHJlcGFyZShlbmNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsN
Cj4gPiAgfQ0KPiANCj4gDQoNCg==

