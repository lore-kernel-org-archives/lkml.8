Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F105C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CD6207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752680;
	bh=Z3rIJa+Xax5nS02cYxpdGAtB9OBg2QGFnRukB6j2RwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PX6mZeXywUZIehJqn3Acw/nxxdRbmK8fw4FMvu5l2WLSjvItXaRFz5fVF/eZ92mlr
	 ApS4Tt4+HNDgUX986CL6Pc6jN+kTPgQLSDjvzkZrep0mxp97B+RKqoIxhklYaTh+n1
	 0Mln9WxUQlmiTCcfLqQKI8amxP3bh7/3JtLaDfjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgGNSvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbgGNSvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:51:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDDB22B3F;
        Tue, 14 Jul 2020 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752669;
        bh=Z3rIJa+Xax5nS02cYxpdGAtB9OBg2QGFnRukB6j2RwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEEFzCfzho6oxirRAsG8aOsvsCepnv2HsMrG3712vJURmTb1ldoaR5UrJBQWZTzw9
         U5E9/ee0n2nFIZDhUUl0fsqUpiNNVXVc9BIi1N1kxnAc/l5eHb4cu3PJtYR4OiwKQg
         978VPvwfXfRA6nyp41TFi+N0xX6hCEJMAYj+7Zwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/109] net: macb: fix wakeup test in runtime suspend/resume routines
Date:   Tue, 14 Jul 2020 20:44:08 +0200
Message-Id: <20200714184108.637156243@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit 515a10a701d570e26dfbe6ee373f77c8bf11053f ]

Use the proper struct device pointer to check if the wakeup flag
and wakeup source are positioned.
Use the one passed by function call which is equivalent to
&bp->dev->dev.parent.

It's preventing the trigger of a spurious interrupt in case the
Wake-on-Lan feature is used.

Fixes: d54f89af6cc4 ("net: macb: Add pm runtime support")
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Harini Katakam <harini.katakam@xilinx.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1ec19d9fab00c..16f5c62ba6dfe 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4507,7 +4507,7 @@ static int __maybe_unused macb_runtime_suspend(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
-	if (!(device_may_wakeup(&bp->dev->dev))) {
+	if (!(device_may_wakeup(dev))) {
 		clk_disable_unprepare(bp->tx_clk);
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
@@ -4523,7 +4523,7 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
-	if (!(device_may_wakeup(&bp->dev->dev))) {
+	if (!(device_may_wakeup(dev))) {
 		clk_prepare_enable(bp->pclk);
 		clk_prepare_enable(bp->hclk);
 		clk_prepare_enable(bp->tx_clk);
-- 
2.25.1



