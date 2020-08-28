Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B0CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E02086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a5Dq+rzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgH1OBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:01:44 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:29153
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbgH1N76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhEgNJzgbK4xwGiQBuxKhWwPu9z3FCacoZDe6EUDuF96MVnMZWMQ42bee/2OWkr/3A5FYYAW60o5eDv7LtZEIM/JtGmtubWLK7BJY8V9Z5G3x6+gDpqSMdGQClWEpiFitspHUw+cHHZJkPmuGyDpvN7eYHGo8kxofIeqccaPMxi3I7NPsf++6EOxyRxFpQ3c4R7y+VaDCNwHSBe4+5sVXaWHVIcCPEOTQC4oYw4JZcsG3Sbiu7ss4gMqpFNNp1GZ8HrL4MM8Rn2lQC+XKPrarCWB8YQwl3HHqQnzOJICNSMtFbJvOy38pMZg8b7CkIXrG8RLAxkVXf7/D2Sv0AMqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIKYpzXRiurH8YBiJf/qyWthg1ZT0rZ1bm+BXbXHFog=;
 b=Aec7UfP6joit9b981pCH6lV2JzD0L/NVmlUuHPgQSCPtOoCeBnKqan9EMmY+oUcrohx+bjVS5pUpg5sUzHXvIvpHqxviSK2HfcS5gzyHggBL4UwTqF1tZVNj6FQybqcEs1it4cWSUtVC6bQBEU6utMku4SwBUoBa6XoNrDcQ7SqcI9KA9L6MZDAjRkuQHPxMNIoM/+Cp0WS0dZa4X/X4YiSv2RlrpqGUSe1CMBwt30bV5dxS90StvRMx4hd584ml6uBc7svn4NzJbfM3a7HKlEYjNdOKSNWlG2lZ/6XyxJOop/tJMh4CAhY9Dyc+tmlRzeak2EkNgW/9O/2B59Ogfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIKYpzXRiurH8YBiJf/qyWthg1ZT0rZ1bm+BXbXHFog=;
 b=a5Dq+rzIAj1DxNUuTG0PWt0L9/csDZekzyNQzhIgF0JPz2QwUErZEnQLohYEuskxQOTpc5LInMDp2PllLEeVlw+6UFYyrct5RfdecjTz1d9Aoee36iB0nYA4cZRP7HQG7CfHwOyEJWe2aUqhU9gggHSOCjpU89ChQ0bojaKRoxQ=
Received: from SN4PR0501CA0064.namprd05.prod.outlook.com
 (2603:10b6:803:41::41) by BYAPR02MB5895.namprd02.prod.outlook.com
 (2603:10b6:a03:11d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 13:40:23 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::cc) by SN4PR0501CA0064.outlook.office365.com
 (2603:10b6:803:41::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:40:23
 +0000
Received: from [149.199.38.66] (port=59343 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebc-0004sW-QL; Fri, 28 Aug 2020 06:39:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBecA-0006Fd-Rl; Fri, 28 Aug 2020 06:40:22 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SDeEcS024575;
        Fri, 28 Aug 2020 06:40:14 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBec1-0005it-VZ; Fri, 28 Aug 2020 06:40:14 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, sboyd@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v6 2/8] clk: clock-wizard: Add the clockwizard to clk directory
Date:   Fri, 28 Aug 2020 19:09:50 +0530
Message-Id: <1598621996-31040-3-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37788a31-152d-4af2-48e2-08d84b57e9ec
X-MS-TrafficTypeDiagnostic: BYAPR02MB5895:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5895FC128D8CB58BA9A50254AA520@BYAPR02MB5895.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjRLdBTBVm1izWZt/x8+sVs031ZOoSAPqW5IzlmQ8G4CMvomVenUlbhwRqulhTuvURsJbV+IxRa9AcedN6tNOBa4Esi9MjwTgQgBtC8YwDiJWWBOMI7qCSr+DNDp+oesghAsat0c2o53Krj/BIz4SPMRR2sgd8LabzXeRi793cD46EB85rtIs8NsVkdQaKrfr4fypmnNnIId4A0vjUPY9MApIBSyU6w5/sPPLjXjxMBmrnOiRITAmuf4JcECxGoUCFMO3xkC2C08zxk0IEKdw7SdSI5wuROXsA0BAdyWk68rnv14xGEBCbRsIgf06o8BDjjupaUCRWlqVuLfzuUqa0HvnVa1OGAJiWdKABgSOelVBNVL7V+A3JcGZGD+lqRgEbW08Qpf/Hg0U8xLGm1rAw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(6916009)(70586007)(70206006)(107886003)(82310400002)(186003)(82740400003)(66574015)(336012)(316002)(36756003)(83380400001)(47076004)(356005)(81166007)(7696005)(26005)(2616005)(8936002)(44832011)(8676002)(426003)(4326008)(5660300002)(2906002)(9786002)(478600001)(30864003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:40:23.1639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37788a31-152d-4af2-48e2-08d84b57e9ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocking wizard driver to clk.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/Kconfig                 |   9 +
 drivers/clk/Makefile                |   1 +
 drivers/clk/clk-xlnx-clock-wizard.c | 338 ++++++++++++++++++++++++++++++++++++
 3 files changed, 348 insertions(+)
 create mode 100644 drivers/clk/clk-xlnx-clock-wizard.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4026fac..a0e29dd 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -359,6 +359,15 @@ config COMMON_CLK_FIXED_MMIO
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
+config COMMON_CLK_XLNX_CLKWZRD
+	tristate "Xilinx Clocking Wizard"
+	depends on COMMON_CLK && OF
+	help
+	  Support for the Xilinx Clocking Wizard IP core clock generator.
+	  Adds support for clocking wizard and compatible.
+	  This driver supports the Xilinx clocking wizard programmable clock
+	  synthesizer. The number of output is configurable in the design.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index da8fcf1..1ad6414 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
 obj-$(CONFIG_COMMON_CLK_VC5)		+= clk-versaclock5.o
 obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
+obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
 
 # please keep this section sorted lexicographically by directory path name
 obj-y					+= actions/
diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
new file mode 100644
index 0000000..b31524a
--- /dev/null
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx 'Clocking Wizard' driver
+ *
+ *  Copyright (C) 2013 - 2020 Xilinx
+ *
+ *  Sören Brinkmann <soren.brinkmann@xilinx.com>
+ *  Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/err.h>
+
+#define WZRD_NUM_OUTPUTS	7
+#define WZRD_ACLK_MAX_FREQ	250000000UL
+
+#define WZRD_CLK_CFG_REG(n)	(0x200 + 4 * (n))
+
+#define WZRD_CLKOUT0_FRAC_EN	BIT(18)
+#define WZRD_CLKFBOUT_FRAC_EN	BIT(26)
+
+#define WZRD_CLKFBOUT_MULT_SHIFT	8
+#define WZRD_CLKFBOUT_MULT_MASK		(0xff << WZRD_CLKFBOUT_MULT_SHIFT)
+#define WZRD_DIVCLK_DIVIDE_SHIFT	0
+#define WZRD_DIVCLK_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
+#define WZRD_CLKOUT_DIVIDE_SHIFT	0
+#define WZRD_CLKOUT_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
+
+enum clk_wzrd_int_clks {
+	wzrd_clk_mul,
+	wzrd_clk_mul_div,
+	wzrd_clk_int_max
+};
+
+/**
+ * struct clk_wzrd:
+ * @clk_data:		Clock data
+ * @nb:			Notifier block
+ * @base:		Memory base
+ * @clk_in1:		Handle to input clock 'clk_in1'
+ * @axi_clk:		Handle to input clock 's_axi_aclk'
+ * @clks_internal:	Internal clocks
+ * @clkout:		Output clocks
+ * @speed_grade:	Speed grade of the device
+ * @suspended:		Flag indicating power state of the device
+ */
+struct clk_wzrd {
+	struct clk_onecell_data clk_data;
+	struct notifier_block nb;
+	void __iomem *base;
+	struct clk *clk_in1;
+	struct clk *axi_clk;
+	struct clk *clks_internal[wzrd_clk_int_max];
+	struct clk *clkout[WZRD_NUM_OUTPUTS];
+	unsigned int speed_grade;
+	bool suspended;
+};
+
+#define to_clk_wzrd(_nb) container_of(_nb, struct clk_wzrd, nb)
+
+/* maximum frequencies for input/output clocks per speed grade */
+static const unsigned long clk_wzrd_max_freq[] = {
+	800000000UL,
+	933000000UL,
+	1066000000UL
+};
+
+static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned long event,
+				 void *data)
+{
+	unsigned long max;
+	struct clk_notifier_data *ndata = data;
+	struct clk_wzrd *clk_wzrd = to_clk_wzrd(nb);
+
+	if (clk_wzrd->suspended)
+		return NOTIFY_OK;
+
+	if (ndata->clk == clk_wzrd->clk_in1)
+		max = clk_wzrd_max_freq[clk_wzrd->speed_grade - 1];
+	else if (ndata->clk == clk_wzrd->axi_clk)
+		max = WZRD_ACLK_MAX_FREQ;
+	else
+		return NOTIFY_DONE;	/* should never happen */
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		if (ndata->new_rate > max)
+			return NOTIFY_BAD;
+		return NOTIFY_OK;
+	case POST_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int __maybe_unused clk_wzrd_suspend(struct device *dev)
+{
+	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(clk_wzrd->axi_clk);
+	clk_wzrd->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused clk_wzrd_resume(struct device *dev)
+{
+	int ret;
+	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
+
+	ret = clk_prepare_enable(clk_wzrd->axi_clk);
+	if (ret) {
+		dev_err(dev, "unable to enable s_axi_aclk\n");
+		return ret;
+	}
+
+	clk_wzrd->suspended = false;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
+			 clk_wzrd_resume);
+
+static int clk_wzrd_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	u32 reg;
+	unsigned long rate;
+	const char *clk_name;
+	struct clk_wzrd *clk_wzrd;
+	struct resource *mem;
+	struct device_node *np = pdev->dev.of_node;
+
+	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
+	if (!clk_wzrd)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, clk_wzrd);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clk_wzrd->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(clk_wzrd->base))
+		return PTR_ERR(clk_wzrd->base);
+
+	ret = of_property_read_u32(np, "speed-grade", &clk_wzrd->speed_grade);
+	if (!ret) {
+		if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
+			dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
+				 clk_wzrd->speed_grade);
+			clk_wzrd->speed_grade = 0;
+		}
+	}
+
+	clk_wzrd->clk_in1 = devm_clk_get(&pdev->dev, "clk_in1");
+	if (IS_ERR(clk_wzrd->clk_in1)) {
+		if (clk_wzrd->clk_in1 != ERR_PTR(-EPROBE_DEFER))
+			dev_err(&pdev->dev, "clk_in1 not found\n");
+		return PTR_ERR(clk_wzrd->clk_in1);
+	}
+
+	clk_wzrd->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(clk_wzrd->axi_clk)) {
+		if (clk_wzrd->axi_clk != ERR_PTR(-EPROBE_DEFER))
+			dev_err(&pdev->dev, "s_axi_aclk not found\n");
+		return PTR_ERR(clk_wzrd->axi_clk);
+	}
+	ret = clk_prepare_enable(clk_wzrd->axi_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
+		return ret;
+	}
+	rate = clk_get_rate(clk_wzrd->axi_clk);
+	if (rate > WZRD_ACLK_MAX_FREQ) {
+		dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n",
+			rate);
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
+	/* we don't support fractional div/mul yet */
+	reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
+		    WZRD_CLKFBOUT_FRAC_EN;
+	reg |= readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2)) &
+		     WZRD_CLKOUT0_FRAC_EN;
+	if (reg)
+		dev_warn(&pdev->dev, "fractional div/mul not supported\n");
+
+	/* register multiplier */
+	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
+		     WZRD_CLKFBOUT_MULT_MASK) >> WZRD_CLKFBOUT_MULT_SHIFT;
+	clk_name = kasprintf(GFP_KERNEL, "%s_mul", dev_name(&pdev->dev));
+	if (!clk_name) {
+		ret = -ENOMEM;
+		goto err_disable_clk;
+	}
+	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
+			(&pdev->dev, clk_name,
+			 __clk_get_name(clk_wzrd->clk_in1),
+			 0, reg, 1);
+	kfree(clk_name);
+	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
+		dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
+		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
+		goto err_disable_clk;
+	}
+
+	/* register div */
+	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
+			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
+	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
+	if (!clk_name) {
+		ret = -ENOMEM;
+		goto err_rm_int_clk;
+	}
+
+	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
+			(&pdev->dev, clk_name,
+			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
+			 0, 1, reg);
+	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
+		dev_err(&pdev->dev, "unable to register divider clock\n");
+		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
+		goto err_rm_int_clk;
+	}
+
+	/* register div per output */
+	for (i = WZRD_NUM_OUTPUTS - 1; i >= 0 ; i--) {
+		const char *clkout_name;
+
+		if (of_property_read_string_index(np, "clock-output-names", i,
+						  &clkout_name)) {
+			dev_err(&pdev->dev,
+				"clock output name not specified\n");
+			ret = -EINVAL;
+			goto err_rm_int_clks;
+		}
+		reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * 12);
+		reg &= WZRD_CLKOUT_DIVIDE_MASK;
+		reg >>= WZRD_CLKOUT_DIVIDE_SHIFT;
+		clk_wzrd->clkout[i] = clk_register_fixed_factor
+			(&pdev->dev, clkout_name, clk_name, 0, 1, reg);
+		if (IS_ERR(clk_wzrd->clkout[i])) {
+			int j;
+
+			for (j = i + 1; j < WZRD_NUM_OUTPUTS; j++)
+				clk_unregister(clk_wzrd->clkout[j]);
+			dev_err(&pdev->dev,
+				"unable to register divider clock\n");
+			ret = PTR_ERR(clk_wzrd->clkout[i]);
+			goto err_rm_int_clks;
+		}
+	}
+
+	kfree(clk_name);
+
+	clk_wzrd->clk_data.clks = clk_wzrd->clkout;
+	clk_wzrd->clk_data.clk_num = ARRAY_SIZE(clk_wzrd->clkout);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_wzrd->clk_data);
+
+	if (clk_wzrd->speed_grade) {
+		clk_wzrd->nb.notifier_call = clk_wzrd_clk_notifier;
+
+		ret = clk_notifier_register(clk_wzrd->clk_in1,
+					    &clk_wzrd->nb);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "unable to register clock notifier\n");
+
+		ret = clk_notifier_register(clk_wzrd->axi_clk, &clk_wzrd->nb);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "unable to register clock notifier\n");
+	}
+
+	return 0;
+
+err_rm_int_clks:
+	clk_unregister(clk_wzrd->clks_internal[1]);
+err_rm_int_clk:
+	kfree(clk_name);
+	clk_unregister(clk_wzrd->clks_internal[0]);
+err_disable_clk:
+	clk_disable_unprepare(clk_wzrd->axi_clk);
+
+	return ret;
+}
+
+static int clk_wzrd_remove(struct platform_device *pdev)
+{
+	int i;
+	struct clk_wzrd *clk_wzrd = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	for (i = 0; i < WZRD_NUM_OUTPUTS; i++)
+		clk_unregister(clk_wzrd->clkout[i]);
+	for (i = 0; i < wzrd_clk_int_max; i++)
+		clk_unregister(clk_wzrd->clks_internal[i]);
+
+	if (clk_wzrd->speed_grade) {
+		clk_notifier_unregister(clk_wzrd->axi_clk, &clk_wzrd->nb);
+		clk_notifier_unregister(clk_wzrd->clk_in1, &clk_wzrd->nb);
+	}
+
+	clk_disable_unprepare(clk_wzrd->axi_clk);
+
+	return 0;
+}
+
+static const struct of_device_id clk_wzrd_ids[] = {
+	{ .compatible = "xlnx,clocking-wizard" },
+	{ .compatible = "xlnx,clocking-wizard-6.0" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
+
+static struct platform_driver clk_wzrd_driver = {
+	.driver = {
+		.name = "clk-wizard",
+		.of_match_table = clk_wzrd_ids,
+		.pm = &clk_wzrd_dev_pm_ops,
+	},
+	.probe = clk_wzrd_probe,
+	.remove = clk_wzrd_remove,
+};
+module_platform_driver(clk_wzrd_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com");
+MODULE_DESCRIPTION("Driver for the Xilinx Clocking Wizard IP core");
-- 
2.1.1

