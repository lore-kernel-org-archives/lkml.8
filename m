Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97935C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC6222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876229;
	bh=qZ/AK7qDtTJakLsjaUI3mUDTzYXOk3amPehL/OjaO/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6iW+sES7Mt+CvbtSKn4dwBF9HduS6tMmkJuSiMqd6+vxl3tuZu2Ap63bd800hd9u
	 AJ2uovBGPObBOSE0lsnSQTs9URYnKacw5i8C+sZay2CxjH8LqleWVuLt1dA88JesVd
	 pUB+BvGI1dCuvxAbqSQ6K7DXSYDtzz7jFZrxK39c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405016AbgAXOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:20:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404879AbgAXOUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:20:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F592077C;
        Fri, 24 Jan 2020 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875632;
        bh=qZ/AK7qDtTJakLsjaUI3mUDTzYXOk3amPehL/OjaO/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjOGT76wvXQbHp3rSUX+AgBe+jcQJKD9gGj5gmjIl0NPAF6ynZjuXUqMJC8CWQ8mr
         qB5+k1Ps5nRDIyVFeBVy0YXicnEefPbPFBzs4CNsYsR9njTcl3xYRTwoJFB6lWIws8
         yKUUryEOw4nlZ48cXOQjlNULTIXUjmwwazMjfXpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/56] clk: qcom: gcc-sdm845: Add missing flag to votable GDSCs
Date:   Fri, 24 Jan 2020 09:19:32 -0500
Message-Id: <20200124142012.29752-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <georgi.djakov@linaro.org>

[ Upstream commit 5e82548e26ef62e257dc2ff37c11acb5eb72728e ]

On sdm845 devices, during boot we see the following warnings (unless we
have added 'pd_ignore_unused' to the kernel command line):
	hlos1_vote_mmnoc_mmu_tbu_sf_gdsc status stuck at 'on'
	hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc status stuck at 'on'
	hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc status stuck at 'on'
	hlos1_vote_aggre_noc_mmu_tbu2_gdsc status stuck at 'on'
	hlos1_vote_aggre_noc_mmu_tbu1_gdsc status stuck at 'on'
	hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc status stuck at 'on'
	hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc status stuck at 'on'

As the name of these GDSCs suggests, they are "votable" and in downstream
DT, they all have the property "qcom,no-status-check-on-disable", which
means that we should not poll the status bit when we disable them.

Luckily the VOTABLE flag already exists and it does exactly what we need,
so let's make use of it to make the warnings disappear.

Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
Reported-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Link: https://lkml.kernel.org/r/20191126153437.11808-1-georgi.djakov@linaro.org
Tested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index ada3e4aeb38f9..6bd96ddadbe31 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3150,6 +3150,7 @@ static struct gdsc hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc = {
 		.name = "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
@@ -3158,6 +3159,7 @@ static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
 		.name = "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
@@ -3166,6 +3168,7 @@ static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
 		.name = "hlos1_vote_aggre_noc_mmu_tbu1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
@@ -3174,6 +3177,7 @@ static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
 		.name = "hlos1_vote_aggre_noc_mmu_tbu2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
@@ -3182,6 +3186,7 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
 		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
@@ -3190,6 +3195,7 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
 		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
@@ -3198,6 +3204,7 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
 		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct clk_regmap *gcc_sdm845_clocks[] = {
-- 
2.20.1

