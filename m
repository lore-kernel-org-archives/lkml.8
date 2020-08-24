Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A115C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE6207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259182;
	bh=yXmezxRwmhe4uOvtF52TtcQKfodXuUh05dU6AA6Qqx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m81CewJ7XrhhNp/yYcZiOpJt0FegpBl7GGKny2F6BNlPgN8PQJCa6r61IbDktg1KI
	 w9+GZOF7qbFOUwz8ZsPfR5Yajvn6U9qwaOQOf2ih8BIPWwJ0Boi3/wIPxXzKPtSG0D
	 BbB+B4sK5GUl2pYsiRSKARA3UErehGHY7eINfXGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgHXIxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgHXIwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3EB1207D3;
        Mon, 24 Aug 2020 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259160;
        bh=yXmezxRwmhe4uOvtF52TtcQKfodXuUh05dU6AA6Qqx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqPW9fSR/vDsnVCfdiSDboLhPt+Yx8lv9QO6G045fAllbsTL70B0rgmyZVETjSpcj
         ixcNtBbnxdEPXbhJNXYPlX+Ky0WXgomp72By74ZPLnW93v3qx6l6wfRTdq/FnOxp3M
         NpJDgDyJHw2JtaYEKZWpFdP+XcBkIuucSxn59+60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/39] net: fec: correct the error path for regulator disable in probe
Date:   Mon, 24 Aug 2020 10:31:30 +0200
Message-Id: <20200824082350.125735828@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit c6165cf0dbb82ded90163dce3ac183fc7a913dc4 ]

Correct the error path for regulator disable.

Fixes: 9269e5560b26 ("net: fec: add phy-reset-gpios PROBE_DEFER check")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8df32398d3435..9b3ea0406e0d5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3505,11 +3505,11 @@ fec_probe(struct platform_device *pdev)
 failed_irq:
 failed_init:
 	fec_ptp_stop(pdev);
-	if (fep->reg_phy)
-		regulator_disable(fep->reg_phy);
 failed_reset:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	if (fep->reg_phy)
+		regulator_disable(fep->reg_phy);
 failed_regulator:
 failed_clk_ipg:
 	fec_enet_clk_enable(ndev, false);
-- 
2.25.1



