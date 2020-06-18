Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1035C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5420739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QDCb+AFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgFRLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:49:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37119 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbgFRLtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:49:55 -0400
X-UUID: 6e5b1069c6694ebdb808c16dfa8c7202-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BezqSJANb6qgtOc2Spryl5/bYO+3fAr4t48HhEcwp3w=;
        b=QDCb+AFsC8iwjS8oolB/6LS9fcteaHYJ6uJjtdVrRkl8WD4UfOCAjva/DKHPsSXEubP5XZADt0DfSTci3NiFUZ0xpk7CIaoVPP7iYb2S0zgklbqUGOd3cX8FRTWAyMrtd+R3sQiLhU4fuKfN6pzHHB3+wMJkku3Gvg9P/zmiGqY=;
X-UUID: 6e5b1069c6694ebdb808c16dfa8c7202-20200618
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2130525936; Thu, 18 Jun 2020 19:49:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 19:49:47 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 19:49:45 +0800
Message-ID: <1592480963.12647.5.camel@mbjsdccf07>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Set MISC_CTRL register
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Thu, 18 Jun 2020 19:49:23 +0800
In-Reply-To: <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-4-chao.hao@mediatek.com>
         <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDExOjM0ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTcvMDYvMjAyMCAwNTowMCwgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gQWRkIEZf
TU1VX0lOX09SREVSX1dSX0VOIGRlZmluaXRpb24gaW4gTUlTQ19DVFJMLg0KPiA+IEluIG9yZGVy
IHRvIGltcHJvdmUgcGVyZm9ybWFuY2UsIHdlIGFsd2F5cyBkaXNhYmxlIFNUQU5EQVJEX0FYSV9N
T0RFDQo+ID4gYW5kIElOX09SREVSX1dSX0VOIGluIE1JU0NfQ1RSTC4NCj4gPiANCj4gPiBDaGFu
Z2Ugc2luY2UgdjM6DQo+IA0KPiBUaGUgY2hhbmdlbG9nIHNob3VsZCBnbyBiZWxvdyB0aGUgJy0t
LScgYXMgd2UgZG9uJ3Qgd2FudCB0aGlzIGluIHRoZSBnaXQgaGlzdG9yeQ0KPiBvbmNlIHRoZSBw
YXRjaCBnZXQncyBhY2NlcHRlZC4NCj4gDQpva29rLCB0aGFua3MNCg0KPiA+IDEuIFJlbmFtZSBE
aXNhYmxlIFNUQU5EQVJEX0FYSV9NT0RFIGluIE1JU0NfQ1RSTCB0byBTZXQgTUlTQ19DVFJMIHJl
Z2lzdGVyDQo+ID4gMi4gQWRkIEZfTU1VX0lOX0RSREVSX1dSX0VOIGRlZmluaXRpb24gaW4gTUlT
Q19DVFJMDQo+ID4gICAgICAgIFdlIG5lZWQgdG8gZGlzYWJsZSBpbl9vcmRlcl93cml0ZSB0byBp
bXByb3ZlIHBlcmZvcm1hbmNlDQo+ID4gDQo+ID4gQ2M6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxMSArKysrKysr
KysrKw0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRl
eCA4OGQzZGY1YjkxYzIuLjIzOWQyY2RiYmM5ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+
IEBAIC00Miw2ICs0Miw5IEBADQo+ID4gICNkZWZpbmUgRl9JTlZMRF9FTjEJCQkJQklUKDEpDQo+
ID4gIA0KPiA+ICAjZGVmaW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJMHgwNDgNCj4gPiArI2RlZmlu
ZSBGX01NVV9JTl9PUkRFUl9XUl9FTgkJCShCSVQoMSkgfCBCSVQoMTcpKQ0KPiA+ICsjZGVmaW5l
IEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVAkJKEJJVCgzKSB8IEJJVCgxOSkpDQo+ID4gKw0K
PiA+ICAjZGVmaW5lIFJFR19NTVVfRENNX0RJUwkJCQkweDA1MA0KPiA+ICANCj4gPiAgI2RlZmlu
ZSBSRUdfTU1VX0NUUkxfUkVHCQkJMHgxMTANCj4gPiBAQCAtNTc4LDYgKzU4MSwxNCBAQCBzdGF0
aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0
YSkNCj4gPiAgCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NU
UkwpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc19taXNj
X2N0cmwpIHsNCj4gDQo+IFRoYXQncyBjb25mdXNpbmcuIFdlIHJlbmFtZWQgdGhlIHJlZ2lzdGVy
IHRvIG1pc2NfY3RybCwgYnV0IGl0J3MgcHJlc2VudCBpbiBhbGwNCj4gU29Dcy4gV2Ugc2hvdWxk
IGZpbmQgYSBiZXR0ZXIgbmFtZSBmb3IgdGhpcyBmbGFnIHRvIGRlc2NyaWJlIHdoYXQgdGhlIGhh
cmR3YXJlDQo+IHN1cHBvcnRzLg0KPiANCg0Kb2ssIHRoYW5rcyBmb3IgeW91IGFkdmljZSwgSSB3
aWxsIHJlbmFtZSBpdCBpbiBuZXh0IHZlcnNpb24uDQpleDpoYXNfcGVyZl9yZXEoaGFzIHBlcmZv
cm1hbmNlIHJlcXVpcmVtZW50KQ0KDQoNCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQo+ID4g
KwkJLyogRm9yIG1tX2lvbW11LCBpdCBjYW4gaW1wcm92ZSBwZXJmb3JtYW5jZSBieSB0aGUgc2V0
dGluZyAqLw0KPiA+ICsJCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19N
TVVfTUlTQ19DVFJMKTsNCj4gPiArCQlyZWd2YWwgJj0gfkZfTU1VX1NUQU5EQVJEX0FYSV9NT0RF
X0JJVDsNCj4gPiArCQlyZWd2YWwgJj0gfkZfTU1VX0lOX09SREVSX1dSX0VOOw0KPiA+ICsJCXdy
aXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4g
PiArCX0NCj4gPiArDQo+ID4gIAlpZiAoZGV2bV9yZXF1ZXN0X2lycShkYXRhLT5kZXYsIGRhdGEt
PmlycSwgbXRrX2lvbW11X2lzciwgMCwNCj4gPiAgCQkJICAgICBkZXZfbmFtZShkYXRhLT5kZXYp
LCAodm9pZCAqKWRhdGEpKSB7DQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSAr
IFJFR19NTVVfUFRfQkFTRV9BRERSKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBpbmRleCAxYjZlYTgz
OWI5MmMuLmQ3MTFhYzYzMDAzNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+IEBAIC00MCw2
ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gPiAgDQo+ID4gIAkvKiBI
VyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQo+
ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KPiA+ICsJYm9vbAkJICAgIGhhc19t
aXNjX2N0cmw7DQo+ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc192bGRfcGFfcm5nOw0KPiA+
ICAJYm9vbCAgICAgICAgICAgICAgICByZXNldF9heGk7DQo+ID4gIAl1bnNpZ25lZCBjaGFyICAg
ICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KPiA+IA0KDQo=

