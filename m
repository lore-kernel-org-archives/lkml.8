Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB7C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BC622314
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XnbrWVhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBEVXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:23:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4124 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:23:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b32590000>; Wed, 05 Feb 2020 13:23:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 13:23:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 13:23:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb
 2020 21:23:51 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Feb 2020 21:23:52 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.216]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3b32670000>; Wed, 05 Feb 2020 13:23:51 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <helen.koike@collabora.com>, <sboyd@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/6] clk: tegra: Add Tegra210 CSI TPG clock gate
Date:   Wed, 5 Feb 2020 13:23:22 -0800
Message-ID: <1580937806-17376-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580937806-17376-1-git-send-email-skomatineni@nvidia.com>
References: <1580937806-17376-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580937818; bh=U33XItr+moxxea1Mr2O71xPE31NqHV1XULA57TM/x3s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XnbrWVhnVMfLS9EibM3fY56tHYO4SAGKG3Rk70vZ9f0B8xHCwRird30FMFncqeJat
         vjJd6o3q3Lkp1qxlR8kB1d0Qfm0XMZ6SzT0kn75CO7iDc3kvgJp+obTPAQu37xhrWV
         37S8oey7Txv9NYMTrtOlTZSiepXWBTj3FLgFmh/9cqcpEtHpKiVkY22/VPozSoc4QP
         6d8waTpnBmEMh20Ocw8jKpZxcDcSbOgds9hsuQC7UyhkmO5ZI1h0lBbfG/mCCl+dKs
         CVtjfmPOZ1D8eGW1OgcYHhHYPm4RDzpZDJYUobf/9J+MP/mJA0A6+oYIh7aAbHOSyD
         H+tQv3rrfd/NQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 CSI hardware internally uses PLLD for internal test pattern
generator logic.

PLLD_BASE register in CAR has a bit CSI_CLK_SOURCE to enable PLLD
out to CSI during TPG mode.

This patch adds this CSI TPG clock gate to Tegra210 clock driver
to allow Tegra video driver to ungate CSI TPG clock during TPG mode
and gate during non TPG mode.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra210.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 762cd186f714..e66498b5fd6f 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3041,6 +3041,13 @@ static __init void tegra210_periph_clk_init(void __iomem *clk_base,
 					     periph_clk_enb_refcnt);
 	clks[TEGRA210_CLK_DSIB] = clk;
 
+	/* csi_tpg */
+	clk = clk_register_gate(NULL, "csi_tpg", "pll_d_out0",
+				CLK_SET_RATE_PARENT, clk_base + PLLD_BASE,
+				23, 0, &pll_d_lock);
+	clk_register_clkdev(clk, "csi_tpg", NULL);
+	clks[TEGRA210_CLK_CSI_TPG] = clk;
+
 	/* la */
 	clk = tegra_clk_register_periph("la", la_parents,
 			ARRAY_SIZE(la_parents), &tegra210_la, clk_base,
-- 
2.7.4

