Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC912C55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD64620714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZDYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:24:41 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:44348 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgDZDYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:24:41 -0400
X-QQ-mid: bizesmtp11t1587871473t879fh72
Received: from wuxy.bitland.com.cn (unknown [103.100.115.75])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 26 Apr 2020 11:24:12 +0800 (CST)
X-QQ-SSF: 01400000002000Z0ZM30B00A0000000
X-QQ-FEAT: STDtK/lFkpah7mmZ8kZTATOOmbwdzlpfhSmcEuCzt/BbX3eeyOMrgDyxhhU7n
        gWY2i5mzls1hckLHM71jlLv6CniFhddgwh5D6xVYoJlBcJeKzWa58GhiqC7XIBf/LJtxBl1
        yv61qHVM21FUNeWQHRxY8/TTz/brNpDbHV7GtxKNItzof5I7iJM0b1hMhPs2AV6FGHQrphK
        cjFWcT5qBJFxgk3fXoM1Dei35q4SZ9vPPUFxhwOhxhC7eftus2RGkFBKYV84WbMtm5SXasg
        dI1StDpyD2d268ONRPo8FJbbyZiPIXz20FR/x5q2veZlSLhghjYHKjsILDjTfj/kXQYtv4T
        IUQyy0q
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     drinkcat@chromium.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Date:   Sun, 26 Apr 2020 11:24:10 +0800
Message-Id: <20200426032410.10425-1-wuxy@bitland.com.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuxy <wuxy@bitland.corp-partner.google.com>

Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
flash ID in kukui series,this patch can support the new flash IDs.
This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
The original patch is invalid,so re-submit a new patch for this.

TEST=boot to shell,get the spi information from 'dmesg'.

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
---
 drivers/mtd/spi-nor/winbond.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 17deabad57e1..cda4f8847bd6 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -61,6 +61,15 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q64jwxxIM", INFO(0xef8017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128jwxxIM", INFO(0xef8018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q256jwxxIM", INFO(0xef8019, 0, 64 * 1024, 512,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 };
 
 /**
-- 
2.20.1



