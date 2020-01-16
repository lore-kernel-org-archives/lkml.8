Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89EEC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919EC246AE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194834;
	bh=L/KSiELxp369zGbGPtlCYt4xEKWsCEJceCqSHQySHVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAU/Ufx1+VpIQiQx8YWU21RCxhWDfls08eStUyQ7zUvAdfG/0oSqPzBf5ek1T120U
	 hZAMouDDLpKwoLwQNMEsI1rg3/Z6IzbHi7u9N1OAtQT92kj/zWXU3fTsjT/M0Z6uX5
	 jGCfpcWaFEEgDY9LCbulRh3Otvv8+LQnsu1IgHUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbgAPRNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbgAPRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE07F246A3;
        Thu, 16 Jan 2020 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194822;
        bh=L/KSiELxp369zGbGPtlCYt4xEKWsCEJceCqSHQySHVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FRzgi9ubCQRV+EzmkN2WYEVK5uh5EryC1lZzxaIsjuVqST7v04WehDNCVU1PJc7e
         uPeTewY+AViOuo7+6R766lGX2EHpUUFiTpWogVeGHkwBGnMi+zONEDrMB6Tg7KMIMZ
         shqOZ6ZeI5I1cC1gWRWDgpmxEyoyUShkJJ6jJTfE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 627/671] clk: samsung: exynos5420: Preserve CPU clocks configuration during suspend/resume
Date:   Thu, 16 Jan 2020 12:04:25 -0500
Message-Id: <20200116170509.12787-364-sashal@kernel.org>
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

From: Marian Mihailescu <mihailescu2m@gmail.com>

[ Upstream commit e21be0d1d7bd7f78a77613f6bcb6965e72b22fc1 ]

Save and restore top PLL related configuration registers for big (APLL)
and LITTLE (KPLL) cores during suspend/resume cycle. So far, CPU clocks
were reset to default values after suspend/resume cycle and performance
after system resume was affected when performance governor has been selected.

Fixes: 773424326b51 ("clk: samsung: exynos5420: add more registers to restore list")
Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index d5af93721299..6473af8903c5 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -171,6 +171,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
 	CLKOUT_CMU_CPU,
+	APLL_CON0,
+	KPLL_CON0,
 	CPLL_CON0,
 	DPLL_CON0,
 	EPLL_CON0,
-- 
2.20.1

