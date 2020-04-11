Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB557C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C4B20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648820;
	bh=i3iAFYySLdD3mRh1mYSgCukywukMtwmymqTWARDy01M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R8rEFKXpbuCvDUvdqAj+6rUbOa0G36c15kPTTNO71clK8PE6l7ggy04MIttkndBHB
	 8WbkrIZD3XzLsFH5VBhNGuBmXtvWb4eTXYQnmILBwVIBBEDg3QmsD5GPT2vQHOEPlh
	 Qly/vLZU0hirTeFpM3DE3s+dZBck+Dp2+W+4DjHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDKXFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbgDKXE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF1A20CC7;
        Sat, 11 Apr 2020 23:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646297;
        bh=i3iAFYySLdD3mRh1mYSgCukywukMtwmymqTWARDy01M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMlEp1EP89yUrODPBTm6Dl0vGKV/MBcZDRvMxIyL3iPZ1M7kNLY2inAZoTMlJ9btK
         lsPslc4hMURAvNXm9WGba4pFE7Sqpe9Yng75CSuf9O60JFRG/YeVeI3gvXwzs9pYXd
         NVvbJ+wUatI7WEKE4Tl/L6f9C4TAk3z6b8wEM4t4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brett Creeley <brett.creeley@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 057/149] ice: Fix implicit queue mapping mode in ice_vsi_get_qs
Date:   Sat, 11 Apr 2020 19:02:14 -0400
Message-Id: <20200411230347.22371-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit 39066dc549cf8a688f6e105a4e9f2a8abefbcebe ]

Currently in ice_vsi_get_qs() we set the mapping_mode for Tx and Rx to
vsi->[tx|rx]_mapping_mode, but the problem is vsi->[tx|rx]_mapping_mode
have not been set yet. This was working because ICE_VSI_MAP_CONTIG is
defined to 0. Fix this by being explicit with our mapping mode by
initializing the Tx and Rx structure's mapping_mode to
ICE_VSI_MAP_CONTIG and then setting the vsi->[tx|rx]_mapping_mode to the
[tx|rx]_qs_cfg.mapping_mode values.

Also, only assign the vsi->[tx|rx]_mapping_mode when the queues are
successfully mapped to the VSI. With this change there was no longer a
need to initialize the ret variable to 0 so remove that.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d974e2fa3e638..3353b34561119 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -433,7 +433,7 @@ static int ice_vsi_get_qs(struct ice_vsi *vsi)
 		.scatter_count = ICE_MAX_SCATTER_TXQS,
 		.vsi_map = vsi->txq_map,
 		.vsi_map_offset = 0,
-		.mapping_mode = vsi->tx_mapping_mode
+		.mapping_mode = ICE_VSI_MAP_CONTIG
 	};
 	struct ice_qs_cfg rx_qs_cfg = {
 		.qs_mutex = &pf->avail_q_mutex,
@@ -443,18 +443,21 @@ static int ice_vsi_get_qs(struct ice_vsi *vsi)
 		.scatter_count = ICE_MAX_SCATTER_RXQS,
 		.vsi_map = vsi->rxq_map,
 		.vsi_map_offset = 0,
-		.mapping_mode = vsi->rx_mapping_mode
+		.mapping_mode = ICE_VSI_MAP_CONTIG
 	};
-	int ret = 0;
-
-	vsi->tx_mapping_mode = ICE_VSI_MAP_CONTIG;
-	vsi->rx_mapping_mode = ICE_VSI_MAP_CONTIG;
+	int ret;
 
 	ret = __ice_vsi_get_qs(&tx_qs_cfg);
-	if (!ret)
-		ret = __ice_vsi_get_qs(&rx_qs_cfg);
+	if (ret)
+		return ret;
+	vsi->tx_mapping_mode = tx_qs_cfg.mapping_mode;
 
-	return ret;
+	ret = __ice_vsi_get_qs(&rx_qs_cfg);
+	if (ret)
+		return ret;
+	vsi->rx_mapping_mode = rx_qs_cfg.mapping_mode;
+
+	return 0;
 }
 
 /**
-- 
2.20.1

