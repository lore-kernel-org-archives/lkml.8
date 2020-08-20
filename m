Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42A722BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930380;
	bh=glrZ8+Vz8mqHzTmrL71cuHD1+DnBP22ANxGQaarC4NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgjCVGvKYSsGgB9aRKOlGSntQsVfX7tRPhF1nxtA3zL3PiE8t0ApMCwbwWo9d6/f6
	 tOttdNvDDSMuLwv/6/dSkt9OO9c/J7VxLZLExCAd3cBOYaAN4yA6mQF62gVDkwPXG2
	 ZDUAZFg6AaChxXKb6Ov6G19KQ+l0Ppl/7avTewzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgHTNc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgHTJbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EB720724;
        Thu, 20 Aug 2020 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915870;
        bh=glrZ8+Vz8mqHzTmrL71cuHD1+DnBP22ANxGQaarC4NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJdB0Wu+7+/KQVI9y9pluyzgIERKEBJFrODVEf9hvkrEM/Bs5gg7Omg7D4gZI/g3X
         H9ncCMuBYUGySpOzvzk7Oj0kvo2Ju4n8R39/w3RxeQ6tF3pW43SVucDvT4jY0SYKPy
         781gFIn1v0IZeCExGnBl69jyS4/bjds2gb4tWwA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 156/232] clk: qcom: gcc: fix sm8150 GPU and NPU clocks
Date:   Thu, 20 Aug 2020 11:20:07 +0200
Message-Id: <20200820091620.367063405@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 667f39b59b494d96ae70f4217637db2ebbee3df0 ]

Fix the parents and set BRANCH_HALT_SKIP. From the downstream driver it
should be a 500us delay and not skip, however this matches what was done
for other clocks that had 500us delay in downstream.

Fixes: f73a4230d5bb ("clk: qcom: gcc: Add GPU and NPU clocks for SM8150")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20200709135251.643-2-jonathan@marek.ca
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 72524cf110487..55e9d6d75a0cd 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -1617,6 +1617,7 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 };
 
 static struct clk_branch gcc_gpu_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(15),
@@ -1632,13 +1633,14 @@ static struct clk_branch gcc_gpu_gpll0_clk_src = {
 };
 
 static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(16),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_gpll0_div_clk_src",
 			.parent_hws = (const struct clk_hw *[]){
-				&gcc_gpu_gpll0_clk_src.clkr.hw },
+				&gpll0_out_even.clkr.hw },
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
@@ -1729,6 +1731,7 @@ static struct clk_branch gcc_npu_cfg_ahb_clk = {
 };
 
 static struct clk_branch gcc_npu_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(18),
@@ -1744,13 +1747,14 @@ static struct clk_branch gcc_npu_gpll0_clk_src = {
 };
 
 static struct clk_branch gcc_npu_gpll0_div_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(19),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_npu_gpll0_div_clk_src",
 			.parent_hws = (const struct clk_hw *[]){
-				&gcc_npu_gpll0_clk_src.clkr.hw },
+				&gpll0_out_even.clkr.hw },
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
-- 
2.25.1



