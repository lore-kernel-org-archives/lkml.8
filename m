Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07A8C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E9220792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgGUJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:19:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34296 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgGUJTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25EEB1A05CC;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A2001A05BD;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D95C3202A9;
        Tue, 21 Jul 2020 11:19:31 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/6] staging: dpaa2-ethsw: setup the STP state for all installed VLANs
Date:   Tue, 21 Jul 2020 12:19:16 +0300
Message-Id: <20200721091919.20394-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the STP state for all VLANs installed on the port. This is also
avoiding the error situation when the DEFAULT_VLAN_ID is not installed
on the port (thus the firmware complains that it cannot setup the
required STP state).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 530e4105375c..83e6bd4a803b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -183,21 +183,26 @@ static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
 static int ethsw_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
 {
 	struct dpsw_stp_cfg stp_cfg = {
-		.vlan_id = DEFAULT_VLAN_ID,
 		.state = state,
 	};
 	int err;
+	u16 vid;
 
 	if (!netif_running(port_priv->netdev) || state == port_priv->stp_state)
 		return 0;	/* Nothing to do */
 
-	err = dpsw_if_set_stp(port_priv->ethsw_data->mc_io, 0,
-			      port_priv->ethsw_data->dpsw_handle,
-			      port_priv->idx, &stp_cfg);
-	if (err) {
-		netdev_err(port_priv->netdev,
-			   "dpsw_if_set_stp err %d\n", err);
-		return err;
+	for (vid = 0; vid <= VLAN_VID_MASK; vid++) {
+		if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER) {
+			stp_cfg.vlan_id = vid;
+			err = dpsw_if_set_stp(port_priv->ethsw_data->mc_io, 0,
+					      port_priv->ethsw_data->dpsw_handle,
+					      port_priv->idx, &stp_cfg);
+			if (err) {
+				netdev_err(port_priv->netdev,
+					   "dpsw_if_set_stp err %d\n", err);
+				return err;
+			}
+		}
 	}
 
 	port_priv->stp_state = state;
-- 
2.25.1

