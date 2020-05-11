Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE9120746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgEKMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:30:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbgEKMaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:30:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 62BA41ECF4DD7E306A7A;
        Mon, 11 May 2020 20:29:59 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 20:29:57 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: imx: pcm037: make pcm970_sja1000_platform_data static
Date:   Mon, 11 May 2020 20:36:04 +0800
Message-ID: <1589200564-12623-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

arch/arm/mach-imx/mach-pcm037.c:407:30: warning: symbol
'pcm970_sja1000_platform_data' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 arch/arm/mach-imx/mach-pcm037.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index bd9443f..c7d23e9 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -404,7 +404,7 @@ static struct resource pcm970_sja1000_resources[] = {
 	},
 };

-struct sja1000_platform_data pcm970_sja1000_platform_data = {
+static struct sja1000_platform_data pcm970_sja1000_platform_data = {
 	.osc_freq	= 16000000,
 	.ocr		= OCR_TX1_PULLDOWN | OCR_TX0_PUSHPULL,
 	.cdr		= CDR_CBP,
--
2.6.2

