Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082D720737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896491AbgDOKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:40:40 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:34708 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408541AbgDOKYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:24:30 -0400
X-QQ-mid: bizesmtp25t1586946253tzxvjrfv
Received: from localhost.localdomain (unknown [183.62.170.245])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 15 Apr 2020 18:23:53 +0800 (CST)
X-QQ-SSF: 01400000008000Z0ZM30000A0000000
X-QQ-FEAT: HOoxYYcCKFWQ2Z0zDevDSJZyvUV7FL1N/iMRO7LZCDpv0SB1CO9Whqnv5SRzH
        52mpts2kk3xHXlKza4iIxB8JDJUFdaM03BIKwrdJp0b0pMwp3qwcX7q1Cu14Us625TFi5ns
        YXVppADkARbSQN4s/Mwi6SeVAbYqXOWRcUKx00bnFVnwzbwIu1a6EGesz77ZjtaNRD+9z4S
        WGbJdGTDuEvHa/xlAqWa9E7Ql3bwjpwxdzmvV0EnSOOH0CcKrqaMbeRREckxeziQpp0sPqX
        EiJ8OnpeAEre8oQgUkGvFzycGlp41KRkpqLBKQLqFUeyzx4GeJ8JjNUETfciZK4Fh0g8n7S
        Vp5mvtHeliP/qQ/4oVD1fc0X8dCAw==
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     wuxy@bitland.com.cn, wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] [v2]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Date:   Wed, 15 Apr 2020 18:23:49 +0800
Message-Id: <20200415102349.26836-1-wuxy@bitland.com.cn>
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



