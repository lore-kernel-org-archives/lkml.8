Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6023420792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgGUJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:19:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56076 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUJTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6A3420044D;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAF47200431;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 75AB9202A9;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/6] staging: dpaa2-ethsw: read the port state from firmware
Date:   Tue, 21 Jul 2020 12:19:18 +0300
Message-Id: <20200721091919.20394-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on the port state seen by the firmware since it will also be the
one erroring out when trying to setup anything major when the port is
up.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 9114437645a8..c6885912c60b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -43,6 +43,25 @@ static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 	return 0;
 }
 
+static bool ethsw_port_is_up(struct ethsw_port_priv *port_priv)
+{
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_link_state state;
+	int err;
+
+	err = dpsw_if_get_link_state(port_priv->ethsw_data->mc_io, 0,
+				     port_priv->ethsw_data->dpsw_handle,
+				     port_priv->idx, &state);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_get_link_state() err %d\n", err);
+		return true;
+	}
+
+	WARN_ONCE(state.up > 1, "Garbage read into link_state");
+
+	return state.up ? true : false;
+}
+
 static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -61,7 +80,7 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	tci_cfg.vlan_id = pvid;
 
 	/* Interface needs to be down to change PVID */
-	up = netif_running(netdev);
+	up = ethsw_port_is_up(port_priv);
 	if (up) {
 		err = dpsw_if_disable(ethsw->mc_io, 0,
 				      ethsw->dpsw_handle,
-- 
2.25.1

