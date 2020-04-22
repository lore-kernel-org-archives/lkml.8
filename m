Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A41C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A4A2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550097;
	bh=diZCH/Mg8n9hXnJ0WhmZgAaGP/vFOO2uGKOad9Enxpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pN1Rtp+6vY8DySQmy8I0IIqUyUdPKLrRdQDGRjbAk6Y+XjaCZAIrmMDt7Nlta5/SW
	 d0Mz6poXKeWv6C1X3RxgC4/rEhh7B3iwdkv3Lo9OwfwJOnlvitAEauWRRFJ2+5B0cT
	 7KT/h+UwSW8yWoFCvLB3/h0FKs2xwwVndt/5EvSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgDVKIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgDVKIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:08:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AC22076C;
        Wed, 22 Apr 2020 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550091;
        bh=diZCH/Mg8n9hXnJ0WhmZgAaGP/vFOO2uGKOad9Enxpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=At5yPSyWNiQ/lWkGyZOtncWFFSawMrTX16DvmKg1aHAM+6BpEk1+TDg6BKjbHAzaY
         wpfhgzjGg+jbU3GlYEcJfPTyd5K3FC+/ltQ2plccVOB70VYuq40QCm4bJRohuINXeW
         hq+amkIhwkKbNRa7hO4RIAEIX1/Qf6a6Sb4UbMCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 105/125] clk: tegra: Fix Tegra PMC clock out parents
Date:   Wed, 22 Apr 2020 11:57:02 +0200
Message-Id: <20200422095049.865207195@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit 6fe38aa8cac3a5db38154331742835a4d9740788 ]

Tegra PMC clocks clk_out_1, clk_out_2, and clk_out_3 supported parents
are osc, osc_div2, osc_div4 and extern clock.

Clock driver is using incorrect parents clk_m, clk_m_div2, clk_m_div4
for PMC clocks.

This patch fixes this.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra-pmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
index 91377abfefa19..17a04300f93bf 100644
--- a/drivers/clk/tegra/clk-tegra-pmc.c
+++ b/drivers/clk/tegra/clk-tegra-pmc.c
@@ -60,16 +60,16 @@ struct pmc_clk_init_data {
 
 static DEFINE_SPINLOCK(clk_out_lock);
 
-static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern1",
+static const char *clk_out1_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern1",
 };
 
-static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern2",
+static const char *clk_out2_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern2",
 };
 
-static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern3",
+static const char *clk_out3_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern3",
 };
 
 static struct pmc_clk_init_data pmc_clks[] = {
-- 
2.20.1



