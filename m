Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92CC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21B12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eseKmqrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGWMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:19:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10728 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGWMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:19:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f19803b0001>; Thu, 23 Jul 2020 05:19:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 05:19:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 23 Jul 2020 05:19:20 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 12:19:19 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 12:19:19 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1980440001>; Thu, 23 Jul 2020 05:19:18 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <digetx@gmail.com>, <linux-i2c@vger.kernel.org>,
        <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ldewangan@nvidia.com>,
        <smohammed@nvidia.com>, <rgumasta@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 5/7] i2c: tegra: enable second level clock gating
Date:   Thu, 23 Jul 2020 17:48:51 +0530
Message-ID: <1595506733-10307-5-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595506733-10307-1-git-send-email-kyarlagadda@nvidia.com>
References: <1595506733-10307-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595506747; bh=YtW5ONuxQcaNg5+GvR7yBueoYCGlYcr9525vggzlM5Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=eseKmqrlY/enO0KSXaanUL2AKHEuZ1u3zDUrTCD7w5U4VmCNMXxDLdKnKHC7BRqz0
         SMCn1OldRpl4TsmNXASWOcwS5rxsb4MBEv4BhcqtJaGgxr6JgAOjShVHA4tfxtwQAe
         fsarR6S2zMoMchKoubouT5QaoKc92ld4Rfb32xTK+5jx44M/eanIdrBF7uHeZTFWcB
         Pxsf0eaU7P5KMT2wPUQzr5UxMnIbY8rfBi1vIVbfZiNH2mf0wCdXs0LYu+aypESjGu
         qNMJWVcl7dR9hoRnO67OxcFxk+d+9pp7j+0t+wSdD2Yk+KbC87g6cQj/wFdoeYQLm6
         XAd2YBbRnuXXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Second Level Clock Gating feature for supported chips.
With SLCG enabled, software need not control clocks anymore
and leave clocks enabled always on.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 2f654ed..8ab968e 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -235,6 +235,7 @@ struct tegra_i2c_hw_feature {
 	u32 setup_hold_time_fast_fast_plus_mode;
 	u32 setup_hold_time_hs_mode;
 	bool has_interface_timing_reg;
+	bool has_slcg_support;
 };
 
 /**
@@ -299,6 +300,7 @@ struct tegra_i2c_dev {
 	struct completion dma_complete;
 	bool is_curr_atomic_xfer;
 	int clk_divisor_hs_mode;
+	bool is_clkon_always;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
@@ -1478,6 +1480,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.supports_bus_clear = false,
 	.has_reg_write_buffering = true,
 	.has_hs_mode_support = false,
+	.has_slcg_support = false,
 	.has_apb_dma = true,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x2,
@@ -1506,6 +1509,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.supports_bus_clear = false,
 	.has_reg_write_buffering = true,
 	.has_hs_mode_support = false,
+	.has_slcg_support = false,
 	.has_apb_dma = true,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x2,
@@ -1534,6 +1538,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.supports_bus_clear = true,
 	.has_reg_write_buffering = true,
 	.has_hs_mode_support = false,
+	.has_slcg_support = false,
 	.has_apb_dma = true,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x2,
@@ -1562,6 +1567,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.supports_bus_clear = true,
 	.has_reg_write_buffering = true,
 	.has_hs_mode_support = false,
+	.has_slcg_support = false,
 	.has_apb_dma = true,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x2,
@@ -1590,6 +1596,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.supports_bus_clear = true,
 	.has_reg_write_buffering = true,
 	.has_hs_mode_support = false,
+	.has_slcg_support = false,
 	.has_apb_dma = true,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x2,
@@ -1618,6 +1625,7 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.supports_bus_clear = true,
 	.has_reg_write_buffering = false,
 	.has_hs_mode_support = false,
+	.has_slcg_support = true,
 	.has_apb_dma = false,
 	.tlow_std_mode = 0x4,
 	.thigh_std_mode = 0x3,
@@ -1646,6 +1654,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.supports_bus_clear = true,
 	.has_reg_write_buffering = false,
 	.has_hs_mode_support = true,
+	.has_slcg_support = true,
 	.has_apb_dma = false,
 	.tlow_std_mode = 0x8,
 	.thigh_std_mode = 0x7,
@@ -1822,7 +1831,12 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (i2c_dev->is_multimaster_mode) {
+	if (i2c_dev->is_multimaster_mode || i2c_dev->hw->has_slcg_support)
+		i2c_dev->is_clkon_always = true;
+	else
+		i2c_dev->is_clkon_always = false;
+
+	if (i2c_dev->is_clkon_always) {
 		ret = clk_enable(i2c_dev->div_clk);
 		if (ret < 0) {
 			dev_err(i2c_dev->dev, "div_clk enable failed %d\n",
@@ -1875,7 +1889,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	tegra_i2c_release_dma(i2c_dev);
 
 disable_div_clk:
-	if (i2c_dev->is_multimaster_mode)
+	if (i2c_dev->is_clkon_always)
 		clk_disable(i2c_dev->div_clk);
 
 put_rpm:
@@ -1908,7 +1922,7 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c_dev->adapter);
 
-	if (i2c_dev->is_multimaster_mode)
+	if (i2c_dev->is_clkon_always)
 		clk_disable(i2c_dev->div_clk);
 
 	pm_runtime_disable(&pdev->dev);
@@ -1932,7 +1946,8 @@ static int __maybe_unused tegra_i2c_suspend(struct device *dev)
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int err = 0;
 
-	i2c_mark_adapter_suspended(&i2c_dev->adapter);
+	if (i2c_dev->is_clkon_always)
+		clk_disable(i2c_dev->div_clk);
 
 	if (!pm_runtime_status_suspended(dev))
 		err = tegra_i2c_runtime_suspend(dev);
@@ -1968,6 +1983,15 @@ static int __maybe_unused tegra_i2c_resume(struct device *dev)
 			return err;
 	}
 
+	if (i2c_dev->is_clkon_always) {
+		err = clk_enable(i2c_dev->div_clk);
+		if (err < 0) {
+			dev_err(i2c_dev->dev, "clock enable failed %d\n",
+				err);
+			return err;
+		}
+	}
+
 	i2c_mark_adapter_resumed(&i2c_dev->adapter);
 
 	return 0;
-- 
2.7.4

