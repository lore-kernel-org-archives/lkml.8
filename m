Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2AAC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4313A20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193919;
	bh=jcUO4aiGzaGJ0ae33gdIpJzoUiIP1myn1aets66c0us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMWIPbtm/7H7QaFXTu53WAjVL8v8sg8wSnlLj/FerSdU/VeqnzRz3aq2m8eb7vHfs
	 uEvIU9N+gR4skiw0TM29IQS3fLA+TuWAt0A1Ta4/70W9wFVaqluT1tSw/J23AVWnzV
	 8zQXaSgp8txPhIpt/QFs4bXPG+/3cQ172YFP3yFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgAPQ5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbgAPQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0C620730;
        Thu, 16 Jan 2020 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193849;
        bh=jcUO4aiGzaGJ0ae33gdIpJzoUiIP1myn1aets66c0us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3t1t2Cyo5PvWh41o1h8u/hb61U54iYEFY0WQW1gK2WEz8bpJShDbO+/T7hVHgiiS
         AcKku1iQyWyFQL6yOxyed2SAkCpaRUsMKPtRHtAVzuJrdedIGWk1PMVMXr9LJWrUEC
         HDaYRmLSbb9fb4Dk4MMTe5RJUvgcqgnYCLHxlZ2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 101/671] remoteproc: qcom: q6v5-mss: Add missing regulator for MSM8996
Date:   Thu, 16 Jan 2020 11:45:32 -0500
Message-Id: <20200116165502.8838-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit 47b874748d500020026ee43b386b5598e20f3a68 ]

Add proxy vote for pll supply on MSM8996 SoC.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc on msm8996")
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 073747ba8000..cc475dcbf27f 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1268,6 +1268,13 @@ static const struct rproc_hexagon_res sdm845_mss = {
 
 static const struct rproc_hexagon_res msm8996_mss = {
 	.hexagon_mba_image = "mba.mbn",
+	.proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "pll",
+			.uA = 100000,
+		},
+		{}
+	},
 	.proxy_clk_names = (char*[]){
 			"xo",
 			"pnoc",
-- 
2.20.1

