Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8033FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430842078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HSYk/ewF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgFZMm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:27 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:20257
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbgFZMmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEGzW0MMQhkCeWaOxxMwHIMbrGmD0IJdzwRJ04suyu8AuldnlyLCwWOOM4hO5dlkRmbWDHWT5N4t6CuSfAKNbC3c9Nd4gywQygISWfCWAHo90NMleZHY9saAHfn2KIIWnjYNmkKGuoBqYY23yaINkzfI45eDwmd3jhHIDSnEXAUS5igzIS5FwLHK/eBkFo1HdNsdev0OxjpmNEk4yDWQCvICwNaBPYLVheXDLCR+Oi9fYlj1j3DYebNTK2y5lrGfLrvCoqHmSK9VrxhTptrVLMMElRLNrHumdjIiP8kKiG5OWiXQ3JAySJ6WR1/EtuyvFrkmSGP6U1/PuWFk5PhM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPv6TD7wUNMPgu/HpNIyYMMTw8BdZmLj2JkoFzDg4OI=;
 b=Ysts5Hf4neyAh8wLa8anxVqVgf09+nEkyAwFyujL7qkmEyhqEwxB4HPW5PuUKYqE+RpcCdlqBHZvZQrDvV1I+R19qt5ch4VaaqH69Q9AI2PZAxp2yjlWWOczShOR6pncnAyoLXGjwGuUbcmA3enGXd2faQxZORFtEoabgnR1ug6NzTXXPIzBo4izOBEsGZ2yQmdH9AT5ap1AHribzDeQqLut8nhuIxa/FKXJ34HQ6BNVurShHfFUAjGmyyt47AHzIRBClGnfzQ0IKlQ2C/7dauoyVOTYlvPTFeGM8LrLCUNoY3a6h2xkomMUe99BjHlhXO9zjFTErdPqotE/k/1E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPv6TD7wUNMPgu/HpNIyYMMTw8BdZmLj2JkoFzDg4OI=;
 b=HSYk/ewFDrfHvWksnl6YOV6I635PWhUWvcp5C/wmb/syHU8bbNdtcuNmvMVuTFshfANaFIjU3Nt9e0JWCxZOx/tCBEgWfIU8UVAQ1qviIOH0Yb6D5edRGDIUo1n1TAzko7aANFa3S/5OamDBkkyhF3JTqOpNyrDHxBRpMR1GDT4=
Received: from SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) by BY5PR02MB6787.namprd02.prod.outlook.com
 (2603:10b6:a03:201::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:42:15 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::da) by SN4PR0201CA0010.outlook.office365.com
 (2603:10b6:803:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 12:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:42:15
 +0000
Received: from [149.199.38.66] (port=38931 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonf8-0003KP-J4; Fri, 26 Jun 2020 05:40:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongN-0001e6-6y; Fri, 26 Jun 2020 05:42:15 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCgDAE029309;
        Fri, 26 Jun 2020 05:42:13 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongL-0001Wm-AN; Fri, 26 Jun 2020 05:42:13 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 8/8] staging: clocking-wizard: Delete the driver from the staging
Date:   Fri, 26 Jun 2020 18:11:44 +0530
Message-Id: <1593175304-4876-9-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(346002)(136003)(46966005)(5660300002)(36756003)(316002)(426003)(4326008)(107886003)(44832011)(30864003)(6666004)(82740400003)(478600001)(966005)(9786002)(81166007)(47076004)(6916009)(7696005)(66574015)(83380400001)(70206006)(356005)(2906002)(70586007)(2616005)(82310400002)(8936002)(8676002)(336012)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b07432f-731c-4294-2e98-08d819ce5b1b
X-MS-TrafficTypeDiagnostic: BY5PR02MB6787:
X-Microsoft-Antispam-PRVS: <BY5PR02MB678761B6E789CA7A1D363C21AA930@BY5PR02MB6787.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xC5VTSLRuP4eMf1CQia2czireImBoXF0SZ/mphVXO8EGHJBQg3nmaHralgDGQJ4b8pFjAZ42rxCjfyB/E5ob6bqVNMqbHY1rL8mmlUx2jIh+hpAc39MCJjRE608vcsLxDCjfTudWOKFNS+RJp9r2HXOdPCtar5zb+rr4njJo1fz4TJNM8ZB0WZGLVcSPiSzXeh5dUq2HyRJYKBFeAT25E1WNSLfmBUdAWvBsfhr9qKsG8FWRfXqmgTqHFDePVAVltweGjnrwh3tm0XbSwcB/yrahIKTLHA7LcfEUftgTCDpQmC0nyG9xhVEgEoUW0dch+0wWmhdMsQPh+gLKDfgsKgtQ0JXof+rnGPxLbM94O9L7UD2tm5otJUBOZo6me6UxuKDzUZal6FeuSw6FQDYlpJPClqJXhx5Zz4QTcln0ux727J1Ep4+PrRW9gh8u9+2zua0zSKu8hVPr0074zyl70WGKnYw/AF0IGXld/b4ak8A=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:42:15.5280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b07432f-731c-4294-2e98-08d819ce5b1b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the driver from the staging as it is in drivers/clk.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/clocking-wizard/Kconfig            |  10 -
 drivers/staging/clocking-wizard/Makefile           |   2 -
 drivers/staging/clocking-wizard/TODO               |  12 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        | 333 ---------------------
 drivers/staging/clocking-wizard/dt-binding.txt     |  30 --
 7 files changed, 390 deletions(-)
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 4ec5528..cdb5422 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -78,8 +78,6 @@ source "drivers/staging/gs_fpgaboot/Kconfig"
 
 source "drivers/staging/unisys/Kconfig"
 
-source "drivers/staging/clocking-wizard/Kconfig"
-
 source "drivers/staging/fbtft/Kconfig"
 
 source "drivers/staging/fsl-dpaa2/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4d34198..14570e5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpgaboot/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
deleted file mode 100644
index 04be22d..0000000
--- a/drivers/staging/clocking-wizard/Kconfig
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Xilinx Clocking Wizard Driver
-#
-
-config COMMON_CLK_XLNX_CLKWZRD
-	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF
-	help
-	  Support for the Xilinx Clocking Wizard IP core clock generator.
diff --git a/drivers/staging/clocking-wizard/Makefile b/drivers/staging/clocking-wizard/Makefile
deleted file mode 100644
index b1f9152..0000000
--- a/drivers/staging/clocking-wizard/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
diff --git a/drivers/staging/clocking-wizard/TODO b/drivers/staging/clocking-wizard/TODO
deleted file mode 100644
index ebe99db..0000000
--- a/drivers/staging/clocking-wizard/TODO
+++ /dev/null
@@ -1,12 +0,0 @@
-TODO:
-	- support for fractional multiplier
-	- support for fractional divider (output 0 only)
-	- support for set_rate() operations (may benefit from Stephen Boyd's
-	  refactoring of the clk primitives: https://lkml.org/lkml/2014/9/5/766)
-	- review arithmetic
-	  - overflow after multiplication?
-	  - maximize accuracy before divisions
-
-Patches to:
-	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-	Sören Brinkmann <soren.brinkmann@xilinx.com>
diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
deleted file mode 100644
index e52a64b..0000000
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ /dev/null
@@ -1,333 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Xilinx 'Clocking Wizard' driver
- *
- *  Copyright (C) 2013 - 2014 Xilinx
- *
- *  Sören Brinkmann <soren.brinkmann@xilinx.com>
- */
-
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/module.h>
-#include <linux/err.h>
-
-#define WZRD_NUM_OUTPUTS	7
-#define WZRD_ACLK_MAX_FREQ	250000000UL
-
-#define WZRD_CLK_CFG_REG(n)	(0x200 + 4 * (n))
-
-#define WZRD_CLKOUT0_FRAC_EN	BIT(18)
-#define WZRD_CLKFBOUT_FRAC_EN	BIT(26)
-
-#define WZRD_CLKFBOUT_MULT_SHIFT	8
-#define WZRD_CLKFBOUT_MULT_MASK		(0xff << WZRD_CLKFBOUT_MULT_SHIFT)
-#define WZRD_DIVCLK_DIVIDE_SHIFT	0
-#define WZRD_DIVCLK_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
-#define WZRD_CLKOUT_DIVIDE_SHIFT	0
-#define WZRD_CLKOUT_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
-
-enum clk_wzrd_int_clks {
-	wzrd_clk_mul,
-	wzrd_clk_mul_div,
-	wzrd_clk_int_max
-};
-
-/**
- * struct clk_wzrd:
- * @clk_data:		Clock data
- * @nb:			Notifier block
- * @base:		Memory base
- * @clk_in1:		Handle to input clock 'clk_in1'
- * @axi_clk:		Handle to input clock 's_axi_aclk'
- * @clks_internal:	Internal clocks
- * @clkout:		Output clocks
- * @speed_grade:	Speed grade of the device
- * @suspended:		Flag indicating power state of the device
- */
-struct clk_wzrd {
-	struct clk_onecell_data clk_data;
-	struct notifier_block nb;
-	void __iomem *base;
-	struct clk *clk_in1;
-	struct clk *axi_clk;
-	struct clk *clks_internal[wzrd_clk_int_max];
-	struct clk *clkout[WZRD_NUM_OUTPUTS];
-	unsigned int speed_grade;
-	bool suspended;
-};
-
-#define to_clk_wzrd(_nb) container_of(_nb, struct clk_wzrd, nb)
-
-/* maximum frequencies for input/output clocks per speed grade */
-static const unsigned long clk_wzrd_max_freq[] = {
-	800000000UL,
-	933000000UL,
-	1066000000UL
-};
-
-static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned long event,
-				 void *data)
-{
-	unsigned long max;
-	struct clk_notifier_data *ndata = data;
-	struct clk_wzrd *clk_wzrd = to_clk_wzrd(nb);
-
-	if (clk_wzrd->suspended)
-		return NOTIFY_OK;
-
-	if (ndata->clk == clk_wzrd->clk_in1)
-		max = clk_wzrd_max_freq[clk_wzrd->speed_grade - 1];
-	else if (ndata->clk == clk_wzrd->axi_clk)
-		max = WZRD_ACLK_MAX_FREQ;
-	else
-		return NOTIFY_DONE;	/* should never happen */
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-		if (ndata->new_rate > max)
-			return NOTIFY_BAD;
-		return NOTIFY_OK;
-	case POST_RATE_CHANGE:
-	case ABORT_RATE_CHANGE:
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static int __maybe_unused clk_wzrd_suspend(struct device *dev)
-{
-	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
-
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-	clk_wzrd->suspended = true;
-
-	return 0;
-}
-
-static int __maybe_unused clk_wzrd_resume(struct device *dev)
-{
-	int ret;
-	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
-
-	ret = clk_prepare_enable(clk_wzrd->axi_clk);
-	if (ret) {
-		dev_err(dev, "unable to enable s_axi_aclk\n");
-		return ret;
-	}
-
-	clk_wzrd->suspended = false;
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
-			 clk_wzrd_resume);
-
-static int clk_wzrd_probe(struct platform_device *pdev)
-{
-	int i, ret;
-	u32 reg;
-	unsigned long rate;
-	const char *clk_name;
-	struct clk_wzrd *clk_wzrd;
-	struct device_node *np = pdev->dev.of_node;
-
-	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
-	if (!clk_wzrd)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, clk_wzrd);
-
-	clk_wzrd->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(clk_wzrd->base))
-		return PTR_ERR(clk_wzrd->base);
-
-	ret = of_property_read_u32(np, "speed-grade", &clk_wzrd->speed_grade);
-	if (!ret) {
-		if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
-			dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
-				 clk_wzrd->speed_grade);
-			clk_wzrd->speed_grade = 0;
-		}
-	}
-
-	clk_wzrd->clk_in1 = devm_clk_get(&pdev->dev, "clk_in1");
-	if (IS_ERR(clk_wzrd->clk_in1)) {
-		if (clk_wzrd->clk_in1 != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "clk_in1 not found\n");
-		return PTR_ERR(clk_wzrd->clk_in1);
-	}
-
-	clk_wzrd->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(clk_wzrd->axi_clk)) {
-		if (clk_wzrd->axi_clk != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "s_axi_aclk not found\n");
-		return PTR_ERR(clk_wzrd->axi_clk);
-	}
-	ret = clk_prepare_enable(clk_wzrd->axi_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
-		return ret;
-	}
-	rate = clk_get_rate(clk_wzrd->axi_clk);
-	if (rate > WZRD_ACLK_MAX_FREQ) {
-		dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n",
-			rate);
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
-
-	/* we don't support fractional div/mul yet */
-	reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-		    WZRD_CLKFBOUT_FRAC_EN;
-	reg |= readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2)) &
-		     WZRD_CLKOUT0_FRAC_EN;
-	if (reg)
-		dev_warn(&pdev->dev, "fractional div/mul not supported\n");
-
-	/* register multiplier */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-		     WZRD_CLKFBOUT_MULT_MASK) >> WZRD_CLKFBOUT_MULT_SHIFT;
-	clk_name = kasprintf(GFP_KERNEL, "%s_mul", dev_name(&pdev->dev));
-	if (!clk_name) {
-		ret = -ENOMEM;
-		goto err_disable_clk;
-	}
-	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
-			(&pdev->dev, clk_name,
-			 __clk_get_name(clk_wzrd->clk_in1),
-			 0, reg, 1);
-	kfree(clk_name);
-	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
-		dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
-		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
-		goto err_disable_clk;
-	}
-
-	/* register div */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
-	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
-	if (!clk_name) {
-		ret = -ENOMEM;
-		goto err_rm_int_clk;
-	}
-
-	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
-			(&pdev->dev, clk_name,
-			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
-			 0, 1, reg);
-	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
-		dev_err(&pdev->dev, "unable to register divider clock\n");
-		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
-		goto err_rm_int_clk;
-	}
-
-	/* register div per output */
-	for (i = WZRD_NUM_OUTPUTS - 1; i >= 0 ; i--) {
-		const char *clkout_name;
-
-		if (of_property_read_string_index(np, "clock-output-names", i,
-						  &clkout_name)) {
-			dev_err(&pdev->dev,
-				"clock output name not specified\n");
-			ret = -EINVAL;
-			goto err_rm_int_clks;
-		}
-		reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * 12);
-		reg &= WZRD_CLKOUT_DIVIDE_MASK;
-		reg >>= WZRD_CLKOUT_DIVIDE_SHIFT;
-		clk_wzrd->clkout[i] = clk_register_fixed_factor
-			(&pdev->dev, clkout_name, clk_name, 0, 1, reg);
-		if (IS_ERR(clk_wzrd->clkout[i])) {
-			int j;
-
-			for (j = i + 1; j < WZRD_NUM_OUTPUTS; j++)
-				clk_unregister(clk_wzrd->clkout[j]);
-			dev_err(&pdev->dev,
-				"unable to register divider clock\n");
-			ret = PTR_ERR(clk_wzrd->clkout[i]);
-			goto err_rm_int_clks;
-		}
-	}
-
-	kfree(clk_name);
-
-	clk_wzrd->clk_data.clks = clk_wzrd->clkout;
-	clk_wzrd->clk_data.clk_num = ARRAY_SIZE(clk_wzrd->clkout);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_wzrd->clk_data);
-
-	if (clk_wzrd->speed_grade) {
-		clk_wzrd->nb.notifier_call = clk_wzrd_clk_notifier;
-
-		ret = clk_notifier_register(clk_wzrd->clk_in1,
-					    &clk_wzrd->nb);
-		if (ret)
-			dev_warn(&pdev->dev,
-				 "unable to register clock notifier\n");
-
-		ret = clk_notifier_register(clk_wzrd->axi_clk, &clk_wzrd->nb);
-		if (ret)
-			dev_warn(&pdev->dev,
-				 "unable to register clock notifier\n");
-	}
-
-	return 0;
-
-err_rm_int_clks:
-	clk_unregister(clk_wzrd->clks_internal[1]);
-err_rm_int_clk:
-	kfree(clk_name);
-	clk_unregister(clk_wzrd->clks_internal[0]);
-err_disable_clk:
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-
-	return ret;
-}
-
-static int clk_wzrd_remove(struct platform_device *pdev)
-{
-	int i;
-	struct clk_wzrd *clk_wzrd = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	for (i = 0; i < WZRD_NUM_OUTPUTS; i++)
-		clk_unregister(clk_wzrd->clkout[i]);
-	for (i = 0; i < wzrd_clk_int_max; i++)
-		clk_unregister(clk_wzrd->clks_internal[i]);
-
-	if (clk_wzrd->speed_grade) {
-		clk_notifier_unregister(clk_wzrd->axi_clk, &clk_wzrd->nb);
-		clk_notifier_unregister(clk_wzrd->clk_in1, &clk_wzrd->nb);
-	}
-
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-
-	return 0;
-}
-
-static const struct of_device_id clk_wzrd_ids[] = {
-	{ .compatible = "xlnx,clocking-wizard" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
-
-static struct platform_driver clk_wzrd_driver = {
-	.driver = {
-		.name = "clk-wizard",
-		.of_match_table = clk_wzrd_ids,
-		.pm = &clk_wzrd_dev_pm_ops,
-	},
-	.probe = clk_wzrd_probe,
-	.remove = clk_wzrd_remove,
-};
-module_platform_driver(clk_wzrd_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com");
-MODULE_DESCRIPTION("Driver for the Xilinx Clocking Wizard IP core");
diff --git a/drivers/staging/clocking-wizard/dt-binding.txt b/drivers/staging/clocking-wizard/dt-binding.txt
deleted file mode 100644
index 723271e..0000000
--- a/drivers/staging/clocking-wizard/dt-binding.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Binding for Xilinx Clocking Wizard IP Core
-
-This binding uses the common clock binding[1]. Details about the devices can be
-found in the product guide[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Clocking Wizard Product Guide
-http://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v5_1/pg065-clk-wiz.pdf
-
-Required properties:
- - compatible: Must be 'xlnx,clocking-wizard'
- - reg: Base and size of the cores register space
- - clocks: Handle to input clock
- - clock-names: Tuple containing 'clk_in1' and 's_axi_aclk'
- - clock-output-names: Names for the output clocks
-
-Optional properties:
- - speed-grade: Speed grade of the device (valid values are 1..3)
-
-Example:
-	clock-generator@40040000 {
-		reg = <0x40040000 0x1000>;
-		compatible = "xlnx,clocking-wizard";
-		speed-grade = <1>;
-		clock-names = "clk_in1", "s_axi_aclk";
-		clocks = <&clkc 15>, <&clkc 15>;
-		clock-output-names = "clk_out0", "clk_out1", "clk_out2",
-				     "clk_out3", "clk_out4", "clk_out5",
-				     "clk_out6", "clk_out7";
-	};
-- 
2.1.1

