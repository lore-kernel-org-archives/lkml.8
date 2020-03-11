Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F5C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0071C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgCKFHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:49 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:52618 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgCKFHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 45D6C841B;
        Wed, 11 Mar 2020 05:07:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fuel84_2627d25592301
X-Filterd-Recvd-Size: 5022
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:42 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 028/491] BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:42 -0700
Message-Id: <dc611bfdc1f2f77aa7ddda8b91d12e03541ccba5.1583896349.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 14 +++++++-------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  6 ++----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 9638d65..07bc87 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -4708,14 +4708,14 @@ static void bnx2x_sync_link(struct link_params *params,
 			LINK_STATUS_SPEED_AND_DUPLEX_MASK) {
 		case LINK_10THD:
 			vars->duplex = DUPLEX_HALF;
-			/* Fall thru */
+			fallthrough;
 		case LINK_10TFD:
 			vars->line_speed = SPEED_10;
 			break;
 
 		case LINK_100TXHD:
 			vars->duplex = DUPLEX_HALF;
-			/* Fall thru */
+			fallthrough;
 		case LINK_100T4:
 		case LINK_100TXFD:
 			vars->line_speed = SPEED_100;
@@ -4723,14 +4723,14 @@ static void bnx2x_sync_link(struct link_params *params,
 
 		case LINK_1000THD:
 			vars->duplex = DUPLEX_HALF;
-			/* Fall thru */
+			fallthrough;
 		case LINK_1000TFD:
 			vars->line_speed = SPEED_1000;
 			break;
 
 		case LINK_2500THD:
 			vars->duplex = DUPLEX_HALF;
-			/* Fall thru */
+			fallthrough;
 		case LINK_2500TFD:
 			vars->line_speed = SPEED_2500;
 			break;
@@ -6335,7 +6335,7 @@ int bnx2x_set_led(struct link_params *params,
 		 */
 		if (!vars->link_up)
 			break;
-		/* fall through */
+		fallthrough;
 	case LED_MODE_ON:
 		if (((params->phy[EXT_PHY1].type ==
 			  PORT_HW_CFG_XGXS_EXT_PHY_TYPE_BCM8727) ||
@@ -12503,13 +12503,13 @@ static void bnx2x_phy_def_cfg(struct link_params *params,
 	switch (link_config  & PORT_FEATURE_LINK_SPEED_MASK) {
 	case PORT_FEATURE_LINK_SPEED_10M_HALF:
 		phy->req_duplex = DUPLEX_HALF;
-		/* fall through */
+		fallthrough;
 	case PORT_FEATURE_LINK_SPEED_10M_FULL:
 		phy->req_line_speed = SPEED_10;
 		break;
 	case PORT_FEATURE_LINK_SPEED_100M_HALF:
 		phy->req_duplex = DUPLEX_HALF;
-		/* fall through */
+		fallthrough;
 	case PORT_FEATURE_LINK_SPEED_100M_FULL:
 		phy->req_line_speed = SPEED_100;
 		break;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index db5107e7..d0580d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8583,12 +8583,10 @@ int bnx2x_set_int_mode(struct bnx2x *bp)
 		BNX2X_DEV_INFO("Failed to enable multiple MSI-X (%d), set number of queues to %d\n",
 			       bp->num_queues,
 			       1 + bp->num_cnic_queues);
-
-		/* fall through */
+		fallthrough;
 	case BNX2X_INT_MODE_MSI:
 		bnx2x_enable_msi(bp);
-
-		/* fall through */
+		fallthrough;
 	case BNX2X_INT_MODE_INTX:
 		bp->num_ethernet_queues = 1;
 		bp->num_queues = bp->num_ethernet_queues + bp->num_cnic_queues;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 5097a44..eeaeb9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -1830,7 +1830,7 @@ int bnx2x_iov_eq_sp_event(struct bnx2x *bp, union event_ring_elem *elem)
 		DP(BNX2X_MSG_IOV, "got VF [%d:%d] RSS update ramrod\n",
 		   vf->abs_vfid, qidx);
 		bnx2x_vf_handle_rss_update_eqe(bp, vf);
-		/* fall through */
+		fallthrough;
 	case EVENT_RING_OPCODE_VF_FLR:
 		/* Do nothing for now */
 		return 0;
@@ -2228,7 +2228,7 @@ int bnx2x_vf_free(struct bnx2x *bp, struct bnx2x_virtf *vf)
 		rc = bnx2x_vf_close(bp, vf);
 		if (rc)
 			goto op_err;
-		/* Fall through - to release resources */
+		fallthrough;	/* to release resources */
 	case VF_ACQUIRED:
 		DP(BNX2X_MSG_IOV, "about to free resources\n");
 		bnx2x_vf_free_resc(bp, vf);
-- 
2.24.0

