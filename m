Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B04EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58ED20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824561;
	bh=5YsxkCbiT4/BpBT77MVxcMiKuXtcFlXKvr3Vd7rcdao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mj10dTkbJ/f9e2tqZQ+PpUTZLueyWy62a74Fs3J/Febul1c/vEu5sDUCow5oxsxXV
	 vH5+Y+saysc0XVzXDD0jXOSjAY16Fj1OXzuFxpWF8BprsJ8uc36I5JosRvgzFxmc+K
	 L7izPutOA+Q8pqYNgEY0za10ry2S4ydd70qxau9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgERR4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbgERRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:55:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18B420674;
        Mon, 18 May 2020 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824555;
        bh=5YsxkCbiT4/BpBT77MVxcMiKuXtcFlXKvr3Vd7rcdao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6Ey3K+wCVuJPDCs9kMwxqEIcGsmZLvZOY2xaeOM3R7zJO/67aUEbWBV3oHGzGdFP
         dodKChEt6SOE0E1rwv4Z+XBUJwvobhWEh2UAGqfoAUF2ZhCXnMuWMQaQU251ZIyqXw
         2f1LLJZKdQovrYnShLxcbUZ8KMR1wvrhox9SZrrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/147] pinctrl: qcom: fix wrong write in update_dual_edge
Date:   Mon, 18 May 2020 19:36:21 +0200
Message-Id: <20200518173521.189845833@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 90bcb0c3ca0809d1ed358bfbf838df4b3d4e58e0 ]

Fix a typo in the readl/writel accessor conversion where val is used
instead of pol changing the behavior of the original code.

Cc: stable@vger.kernel.org
Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200414003726.25347-1-ansuelsmth@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 763da0be10d6f..44320322037df 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -688,7 +688,7 @@ static void msm_gpio_update_dual_edge_pos(struct msm_pinctrl *pctrl,
 
 		pol = msm_readl_intr_cfg(pctrl, g);
 		pol ^= BIT(g->intr_polarity_bit);
-		msm_writel_intr_cfg(val, pctrl, g);
+		msm_writel_intr_cfg(pol, pctrl, g);
 
 		val2 = msm_readl_io(pctrl, g) & BIT(g->in_bit);
 		intstat = msm_readl_intr_status(pctrl, g);
-- 
2.20.1



