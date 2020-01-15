Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B82C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ED724671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAOEC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 23:02:59 -0500
Received: from mx.socionext.com ([202.248.49.38]:23581 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgAOEC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 23:02:59 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Jan 2020 13:02:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5DAF7180059;
        Wed, 15 Jan 2020 13:02:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 15 Jan 2020 13:04:05 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E04E41A01CF;
        Wed, 15 Jan 2020 13:02:56 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net] net: ethernet: ave: Avoid lockdep warning
Date:   Wed, 15 Jan 2020 13:02:42 +0900
Message-Id: <1579060962-12125-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with PROVE_LOCKING=y, lockdep shows the following
dump message.

    INFO: trying to register non-static key.
    the code is fine but needs lockdep annotation.
    turning off the locking correctness validator.
     ...

Calling device_set_wakeup_enable() directly occurs this issue,
and it isn't necessary for initialization, so this patch creates
internal function __ave_ethtool_set_wol() and replaces with this
in ave_init() and ave_resume().

Fixes: 7200f2e3c9e2 ("net: ethernet: ave: Set initial wol state to disabled")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index e5478b7..3b4c7e6 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -468,16 +468,22 @@ static void ave_ethtool_get_wol(struct net_device *ndev,
 		phy_ethtool_get_wol(ndev->phydev, wol);
 }
 
-static int ave_ethtool_set_wol(struct net_device *ndev,
-			       struct ethtool_wolinfo *wol)
+static int __ave_ethtool_set_wol(struct net_device *ndev,
+				 struct ethtool_wolinfo *wol)
 {
-	int ret;
-
 	if (!ndev->phydev ||
 	    (wol->wolopts & (WAKE_ARP | WAKE_MAGICSECURE)))
 		return -EOPNOTSUPP;
 
-	ret = phy_ethtool_set_wol(ndev->phydev, wol);
+	return phy_ethtool_set_wol(ndev->phydev, wol);
+}
+
+static int ave_ethtool_set_wol(struct net_device *ndev,
+			       struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	ret = __ave_ethtool_set_wol(ndev, wol);
 	if (!ret)
 		device_set_wakeup_enable(&ndev->dev, !!wol->wolopts);
 
@@ -1260,7 +1266,7 @@ static int ave_init(struct net_device *ndev)
 
 	/* set wol initial state disabled */
 	wol.wolopts = 0;
-	ave_ethtool_set_wol(ndev, &wol);
+	__ave_ethtool_set_wol(ndev, &wol);
 
 	if (!phy_interface_is_rgmii(phydev))
 		phy_set_max_speed(phydev, SPEED_100);
@@ -1815,7 +1821,7 @@ static int ave_resume(struct device *dev)
 
 	ave_ethtool_get_wol(ndev, &wol);
 	wol.wolopts = priv->wolopts;
-	ave_ethtool_set_wol(ndev, &wol);
+	__ave_ethtool_set_wol(ndev, &wol);
 
 	if (ndev->phydev) {
 		ret = phy_resume(ndev->phydev);
-- 
2.7.4

