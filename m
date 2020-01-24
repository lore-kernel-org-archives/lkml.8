Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0CD2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863920;
	bh=BvH9E5KeG5mIsvrkd/eGOJ/wT1/tG6dyOE8CiU0UUhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIMzl0cB6bMUHuqvW2RMWMFn2jnEmsfqggxpean/rvQA/YTzWg+jz7O7nr5Bh+XZE
	 ibIGmf2UMGjEzw+o7YEbNoXIPZmDullpmXmAAYrxTfZmZRMncmam4w6MwRveQinJSo
	 699L6HY4ouyFlc/iE/ZXKdCO80zhlLwRxCIzAvV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbgAXLFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbgAXLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:05:02 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829512071A;
        Fri, 24 Jan 2020 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863902;
        bh=BvH9E5KeG5mIsvrkd/eGOJ/wT1/tG6dyOE8CiU0UUhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJk7ULd4uJxFzm8AxtclcEPlcLuE+GZDrF7hiY+WOSk8H9UqBAq1ahZFBf+hX5o2/
         bwaWBGEkIcyPgt+rsEy3YwucTCxNM78qUHfIAtyEW+lHwKoUsDcdcbi43n0xNv7JmT
         wnjv7sY/bAfuWb7IeR52a4DTTzbQlpLKSr2Wuha0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/639] remoteproc: qcom: q6v5-mss: Add missing regulator for MSM8996
Date:   Fri, 24 Jan 2020 10:24:48 +0100
Message-Id: <20200124093102.092688894@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 073747ba80002..cc475dcbf27f3 100644
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



