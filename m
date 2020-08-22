Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3E2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R36KT0vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHVUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHVUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:53:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDD9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:53:58 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so2148713qvh.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PIy/GVOiYUwvU428MneLOPWpxXG94aDAsky93UC44VM=;
        b=R36KT0vT1MNfxJ1b+0CQ6/BJdF+XLLG0ecgq3vX9EsTXHjSH57FVeMoIdD4B4T1Ugp
         U9N0efpjzscRmqypNMUprnWGhyH87uNb9CUIZCI/2MJBNoTWFkfiH4TBtCfXOAwQWL1i
         iS/KKRgDlcIdnU0GumkblGp6PuS0ToBMMC0416gNvUFQGxiPmK+fZPMJOomwUkm+xoc9
         eKvKgrXClU+1W6h0g73fKhsx7P/BNLofKWIn4qfJXvOJgg7EtXFyfzFPc4q8h5XidwSv
         Urzsy0PYx7Q9c+0YTI1ssIwOoerDCsD58ZnKDUcoOC9rcTH3xwqywcTb8DUkH5Anf7TB
         iFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PIy/GVOiYUwvU428MneLOPWpxXG94aDAsky93UC44VM=;
        b=ZI+Nhrv5o4mkt3ZC2d4uDGqI1oC7r7pGp6KGivR6k4jFVYn0YQDzCM/5l7KT65ZbUm
         KN1T3Hp6xnr0OnGzybEC7LLeNfYyl19gBH88Hyv4T+GHcLfVaENI1iYsqT77iC0fDRWv
         XzWHc3HNZ+NdB2koJIOrsnWwjFLHE8XAiY9tGHypqcNO6/OwTklvdVBNNwCLQa7E6j5L
         DmXlDEKyNPUYrSd5jilfIK3XNvo/aWMFsKDaEO+w9HOTEuCmkHsidqnoz7o3aT4YPVA8
         CbWFCtFALG+VW6Du9RJkT/+hlMCffWEOF5UuEjUczan6gUiE4oe93gtsbk8UcOad2BXu
         wsvA==
X-Gm-Message-State: AOAM532slKVy61598GKgepaL7sxF6jEz2a80W9QhJcM9WLSD/YLaT1TU
        nBJ0LF4e/s7g3p7qAPcDPUF7+99ewM8=
X-Google-Smtp-Source: ABdhPJxs63fHT4wUUwB2kgsuamhGok6e4/QqqMHtPtP9bFFEKMayPqNOiu8utuSWCZ/PXivGaNdmjg==
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr7511203qvp.191.1598129636871;
        Sat, 22 Aug 2020 13:53:56 -0700 (PDT)
Received: from localhost.localdomain (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t8sm1478553qtt.95.2020.08.22.13.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 13:53:56 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, geert@linux-m68k.org, kishon@ti.com,
        vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
Date:   Sat, 22 Aug 2020 16:53:20 -0400
Message-Id: <20200822205320.9746-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Start by reading the content of the VENDOR_SPECIFIC2 register and update
each bit field based on device properties when defined.

The use of bit masks prevents fields from overriding each other and
enables users to clear bits which are set by default, like datapolarity
in this instance.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
Changes since v1:
- use set_mask_bits

Changes since v2:
- fix missing bit shift dropped in v2
- rebase on 5.9-rc1

Changes since v3:
- switch to u8p_replace_bits() since there's little reason to protect
  against concurrent access

 drivers/phy/ti/phy-tusb1210.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index d8d0cc11d187..a63213f5972a 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -7,15 +7,16 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/ulpi/driver.h>
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
 
 #define TUSB1210_VENDOR_SPECIFIC2		0x80
-#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
-#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
-#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
+#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
+#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
+#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
 
 struct tusb1210 {
 	struct ulpi *ulpi;
@@ -118,22 +119,22 @@ static int tusb1210_probe(struct ulpi *ulpi)
 	 * diagram optimization and DP/DM swap.
 	 */
 
+	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
+
 	/* High speed output drive strength configuration */
-	device_property_read_u8(&ulpi->dev, "ihstx", &val);
-	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);
 
 	/* High speed output impedance configuration */
-	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
 
 	/* DP/DM swap control */
-	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
 
-	if (reg) {
-		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
-		tusb->vendor_specific2 = reg;
-	}
+	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
+	tusb->vendor_specific2 = reg;
 
 	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
 	if (IS_ERR(tusb->phy))

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.27.0

