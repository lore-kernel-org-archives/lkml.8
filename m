Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A449C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0728D207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m3OtPaRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgANHZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:25:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13875 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgANHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6ca10000>; Mon, 13 Jan 2020 23:24:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jan 2020 23:24:36 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:36 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cb30002>; Mon, 13 Jan 2020 23:24:36 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 10/22] soc: tegra: Add support for 32KHz blink clock
Date:   Mon, 13 Jan 2020 23:24:15 -0800
Message-ID: <1578986667-16041-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986657; bh=qb0EQlXbhqaP7vKMqOYVqq988LszIQrC0y8FnuauSF8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=m3OtPaRsZLTc0u/KTEGa1B7qmyrt51PlNjD/+jNjqRohx07xkTQWpoirJtTSDIlnA
         81YoQ8MVcan/bBuDG/47mlLpAULix85KmKfzwJBV3/AmbD6jxkcJwiCpqSi8kE+KzC
         udd/FNN4egLEACtAfImZEQHh08nJ+1zrVdnJi9AytHvTcs+WMqcuZtfJEViis7ucer
         dU61P7SqeB2mbGAsOeHjWFRROCw37RZncdJCiRPAjsrC7dwiaL5vlhqtUQYRKdMbHu
         byV7rATMlmylofB4gnBkNsCBpQ8QH5rtj6M22jrFC+KfpVThWsZP3gb9rAUa5lr2F4
         wbclfT/1xRCAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has blink control to output 32 Khz clock out to Tegra
blink pin. Blink pad DPD state and enable controls are part of
Tegra PMC register space.

Currently Tegra clock driver registers blink control by passing
PMC address and register offset to clk_register_gate which performs
direct PMC access during clk_ops and with this when PMC is in secure
mode, any access from non-secure world does not go through.

This patch adds blink control registration to the Tegra PMC driver
using PMC specific clock gate operations that use tegra_pmc_readl
and tegra_pmc_writel to support both secure mode and non-secure
mode PMC register access.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ecce91517af2..f65aea61149d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -62,12 +62,15 @@
 #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
 #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
+#define  PMC_CNTRL_BLINK_EN		7
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 
 #define PMC_WAKE_MASK			0x0c
 #define PMC_WAKE_LEVEL			0x10
 #define PMC_WAKE_STATUS			0x14
 #define PMC_SW_WAKE_STATUS		0x18
+#define PMC_DPD_PADS_ORIDE		0x1c
+#define  PMC_DPD_PADS_ORIDE_BLINK	20
 
 #define DPD_SAMPLE			0x020
 #define  DPD_SAMPLE_ENABLE		BIT(0)
@@ -80,6 +83,7 @@
 
 #define PWRGATE_STATUS			0x38
 
+#define PMC_BLINK_TIMER			0x40
 #define PMC_IMPL_E_33V_PWR		0x40
 
 #define PMC_PWR_DET			0x48
@@ -171,6 +175,14 @@ struct pmc_clk {
 
 #define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
 
+struct pmc_clk_gate {
+	struct clk_hw	hw;
+	unsigned long	offs;
+	u32		shift;
+};
+
+#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
+
 struct pmc_clk_init_data {
 	char *name;
 	const char *const *parents;
@@ -321,6 +333,7 @@ struct tegra_pmc_soc {
 
 	const struct pmc_clk_init_data *pmc_clks_data;
 	unsigned int num_pmc_clks;
+	bool has_blink_output;
 };
 
 static const char * const tegra186_reset_sources[] = {
@@ -2334,6 +2347,60 @@ tegra_pmc_clk_out_register(struct tegra_pmc *pmc,
 	return clk_register(NULL, &pmc_clk->hw);
 }
 
+static int pmc_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
+}
+
+static int pmc_clk_gate_enable(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	pmc_clk_set_state(gate->offs, gate->shift, 1);
+
+	return 0;
+}
+
+static void pmc_clk_gate_disable(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	pmc_clk_set_state(gate->offs, gate->shift, 0);
+}
+
+static const struct clk_ops pmc_clk_gate_ops = {
+	.is_enabled = pmc_clk_gate_is_enabled,
+	.enable = pmc_clk_gate_enable,
+	.disable = pmc_clk_gate_disable,
+};
+
+static struct clk *
+tegra_pmc_clk_gate_register(struct tegra_pmc *pmc, const char *name,
+			    const char *parent_name, unsigned long offset,
+			    u32 shift)
+{
+	struct clk_init_data init;
+	struct pmc_clk_gate *gate;
+
+	gate = devm_kzalloc(pmc->dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &pmc_clk_gate_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = 0;
+
+	gate->hw.init = &init;
+	gate->offs = offset;
+	gate->shift = shift;
+
+	return clk_register(NULL, &gate->hw);
+}
+
 static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 				     struct device_node *np)
 {
@@ -2343,6 +2410,8 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 	int i, err;
 
 	num_clks = pmc->soc->num_pmc_clks;
+	if (pmc->soc->has_blink_output)
+		num_clks += 1;
 
 	if (!num_clks)
 		return;
@@ -2384,6 +2453,42 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 		clk_data->clks[data->clk_id] = clk;
 	}
 
+	if (pmc->soc->has_blink_output) {
+		tegra_pmc_writel(pmc, 0x0, PMC_BLINK_TIMER);
+		clk = tegra_pmc_clk_gate_register(pmc,
+						  "pmc_blink_override",
+						  "clk_32k",
+						  PMC_DPD_PADS_ORIDE,
+						  PMC_DPD_PADS_ORIDE_BLINK);
+		if (IS_ERR(clk)) {
+			dev_warn(pmc->dev,
+				 "unable to register pmc_blink_override: %d\n",
+				 PTR_ERR_OR_ZERO(clk));
+			return;
+		}
+
+		clk = tegra_pmc_clk_gate_register(pmc, "pmc_blink",
+						  "pmc_blink_override",
+						  PMC_CNTRL,
+						  PMC_CNTRL_BLINK_EN);
+		if (IS_ERR(clk)) {
+			dev_warn(pmc->dev,
+				 "unable to register pmc_blink: %d\n",
+				 PTR_ERR_OR_ZERO(clk));
+			return;
+		}
+
+		err = clk_register_clkdev(clk, "pmc_blink", NULL);
+		if (err) {
+			dev_warn(pmc->dev,
+				 "unable to register pmc_blink lookup: %d\n",
+				 err);
+			return;
+		}
+
+		clk_data->clks[TEGRA_PMC_CLK_BLINK] = clk;
+	}
+
 	err = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 	if (err)
 		dev_warn(pmc->dev, "failed to add pmc clock provider: %d\n",
@@ -2652,6 +2757,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -2701,6 +2807,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -2754,6 +2861,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -2867,6 +2975,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -2983,6 +3092,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.wake_events = tegra210_wake_events,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)					     \
@@ -3114,6 +3224,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.wake_events = tegra186_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -3233,6 +3344,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.wake_events = tegra194_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.7.4

