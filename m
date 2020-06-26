Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D02C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D768206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SRbN9nnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgFZSsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:48:11 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:8848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFZSsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5c6b3KhmYpywzcSMrIEcr01IfFcXkgAZXQA7MiSRK1/IwWbbw31nExrxoZi3/8Iw+xH+O0U8WJHjOP2XmeMNlrJRFX3DqaPSYA9NesxiM2mcMc6BQsk4uzrj8W+ffi04ud08G+dqK/HXHviAftC5VMcce0rYznwjd9rdS4cgOzOEf22gHCZYzBsqx29U332QeIxxpJUZzDcffL5iOeF0VcALL2P8pI6HW6al56Jle6HBjyO1lK9BivzSXzDUrhcfVjVRrGi+y1Oc7vmyp2zJH1g+MGG3FiVCWQpl30xyz4d9Nu26lo3PGbpyj3VnqJKKocg+XFgCanEifdVtzp1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC08RN5nDuoWiwVeFVSkJubrz0zR47lI1HLnx/7wo9k=;
 b=Qjf6YmT/pqetiv3zbqw9tYVVG2WhSXPWTrvbMPLhJR9mu2JPiY2IMI52pBbsPZfpUgXjGnPOntbvGVcbtI9rNgp9cTIi1NvqjiJy1i/su0oBKmCThtrnWv2Aqdq97o80ypN/8fRHLAGNh2h8+ZBUr2xjyQsiHNup/eJ4Q2lyrU9e++189KDrm6+AKLs1/8QsnscBsjO+vFyHwt6/a4Y10Dw/8ISnVrI+9SI8wbBJt7ffJn7UfgGg2NClZ1j4U8yZe97CJvqA5gchjP16IX0WpfNZNc4nLrQlEMapCzf4XFKUgVXMAVRayPfUW7YiH6cFaeInRpeuG64hPE2FT7FXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC08RN5nDuoWiwVeFVSkJubrz0zR47lI1HLnx/7wo9k=;
 b=SRbN9nnbcL9xgax2HwALxOJTDV0xnpfSnQd3OXs4ud4WrrKJDidJCI/WwS5N6aaKQHEk9Q9fkWKV/Q8bM1JGYizS2CC5PKk94PjttIA5AkX8bzeK3nGe4HOqf2NY8YW1tAUv62kVwRMBmTtB0KLztPi3Xtm0wCSBf21PlE22aC4=
Received: from SN4PR0501CA0139.namprd05.prod.outlook.com
 (2603:10b6:803:2c::17) by SN6PR02MB4527.namprd02.prod.outlook.com
 (2603:10b6:805:a5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 18:46:32 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::35) by SN4PR0501CA0139.outlook.office365.com
 (2603:10b6:803:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.12 via Frontend
 Transport; Fri, 26 Jun 2020 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 18:46:31
 +0000
Received: from [149.199.38.66] (port=35642 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotLe-0006Eb-8q; Fri, 26 Jun 2020 11:45:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMt-0000uL-87; Fri, 26 Jun 2020 11:46:31 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QIkPkI018073;
        Fri, 26 Jun 2020 11:46:26 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMn-0000q1-Kq; Fri, 26 Jun 2020 11:46:25 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v5 5/8] clk: clock-wizard: Add support for fractional support
Date:   Sat, 27 Jun 2020 00:16:08 +0530
Message-Id: <1593197171-21747-4-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(136003)(396003)(46966005)(316002)(426003)(83380400001)(82310400002)(81166007)(107886003)(2906002)(8936002)(5660300002)(7696005)(356005)(70586007)(2616005)(186003)(70206006)(9786002)(36756003)(6916009)(6666004)(47076004)(82740400003)(336012)(26005)(4326008)(44832011)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34f7b3fb-c966-4728-b5f1-08d81a013e53
X-MS-TrafficTypeDiagnostic: SN6PR02MB4527:
X-Microsoft-Antispam-PRVS: <SN6PR02MB45272E742DC2E2EF014A9285AA930@SN6PR02MB4527.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gpiW+09p4Typ/OhaHmdWtpxaMJtN4rUAE92FREnf007C+qdVweTkFXG6MGIa5O5xknbO6RKIWyLH5kky2qWtvB1LR7wYXPJjmbFoAV8Jgtnl0ViHy+MLxjzRnIvJmNwgENgPH+I87SakIrNJxX09rtpUhHRwiJxozfTDF+qUgBAhESWhkQ18+w6cjaKpDSJaBcTvhvr83q+iFI7QGTGlC4hZDshomW3pU3UfZE5A4oYnxSFm0rVmdEEstiBTPlLXkS8/7SVQQKuRQxYvydP/uH6Ue3E0oYvFW219gRO4bD1uAD3zJjwEhS578LDkK0jOe6Rc1Sx6O9Ops+twye8ATBNlvDcuEL+OHSdxuWoCpDf9cmlGNJfibSw2tOp9dAdMg0isbvHHcHxlf44T+P7Pw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:46:31.5788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f7b3fb-c966-4728-b5f1-08d81a013e53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the set rate granularity is to integral divisors.
Add support for the fractional divisors.
Only the first output0 is fractional in the hardware.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 190 +++++++++++++++++++++++++++++++++---
 1 file changed, 178 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index aaffb04..1cf381c 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -28,11 +28,15 @@
 
 #define WZRD_CLKFBOUT_MULT_SHIFT	8
 #define WZRD_CLKFBOUT_MULT_MASK		(0xff << WZRD_CLKFBOUT_MULT_SHIFT)
+#define WZRD_CLKFBOUT_FRAC_SHIFT	16
+#define WZRD_CLKFBOUT_FRAC_MASK		(0x3ff << WZRD_CLKFBOUT_FRAC_SHIFT)
 #define WZRD_DIVCLK_DIVIDE_SHIFT	0
 #define WZRD_DIVCLK_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
 #define WZRD_CLKOUT_DIVIDE_SHIFT	0
 #define WZRD_CLKOUT_DIVIDE_WIDTH	8
 #define WZRD_CLKOUT_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
+#define WZRD_CLKOUT_FRAC_SHIFT		8
+#define WZRD_CLKOUT_FRAC_MASK		0x3ff
 
 #define WZRD_DR_MAX_INT_DIV_VALUE	255
 #define WZRD_DR_NUM_RETRIES		10000
@@ -51,6 +55,7 @@
 enum clk_wzrd_int_clks {
 	wzrd_clk_mul,
 	wzrd_clk_mul_div,
+	wzrd_clk_mul_frac,
 	wzrd_clk_int_max
 };
 
@@ -212,6 +217,161 @@ static const struct clk_ops clk_wzrd_clk_divider_ops = {
 	.recalc_rate = clk_wzrd_recalc_rate,
 };
 
+static unsigned long clk_wzrd_recalc_ratef(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	unsigned int val;
+	u32 div, frac;
+	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
+	void __iomem *div_addr =
+			(void __iomem *)((u64)divider->base + divider->offset);
+
+	val = readl(div_addr);
+	div = val & div_mask(divider->width);
+	frac = (val >> WZRD_CLKOUT_FRAC_SHIFT) & WZRD_CLKOUT_FRAC_MASK;
+
+	return ((parent_rate * 1000) / ((div * 1000) + frac));
+}
+
+static int clk_wzrd_dynamic_reconfig_f(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	int err = 0;
+	u16 retries;
+	u32 value, pre;
+	unsigned long flags = 0;
+	unsigned long rate_div, f, clockout0_div;
+	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
+	void __iomem *div_addr =
+			(void __iomem *)((u64)divider->base + divider->offset);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	rate_div = ((parent_rate * 1000) / rate);
+	clockout0_div = rate_div / 1000;
+
+	pre = DIV_ROUND_CLOSEST((parent_rate * 1000), rate);
+	f = (u32)(pre - (clockout0_div * 1000));
+	f = f & WZRD_CLKOUT_FRAC_MASK;
+
+	value = ((f << WZRD_CLKOUT_DIVIDE_WIDTH) | (clockout0_div &
+			WZRD_CLKOUT_DIVIDE_MASK));
+
+	/* Set divisor and clear phase offset */
+	writel(value, div_addr);
+	writel(0x0, div_addr + WZRD_DR_DIV_TO_PHASE_OFFSET);
+
+	/* Check status register */
+	retries = WZRD_DR_NUM_RETRIES;
+	while (retries--) {
+		if (readl(divider->base + WZRD_DR_STATUS_REG_OFFSET) &
+							WZRD_DR_LOCK_BIT_MASK)
+			break;
+	}
+
+	if (!retries) {
+		err = -ETIMEDOUT;
+		goto err_reconfig;
+	}
+
+	/* Initiate reconfiguration */
+	writel(WZRD_DR_BEGIN_DYNA_RECONF,
+	       divider->base + WZRD_DR_INIT_REG_OFFSET);
+
+	/* Check status register */
+	retries = WZRD_DR_NUM_RETRIES;
+	while (retries--) {
+		if (readl(divider->base + WZRD_DR_STATUS_REG_OFFSET) &
+							WZRD_DR_LOCK_BIT_MASK)
+			break;
+	}
+
+	if (!retries)
+		err = -ETIMEDOUT;
+
+err_reconfig:
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return err;
+}
+
+static long clk_wzrd_round_rate_f(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	return rate;
+}
+
+static const struct clk_ops clk_wzrd_clk_divider_ops_f = {
+	.round_rate = clk_wzrd_round_rate_f,
+	.set_rate = clk_wzrd_dynamic_reconfig_f,
+	.recalc_rate = clk_wzrd_recalc_ratef,
+};
+
+static struct clk *clk_wzrd_register_divf(struct device *dev,
+					  const char *name,
+					  const char *parent_name,
+					  unsigned long flags,
+					  void __iomem *base, u16 offset,
+					  u8 shift, u8 width,
+					  u8 clk_divider_flags,
+					  const struct clk_div_table *table,
+					  spinlock_t *lock)
+{
+	struct clk_wzrd_divider *div;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
+		if (width + shift > 16) {
+			pr_warn("divider value exceeds LOWORD field\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_ro_ops;
+	else
+		init.ops = &clk_wzrd_clk_divider_ops_f;
+
+	init.flags = flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	div->base = base;
+	div->offset = offset;
+	div->shift = shift;
+	div->width = width;
+	div->flags = clk_divider_flags;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(div);
+		return ERR_PTR(ret);
+	}
+
+	return hw->clk;
+}
+
 static struct clk *clk_wzrd_register_divider(struct device *dev,
 					     const char *name,
 					     const char *parent_name,
@@ -330,7 +490,7 @@ static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
 static int clk_wzrd_probe(struct platform_device *pdev)
 {
 	int i, ret;
-	u32 reg;
+	u32 reg, reg_f, mult;
 	unsigned long rate;
 	const char *clk_name;
 	struct clk_wzrd *clk_wzrd;
@@ -382,17 +542,13 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	/* we don't support fractional div/mul yet */
-	reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-		    WZRD_CLKFBOUT_FRAC_EN;
-	reg |= readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2)) &
-		     WZRD_CLKOUT0_FRAC_EN;
-	if (reg)
-		dev_warn(&pdev->dev, "fractional div/mul not supported\n");
-
 	/* register multiplier */
 	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
 		     WZRD_CLKFBOUT_MULT_MASK) >> WZRD_CLKFBOUT_MULT_SHIFT;
+	reg_f = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
+		     WZRD_CLKFBOUT_FRAC_MASK) >> WZRD_CLKFBOUT_FRAC_SHIFT;
+
+	mult = ((reg * 1000) + reg_f);
 	clk_name = kasprintf(GFP_KERNEL, "%s_mul", dev_name(&pdev->dev));
 	if (!clk_name) {
 		ret = -ENOMEM;
@@ -401,7 +557,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
 			(&pdev->dev, clk_name,
 			 __clk_get_name(clk_wzrd->clk_in1),
-			 0, reg, 1);
+			0, mult, 1000);
 	kfree(clk_name);
 	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
 		dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
@@ -440,8 +596,18 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_rm_int_clks;
 		}
-		clk_wzrd->clkout[i] = clk_wzrd_register_divider(&pdev->dev,
-								clkout_name,
+		if (!i)
+			clk_wzrd->clkout[i] = clk_wzrd_register_divf
+				(&pdev->dev, clkout_name,
+				clk_name, 0,
+				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
+				WZRD_CLKOUT_DIVIDE_SHIFT,
+				WZRD_CLKOUT_DIVIDE_WIDTH,
+				CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
+				NULL, &clkwzrd_lock);
+		else
+			clk_wzrd->clkout[i] = clk_wzrd_register_divider
+				(&pdev->dev, clkout_name,
 				clk_name, 0,
 				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
 				WZRD_CLKOUT_DIVIDE_SHIFT,
-- 
2.1.1

