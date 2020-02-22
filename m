Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2D5C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0FF20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBVRLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:11:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBVRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:11:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5YIp-00056G-1O; Sat, 22 Feb 2020 17:10:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ice: remove redundant assignment to pointer vsi
Date:   Sat, 22 Feb 2020 17:10:54 +0000
Message-Id: <20200222171054.171505-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer vsi is being re-assigned a value that is never read,
the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 169b72a94b9d..2c8e334c47a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2191,7 +2191,6 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		set_bit(vf_q_id, vf->rxq_ena);
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_BASE_QS_PER_VF) {
 		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
-- 
2.25.0

