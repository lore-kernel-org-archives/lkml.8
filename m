Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A07C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BF020792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGUJTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:19:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34262 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgGUJTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 939DC1A05BE;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86F451A05BD;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 51E3A202A9;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/6] staging: dpaa2-ethsw: verify the nofifier block
Date:   Tue, 21 Jul 2020 12:19:14 +0300
Message-Id: <20200721091919.20394-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now we have a notifier block for each DPSW instance probed, we
have to also check that the netdev is indeed connected to the notifier
received. Without this, we end up with the same switchdev callback being
executed multiple times (because it would be received by all notifier
blocks, not just the one intended to).
Also, move the function higher in the source file because it will be
used in later patches from multiple places.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 31 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 2fb75a7c9314..557a75115da8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -749,6 +749,20 @@ static const struct net_device_ops ethsw_port_ops = {
 	.ndo_get_phys_port_name = port_get_phys_name,
 };
 
+static bool ethsw_port_dev_check(const struct net_device *netdev,
+				 struct notifier_block *nb)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	if (netdev->netdev_ops == &ethsw_port_ops &&
+	    (!nb || &port_priv->ethsw_data->port_nb == nb ||
+	     &port_priv->ethsw_data->port_switchdev_nb == nb ||
+	     &port_priv->ethsw_data->port_switchdevb_nb == nb))
+		return true;
+
+	return false;
+}
+
 static void ethsw_links_state_update(struct ethsw_core *ethsw)
 {
 	int i;
@@ -1199,12 +1213,7 @@ static int port_bridge_leave(struct net_device *netdev)
 	return err;
 }
 
-static bool ethsw_port_dev_check(const struct net_device *netdev)
-{
-	return netdev->netdev_ops == &ethsw_port_ops;
-}
-
-static int port_netdevice_event(struct notifier_block *unused,
+static int port_netdevice_event(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
@@ -1212,7 +1221,7 @@ static int port_netdevice_event(struct notifier_block *unused,
 	struct net_device *upper_dev;
 	int err = 0;
 
-	if (!ethsw_port_dev_check(netdev))
+	if (!ethsw_port_dev_check(netdev, nb))
 		return NOTIFY_DONE;
 
 	/* Handle just upper dev link/unlink for the moment */
@@ -1280,7 +1289,7 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 }
 
 /* Called under rcu_read_lock() */
-static int port_switchdev_event(struct notifier_block *unused,
+static int port_switchdev_event(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
@@ -1289,7 +1298,7 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!ethsw_port_dev_check(dev))
+	if (!ethsw_port_dev_check(dev, nb))
 		return NOTIFY_DONE;
 
 	if (event == SWITCHDEV_PORT_ATTR_SET)
@@ -1353,12 +1362,12 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
-static int port_switchdev_blocking_event(struct notifier_block *unused,
+static int port_switchdev_blocking_event(struct notifier_block *nb,
 					 unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 
-	if (!ethsw_port_dev_check(dev))
+	if (!ethsw_port_dev_check(dev, nb))
 		return NOTIFY_DONE;
 
 	switch (event) {
-- 
2.25.1

