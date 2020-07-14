Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CCC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A8B224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGNNfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:35:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49972 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgGNNfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:35:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 11A481A01FC;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 052921A01E7;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C18EA205A4;
        Tue, 14 Jul 2020 15:35:15 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/6] staging: dpaa2-ethsw: use netif_running when checking for port up
Date:   Tue, 14 Jul 2020 16:34:28 +0300
Message-Id: <20200714133431.17532-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714133431.17532-1-ioana.ciornei@nxp.com>
References: <20200714133431.17532-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cases where the switch interface needs to be disabled so
that changes in the configuration can be made. In such cases, we should
check for a running interface (bit __LINK_STATE_START of the netdev)
instead of netif_carrier_ok(). This is because on open() we enable the
switch interface even though the link up has not come out yet.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b57bc705c2ee..a1917842536e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -48,7 +48,7 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
 	struct dpsw_tci_cfg tci_cfg = { 0 };
-	bool is_oper;
+	bool up;
 	int err, ret;
 
 	err = dpsw_if_get_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
@@ -61,8 +61,8 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	tci_cfg.vlan_id = pvid;
 
 	/* Interface needs to be down to change PVID */
-	is_oper = netif_oper_up(netdev);
-	if (is_oper) {
+	up = netif_running(netdev);
+	if (up) {
 		err = dpsw_if_disable(ethsw->mc_io, 0,
 				      ethsw->dpsw_handle,
 				      port_priv->idx);
@@ -85,7 +85,7 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	port_priv->pvid = pvid;
 
 set_tci_error:
-	if (is_oper) {
+	if (up) {
 		ret = dpsw_if_enable(ethsw->mc_io, 0,
 				     ethsw->dpsw_handle,
 				     port_priv->idx);
@@ -188,7 +188,7 @@ static int ethsw_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
 	};
 	int err;
 
-	if (!netif_oper_up(port_priv->netdev) || state == port_priv->stp_state)
+	if (!netif_running(port_priv->netdev) || state == port_priv->stp_state)
 		return 0;	/* Nothing to do */
 
 	err = dpsw_if_set_stp(port_priv->ethsw_data->mc_io, 0,
-- 
2.25.1

