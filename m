Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BAEC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B522076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6+ewChR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgDVPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:39:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08223C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:39:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so1270443pfx.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OSzsOQN8Z1q5Ww0pPBotbwJfApA1ur1KHIVoOxI4Rrw=;
        b=g6+ewChR1dfm8d7rbsEaXxVVw8tca9f8lcTqPwL2DHu8RVOvpgak8FFsHJXn+8zdJS
         TQomHYy5JEP16wiHIJhMl/Yc9H4L53lH3a+NN0gwQHA/cUPbTgdjfbnOGoV06w85VQko
         FYaEXTatbcNneu451BucAl8GA6y4rDMBGfp91F2ct/NmwErVYA1PrgbKsdrsecqH5zZU
         IxhBj6rybFoKPmm1hwe7/vSczGLbji8kQOFjcmwVrdQeWXO4Srz8afR2NfWbPjNGY26L
         wj5sCPFs3NaCS/iFMIKPuks34mkZf/24JcUzlwl0af5LMGlXQj2cLmxEK582nA5xD1b2
         uz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OSzsOQN8Z1q5Ww0pPBotbwJfApA1ur1KHIVoOxI4Rrw=;
        b=ucAXY4lKNg40F0CfGRTshI2T7Z2DKWcrHgNTCVKaNXq/qnMEcuP6+5VlyIWYT60XXb
         K59UKGTNzv+nEr6H+2cujI8mRjIBISzH0jNAmScIU9w+DuetGLhPZoc3W5PKjG9y+8tD
         PLIo3LZhyN5u4yJ7VKVK7u0CAqDO1pICpDlZ0vq262n0/XrUsRSA04SsD8zLva8oKG0Q
         t+uWYW6jS5XCSZ/gyPtPwiKTPfdWhW8nmZG8zc7M1DWs54ErnFS0PjYZIVyw6EbJTuaz
         XHnVj/iz51//Hj0xlYyLqylJnB2M1pEx3d1nhYN13Mbdly/J3r1+6ZM5FLjFL8h7Uzu+
         K4jg==
X-Gm-Message-State: AGi0PuaY0Je5ljETQpjIKfIsRVC6CE7bkyiXVdTbXPyIQYLaYdqURMHS
        lxtmuY+4dJsxkiYQaOqFpTQ=
X-Google-Smtp-Source: APiQypI3c0dky0npRWJ2vqUNhjgaVx/d2aoSqIAgxb9oK5DJxVFZ+N0yGfof2GL4IhuULOChQShSDA==
X-Received: by 2002:a63:e607:: with SMTP id g7mr26503214pgh.303.1587569956501;
        Wed, 22 Apr 2020 08:39:16 -0700 (PDT)
Received: from blackclown ([182.70.139.46])
        by smtp.gmail.com with ESMTPSA id m14sm5358050pgk.56.2020.04.22.08.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 08:39:15 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:09:00 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200422153900.GA6184@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break lines with length over 80 characters to conform
to the linux coding style. Issue found by checkpatch.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/data_tx.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index c30e4f5b6e2d..85ad94de20e5 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -165,7 +165,8 @@ static int wfx_tx_policy_upload(struct wfx_vif *wvif)
 		spin_lock_bh(&wvif->tx_policy_cache.lock);
 		for (i = 0; i < HIF_TX_RETRY_POLICY_MAX; ++i)
 			if (!policies[i].uploaded &&
-			    memzcmp(policies[i].rates, sizeof(policies[i].rates)))
+			    memzcmp(policies[i].rates,
+				    sizeof(policies[i].rates)))
 				break;
 		if (i < HIF_TX_RETRY_POLICY_MAX) {
 			policies[i].uploaded = true;
@@ -290,7 +291,8 @@ static void wfx_tx_fixup_rates(struct ieee80211_tx_rate *rates)
 		if (rates[i].idx == -1) {
 			rates[i].idx = 0;
 			rates[i].count = 8; // == hw->max_rate_tries
-			rates[i].flags = rates[i - 1].flags & IEEE80211_TX_RC_MCS;
+			rates[i].flags = rates[i - 1].flags &
+					 IEEE80211_TX_RC_MCS;
 			break;
 		}
 	}
@@ -318,7 +320,9 @@ static u8 wfx_tx_get_rate_id(struct wfx_vif *wvif,
 	return rate_id;
 }
 
-static struct hif_ht_tx_parameters wfx_tx_get_tx_parms(struct wfx_dev *wdev, struct ieee80211_tx_info *tx_info)
+static struct
+hif_ht_tx_parameters wfx_tx_get_tx_parms(struct wfx_dev *wdev,
+					 struct ieee80211_tx_info *tx_info)
 {
 	struct ieee80211_tx_rate *rate = &tx_info->driver_rates[0];
 	struct hif_ht_tx_parameters ret = { };
@@ -381,7 +385,8 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 	hif_msg->id = HIF_REQ_ID_TX;
 	hif_msg->interface = wvif->id;
 	if (skb->len > wvif->wdev->hw_caps.size_inp_ch_buf) {
-		dev_warn(wvif->wdev->dev, "requested frame size (%d) is larger than maximum supported (%d)\n",
+		dev_warn(wvif->wdev->dev,
+			 "requested frame size (%d) is larger than maximum supported (%d)\n",
 			 skb->len, wvif->wdev->hw_caps.size_inp_ch_buf);
 		skb_pull(skb, wmsg_len);
 		return -EIO;
@@ -394,7 +399,8 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 	// data for debug.
 	req->packet_id = queue_id << 28 |
 			 IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl)) << 16 |
-			 (atomic_add_return(1, &wvif->wdev->packet_id) & 0xFFFF);
+			 (atomic_add_return(1, &wvif->wdev->packet_id) &
+			  0xFFFF);
 	req->data_flags.fc_offset = offset;
 	if (tx_info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM)
 		req->data_flags.after_dtim = 1;
@@ -517,7 +523,8 @@ void wfx_tx_confirm_cb(struct wfx_vif *wvif, const struct hif_cnf_tx *arg)
 		if (tx_count < rate->count &&
 		    arg->status == HIF_STATUS_RETRY_EXCEEDED &&
 		    arg->ack_failures)
-			dev_dbg(wvif->wdev->dev, "all retries were not consumed: %d != %d\n",
+			dev_dbg(wvif->wdev->dev,
+				"all retries were not consumed: %d != %d\n",
 				rate->count, tx_count);
 		if (tx_count <= rate->count && tx_count &&
 		    arg->txed_rate != wfx_get_hw_rate(wvif->wdev, rate))
@@ -557,7 +564,8 @@ void wfx_tx_confirm_cb(struct wfx_vif *wvif, const struct hif_cnf_tx *arg)
 		else
 			tx_info->flags |= IEEE80211_TX_STAT_ACK;
 	} else if (arg->status == HIF_REQUEUE) {
-		WARN(!arg->tx_result_flags.requeue, "incoherent status and result_flags");
+		WARN(!arg->tx_result_flags.requeue,
+		     "incoherent status and result_flags");
 		if (tx_info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM) {
 			wvif->after_dtim_tx_allowed = false; // DTIM period elapsed
 			schedule_work(&wvif->update_tim_work);
@@ -595,7 +603,8 @@ void wfx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		if (wait_event_timeout(wdev->tx_dequeue,
 				       wfx_tx_queue_empty(wdev, queue, vif_id),
 				       msecs_to_jiffies(1000)) <= 0)
-			dev_warn(wdev->dev, "frames queued while flushing tx queues?");
+			dev_warn(wdev->dev,
+				 "frames queued while flushing tx queues?");
 	}
 	wfx_tx_flush(wdev);
 	if (wdev->chip_frozen)
-- 
2.17.1

