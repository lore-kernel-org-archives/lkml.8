Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC6CC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2693620708
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgELBie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:38:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgELBid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:38:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70508F53A8D7A8A81B81;
        Tue, 12 May 2020 09:38:28 +0800 (CST)
Received: from ubuntu.huawei.com (10.175.100.98) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 12 May 2020 09:38:26 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     <narmstrong@baylibre.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-oxnas@groups.io>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: oxnas: make ox820_boot_secondary static
Date:   Tue, 12 May 2020 09:46:13 +0800
Message-ID: <1589247973-29728-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.98]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

arch/arm/mach-oxnas/platsmp.c:30:12: warning: symbol 'ox820_boot_secondary' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 arch/arm/mach-oxnas/platsmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
index ab35275..f0a50b9 100644
--- a/arch/arm/mach-oxnas/platsmp.c
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -27,7 +27,8 @@ static void __iomem *gic_cpu_ctrl;
 #define GIC_CPU_CTRL			0x00
 #define GIC_CPU_CTRL_ENABLE		1

-int __init ox820_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __init ox820_boot_secondary(unsigned int cpu,
+		struct task_struct *idle)
 {
 	/*
 	 * Write the address of secondary startup into the
--
2.7.4

