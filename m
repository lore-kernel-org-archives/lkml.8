Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E2CC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5024A2081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193132;
	bh=Xghdmv/I0g1bp8H5pEaFYmz+Bno1uviWEA0OHUUBcRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6QCiXNO0m6LnZDLpACINnPosIFDaYU2ipkWVJZzQxcJ+pJm9fVe4iRHfFoz5YHDY
	 QB7cpwRyvY1xOsVhs9vc0+xKBfu7S5g9hGgDoJXot3oz8DmZrC3/hYrzpk2+lnCHx9
	 pNrU08ONQ0nYV4lnIvr+UAwaD6h5VkPXW4iK+r3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgAPQpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgAPQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:45:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301BF21582;
        Thu, 16 Jan 2020 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193128;
        bh=Xghdmv/I0g1bp8H5pEaFYmz+Bno1uviWEA0OHUUBcRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbNrzMPVIFy4rHoNcrvYObg0Snv1DSlwmHrU7BFxBi74nUMQJbijeU3wt1wZoha/N
         3OCpHVTiO+/KNDjzJXlQikKQToz2nn/3F5DEj4dfsQ78U/v/GncDMCvUF+S5djXlr0
         MnSkVNNQWHwcNzyYX0/8j5pXZhnrkgkcPNF5CkBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 030/205] dpaa2-eth: Fix minor bug in ethtool stats reporting
Date:   Thu, 16 Jan 2020 11:40:05 -0500
Message-Id: <20200116164300.6705-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 4b177f065e7ec37399b18e18412a8c7b75f8f299 ]

Don't print error message for a successful return value.

Fixes: d84c3a4ded96 ("dpaa2-eth: Add new DPNI statistics counters")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 0aa1c34019bb..dc9a6c36cac0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -216,7 +216,7 @@ static void dpaa2_eth_get_ethtool_stats(struct net_device *net_dev,
 		if (err == -EINVAL)
 			/* Older firmware versions don't support all pages */
 			memset(&dpni_stats, 0, sizeof(dpni_stats));
-		else
+		else if (err)
 			netdev_warn(net_dev, "dpni_get_stats(%d) failed\n", j);
 
 		num_cnt = dpni_stats_page_size[j] / sizeof(u64);
-- 
2.20.1

