Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F7420775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896195AbgDOKIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:08:10 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:52673 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896152AbgDOKHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:07:35 -0400
X-QQ-mid: bizesmtp17t1586945230twufz7zk
Received: from localhost.localdomain (unknown [183.62.170.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 15 Apr 2020 18:06:49 +0800 (CST)
X-QQ-SSF: 01400000008000Z0ZM30000A0000000
X-QQ-FEAT: ChTsRoALjQBfGj9zU5LZU0Z8J70ngs1Dqbnbxv1X3e7fotTsF3nzzaSKVq54f
        1XyB4APyvSgejfGKeQjgAWxsrnZt7ckPVQ72hoAuYEL61aHZqGSQGh34giikNa3uZ3WEET1
        0ROhL8McFjYDzzzrzKL/eJHEbLVJnUPh5Vt559JDIOXIdSRP8m9rmu/dP5mqrGR6IcH7dwP
        nb7POpp+TCWw3agJgQF1SXpaUmV8zAPrxuZL+6GKNSqwAScdSG+ejRUb3EQn5MAo/C8BN/v
        H6h9AaA52DQG9nLLijKSb8QEexOI94URw+dnuHhZXKKyf1PLbILM++Ex/qfWHNapYh/ME3J
        UeIpRa5r5bTQ4pOzoI=
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     wuxy@bitland.com.cn, wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Date:   Wed, 15 Apr 2020 18:06:46 +0800
Message-Id: <20200415100646.26015-1-wuxy@bitland.com.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuxy <wuxy@bitland.corp-partner.google.com>

Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
flash ID in kukui series,this patch can support the new flash IDs.

TEST=boot to shell,get the spi information from 'dmesg'.

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
---
 drivers/mtd/spi-nor/winbond.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 17deabad57e1..1ec518d9b78d 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -61,6 +61,18 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q32jwxxIM", INFO(0xef8016, 0, 64 * 1024,  64,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
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



