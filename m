Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE30E2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mrr+T6gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHCGRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15607 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728308AbgHCGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:19 -0400
X-UUID: ce79ef8e0d904c82aa1ad77df6c2340d-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8OxYDBn6rUlcM4RMvqMgBGh8IuKHYLplObbzSllCNoE=;
        b=Mrr+T6gz/k0pMt/i0iDQ0JX3FqIo79RP7EvGAN5RaR5afMblpTDzsyS4ItGx2GAySQJN5vwtLwDZyKDroOp7yT5jgMv+DlGp9z3CfPA+Rl5TNHhnN9iO0+e0oxBZuWqdTx4Wm4xTnjkD2P2eGvFqupADJFNYwvD66kg5iFJ+hIU=;
X-UUID: ce79ef8e0d904c82aa1ad77df6c2340d-20200803
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1631479455; Mon, 03 Aug 2020 14:17:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:13 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v2,6/6] arm64: dts: mt8192: add infracfg_rst node
Date:   Mon, 3 Aug 2020 14:15:11 +0800
Message-ID: <20200803061511.29555-7-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803061511.29555-1-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGluZnJhY2ZnX3JzdCBub2RlIHdoaWNoIGlzIGZvciBNVDgxOTIgcGxhdGZvcm0NCg0KU2ln
bmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCAxMyArKysrKysrKysr
KystDQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQppbmRleCA5MzFlMWNhMTcy
MjAuLmM5N2VmZjNhYTQ4ZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTkyLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTky
LmR0c2kNCkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVw
dC1jb250cm9sbGVyL2lycS5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waW5jdHJsL210ODE5
Mi1waW5mdW5jLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1wb3dlci5o
Pg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC90aS1zeXNjb24uaD4NCiANCiAvIHsNCiAJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTIiOw0KQEAgLTIxOSw5ICsyMjAsMTkgQEANCiAJ
CX07DQogDQogCQlpbmZyYWNmZzogaW5mcmFjZmdAMTAwMDEwMDAgew0KLQkJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTkyLWluZnJhY2ZnIiwgInN5c2NvbiI7DQorCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxOTItaW5mcmFjZmciLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KIAkJ
CXJlZyA9IDwwIDB4MTAwMDEwMDAgMCAweDEwMDA+Ow0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsN
CisNCisJCQlpbmZyYWNmZ19yc3Q6IHJlc2V0LWNvbnRyb2xsZXIgew0KKwkJCQljb21wYXRpYmxl
ID0gImdlbmVyaWMtcmVzZXQiLCAidGksc3lzY29uLXJlc2V0IjsNCisJCQkJI3Jlc2V0LWNlbGxz
ID0gPDE+Ow0KKwkJCQl0aSxyZXNldC1iaXRzID0gPA0KKwkJCQkJMHgxNDAgMTUgMHgxNDQgMTUg
MCAwIChBU1NFUlRfU0VUIHwgREVBU1NFUlRfU0VUIHwgU1RBVFVTX05PTkUpIC8qIDA6IHBjaWUg
Ki8NCisJCQkJPjsNCisJCQkJYXNzZXJ0LWRlYXNzZXJ0LXRvZ2V0aGVyOw0KKwkJCQl1cGRhdGUt
Zm9yY2U7DQorCQkJfTsNCiAJCX07DQogDQogCQlwZXJpY2ZnOiBwZXJpY2ZnQDEwMDAzMDAwIHsN
Ci0tIA0KMi4xOC4wDQo=

