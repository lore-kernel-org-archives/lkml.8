Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D6214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409891;
	bh=vVe2J0NLPpOZp8vR8ECvcA8eLEA7SgBwdYsD8uicAmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z3FzASA4fV31U07Ilm0M9z2CS9L1XT+Ru/torzoy9bDsxbza1yQwSzkRf8w+mmf6X
	 k85GfmttMvB4ATOtmrEhbCHexuLygwMefDn0+/LhX/Hcvzw6m8JjwIRFL3Npykr833
	 za9iruhFfd8YN6WOeYTS89k43hTqCczC/3mp7fdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgA3Sou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbgA3Sos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1047E205F4;
        Thu, 30 Jan 2020 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409887;
        bh=vVe2J0NLPpOZp8vR8ECvcA8eLEA7SgBwdYsD8uicAmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/9ed2iJOMl0Wf9LWzZsTx1Z/kj7ThvNcH94gztW6qEIvMXOHBmnrDCMIHfcb74kL
         ytK8CoHxsjZGgaxnx3opC2KBmpHQwPyK2YhTe9HejVPi7wmTdyCe/kWFir2CfgMJx1
         wb+gHKQtMBUZBA2iRZF8CGxTVCYgkVM3toDZJvso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/110] stmmac: debugfs entry name is not be changed when udev rename device name.
Date:   Thu, 30 Jan 2020 19:38:48 +0100
Message-Id: <20200130183622.973401988@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiping Ma <jiping.ma2@windriver.com>

[ Upstream commit 481a7d154cbbd5ca355cc01cc8969876b240eded ]

Add one notifier for udev changes net device name.
Fixes: b6601323ef9e ("net: stmmac: debugfs entry name is not be changed when udev rename")

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1b3520d0e59ef..06dd65c419c49 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -105,6 +105,7 @@ MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
+static const struct net_device_ops stmmac_netdev_ops;
 static void stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
@@ -4175,6 +4176,34 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
 
+/* Use network device events to rename debugfs file entries.
+ */
+static int stmmac_device_event(struct notifier_block *unused,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	if (dev->netdev_ops != &stmmac_netdev_ops)
+		goto done;
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		if (priv->dbgfs_dir)
+			priv->dbgfs_dir = debugfs_rename(stmmac_fs_dir,
+							 priv->dbgfs_dir,
+							 stmmac_fs_dir,
+							 dev->name);
+		break;
+	}
+done:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block stmmac_notifier = {
+	.notifier_call = stmmac_device_event,
+};
+
 static void stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4189,12 +4218,15 @@ static void stmmac_init_fs(struct net_device *dev)
 	/* Entry to report the DMA HW features */
 	debugfs_create_file("dma_cap", 0444, priv->dbgfs_dir, dev,
 			    &stmmac_dma_cap_fops);
+
+	register_netdevice_notifier(&stmmac_notifier);
 }
 
 static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.20.1



