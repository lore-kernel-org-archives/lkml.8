Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C472C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168B320719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBGaI3ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCZRmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:42:39 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36904 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:42:39 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so2704817pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pi3s+hsQEc9m8KDmVv9mSsGP5/0IqLYBx14WB1G7v7g=;
        b=hBGaI3ZAbh8EF/9Pw5vh4P3kwXvhPvbRNmKo0T6S0GXuLkO1Y259C8aA3uyZE7Vguf
         VY4bD5uL+dTsvcLdr3Dzx2hW4RC/RXLml7ZVCQ3jTdIi/Jjr94Ynun+DXRwv7w1WPyqd
         AYShLYfxNHfUO4lXIp+J//7CWi+MZiiMthPcZ5J4a/DfIpVGViwjP6UUqI305A1G4KxQ
         AASwLj49vY46ZYwf7o58g8Yf9sYrvmqTEwppr+qSQOMIUoQ7dQ4F9/vwmBTaC6hm8B4o
         eqptE6iNyB8uOyO0gVt9ukW6Xnz7uQNQGxa9oD5RYbLdhGyAhib1Y1FpuZFcW5IqcWcl
         +NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pi3s+hsQEc9m8KDmVv9mSsGP5/0IqLYBx14WB1G7v7g=;
        b=B3mtX0xKuGcSSbIvaUXYw9vuCYKH5+duEHSPNiK/cfILy6mA5FVMuodjvjKKWz1wnU
         +EWcWntFhpYc5gE85riLLsm3FS8MY1qKmWdcfUpihsyls9FI52n2c4y7Zo5IU7b35SDD
         srFQgEILTNzJfTH3IaUUVwDn4r4Qmi0Ae9Movluu6+55FWRA7CGMLDu27WHFidQzkXbv
         nkYphmaXVPBt+rbg2MW4TV66koDmX3+DVREQ3SbBYEz2z//4sJrUZdw8DUyioDMktrtN
         8NpyiJZnQUGBZrsGzspI8lo/5+apoSokjqS+MKuieTWv1bMCbIqLvNVwum+zb59MAuEn
         i7xQ==
X-Gm-Message-State: ANhLgQ0lRBvNepdK9/mVkV4XscLW7Nyck3JU13sNV/3CM5OXEGk2Fhqq
        2Og5DfKr4IzqQyyzINmsBkc=
X-Google-Smtp-Source: ADFU+vtOOB4YT138AG39SOK4IzfdmgDSBLxPqSj8uEcIJySFjzTzwvcbFIyUUVC/KFkZJT84bChUrQ==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr8841190pls.298.1585244557355;
        Thu, 26 Mar 2020 10:42:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id q71sm2160373pfc.92.2020.03.26.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:42:36 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] ARM: vf610: report soc info via soc device
Date:   Thu, 26 Mar 2020 10:42:32 -0700
Message-Id: <20200326174232.23365-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds plumbing to soc device info code necessary to support
Vybrid devices. Use case in mind for this is CAAM driver, which
utilizes said API.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 arch/arm/mach-imx/cpu.c        | 16 ++++++++++
 arch/arm/mach-imx/mach-vf610.c | 53 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h        |  6 ++++
 3 files changed, 75 insertions(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 06f8d64b65af..e3d12b21d6f6 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -172,6 +172,22 @@ struct device * __init imx_soc_device_init(void)
 		ocotp_compat = "fsl,imx7ulp-ocotp";
 		soc_id = "i.MX7ULP";
 		break;
+	case MXC_CPU_VF500:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF500";
+		break;
+	case MXC_CPU_VF510:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF510";
+		break;
+	case MXC_CPU_VF600:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF600";
+		break;
+	case MXC_CPU_VF610:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF610";
+		break;
 	default:
 		soc_id = "Unknown";
 	}
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 9c929b09310c..565dc08412a2 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -3,11 +3,63 @@
  * Copyright 2012-2013 Freescale Semiconductor, Inc.
  */

+#include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/io.h>
+
 #include <linux/irqchip.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>

+#include "common.h"
+#include "hardware.h"
+
+#define MSCM_CPxCOUNT		0x00c
+#define MSCM_CPxCFG1		0x014
+
+static void __init vf610_detect_cpu(void)
+{
+	struct device_node *np;
+	u32 cpxcount, cpxcfg1;
+	unsigned int cpu_type;
+	void __iomem *mscm;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-mscm-cpucfg");
+	if (WARN_ON(!np))
+		return;
+
+	mscm = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (WARN_ON(!mscm))
+		return;
+
+	cpxcount = readl_relaxed(mscm + MSCM_CPxCOUNT);
+	cpxcfg1  = readl_relaxed(mscm + MSCM_CPxCFG1);
+
+	iounmap(mscm);
+
+	cpu_type = cpxcount ? MXC_CPU_VF600 : MXC_CPU_VF500;
+
+	if (cpxcfg1)
+		cpu_type |= MXC_CPU_VFx10;
+
+	mxc_set_cpu_type(cpu_type);
+}
+
+static void __init vf610_init_machine(void)
+{
+	struct device *parent;
+
+	vf610_detect_cpu();
+
+	parent = imx_soc_device_init();
+	if (parent == NULL)
+		pr_warn("failed to initialize soc device\n");
+
+	of_platform_default_populate(NULL, NULL, parent);
+}
+
 static const char * const vf610_dt_compat[] __initconst = {
 	"fsl,vf500",
 	"fsl,vf510",
@@ -20,5 +72,6 @@ static const char * const vf610_dt_compat[] __initconst = {
 DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF5xx/VF6xx (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.init_machine   = vf610_init_machine,
 	.dt_compat	= vf610_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 2bfd2d59b4a6..48e6d781f15b 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -33,6 +33,12 @@
 #define MXC_CPU_IMX7D		0x72
 #define MXC_CPU_IMX7ULP		0xff

+#define MXC_CPU_VFx10		0x010
+#define MXC_CPU_VF500		0x500
+#define MXC_CPU_VF510		(MXC_CPU_VF500 | MXC_CPU_VFx10)
+#define MXC_CPU_VF600		0x600
+#define MXC_CPU_VF610		(MXC_CPU_VF600 | MXC_CPU_VFx10)
+
 #define IMX_DDR_TYPE_LPDDR2		1

 #ifndef __ASSEMBLY__
--
2.21.0
