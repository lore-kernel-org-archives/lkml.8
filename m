Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A4C20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgE1Czx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:55:53 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:42501 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgE1Czw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:55:52 -0400
X-QQ-mid: bizesmtp17t1590634531t4kkroiy
Received: from localhost.localdomain (unknown [119.145.4.99])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 28 May 2020 10:55:05 +0800 (CST)
X-QQ-SSF: 01400000008000Z0ZM30B00A0000000
X-QQ-FEAT: uJKlVohL8WrUmw5d04dFFrqzkgAeOWXIToTH7WzM6KcwWQSN0b8y8Nxejvw4W
        dkt5TuBcZ6dSar9Sn5vl7VTFkOol1StpX7ZF/mnKXyE8OYCcuO8FNNDKwXpab5SbP9gEURx
        YTgfzdqC8MA4dIM1uYrYzVoVIZQW4Lz33KCTt436b837Ezg9bUPLg9kAoXieHoIo7zOW4ce
        tqnKj9cCJL/ozufCUTaYtR0waY9RnlQI+B5gtPQOKvy4Me8jOXS1iiIe+w1yvZMVpraJ3k5
        XZlUnjviXASmwOoB8zwodEFsH5T/LfIDH43iGpGUjkCOTk27zDOZhxwV8bNi5DyPiqm5OIT
        nVr1LHYvFEvPCT9wPs=
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        linux-mtd@lists.infradead.org, stlin2@winbond.com
Cc:     wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Date:   Thu, 28 May 2020 10:55:03 +0800
Message-Id: <20200528025503.24003-1-wuxy@bitland.com.cn>
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
flash IDs in kukui series,this patch can support the new flash IDs.

TEST=boot to shell,get the spi information from 'dmesg'.

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
Signed-off-by: ST Lin <stlin2@winbond.com>

This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
The original patch is invalid,so re-submit a new patch for this.
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



