Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0398AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4AD20885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916496;
	bh=Ot+IlbwWoYcMtGQlRqjPHSZwBDd0x0OKpAG8nmv7J4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BupP2EmZyyx9UXWNmhDYd+ZWOCK6Yb2wezS7Do5mVqstgA6A0WjSok2EAFkda5txs
	 RpIgs9cDFLNoLwlMzj2xkjKJHTTkKlYAPA32cjh8O1mu50/1QffFKhs3prysSyPOnn
	 SO5oJx85lM89rlfVqRvG3pPpx3pF60d4au+mc4PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHTJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbgHTJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:41:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91016207DE;
        Thu, 20 Aug 2020 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916482;
        bh=Ot+IlbwWoYcMtGQlRqjPHSZwBDd0x0OKpAG8nmv7J4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj6+EXmW/Zt0dTuxdqAhu+Jd4qWJQoLlu35Ry5GLxFcfRKgxFNFGX6CLdZIgfyx2p
         AzSE9w3MZSQjaNh96mVguUnrgPdA3XvvEjhU2iqlnTwY1ASBRM51+vzEBkGCrKM2Do
         Yu+taSw3ddfCe/dvcOBu9c7mgivjOupHuDLwavPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Konrad Dybcio <konradybcio@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 143/204] clk: qcom: gcc-sdm660: Fix up gcc_mss_mnoc_bimc_axi_clk
Date:   Thu, 20 Aug 2020 11:20:40 +0200
Message-Id: <20200820091613.395253114@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konradybcio@gmail.com>

[ Upstream commit 3386af51d3bcebcba3f7becdb1ef2e384abe90cf ]

Add missing halt_check, hwcg_reg and hwcg_bit properties.
These were likely omitted when porting the driver upstream.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
Link: https://lore.kernel.org/r/20200726111215.22361-9-konradybcio@gmail.com
Fixes: f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for SDM660")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sdm660.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index bf5730832ef3d..c6fb57cd576f5 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -1715,6 +1715,9 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
 
 static struct clk_branch gcc_mss_mnoc_bimc_axi_clk = {
 	.halt_reg = 0x8a004,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x8a004,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x8a004,
 		.enable_mask = BIT(0),
-- 
2.25.1



