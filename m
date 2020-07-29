Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85962C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6464A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YOHx7014"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgG2ITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:19:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20847 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgG2ITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:19:14 -0400
X-UUID: 927e91cfe5d544b59e07ef633784d0fd-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UNLqnEsdKNmSGXuBOvN1uBWFDDUciwsnHV7r4PQfRiM=;
        b=YOHx7014d6+Zce3cWaK/zSTv5Kyqu1y0/pVmyCGKwWmVm331EC+tqZusLxn8AcHOB+SQu2v1ip+cRnzf5oJvCkGPSg/YFk+9aS7BQ+hmh6eAJJTkJeXcvW5fzaeLMgp6Aj5MCAmnqNsdlxbshDJJRgf79azNozhivxSAQXcOR1A=;
X-UUID: 927e91cfe5d544b59e07ef633784d0fd-20200729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2009448367; Wed, 29 Jul 2020 16:19:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 29 Jul
 2020 16:19:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 16:19:07 +0800
Message-ID: <1596010724.11360.6.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] arm64: dts: mt8192: add infracfg_rst node
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>
Date:   Wed, 29 Jul 2020 16:18:44 +0800
In-Reply-To: <b81f1936-caf0-e843-9556-14e3024d6d6f@gmail.com>
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
         <1596008357-11213-3-git-send-email-crystal.guo@mediatek.com>
         <b81f1936-caf0-e843-9556-14e3024d6d6f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTI5IGF0IDE1OjQ1ICswODAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjkvMDcvMjAyMCAwOTozOSwgQ3J5c3RhbCBHdW8gd3JvdGU6DQo+ID4gYWRk
IGluZnJhY2ZnX3JzdCBub2RlIHdoaWNoIGlzIGZvciBNVDgxOTIgcGxhdGZvcm0NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaSB8
IDEwICsrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxOTIuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTky
LmR0c2kNCj4gPiBpbmRleCBiMTZkYmJkLi5hZGM2MjM5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+ID4gQEAgLTIxNyw5ICsyMTcsMTcgQEAN
Cj4gPiAgIAkJfTsNCj4gPiAgIA0KPiA+ICAgCQlpbmZyYWNmZzogaW5mcmFjZmdAMTAwMDEwMDAg
ew0KPiA+IC0JCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIsICJzeXNj
b24iOw0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIsICJz
eXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ID4gICAJCQlyZWcgPSA8MCAweDEwMDAxMDAwIDAgMHgx
MDAwPjsNCj4gPiAgIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiArDQo+ID4gKwkJCWluZnJh
Y2ZnX3JzdDogcmVzZXQtY29udHJvbGxlciB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gInRpLHN5
c2Nvbi1yZXNldCI7DQo+ID4gKwkJCQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4gKwkJCQl0aSxy
ZXNldC1iaXRzID0gPA0KPiA+ICsJCQkJCTB4MTQwIDE1IDB4MTQ0IDE1IDAgMCAoQVNTRVJUX1NF
VCB8IERFQVNTRVJUX1NFVCB8IFNUQVRVU19OT05FKSAvKiAwOiBwY2llICovDQo+IA0KPiBZb3Ug
aGF2ZSBUZXhhcyBJbnN0cnVtZW50cyBoYXJkd2FyZSBpbnNpZGUgaW5mcmFjZmc/IEFyZSB5b3Ug
c3VyZT8NCj4gDQpUSSByZXNldC1jb250cm9sbGVyIGRyaXZlciBpcyBhIGNvbW1vbiBkcml2ZXIs
IE1USyBTT0MgaGFzIHRoZSBzaW1pbGFyDQpjb250cm9sIGZsb3csIHRodXMgY2FuIHJldXNlIGl0
Lg0KDQo+ID4gKwkJCQk+Ow0KPiA+ICsJCQl9Ow0KPiA+ICAgCQl9Ow0KPiA+ICAgDQo+ID4gICAJ
CXBlcmljZmc6IHBlcmljZmdAMTAwMDMwMDAgew0KPiA+IA0KDQo=

