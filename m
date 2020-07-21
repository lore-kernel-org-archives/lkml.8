Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F69C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA72D20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgGUJTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:19:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56092 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUJTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05BBE200854;
        Tue, 21 Jul 2020 11:19:33 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDDBE200431;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B8F3B202A9;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 6/6] staging: dpaa2-ethsw: check if there is space for a new VLAN
Date:   Tue, 21 Jul 2020 12:19:19 +0300
Message-Id: <20200721091919.20394-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid getting into a WARNING as below by checking, while in the prepare
state of the transactional operation, if there is space for a new VLAN.
If we reached the maximum number, return an appropriate error.

[ 6503.657564] eth3: Commit of object (id=1) failed.
[ 6503.657588] WARNING: CPU: 2 PID: 17144 at net/switchdev/switchdev.c:277 switchdev_port_obj_add_now+0xcc/0x110
...
[ 6503.657628] x1 : 70887ce26695c500 x0 : 0000000000000000
[ 6503.657630] Call trace:
[ 6503.657633]  switchdev_port_obj_add_now+0xcc/0x110
[ 6503.657635]  switchdev_port_obj_add+0x40/0xc0
[ 6503.657638]  br_switchdev_port_vlan_add+0x50/0x78
[ 6503.657640]  __vlan_add+0x2dc/0x758
[ 6503.657642]  nbp_vlan_add+0xc0/0x180
[ 6503.657644]  br_vlan_info.isra.0+0x68/0x128
[ 6503.657646]  br_process_vlan_info+0x224/0x2f8
[ 6503.657647]  br_afspec+0x158/0x188
[ 6503.657649]  br_setlink+0x1a4/0x290

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c6885912c60b..19fc0401e261 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -979,10 +979,27 @@ static int port_vlans_add(struct net_device *netdev,
 			  struct switchdev_trans *trans)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	int vid, err = 0;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpsw_attr *attr = &ethsw->sw_attr;
+	int vid, err = 0, new_vlans = 0;
+
+	if (switchdev_trans_ph_prepare(trans)) {
+		for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++)
+			if (!port_priv->ethsw_data->vlans[vid])
+				new_vlans++;
+
+		/* Check if there is space for a new VLAN */
+		err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					  &ethsw->sw_attr);
+		if (err) {
+			netdev_err(netdev, "dpsw_get_attributes err %d\n", err);
+			return err;
+		}
+		if (attr->max_vlans - attr->num_vlans < new_vlans)
+			return -ENOSPC;
 
-	if (switchdev_trans_ph_prepare(trans))
 		return 0;
+	}
 
 	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
 		if (!port_priv->ethsw_data->vlans[vid]) {
-- 
2.25.1

