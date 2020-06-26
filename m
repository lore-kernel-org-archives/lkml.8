Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9561B207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pTjd9caU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgFZMmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:35 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:13452
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728576AbgFZMmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUqLE4CkE3RhCfz46X5jFeIP8k340yRC0y4R0Iv/1/PERoi8+eDw/i2NIHnK/yWYi4HDQhwgt10mZVga+JSj529xS6pxSI+aDk2pZHYopZJHr3bGYBjUU2ylXA0y+1WkZ/BM0Zc/fUyExHzMgV+4AWi+Wf0pml+h3w9u+SjrnUCrVfCbE1VLmKsJUWc2ph48ZEwulRI5Vx4BoBnJNykZWPzi/xfri3GSLtojDxtyH/Fm2Fir/68y0n9fa4GDLqVaxifGcsnMt51g2q2M023EUUZWX015qZjlfAu2PU7ZQIMy5lAl8LV/jpTbNYcWBwmgkIAOSiqQWaoHxyTVIE9drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UolGFI8IXw2m2imelmgb/VriH+a4TKk96ZgqCicx94s=;
 b=OIbDB1WhnWhMcz2EsNkQuKTyfk0rU4GM9Aa305gTsrLS8ZDLB6Qmur00jhZ4qEJJssEdu0v9zUiSXm3VhsUo+/wlELoPGKQ11nG/4WsFvGVFf/1LrBeWjFlOZj4nPW0dwQMyyr4/OpWBpvROxFA6//pqTLEJWh/h69vDjcn0zIHqwBBv5sFjQuIKXIxWVBtBUiJMLZ5TNvGZ3MuWIpHxQonJXJefUEog5+KdCms+4InkTDD5OiT0yHjMCZ7ahcTy9Bc7eJETp2n0QnhcKoZT0cEj26XHJOWoyByP8O0XrqyWHA+FABbEArep7zRz35jx/Ia7jzGh4t9ZVuUjerKxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UolGFI8IXw2m2imelmgb/VriH+a4TKk96ZgqCicx94s=;
 b=pTjd9caUE/9hLjqj0uZyxX67qDJqGo7I0I+skh8EF84UvwQF7Bu+2ENk1SArCviQ8ZVQ+j1+xO8zvdB270DMQKnvFU0/Z+IMpZ5/hNG9ppxbx74i+7/vci4CzoYHwVLLUXGhmGOFgNy8nyZhyyGJcB0iJ/WITwCM9mXrrLElOEs=
Received: from DM5PR19CA0004.namprd19.prod.outlook.com (2603:10b6:3:151::14)
 by MN2PR02MB6606.namprd02.prod.outlook.com (2603:10b6:208:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:42:15 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::fa) by DM5PR19CA0004.outlook.office365.com
 (2603:10b6:3:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 12:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:42:15
 +0000
Received: from [149.199.38.66] (port=38874 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonf8-0003KD-5C; Fri, 26 Jun 2020 05:40:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongM-0001e6-PO; Fri, 26 Jun 2020 05:42:14 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCg1HV029241;
        Fri, 26 Jun 2020 05:42:01 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jong9-0001Wm-5t; Fri, 26 Jun 2020 05:42:01 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Chirag Parekh <chirag.parekh@xilinx.com>
Subject: [PATCH v4 4/8] clk: clock-wizard: Add support for dynamic reconfiguration
Date:   Fri, 26 Jun 2020 18:11:40 +0530
Message-Id: <1593175304-4876-5-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(376002)(346002)(46966005)(82740400003)(478600001)(7696005)(4326008)(47076004)(6666004)(2906002)(70586007)(70206006)(316002)(6916009)(81166007)(336012)(54906003)(5660300002)(2616005)(426003)(36756003)(82310400002)(8676002)(356005)(8936002)(83380400001)(26005)(44832011)(107886003)(9786002)(186003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a261d12-5db9-4b59-4c29-08d819ce5ad0
X-MS-TrafficTypeDiagnostic: MN2PR02MB6606:
X-Microsoft-Antispam-PRVS: <MN2PR02MB66061B89D6EC4E1FE5D81068AA930@MN2PR02MB6606.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0KG6iDgW12FyaSEHQRF7RCmIDVoxxVz8C0oQNycmZJwEVBmyo1uqQN8W9VMED7ZtfiFjvHIcnrZKLSjzz5CATMoV6Bsp1WGj1t19O+bgDrvON//uzze2trQADi9rqUn2FSJ8OgHGMFbchoUauHHUfKbFKDpR0AzQHozwC8w+WeA++u+RSeo8evUK1NdUCMdv8DMbNvlk1Vn5CzdivG/0ypFvmodNzP5Db45dRVcjaF+4qyF108JtGMSJUJrqxuHp9+NH6rZaiwXSdLE6pMjQFXX3kdqTZrUkVBoTA8GU4qKZ13WTbMJlXFaSzX81aq7V/CKqO+oqpx/+VhFzIcXsMzKpkPwuPUpjgIpobxh2zDzKDd0SYn8rLevsTwlhpPfcShUEe0oY1CoQRWESNYNQA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:42:15.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a261d12-5db9-4b59-4c29-08d819ce5ad0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds support for dynamic reconfiguration of clock output rate.
Output clocks are registered as dividers and set rate callback function
is used for dynamic reconfiguration.

Based on the initial work from Chirag.

Signed-off-by: Chirag Parekh <chirag.parekh@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---

 drivers/clk/clk-xlnx-clock-wizard.c | 212 +++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index d6577c8..4b563f3 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -31,8 +31,23 @@
 #define WZRD_DIVCLK_DIVIDE_SHIFT	0
 #define WZRD_DIVCLK_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
 #define WZRD_CLKOUT_DIVIDE_SHIFT	0
+#define WZRD_CLKOUT_DIVIDE_WIDTH	8
 #define WZRD_CLKOUT_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
 
+#define WZRD_DR_MAX_INT_DIV_VALUE	255
+#define WZRD_DR_NUM_RETRIES		10000
+#define WZRD_DR_STATUS_REG_OFFSET	0x04
+#define WZRD_DR_LOCK_BIT_MASK		0x00000001
+#define WZRD_DR_INIT_REG_OFFSET		0x25C
+#define WZRD_DR_DIV_TO_PHASE_OFFSET	4
+#define WZRD_DR_BEGIN_DYNA_RECONF	0x03
+
+/* Get the mask from width */
+#define div_mask(width)			((1 << (width)) - 1)
+
+/* Extract divider instance from clock hardware instance */
+#define to_clk_wzrd_divider(_hw) container_of(_hw, struct clk_wzrd_divider, hw)
+
 enum clk_wzrd_int_clks {
 	wzrd_clk_mul,
 	wzrd_clk_mul_div,
@@ -64,6 +79,29 @@ struct clk_wzrd {
 	bool suspended;
 };
 
+/**
+ * struct clk_wzrd_divider - clock divider specific to clk_wzrd
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @base:	base address of register containing the divider
+ * @offset:	offset address of register containing the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @flags:	clk_wzrd divider flags
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ * @lock:	register lock
+ */
+struct clk_wzrd_divider {
+	struct clk_hw hw;
+	void __iomem *base;
+	u16 offset;
+	u8 shift;
+	u8 width;
+	u8 flags;
+	const struct clk_div_table *table;
+	spinlock_t *lock;  /* divider lock */
+};
+
 #define to_clk_wzrd(_nb) container_of(_nb, struct clk_wzrd, nb)
 
 /* maximum frequencies for input/output clocks per speed grade */
@@ -73,6 +111,164 @@ static const unsigned long clk_wzrd_max_freq[] = {
 	1066000000UL
 };
 
+/* spin lock variable for clk_wzrd */
+static DEFINE_SPINLOCK(clkwzrd_lock);
+
+static unsigned long clk_wzrd_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
+	void __iomem *div_addr =
+			(void __iomem *)((u64)divider->base + divider->offset);
+	unsigned int val;
+
+	val = readl(div_addr) >> divider->shift;
+	val &= div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+			divider->flags);
+}
+
+static int clk_wzrd_dynamic_reconfig(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	int err = 0;
+	u16 retries;
+	u32 value;
+	unsigned long flags = 0;
+	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
+	void __iomem *div_addr =
+			(void __iomem *)((u64)divider->base + divider->offset);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	value = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	/* Cap the value to max */
+	if (value > WZRD_DR_MAX_INT_DIV_VALUE)
+		value = WZRD_DR_MAX_INT_DIV_VALUE;
+
+	/* Set divisor and clear phase offset */
+	writel(value, div_addr);
+	writel(0x00, div_addr + WZRD_DR_DIV_TO_PHASE_OFFSET);
+
+	/* Check status register */
+	retries = WZRD_DR_NUM_RETRIES;
+	while (retries--) {
+		if (readl(divider->base + WZRD_DR_STATUS_REG_OFFSET) &
+							WZRD_DR_LOCK_BIT_MASK)
+			break;
+	}
+
+	if (retries == 0) {
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
+	if (retries == 0)
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
+static long clk_wzrd_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	u8 div;
+
+	/*
+	 * since we donot change parent rate we just round rate to closest
+	 * achievable
+	 */
+	div = DIV_ROUND_CLOSEST(*prate, rate);
+
+	return (*prate / div);
+}
+
+static const struct clk_ops clk_wzrd_clk_divider_ops = {
+	.round_rate = clk_wzrd_round_rate,
+	.set_rate = clk_wzrd_dynamic_reconfig,
+	.recalc_rate = clk_wzrd_recalc_rate,
+};
+
+static struct clk *clk_wzrd_register_divider(struct device *dev,
+					     const char *name,
+					     const char *parent_name,
+					     unsigned long flags,
+					     void __iomem *base, u16 offset,
+					     u8 shift, u8 width,
+					     u8 clk_divider_flags,
+					     const struct clk_div_table *table,
+					     spinlock_t *lock)
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
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_ro_ops;
+	else
+		init.ops = &clk_wzrd_clk_divider_ops;
+	init.flags = flags | CLK_IS_BASIC;
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
+		hw = ERR_PTR(ret);
+	}
+
+	return hw->clk;
+}
+
 static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned long event,
 				 void *data)
 {
@@ -225,7 +421,8 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
 			(&pdev->dev, clk_name,
 			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
-			 0, 1, reg);
+			flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
+			CLK_DIVIDER_ALLOW_ZERO, &clkwzrd_lock);
 	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
 		dev_err(&pdev->dev, "unable to register divider clock\n");
 		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
@@ -243,11 +440,14 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_rm_int_clks;
 		}
-		reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * 12);
-		reg &= WZRD_CLKOUT_DIVIDE_MASK;
-		reg >>= WZRD_CLKOUT_DIVIDE_SHIFT;
-		clk_wzrd->clkout[i] = clk_register_fixed_factor
-			(&pdev->dev, clkout_name, clk_name, 0, 1, reg);
+		clk_wzrd->clkout[i] = clk_wzrd_register_divider(&pdev->dev,
+								clkout_name,
+				clk_name, 0,
+				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
+				WZRD_CLKOUT_DIVIDE_SHIFT,
+				WZRD_CLKOUT_DIVIDE_WIDTH,
+				CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
+				NULL, &clkwzrd_lock);
 		if (IS_ERR(clk_wzrd->clkout[i])) {
 			int j;
 
-- 
2.1.1

