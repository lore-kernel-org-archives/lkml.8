Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D54C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7943A21775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncLxx5wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEBEXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBEXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:23:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 21:23:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so816069pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B5O6bNLv6v1kkgNv2oLyV6/5KsUPHviWj2aSnXUWZ5I=;
        b=ncLxx5wynfnL0b2iuPI0E3Fas7gvAovyZaKxcXmJJBZWRgiPxYsEPjcN2MrKKqajL0
         s/xUC+XYBjPT8rXp3FNRyhQp4JaxerPh1xDkD+ze5rMnK1AuLHQpksR2UjDgWgMxR011
         /+D6650ANWr0TR0fUwhYBTohT/IZJab7FjdN2JPiategBGZ6FPxSGfhG/6wJ9fcyhhnA
         5ro0Ol+a7FSDXBdUoQepQwfIclwaKm/3O1M8DAiaUshHENTk2w0OWtt0097QZ9bx9Jmc
         2PzTPkvR1wofetxRV+rDdZ1H6m+AjNPtppU5DQaWMj+BGeDGw35FE9EKmDoJTCKNgyuy
         mwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B5O6bNLv6v1kkgNv2oLyV6/5KsUPHviWj2aSnXUWZ5I=;
        b=LCUsDxvG7U5zdddAGrJWvtSQEsmWMzTAxkqRrWe+OGfZfQ2oK5hb7G6ywryOBkMxmG
         dS5mcc3FjEaBA4qrx33bfJKVnCniZFRKMOVWQ7u41fbj8bEPLcPnIitwhsMfhH2Zgeiz
         2i10S/1lFV9FoCqAoeTm6rMVKw4xSUOkv1yMznaIrhBH4I1/VF+rXvHscZGZFqXRDan+
         uw6y8K1gAFv8VAwoQdub515x3O1uIxwV+WRm1GqiOOrVJ1iBlQqEq5jdXwFtUyi/+V62
         bEwXRbrvI/R3gnXj0jbFCN7sZecU4scxlIgdeXzK2htdP6+61rdetvmYIZ2uxDmJsk/D
         fLbA==
X-Gm-Message-State: AGi0PuYmNCuWssge9gjRyKI+YaZ02zSbtDbnxwzAPX6NNV/TI34KYY1q
        KfGJ/BR4EBXuAD2fYsriuGWwgLxY
X-Google-Smtp-Source: APiQypI9DsptJLWsDzkEPvpT6vGtUmhwoo9EJPRNZEIfGKhoMD9Kr+U51KQ/2L0TGIpok4MdV8IdEQ==
X-Received: by 2002:a17:902:7d98:: with SMTP id a24mr7225182plm.97.1588393414612;
        Fri, 01 May 2020 21:23:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id r78sm3045531pgr.40.2020.05.01.21.23.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 01 May 2020 21:23:33 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Date:   Fri,  1 May 2020 21:23:28 -0700
Message-Id: <1588393408-31225-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Drop CONFIG_MTD_M25P80 that was removed in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/arm/configs/axm55xx_defconfig     | 1 -
 arch/arm/configs/davinci_all_defconfig | 1 -
 arch/arm/configs/dove_defconfig        | 1 -
 arch/arm/configs/imx_v6_v7_defconfig   | 1 -
 arch/arm/configs/keystone_defconfig    | 1 -
 arch/arm/configs/mvebu_v5_defconfig    | 1 -
 arch/arm/configs/mvebu_v7_defconfig    | 1 -
 arch/arm/configs/mxs_defconfig         | 1 -
 arch/arm/configs/pxa_defconfig         | 1 -
 arch/arm/configs/qcom_defconfig        | 1 -
 arch/arm/configs/sama5_defconfig       | 1 -
 arch/arm/configs/socfpga_defconfig     | 1 -
 arch/arm/configs/tegra_defconfig       | 1 -
 13 files changed, 13 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 4607521..c731d4a 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -88,7 +88,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index e849367..4d8f6f6 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -75,7 +75,6 @@ CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
 CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
 CONFIG_MTD_SPI_NOR=m
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index e70c997..546afaf 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -44,7 +44,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5a20d12..308de35 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -110,7 +110,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 11e2211..eeaa140 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -121,7 +121,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 226f2e9..1859097 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -75,7 +75,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index cddce57..c8f4723 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -50,7 +50,6 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index a9c6f32..1322ebd 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -46,7 +46,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index b817c57..50bbfdd 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -181,7 +181,6 @@ CONFIG_MTD_RAM=m
 CONFIG_MTD_ROM=m
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PXA2XX=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
 CONFIG_MTD_RAW_NAND=m
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index c882167..0a90c8d 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -62,7 +62,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index bab7861..7e9ec6f 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -63,7 +63,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index e73c97b..04c8bd3 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -48,7 +48,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index aa94369..6a7988a 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -76,7 +76,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEGRA_GMI=y
 CONFIG_MTD=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_AD525X_DPOT=y
-- 
2.7.4

