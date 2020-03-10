Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E120675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847183;
	bh=LZyWpX33RtTDKGvVKBxikGAy/hclwcm1ft5zVmNnDl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mf1dyUfxqmL9zRp+lHkdTf1u6AA6JdD/gJrc4ytq3+k+QM1+tyUm+Fk67OnkuHZ1f
	 quugIE/sboLokNE30lTEmXbEPHa8B2kqmlMVV7BvH20xwI3ZR6ecwlKWfMDb9IP/fy
	 rO6rlo9XiFJ0a5WebEj+JGJBA6B2Jnni1/tmAUII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgCJMtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCJMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2E92467D;
        Tue, 10 Mar 2020 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844535;
        bh=LZyWpX33RtTDKGvVKBxikGAy/hclwcm1ft5zVmNnDl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wq8+gjfoQrS/j0rlGnkCvRLKpdeDqaIwcAtRU273BMwIsXOA6rcS6FpNELXgKVvDs
         OTm5L9fE8ZjqJ1cOkP9rDKU7Fxt7kGoUTGfZcNVwg0NFEEscLaudikraSKOrJojC+v
         YVD1i6qt/4BqmlYqinvYvjQO3e0R/drydLgkTRXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/168] net: stmmac: fix notifier registration
Date:   Tue, 10 Mar 2020 13:37:32 +0100
Message-Id: <20200310123636.162963642@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 474a31e13a4e9749fb3ee55794d69d0f17ee0998 ]

We cannot register the same netdev notifier multiple times when probing
stmmac devices. Register the notifier only once in module init, and also
make debugfs creation/deletion safe against simultaneous notifier call.

Fixes: 481a7d154cbb ("stmmac: debugfs entry name is not be changed when udev rename device name.")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 582176d869c35..89a6ae2b17e35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4208,6 +4208,8 @@ static void stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	rtnl_lock();
+
 	/* Create per netdev entries */
 	priv->dbgfs_dir = debugfs_create_dir(dev->name, stmmac_fs_dir);
 
@@ -4219,14 +4221,13 @@ static void stmmac_init_fs(struct net_device *dev)
 	debugfs_create_file("dma_cap", 0444, priv->dbgfs_dir, dev,
 			    &stmmac_dma_cap_fops);
 
-	register_netdevice_notifier(&stmmac_notifier);
+	rtnl_unlock();
 }
 
 static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
@@ -4728,14 +4729,14 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
-#ifdef CONFIG_DEBUG_FS
-	stmmac_exit_fs(ndev);
-#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	phylink_destroy(priv->phylink);
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
@@ -4955,6 +4956,7 @@ static int __init stmmac_init(void)
 	/* Create debugfs main directory if it doesn't exist yet */
 	if (!stmmac_fs_dir)
 		stmmac_fs_dir = debugfs_create_dir(STMMAC_RESOURCE_NAME, NULL);
+	register_netdevice_notifier(&stmmac_notifier);
 #endif
 
 	return 0;
@@ -4963,6 +4965,7 @@ static int __init stmmac_init(void)
 static void __exit stmmac_exit(void)
 {
 #ifdef CONFIG_DEBUG_FS
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(stmmac_fs_dir);
 #endif
 }
-- 
2.20.1



