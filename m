Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA2CC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B741206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpvEqVHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDDNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:01:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33863 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgDDNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 09:01:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so3953602plm.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbmGGp28iLBGx2kdu0b3vnWpbi+iqdsV4klADyRej2U=;
        b=lpvEqVHbWsSI/vC2WOlhE5B7pZ591FruvYm+Oo4rRXNnPNDDJGl7teLltiQT5nn7A9
         utndRD33FUc866UH7L4t/z1o3kbnnGYnk+AI2YxgQj7KZTpP9BAtHiD+J+yLf1GDowAL
         9olyw1DeYPBjXWFJ08IPBU9/GGpL1lXJwJE6lioc1H7pFrdEzgK8WJxE2++ab4qj5yFt
         JYjw56zlSnHnbd3WW3BwFp5YWxcXb4whiJv8gFGGwoRiZUaH5uX/az0Naw4sBwNgWIcr
         hu2PH9mBENUleRxtkEjmaE66/XnOOheSx0c9DC1oqqSN0vgAf5zc34uGBd4wDniEngmZ
         F4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbmGGp28iLBGx2kdu0b3vnWpbi+iqdsV4klADyRej2U=;
        b=SFTru5tf8FusPCN78vMgbD2q75VtyG9OmcSvHHZtkne/uS2SL8Ypec5Q9b4sw53s7b
         oQTIjC/LragmLndsVM+yyVJOvOtkHSq+gbFcp7Oe19l2ux4vg4wQsIa1FCBkbu7q4FbT
         12slMQXDHsLSKzuB2YnPiqPBUOG8FUqf2wTJfvLjmWPV7v+s75sQvXUVJl0jAr2x86ZS
         FeFCu4l6dg3yV44EVpj8Tg/t/bKe/Ujs2vSKYVIk1t3iVeOEdDnT7D+kW+z6LL4XkLRM
         hONS4j2ITBEV3DdpdRuMa9L6h5dx27vcsd4zmIuaXoMZypuegBFTsU8zvHDZcsvKvBJE
         4toQ==
X-Gm-Message-State: AGi0PuZGoav3WPnhT1fnyOO5P+NqzLDCmRiKmn8nBPNtiYZ6VUWb3e//
        ALqD8sHj7g++cZM5mfaAx8ez9yZMO50=
X-Google-Smtp-Source: APiQypJBHHjo3d1FCB1Q3yDGSYQrsi6rcyZpuKwsY/nCpSkBxVSk5JCT19Ua2PZ59lsTY8tBA19OLA==
X-Received: by 2002:a17:90b:4c0e:: with SMTP id na14mr15870273pjb.73.1586005304747;
        Sat, 04 Apr 2020 06:01:44 -0700 (PDT)
Received: from guoguo-omen.lan ([240e:379:951:6837:3b06:87cd:9fe1:1cd2])
        by smtp.gmail.com with ESMTPSA id b133sm7824814pfb.180.2020.04.04.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 06:01:44 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
Date:   Sat,  4 Apr 2020 20:58:40 +0800
Message-Id: <20200404125845.1381080-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 10050a02f7d508fa88f70fcfceefbacd13488ca7.

Winbond W25Q256FV and W25Q256JV both uses 0xef4019 as JEDEC ID,
but only the latter has proper 4B_OPCODES support.
W25Q256FV has all 4B read instructions but it lacks a 4B page program
instruction, causing the entire flash to be read-only.
Disable 4B_OPCODES for W25Q256 completely.
Users can use broken-flash-reset as a temporary workaround.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
"line over 80 characters" warning produced by checkpatch.pl isn't
fixed because I think a revert commit should bring a file back to
what it was before.
I don't have a w25q256jv available and can't compare SFDP table
to create a fix similar to mx25l25635 one.

 drivers/mtd/spi-nor/winbond.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 17deabad57e1..9673ec7fa003 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -52,9 +52,7 @@ static const struct flash_info winbond_parts[] = {
 	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
-	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
-			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			  SPI_NOR_4B_OPCODES) },
+	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
-- 
2.25.1

