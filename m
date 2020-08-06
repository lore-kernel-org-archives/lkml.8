Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E292C38143
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03ED22D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LxLKwgr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgHFJbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:31:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729092AbgHFJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:23:40 -0400
X-UUID: d5e00c944d6e4ea8bf89776256ce0a6c-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gzKuM68ZpyeJR74U4TkdxIx7zStccxZl/s5YGVfZylE=;
        b=LxLKwgr2B9dfiUA04tGuWw1KDuCa0CXsySCoRWxJ/Wk7MLMG6mKdb8Vu+3QVT/GqutkFU5PZnqCvKo/PeAorP39DYQoJS95nLrgXi3KRBzuRbFuQB7fyEYKWdZTkWHl92+aW1uUoH5Lq7iFVBEelVStRi2O3FOvQu0OJqcjWHo4=;
X-UUID: d5e00c944d6e4ea8bf89776256ce0a6c-20200806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 675302145; Thu, 06 Aug 2020 17:22:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 17:22:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 17:22:00 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v17 12/12] arm64: dts: Add power-domains property to mfgcfg
Date:   Thu, 6 Aug 2020 17:21:55 +0800
Message-ID: <1596705715-15320-13-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWZnY2ZnIGNsb2NrIGlzIHVuZGVyIE1GR19BU1lOQyBwb3dlciBkb21haW4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQpp
bmRleCA0OTQwYmRhLi40M2RiMjI1IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaQ0KQEAgLTgwMCw2ICs4MDAsNyBAQA0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLW1mZ2NmZyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTMwMDAwMDAgMCAw
eDEwMDA+Ow0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZz
Y3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfQVNZTkM+Ow0KIAkJfTsNCiANCiAJCW1tc3lz
OiBzeXNjb25AMTQwMDAwMDAgew0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

