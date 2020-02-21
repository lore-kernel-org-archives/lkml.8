Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DCC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2DD2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271487;
	bh=CVfVA6v89yNedy4aQtUH/s74q22YyBh8hOOT8Sme+v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqFoU2+728fhpowNd7AJc2FmY6EBL7fXdl8u3w8R2PnN6H86d/xjhApM5BUZ+RJ5x
	 HiBBV4oc4ausBt3/Ur+TtGb7oUz4YLgYR+hfS0XkTZrQT8VlzXYFA9I5DZvFnYSFIu
	 0iWXW97TvaIaiQXF2OxvoUHqqFM8b9IwZM6cPp7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgBUHv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbgBUHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386DE20578;
        Fri, 21 Feb 2020 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271478;
        bh=CVfVA6v89yNedy4aQtUH/s74q22YyBh8hOOT8Sme+v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Fp0fcU1pgQF+u3fdwDxVXLmQH12uizssHQJR+DVFtl7WLXXft6aq6G6vYBtFgNgW
         iH+kGLTHsTdowPHL9ejgxVFVr3TbnTNZVHWoDAkX/+LxXg0lAJneQmBuPAIgU+xM4E
         i3pHp7saeOB6FqWbgc2kmRU8c4ZJrn5G8rhzTi4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 181/399] clk: qcom: Add missing msm8998 gcc_bimc_gfx_clk
Date:   Fri, 21 Feb 2020 08:38:26 +0100
Message-Id: <20200221072420.314231029@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit db2c7c0a04b11753f5741d00b784b5380ddeee72 ]

gcc_bimc_gfx_clk is a required clock for booting the GPU and GPU SMMU.

Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lkml.kernel.org/r/20191217164913.4783-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-msm8998.c               | 14 ++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8998.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index cf31b5d03270f..df1d7056436cd 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1996,6 +1996,19 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
+static struct clk_branch gcc_bimc_gfx_clk = {
+	.halt_reg = 0x46040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x46040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_bimc_gfx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	.halt_reg = 0x71010,
 	.halt_check = BRANCH_HALT,
@@ -2810,6 +2823,7 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
 	[GCC_GPU_BIMC_GFX_CLK] = &gcc_gpu_bimc_gfx_clk.clkr,
 	[GCC_GPU_BIMC_GFX_SRC_CLK] = &gcc_gpu_bimc_gfx_src_clk.clkr,
 	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index de1d8a1f59665..63e02dc32a0bb 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -182,6 +182,7 @@
 #define GCC_MSS_GPLL0_DIV_CLK_SRC				173
 #define GCC_MSS_SNOC_AXI_CLK					174
 #define GCC_MSS_MNOC_BIMC_AXI_CLK				175
+#define GCC_BIMC_GFX_CLK					176
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1
-- 
2.20.1



