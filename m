Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E8206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pYOAFoAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgFXGko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:40:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28546 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388582AbgFXGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:40:43 -0400
X-UUID: 4480b2ca7b054f65b6670c72e877b5e1-20200624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=C01wP7O41EMQ3vJzTY+vMBOf3dw7xo6jocNHUFkcK60=;
        b=pYOAFoAuAPMKJOUpuxG+ASLryj8g+nVmFgn2Rg/9Mfvm7FwXtiScWEMX4Aeh062CDT4daPemOheV2tCJ7IcreiAbc3WpayoYeQxw+r3sFQ5318KBye2ride6ZpeZLVvqYTpP2lQcoXZ98ZiwioXD01Rx7/K13LjTrsZVOfp4o3w=;
X-UUID: 4480b2ca7b054f65b6670c72e877b5e1-20200624
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 32306068; Wed, 24 Jun 2020 14:40:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Jun 2020 14:40:35 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Jun 2020 14:40:34 +0800
Message-ID: <1592980794.24677.4.camel@mbjsdccf07>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Set MISC_CTRL register
From:   chao hao <Chao.Hao@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Wed, 24 Jun 2020 14:39:54 +0800
In-Reply-To: <1592618616.3951.12.camel@mhfsdcap03>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-4-chao.hao@mediatek.com>
         <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
         <1592480963.12647.5.camel@mbjsdccf07> <1592618616.3951.12.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F70B4854FFD7F8C1D58622D9F607A9A3ED68DABFF7765DD65D58A3DE4CB487062000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA2LTIwIGF0IDEwOjAzICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBIaSBD
aGFvLA0KPiANCj4gT24gVGh1LCAyMDIwLTA2LTE4IGF0IDE5OjQ5ICswODAwLCBjaGFvIGhhbyB3
cm90ZTogDQo+ID4gT24gV2VkLCAyMDIwLTA2LTE3IGF0IDExOjM0ICswMjAwLCBNYXR0aGlhcyBC
cnVnZ2VyIHdyb3RlOg0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ID4gPiAgDQo+ID4gPiA+ICAjZGVm
aW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJMHgwNDgNCj4gPiA+ID4gKyNkZWZpbmUgRl9NTVVfSU5f
T1JERVJfV1JfRU4JCQkoQklUKDEpIHwgQklUKDE3KSkNCj4gPiA+ID4gKyNkZWZpbmUgRl9NTVVf
U1RBTkRBUkRfQVhJX01PREVfQklUCQkoQklUKDMpIHwgQklUKDE5KSkNCj4gPiA+ID4gKw0KPiA+
ID4gPiAgI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCj4gPiA+ID4gIA0KPiA+ID4g
PiAgI2RlZmluZSBSRUdfTU1VX0NUUkxfUkVHCQkJMHgxMTANCj4gPiA+ID4gQEAgLTU3OCw2ICs1
ODEsMTQgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lv
bW11X2RhdGEgKmRhdGEpDQo+ID4gPiA+ICAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2Ug
KyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICsJ
aWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzX21pc2NfY3RybCkgew0KPiA+ID4gDQo+ID4gPiBUaGF0
J3MgY29uZnVzaW5nLiBXZSByZW5hbWVkIHRoZSByZWdpc3RlciB0byBtaXNjX2N0cmwsIGJ1dCBp
dCdzIHByZXNlbnQgaW4gYWxsDQo+ID4gPiBTb0NzLiBXZSBzaG91bGQgZmluZCBhIGJldHRlciBu
YW1lIGZvciB0aGlzIGZsYWcgdG8gZGVzY3JpYmUgd2hhdCB0aGUgaGFyZHdhcmUNCj4gPiA+IHN1
cHBvcnRzLg0KPiA+ID4gDQo+ID4gDQo+ID4gb2ssIHRoYW5rcyBmb3IgeW91IGFkdmljZSwgSSB3
aWxsIHJlbmFtZSBpdCBpbiBuZXh0IHZlcnNpb24uDQo+ID4gZXg6aGFzX3BlcmZfcmVxKGhhcyBw
ZXJmb3JtYW5jZSByZXF1aXJlbWVudCkNCj4gPiANCj4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4g
PiBNYXR0aGlhcw0KPiA+ID4gDQo+ID4gPiA+ICsJCS8qIEZvciBtbV9pb21tdSwgaXQgY2FuIGlt
cHJvdmUgcGVyZm9ybWFuY2UgYnkgdGhlIHNldHRpbmcgKi8NCj4gPiA+ID4gKwkJcmVndmFsID0g
cmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KPiA+ID4gPiAr
CQlyZWd2YWwgJj0gfkZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVDsNCj4gPiA+ID4gKwkJcmVn
dmFsICY9IH5GX01NVV9JTl9PUkRFUl9XUl9FTjsNCj4gDQo+IE5vdGU6IG10MjcxMiBhbHNvIGlz
IE1JU0NfQ1RSTCByZWdpc3RlciwgYnV0IGl0IGRvbid0IHVzZSB0aGlzDQo+IGluX29yZGVyIHNl
dHRpbmcuDQo+IA0KPiBBcyBjb21tZW50ZWQgaW4gdjMuIDB4NDggaXMgZWl0aGVyIFNUQU5EQVJE
X0FYSV9NT0RFIG9yIE1JU0NfQ1RSTA0KPiByZWdpc3Rlci4gTm8gbmVlZCB0d28gZmxhZ3MocmVz
ZXRfYXhpL2hhc194eCkgZm9yIGl0Lg0KPiANCj4gc29tZXRoaW5nIGxpa2U6DQo+IA0KPiByZWd2
YWwgPSByZWFkbF9yZWxheGVkKGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+IGlm
IChyZXNldF9heGkpIHsNCj4gcmVndmFsID0gMDsNCj4gfSBlbHNlIHsgICAvKiBNSVNDX0NUUkwg
Ki8NCj4gaWYgKCFhcHVbMV0pDQo+IHJlZ3ZhbCAmPSB+Rl9NTVVfU1RBTkRBUkRfQVhJX01PREVf
QklUOw0KPiBpZiAob3V0X29yZGVyX2VuKQ0KPiByZWd2YWwgJj0gfkZfTU1VX0lOX09SREVSX1dS
X0VOOw0KPiB9DQo+IHdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVf
TUlTQ19DVFJMKTsNCj4gDQo+IA0KPiBbMV0gWW91ciBjdXJyZW50IHBhdGNoIGRvZXNuJ3Qgc3Vw
cG9ydCBhcHUtaW9tbXUsIHRodXMsIGFkZCBpdCB3aGVuDQo+IG5lY2Vzc2FyeS4NCg0Kb2ssIHRo
ZSBwYXRjaHNldCBkb24ndCBuZWVkIHRvICJpZiAoIWFwdVsxXSkiLCBJIHdpbGwgZml4IGl0IGlu
IG5leHQNCnZlcnNpb24uIHRoYW5rcw0KDQoNCj4gPiA+ID4gKwkJd3JpdGVsX3JlbGF4ZWQocmVn
dmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KPiA+ID4gPiArCX0NCj4gPiA+
ID4gKw0KPiA+ID4gPiAgCWlmIChkZXZtX3JlcXVlc3RfaXJxKGRhdGEtPmRldiwgZGF0YS0+aXJx
LCBtdGtfaW9tbXVfaXNyLCAwLA0KPiA+ID4gPiAgCQkJICAgICBkZXZfbmFtZShkYXRhLT5kZXYp
LCAodm9pZCAqKWRhdGEpKSB7DQo+ID4gPiA+ICAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJh
c2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+ID4gPiBp
bmRleCAxYjZlYTgzOWI5MmMuLmQ3MTFhYzYzMDAzNyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5oDQo+ID4gPiA+IEBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9k
YXRhIHsNCj4gPiA+ID4gIA0KPiA+ID4gPiAgCS8qIEhXIHdpbGwgdXNlIHRoZSBFTUkgY2xvY2sg
aWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4gKi8NCj4gPiA+ID4gIAlib29sICAgICAgICAgICAg
ICAgIGhhc19iY2xrOw0KPiA+ID4gPiArCWJvb2wJCSAgICBoYXNfbWlzY19jdHJsOw0KPiA+ID4g
PiAgCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQo+ID4gPiA+ICAJYm9vbCAg
ICAgICAgICAgICAgICByZXNldF9heGk7DQo+ID4gPiA+ICAJdW5zaWduZWQgY2hhciAgICAgICBs
YXJiaWRfcmVtYXBbTVRLX0xBUkJfTlJfTUFYXTsNCj4gPiA+ID4gDQo+ID4gDQo+ID4gDQo+IA0K
DQo=

