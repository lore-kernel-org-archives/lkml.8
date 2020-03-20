Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59723C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA9F20786
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZpIJ7wUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTHcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:32:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46404 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726821AbgCTHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:42 -0400
X-UUID: dbfc21a60f714f6b933a44b1ee095878-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Nfvzh3wqdzb1MJOk3oGDzEOqxNuPIr7A1JiQgdFIu8U=;
        b=ZpIJ7wUTg2URO6MbDDZhVMsHgiLyj4L8e1kB5b1sxQKA/5v4hpGfBcmsguwrqjBcnQOFzefQKtwpzj1vyVWcwujYTowLriA6VG7g4l2BLI9DQpvYy4gGigIRoh8JZwlySVSZKb1YHe+G+lZqZ6aBWvwbSHU1Fq9bZjWBla7ks0o=;
X-UUID: dbfc21a60f714f6b933a44b1ee095878-20200320
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1481738020; Fri, 20 Mar 2020 15:32:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:31:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:20 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v13 11/11] arm64: dts: Add power-domains property to mfgcfg
Date:   Fri, 20 Mar 2020 15:32:20 +0800
Message-ID: <1584689540-5227-12-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
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
bmRleCA3MGYxOGI5Li40MzNjNjJlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaQ0KQEAgLTY1NCw2ICs2NTQsNyBAQA0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLW1mZ2NmZyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTMwMDAwMDAgMCAw
eDEwMDA+Ow0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZz
Y3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfQVNZTkM+Ow0KIAkJfTsNCiANCiAJCW1tc3lz
OiBzeXNjb25AMTQwMDAwMDAgew0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

