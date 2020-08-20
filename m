Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E1C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930770;
	bh=4ECfkLhEYHdEtCnhAdduHmkM3iWQ8LHlr8d9E3NNG1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I04m+VfeBBS9biEKYq/7QimV0mNzcd51U+8vNIQDIl6+kRzTpZJLQbPwAxG5fmslC
	 0zpdgELBtrHzybtwtpHGQdx2bDESV3VdZj41WNEwn0mOuVe5VVsN1uI1nvl/ouKeJ7
	 AGEFk/hzUf8CEHdAGjtS1wl2XfqCPO1h7LOGUR0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgHTNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHTJak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB8A21775;
        Thu, 20 Aug 2020 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915839;
        bh=4ECfkLhEYHdEtCnhAdduHmkM3iWQ8LHlr8d9E3NNG1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1xuJW6a8IUyooyB/TstdtaI7GAmbqv6d1dId1maA4yfxZAMUIQ77w9b93Am3RFT7
         QH5ExdCvRb2259OVb14Fe8Z8YrVryMq4KbC4V/umFpTTkvaGdqfzAjxDdGCWPgnape
         +kko84jOmGj7/qLzOxzls0ldy+/wupZ1h+1NXLpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 151/232] clk: actions: Fix h_clk for Actions S500 SoC
Date:   Thu, 20 Aug 2020 11:20:02 +0200
Message-Id: <20200820091620.125563669@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

[ Upstream commit f47ee279d25fb0e010cae5d6e758e39b40eb6378 ]

The h_clk clock in the Actions Semi S500 SoC clock driver has an
invalid parent. Replace with the correct one.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/c57e7ebabfa970014f073b92fe95b47d3e5a70b1.1593788312.git.cristian.ciocaltea@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/actions/owl-s500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index e2007ac4d235d..0eb83a0b70bcc 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -183,7 +183,7 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
 static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
-static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
-- 
2.25.1



