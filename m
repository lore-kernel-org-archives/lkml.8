Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA106C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AF420724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920509;
	bh=n5cC+lHzOf2A0IvW1wBUQu3aQb4WELKBqSW+wuzoN30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYwcUlLVVgK/9RzLgth4vlJQlcTGVh7zEjIu1bAleEcCws3jmyPQ8v9LPEqQQSAZT
	 3nVIDotv0D2kW9Jzo3GpCpacDqTxqGoolr3mJoj8QnU79fTGOt2wENYLewKedCH0Vj
	 i4b9moOlqGpFazC9JqgDjY8pxEWmRJMaF931M3PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgHTKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbgHTKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D102075E;
        Thu, 20 Aug 2020 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918557;
        bh=n5cC+lHzOf2A0IvW1wBUQu3aQb4WELKBqSW+wuzoN30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLt5evCp7ObMd3AKPauDN23zqRDawY5gDvqRhNfzJqMv+ahOc7S59S9aG77IIx1RH
         /3FzxXYEOkocCPIxdp3rdhPZOc+o8ttXMEja3e8ze8E70qKhBQbKeCYMUEeJdc25Nm
         +8hdxxqhgoqoaoScFvQX5qUOWaKd7HHaHLDhSfqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>, Timur Tabi <timur@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 212/228] net: qcom/emac: add missed clk_disable_unprepare in error path of emac_clks_phase1_init
Date:   Thu, 20 Aug 2020 11:23:07 +0200
Message-Id: <20200820091618.122503342@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 50caa777a3a24d7027748e96265728ce748b41ef ]

Fix the missing clk_disable_unprepare() before return
from emac_clks_phase1_init() in the error handling case.

Fixes: b9b17debc69d ("net: emac: emac gigabit ethernet controller driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/emac/emac.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 759543512117c..5ab83751a471f 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -493,13 +493,24 @@ static int emac_clks_phase1_init(struct platform_device *pdev,
 
 	ret = clk_prepare_enable(adpt->clk[EMAC_CLK_CFG_AHB]);
 	if (ret)
-		return ret;
+		goto disable_clk_axi;
 
 	ret = clk_set_rate(adpt->clk[EMAC_CLK_HIGH_SPEED], 19200000);
 	if (ret)
-		return ret;
+		goto disable_clk_cfg_ahb;
+
+	ret = clk_prepare_enable(adpt->clk[EMAC_CLK_HIGH_SPEED]);
+	if (ret)
+		goto disable_clk_cfg_ahb;
 
-	return clk_prepare_enable(adpt->clk[EMAC_CLK_HIGH_SPEED]);
+	return 0;
+
+disable_clk_cfg_ahb:
+	clk_disable_unprepare(adpt->clk[EMAC_CLK_CFG_AHB]);
+disable_clk_axi:
+	clk_disable_unprepare(adpt->clk[EMAC_CLK_AXI]);
+
+	return ret;
 }
 
 /* Enable clocks; needs emac_clks_phase1_init to be called before */
-- 
2.25.1



