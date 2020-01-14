Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53590C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D362187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cRoxA+93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgANHYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:24:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6422 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgANHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6c9b0000>; Mon, 13 Jan 2020 23:24:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 23:24:31 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cad0005>; Mon, 13 Jan 2020 23:24:30 -0800
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
Subject: [PATCH v8 03/22] clk: tegra: Add Tegra OSC to clock lookup
Date:   Mon, 13 Jan 2020 23:24:08 -0800
Message-ID: <1578986667-16041-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986651; bh=eB+yZHKI/MG+YeUw9NmM28Dg+VVTcs4fsHCRunBPHZI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cRoxA+93Qmyvofcn9aJAU0e0OOJbEpJLiFDva4Y1BTSnuZ5jjrpW9rYc7IAyGX0VK
         mdwKZ/9ApQKfm4QSWPjIuA9246MY2+mnCFbwIBqL6WnD0nfhxicWWt8cj3m0uSf7Ah
         mCxcKpQ4XoWS2uh4so5Aq5niEP17zvlcNYVbnDqSlZv6jiFSfhBQrqbwu3J/BQO1Av
         LajWKRReFynLhkieZMIm3rgIVm3lzzo+GtihiRmop/FJQA5qPgvt3oZ6VWGUpvbY2Q
         qzupMIIl57kWFqTWT29TyiiZ7l9cAEjIj9Nqu3mvpR+f0zV+ZJxOKFnc6j+yRbTDBJ
         lxgQVBvC/cwUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSC is one of the parent for Tegra PMC clocks clk_out_1, clk_out_2,
and clk_out_3.

This patch adds Tegra OSC to clock lookup.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-id.h          | 1 +
 drivers/clk/tegra/clk-tegra-fixed.c | 5 +++++
 drivers/clk/tegra/clk-tegra114.c    | 2 ++
 drivers/clk/tegra/clk-tegra124.c    | 2 ++
 drivers/clk/tegra/clk-tegra210.c    | 2 ++
 drivers/clk/tegra/clk-tegra30.c     | 2 ++
 6 files changed, 14 insertions(+)

diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
index 17d8b252cd0a..17c13d1aa6bc 100644
--- a/drivers/clk/tegra/clk-id.h
+++ b/drivers/clk/tegra/clk-id.h
@@ -46,6 +46,7 @@ enum clk_id {
 	tegra_clk_clk_m,
 	tegra_clk_clk_m_div2,
 	tegra_clk_clk_m_div4,
+	tegra_clk_osc,
 	tegra_clk_osc_div2,
 	tegra_clk_osc_div4,
 	tegra_clk_clk_out_1,
diff --git a/drivers/clk/tegra/clk-tegra-fixed.c b/drivers/clk/tegra/clk-tegra-fixed.c
index 990106391334..0dc2d5f5cfb5 100644
--- a/drivers/clk/tegra/clk-tegra-fixed.c
+++ b/drivers/clk/tegra/clk-tegra-fixed.c
@@ -46,7 +46,12 @@ int __init tegra_osc_clk_init(void __iomem *clk_base, struct tegra_clk *clks,
 		return -EINVAL;
 	}
 
+	dt_clk = tegra_lookup_dt_id(tegra_clk_osc, clks);
+	if (!dt_clk)
+		return 0;
+
 	osc = clk_register_fixed_rate(NULL, "osc", NULL, 0, *osc_freq);
+	*dt_clk = osc;
 
 	/* osc_div2 */
 	dt_clk = tegra_lookup_dt_id(tegra_clk_osc_div2, clks);
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index d44cb8db0ef6..e3c68eca54b7 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -737,6 +737,7 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_m] = { .dt_id = TEGRA114_CLK_CLK_M, .present = true },
 	[tegra_clk_clk_m_div2] = { .dt_id = TEGRA114_CLK_CLK_M_DIV2, .present = true },
 	[tegra_clk_clk_m_div4] = { .dt_id = TEGRA114_CLK_CLK_M_DIV4, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA114_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA114_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA114_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA114_CLK_PLL_REF, .present = true },
@@ -819,6 +820,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_32k", .dt_id = TEGRA114_CLK_CLK_32K },
 	{ .con_id = "clk_m_div2", .dt_id = TEGRA114_CLK_CLK_M_DIV2 },
 	{ .con_id = "clk_m_div4", .dt_id = TEGRA114_CLK_CLK_M_DIV4 },
+	{ .con_id = "osc", .dt_id = TEGRA114_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA114_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA114_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA114_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 32f3dd1ccbad..ef0f928f0259 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -862,6 +862,7 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_m] = { .dt_id = TEGRA124_CLK_CLK_M, .present = true },
 	[tegra_clk_clk_m_div2] = { .dt_id = TEGRA124_CLK_CLK_M_DIV2, .present = true },
 	[tegra_clk_clk_m_div4] = { .dt_id = TEGRA124_CLK_CLK_M_DIV4, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA124_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA124_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA124_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA124_CLK_PLL_REF, .present = true },
@@ -945,6 +946,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_32k", .dt_id = TEGRA124_CLK_CLK_32K },
 	{ .con_id = "clk_m_div2", .dt_id = TEGRA124_CLK_CLK_M_DIV2 },
 	{ .con_id = "clk_m_div4", .dt_id = TEGRA124_CLK_CLK_M_DIV4 },
+	{ .con_id = "osc", .dt_id = TEGRA124_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA124_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA124_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA124_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 899d8ca68c4f..958f5f6c894d 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -2373,6 +2373,7 @@ static struct tegra_clk tegra210_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_m] = { .dt_id = TEGRA210_CLK_CLK_M, .present = true },
 	[tegra_clk_clk_m_div2] = { .dt_id = TEGRA210_CLK_CLK_M_DIV2, .present = true },
 	[tegra_clk_clk_m_div4] = { .dt_id = TEGRA210_CLK_CLK_M_DIV4, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA210_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA210_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA210_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA210_CLK_PLL_REF, .present = true },
@@ -2501,6 +2502,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_32k", .dt_id = TEGRA210_CLK_CLK_32K },
 	{ .con_id = "clk_m_div2", .dt_id = TEGRA210_CLK_CLK_M_DIV2 },
 	{ .con_id = "clk_m_div4", .dt_id = TEGRA210_CLK_CLK_M_DIV4 },
+	{ .con_id = "osc", .dt_id = TEGRA210_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA210_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA210_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA210_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c2da1f1d2b58..5f3484758123 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -583,6 +583,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_32k", .dt_id = TEGRA30_CLK_CLK_32K },
 	{ .con_id = "clk_m_div2", .dt_id = TEGRA30_CLK_CLK_M_DIV2 },
 	{ .con_id = "clk_m_div4", .dt_id = TEGRA30_CLK_CLK_M_DIV4 },
+	{ .con_id = "osc", .dt_id = TEGRA30_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA30_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA30_CLK_OSC_DIV4 },
 	{ .con_id = "cml0", .dt_id = TEGRA30_CLK_CML0 },
@@ -687,6 +688,7 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_m] = { .dt_id = TEGRA30_CLK_CLK_M, .present = true },
 	[tegra_clk_clk_m_div2] = { .dt_id = TEGRA30_CLK_CLK_M_DIV2, .present = true },
 	[tegra_clk_clk_m_div4] = { .dt_id = TEGRA30_CLK_CLK_M_DIV4, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA30_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA30_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA30_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA30_CLK_PLL_REF, .present = true },
-- 
2.7.4

