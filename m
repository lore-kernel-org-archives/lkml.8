Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27EC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B320663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194470;
	bh=Oy9+H6puvy3Hl0TrNbMsCtOCK+VFOA3wTa72gzc+lvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IYycaezktWygbGpl+zPcNYkuFEj1LQN6ajhjIHFYAC5Su91Ed2U/lACMLShU2JkNf
	 jl5+jX84j1ogMbhv5Jn/qc5KtBPHlAUUCoz6FG5jbKWMRYoU7PPChUUsVNzaiMojM3
	 imZpvukl8po2Q7u0aICFCbwO1Hccwf6ocBoS9v/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbgAPRHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbgAPRHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD672192A;
        Thu, 16 Jan 2020 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194457;
        bh=Oy9+H6puvy3Hl0TrNbMsCtOCK+VFOA3wTa72gzc+lvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQuX150EsgT8Hj3fC2kfGvRwodXSx7KE4+9Ss0Rya+TQRLvUmz3y4TGx8P62erIxB
         3bK9hh0DA0GwZFeRNCorXoV78JR+81vEn340J/JUoocbA9S0VM7lBf4QXrI6A0USL9
         +VY8xVOiK70r5VtU+m7wav0yxGGfHz0cRYP92V2U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 366/671] clk: meson: axg: spread spectrum is on mpll2
Date:   Thu, 16 Jan 2020 12:00:04 -0500
Message-Id: <20200116170509.12787-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit dc4e62d373f881cbf51513296a6db7806516a01a ]

After testing, it appears that the SSEN bit controls the spread
spectrum function on MPLL2, not MPLL0.

Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/axg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 02229d051d77..4e7dac24948b 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -461,11 +461,6 @@ static struct clk_regmap axg_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.ssen = {
-			.reg_off = HHI_MPLL_CNTL,
-			.shift   = 25,
-			.width	 = 1,
-		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 0,
@@ -560,6 +555,11 @@ static struct clk_regmap axg_mpll2_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width	 = 1,
+		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 2,
-- 
2.20.1

