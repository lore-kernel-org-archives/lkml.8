Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B3C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B720684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198389;
	bh=LW2F/jHELeJRFD9QL7sp0B9QATRcwZeOVrASKbhON6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMqHW3w1iRNxbMYYpNb40v4pQtrNmPE/6FqXRk9fOtxZ+MI8xrKZRlqYqseiXDy1f
	 b1ueHQPk123Nqtx6tfKQlfLNVMcEf42z8I74cSOMNAsDqXVZ5cjNYauGG+YrnI7w0w
	 t7ODqOSUv4xCe3LCZs9t69/nPPUKHxuDX/ujuYzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405175AbgAPRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405211AbgAPRgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:36:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59162246C5;
        Thu, 16 Jan 2020 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196211;
        bh=LW2F/jHELeJRFD9QL7sp0B9QATRcwZeOVrASKbhON6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Im8+VoS+bdZ5csWX+o0KtkdzgegB0jr3fCQN3ScN5ancrjaPKeh1oIfDbERxlforz
         VHdfNK3NYtomdeaByE00NZOh4UEUhFfyUWaxWYihcLvLEV8H12Lptj025VORgqaFcU
         EAS1i1Kz+5GAhR5zV9wz5sf6wgTY2lMtnZxxogsk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Danny Alexander <danny.alexander@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 047/251] iwlwifi: mvm: fix A-MPDU reference assignment
Date:   Thu, 16 Jan 2020 12:33:16 -0500
Message-Id: <20200116173641.22137-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1f7698abedeeb3fef3cbcf78e16f925df675a179 ]

The current code assigns the reference, and then goes to increment
it if the toggle bit has changed. That way, we get

Toggle  0  0  0  0  1  1  1  1
ID      1  1  1  1  1  2  2  2

Fix that by assigning the post-toggle ID to get

Toggle  0  0  0  0  1  1  1  1
ID      1  1  1  1  2  2  2  2

Reported-by: Danny Alexander <danny.alexander@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: fbe4112791b8 ("iwlwifi: mvm: update mpdu metadata API")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c2bbc8c17beb..bc06d87a0106 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -810,12 +810,12 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		bool toggle_bit = phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
 
 		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
-		rx_status->ampdu_reference = mvm->ampdu_ref;
 		/* toggle is switched whenever new aggregation starts */
 		if (toggle_bit != mvm->ampdu_toggle) {
 			mvm->ampdu_ref++;
 			mvm->ampdu_toggle = toggle_bit;
 		}
+		rx_status->ampdu_reference = mvm->ampdu_ref;
 	}
 
 	rcu_read_lock();
-- 
2.20.1

