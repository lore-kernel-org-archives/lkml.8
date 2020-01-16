Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA00EC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198420;
	bh=ZGJmYlRjr2H0cz1pgfoxuIs7wu9sOSTq74J+NGGbjRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwZVQEZhLWHTg6F2C7BACcCrXjI7gGT7IhKtnlCEsM0pRvmzGx9hISeNGG+S6NY20
	 +0kZZIypr4Ml1d/Lb4fAEisSVQ3JHmvnx6+TXQJ80rIh15Cc4p4bwHtjUtdVRlUY5V
	 2OkCBAB4sMa//mNB5HersmzpnM+L0x4RAIrhRHkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395264AbgAPSNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405202AbgAPRgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:36:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA66246B8;
        Thu, 16 Jan 2020 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196210;
        bh=ZGJmYlRjr2H0cz1pgfoxuIs7wu9sOSTq74J+NGGbjRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dgn3RykfLEIcnLGf/6LMjzLGB+c2eak+Tu3H/7mVKlCoDza3Nzos1rLMTJg0YvODD
         m1G2ZAwUaN9c5ZGb9C/JwCaJNnuxNCJVGJDrG22MumMWZ4o5CXcXDsPSSBtG0TMkdy
         McF1V50+FRNGAmPupAbZPcGJMInX15kyRVqHYRcw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 046/251] clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when ungating it
Date:   Thu, 16 Jan 2020 12:33:15 -0500
Message-Id: <20200116173641.22137-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 108a459ef4cd17a28711d81092044e597b5c7618 ]

The PLL-MIPI clock is somewhat special as it has its own LDOs which
need to be turned on for this PLL to actually work and output a clock
signal.

Add the 2 LDO enable bits to the gate bits.

Fixes: 5690879d93e8 ("clk: sunxi-ng: Add A23 CCU")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 5c6d37bdf247..765c6977484e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -132,7 +132,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_mipi_clk, "pll-mipi",
 				    8, 4,		/* N */
 				    4, 2,		/* K */
 				    0, 4,		/* M */
-				    BIT(31),		/* gate */
+				    BIT(31) | BIT(23) | BIT(22), /* gate */
 				    BIT(28),		/* lock */
 				    CLK_SET_RATE_UNGATE);
 
-- 
2.20.1

