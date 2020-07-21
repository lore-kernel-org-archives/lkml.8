Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94FD20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgGUJTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:19:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34274 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGUJTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D70011A058B;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CAD0E1A05BD;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 95E3A202A9;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/6] staging: dpaa2-ethsw: don't allow interfaces from different DPSWs to be bridged
Date:   Tue, 21 Jul 2020 12:19:15 +0300
Message-Id: <20200721091919.20394-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error out when the user tries to bridge two switch interfaces that are
from different DPSW instances. This is not supported by the hardware and
we should reflect this into what the user is aware of.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 557a75115da8..530e4105375c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1182,6 +1182,9 @@ static int port_bridge_join(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv;
+	struct net_device *other_dev;
+	struct list_head *iter;
 	int i, err;
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
@@ -1192,6 +1195,18 @@ static int port_bridge_join(struct net_device *netdev,
 			return -EINVAL;
 		}
 
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
+		if (!ethsw_port_dev_check(other_dev, NULL))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
+			netdev_err(netdev,
+				   "Interface from a different DPSW is in the bridge already!\n");
+			return -EINVAL;
+		}
+	}
+
 	/* Enable flooding */
 	err = ethsw_port_set_flood(port_priv, 1);
 	if (!err)
-- 
2.25.1

