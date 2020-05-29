Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE11C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0231F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EXjRYk2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgE2HRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2HRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:17:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E6C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:17:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so818847pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P5u/NbTWEXJl8r2ntb3RMUbWPRi8ebmRq4q1xRNaxs0=;
        b=EXjRYk2eE8ul6RkMaGwpyALBo5BTSDqE3OyHZPZb+x6FV1PL83C4t1UyRjx0Rl7Hlh
         4MnRprcXutzOk7MZJ5HWAaNu6U2ubJrQmyn3RFoi9Iph7iubNRbqUT/6SvDrCTr8f79M
         hfqJPtxO8+UDIaGmdlY5wINH9dUZxOi7NC/SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P5u/NbTWEXJl8r2ntb3RMUbWPRi8ebmRq4q1xRNaxs0=;
        b=Hmj6lQcZOaUG++KriEcyjcv5YvSAN603jZSUN1AdUjOj2DqKD0+ipIp28Dmh0UH0+H
         FE7slYLWHn65bfpGLaivxkSYpwO8c3nCYS63ZbWuGXK7IT7WkjsGGmbNImUfhAAk06IY
         zM7RwAJXW64A7+868yR6EMXKYGHgpH+vvjFimK207XgjrVMrAQHCz8Fj5N/8hy9UAJIT
         r/wG+15q+tY1Qj+btWt5sPPWvS3ZIA7QKtjREwRONOHN/Qj0UxBktOnZ2ZbMIYGNcj++
         TIvL2BNv3kQWvSPD3LZYSO6S1Y355L3w/lSVn3HwIzva61X6ao7pbksf7JBZ3bsyFAIL
         7JXw==
X-Gm-Message-State: AOAM5330GAU148ez8m5UJxyKoOjZhj/bzsnVH/+Pd00ifNsQUbO2JMdE
        J0kb2O96BCjjDvM3mvZ0rosAIw==
X-Google-Smtp-Source: ABdhPJyqIMaXyY94gFD+xEgk1Xo4EiJRBAUruzIQi6emdvQxnhR6IlFqXi9tfWoyUkrXC2CoQoI4aw==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr7778933plk.100.1590736629784;
        Fri, 29 May 2020 00:17:09 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w65sm6418005pfb.160.2020.05.29.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:17:08 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/1] drivers: mtd: spi-nor: update read capabilities for w25q64 and s25fl064k
Date:   Fri, 29 May 2020 12:46:55 +0530
Message-Id: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both w25q64 and s25fl064k nor flash support QUAD and DUAL read
command, hence update the same in flash_info table.

This is tested on Broadcom Stingray SoC (bcm958742t).

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
Changes from v1:
 -Address review comments from Vignesh Raghavendra
  Update commit message with testing details.

 drivers/mtd/spi-nor/spansion.c | 3 ++-
 drivers/mtd/spi-nor/winbond.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6756202ace4b..c91bbb8d9cd6 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -52,7 +52,8 @@ static const struct flash_info spansion_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
+	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl116k",  INFO(0x014015,      0,  64 * 1024,  32,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl132k",  INFO(0x014016,      0,  64 * 1024,  64, SECT_4K) },
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 17deabad57e1..2028cab3eff9 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -39,7 +39,8 @@ static const struct flash_info winbond_parts[] = {
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
-	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128,
+			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-- 
2.17.1

