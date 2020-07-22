Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60947C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E89820771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZndOA8YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGVEdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:33:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17006 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725790AbgGVEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:33:24 -0400
X-UUID: e7ccb6d02e4644b7bf103154b1467f43-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=H9+Xagm11TvrRWxbyALKrMjkxXywyXQNawOGwoyEQ7E=;
        b=ZndOA8YKgYFjM4TETAPdzj73Be2G2GAq6urLeVMLeVw/tGx9DX0lt9adM8CstHViMFXrwe9wOW2piPdUIH8PmHlqZVvnfYwv9gHxZS3HbYYShdbqWyNdt+1hFK1/1IsUALbyS53+99o5e/QV5P/BawYIo/U8oB2jr/eM/IjNy+w=;
X-UUID: e7ccb6d02e4644b7bf103154b1467f43-20200722
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 514251515; Wed, 22 Jul 2020 12:33:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 12:33:05 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 12:33:05 +0800
Message-ID: <1595392386.10996.1.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add pwrap driver for
 MT6873/8192 SoCs
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Argus Lin <argus.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 22 Jul 2020 12:33:06 +0800
In-Reply-To: <e80b2e38-1324-a038-5647-6f595381ba47@gmail.com>
References: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1594720432-19586-4-git-send-email-hsin-hsiung.wang@mediatek.com>
         <e80b2e38-1324-a038-5647-6f595381ba47@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 46BA3841AF452073B5F6F01FB82066505059B1E882F9A8BBE0A5884CFB3224812000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMC0wNy0yMiBhdCAwMDo1MSArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dl
ciB3cm90ZToNCj4gDQo+IE9uIDE0LzA3LzIwMjAgMTE6NTMsIEhzaW4tSHNpdW5nIFdhbmcgd3Jv
dGU6DQo+ID4gTVQ2ODczLzgxOTIgYXJlIGhpZ2hseSBpbnRlZ3JhdGVkIFNvQ3MgYW5kIHVzZSBQ
TUlDX01UNjM1OSBmb3INCj4gPiBwb3dlciBtYW5hZ2VtZW50LiBUaGlzIHBhdGNoIGFkZHMgcHdy
YXAgbWFzdGVyIGRyaXZlciB0bw0KPiA+IGFjY2VzcyBQTUlDX01UNjM1OS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbWljLXdyYXAu
YyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBpbmRleCBjODk3MjA1Li42ZTdmNzk2
ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBAQCAt
MjQsMTEgKzI0LDEzIEBADQo+ID4gICAjZGVmaW5lIFBXUkFQX01UODEzNV9CUklER0VfV0RUX1NS
Q19FTgkJMHg1NA0KPiA+ICAgDQo+ID4gICAvKiBtYWNybyBmb3Igd3JhcHBlciBzdGF0dXMgKi8N
Cj4gPiArI2RlZmluZSBQV1JBUF9HRVRfU1dJTkZfMl9GU00oeCkJKCgoeCkgPj4gMSkgJiAweDAw
MDAwMDA3KQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9HRVRfV0FDU19SREFUQSh4KQkJKCgoeCkgPj4g
MCkgJiAweDAwMDBmZmZmKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9HRVRfV0FDU19GU00oeCkJCSgo
KHgpID4+IDE2KSAmIDB4MDAwMDAwMDcpDQo+ID4gICAjZGVmaW5lIFBXUkFQX0dFVF9XQUNTX1JF
USh4KQkJKCgoeCkgPj4gMTkpICYgMHgwMDAwMDAwMSkNCj4gPiAgICNkZWZpbmUgUFdSQVBfU1RB
VEVfU1lOQ19JRExFMAkJQklUKDIwKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9TVEFURV9JTklUX0RP
TkUwCQlCSVQoMjEpDQo+ID4gKyNkZWZpbmUgUFdSQVBfU1RBVEVfSU5JVF9ET05FMQkJQklUKDE1
KQ0KPiA+ICAgDQo+ID4gICAvKiBtYWNybyBmb3IgV0FDUyBGU00gKi8NCj4gPiAgICNkZWZpbmUg
UFdSQVBfV0FDU19GU01fSURMRQkJMHgwMA0KPiA+IEBAIC03NCw2ICs3Niw3IEBADQo+ID4gICAj
ZGVmaW5lIFBXUkFQX0NBUF9EQ00JCUJJVCgyKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9DQVBfSU5U
MV9FTglCSVQoMykNCj4gPiAgICNkZWZpbmUgUFdSQVBfQ0FQX1dEVF9TUkMxCUJJVCg0KQ0KPiA+
ICsjZGVmaW5lIFBXUkFQX0NBUF9BUkIJCUJJVCg1KQ0KPiANCj4gVGhpcyBjb21taXQgc2hvdWxk
IGJlIHR3byBwYXRjaGVzIChhdCBsZWFzdCkuIE9uZSBhZGRpbmcgUFdSQVBfQ0FQX0FSQiBhbmQg
dGhlbiANCj4gYW5vdGhlciBvbmUgYWRkaW5nIE1UNjg3MyBzdXBwb3J0Lg0KPiANCj4gUmVnYXJk
cywNCj4gTWF0dGhpYXMNCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuIEkgd2lsbCB1cGRh
dGUgaXQgaW4gbmV4dCBwYXRjaC4NCg0KPiA+ICAgDQo+ID4gICAvKiBkZWZpbmVzIGZvciBzbGF2
ZSBkZXZpY2Ugd3JhcHBlciByZWdpc3RlcnMgKi8NCj4gPiAgIGVudW0gZGV3X3JlZ3Mgew0KPiA+
IEBAIC0zNDgsNiArMzUxLDEwIEBAIGVudW0gcHdyYXBfcmVncyB7DQoNCltEZWxldGVdDQoNCg==

