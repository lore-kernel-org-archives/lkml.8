Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BFC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68822087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864830;
	bh=4OA7kUrZaNurgiX5nYQOyeOhA/9mphDoYCJnrYjJUGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rt4an2bIwVldPmuSxh9iMnkGDfDfG2/4OqLuO6o7x/bXQ9HwiBiGtaHWrA/6DR+oH
	 PuqNF4fMn90fHd67UCBApy+vimW0NyoNy/O1cyzvNASfKpu60Bkn+DcW1pjHg/5Dd2
	 g9tv1pHvizIdJK6MTL+QB/tB222zsP35TKg1KBbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbgAXLU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390894AbgAXLU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:20:26 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB5920704;
        Fri, 24 Jan 2020 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864826;
        bh=4OA7kUrZaNurgiX5nYQOyeOhA/9mphDoYCJnrYjJUGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csT/dqkbdrSqTZFGOIuKiQVdkdv13cwgvSoWu/zD6V1DD7qMvIjdOBoLUS6s/55Sr
         510GNCKuPeJIbkdRCUlBzGcS5c0BswdM/uIVhzV9Kjydscq1L8ZRkMQ3bUvBWX0VTw
         hm+l8acYTWQPjkCNVDlfszLoNmMFqme6ouP/sXvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 353/639] ath10k: Fix encoding for protected management frames
Date:   Fri, 24 Jan 2020 10:28:43 +0100
Message-Id: <20200124093131.329737684@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

[ Upstream commit 42f1bc43e6a97b9ddbe976eba9bd05306c990c75 ]

Currently the protected management frames are
not appended with the MIC_LEN which results in
the protected management frames being encoded
incorrectly.

Add the extra space at the end of the protected
management frames to fix this encoding error for
the protected management frames.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index a90990b8008de..248decb494c28 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2692,8 +2692,10 @@ ath10k_wmi_tlv_op_gen_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
 	if ((ieee80211_is_action(hdr->frame_control) ||
 	     ieee80211_is_deauth(hdr->frame_control) ||
 	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control))
+	     ieee80211_has_protected(hdr->frame_control)) {
+		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
 		buf_len += IEEE80211_CCMP_MIC_LEN;
+	}
 
 	buf_len = min_t(u32, buf_len, WMI_TLV_MGMT_TX_FRAME_MAX_LEN);
 	buf_len = round_up(buf_len, 4);
-- 
2.20.1



