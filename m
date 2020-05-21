Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AAC20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVUnHTXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgEUF0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 01:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgEUF0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 01:26:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D6C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:26:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t8so1464502wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=94FiodHUtUj74NaCpe0rAM7NIXPvi2dRW79zAd5+bos=;
        b=YVUnHTXJC9friZQ33uhkX/g3Il24tvG6lcvOPeKjB6/JFk/8jIEGBUCuZopbdUkVpy
         zsKXv8gPrHguRfXaeb2j3535C9dBOqyIpXPryxiVx3UP21dvCrFCN9obrf4vy+OV8k0o
         Vw/gLXCRzLVKK5qlGX0XPNZdNzgRKvi2ledis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=94FiodHUtUj74NaCpe0rAM7NIXPvi2dRW79zAd5+bos=;
        b=uL2YV65oougbJWLwcalJSTyRAkn1sTdZ8J+P0MJUxRXu5YTu+NPELPG6lXy3mOs3eT
         fPSzof8gVSwzoBTOAntp683O2ao3WF5eAETj1rifpls9S6M/f5LfTt6Lko5otUDc1u+Q
         e5oRVgIYJXc8nuCTOsiX73RIONgkNAQcZX6+nvlVzXwcyQRTlQx/G5OrW4XoLdRzN81T
         aMfBxjzrPrIpAL4Tw3jShYBpoTDoFH6PQN0Lr/373908WK4IGEkMdugciUZK1WHp3pg2
         DDvjNknPWE4a0kdxFGGZdBz4mKnLqRvIyqwu1zBmwEb4AkH2F570ucC5Aut5IxG5UtFx
         59Aw==
X-Gm-Message-State: AOAM530+qvSfEsy1/dLuO1mfYEnf4wGBMCFGNm0wfSAOF14DqARM3ThU
        WCVlQ1Nm9TsEDvOGlGnlrMverg==
X-Google-Smtp-Source: ABdhPJx7JV9SHaGggcuNKCw4mn1/dp2GgFyYILR9HW5X9qkMIZtgst272a1bYiSSw78+jfeTHcyDOg==
X-Received: by 2002:a1c:25c3:: with SMTP id l186mr7428854wml.103.1590038780122;
        Wed, 20 May 2020 22:26:20 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i21sm5283069wml.5.2020.05.20.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 22:26:19 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] drivers: mtd: spi-nor: update read capabilities for w25q64 and s25fl064k
Date:   Thu, 21 May 2020 10:56:08 +0530
Message-Id: <20200521052608.32667-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both w25q64 and s25fl064k nor flash support QUAD and DUAL read
command, hence update the same in flash_info table.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
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

