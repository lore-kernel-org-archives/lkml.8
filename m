Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54463C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E32068F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHETTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:19:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgHER5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:57:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3KK5-0004Gk-Ej; Wed, 05 Aug 2020 14:23:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: fix a handful of spelling mistakes
Date:   Wed,  5 Aug 2020 15:23:17 +0100
Message-Id: <20200805142317.23845-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are various spelling mistakes in comments and error messages.
Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wfx/data_rx.c | 2 +-
 drivers/staging/wfx/data_tx.c | 2 +-
 drivers/staging/wfx/debug.c   | 4 ++--
 drivers/staging/wfx/hif_rx.c  | 2 +-
 drivers/staging/wfx/hif_tx.c  | 4 ++--
 drivers/staging/wfx/main.c    | 2 +-
 drivers/staging/wfx/main.h    | 2 +-
 drivers/staging/wfx/sta.c     | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index 6fb078880742..7fcbbfc53416 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -73,7 +73,7 @@ void wfx_rx_cb(struct wfx_vif *wvif,
 	if (arg->rx_flags.encryp)
 		hdr->flag |= RX_FLAG_DECRYPTED;
 
-	// Block ack negociation is offloaded by the firmware. However,
+	// Block ack negotiation is offloaded by the firmware. However,
 	// re-ordering must be done by the mac80211.
 	if (ieee80211_is_action(frame->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index 3acf4eb0214d..41f9afd41e14 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -234,7 +234,7 @@ static void wfx_tx_fixup_rates(struct ieee80211_tx_rate *rates)
 	int i;
 	bool finished;
 
-	// Firmware is not able to mix rates with differents flags
+	// Firmware is not able to mix rates with different flags
 	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
 		if (rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
 			rates[i].flags |= IEEE80211_TX_RC_SHORT_GI;
diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 3f1712b7c919..e396f18747d1 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -267,7 +267,7 @@ static ssize_t wfx_send_hif_msg_write(struct file *file,
 	if (count < sizeof(struct hif_msg))
 		return -EINVAL;
 
-	// wfx_cmd_send() chekc that reply buffer is wide enough, but do not
+	// wfx_cmd_send() checks that reply buffer is wide enough, but does not
 	// return precise length read. User have to know how many bytes should
 	// be read. Filling reply buffer with a memory pattern may help user.
 	memset(context->reply, 0xFF, sizeof(context->reply));
@@ -299,7 +299,7 @@ static ssize_t wfx_send_hif_msg_read(struct file *file, char __user *user_buf,
 		return ret;
 	if (context->ret < 0)
 		return context->ret;
-	// Be carefull, write() is waiting for a full message while read()
+	// Be careful, write() is waiting for a full message while read()
 	// only return a payload
 	if (copy_to_user(user_buf, context->reply, count))
 		return -EFAULT;
diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index cc7c0cf226ba..1d32973d8ec1 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -118,7 +118,7 @@ static int hif_keys_indication(struct wfx_dev *wdev,
 
 	// SL_PUB_KEY_EXCHANGE_STATUS_SUCCESS is used by legacy secure link
 	if (body->status && body->status != HIF_STATUS_SLK_NEGO_SUCCESS)
-		dev_warn(wdev->dev, "secure link negociation error\n");
+		dev_warn(wdev->dev, "secure link negotiation error\n");
 	memcpy(pubkey, body->ncp_pub_key, sizeof(pubkey));
 	memreverse(pubkey, sizeof(pubkey));
 	wfx_sl_check_pubkey(wdev, pubkey, body->ncp_pub_key_mac);
diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 5110f9b93762..11fbdb5fcecc 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -78,7 +78,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
 
 	wfx_bh_request_tx(wdev);
 
-	// NOTE: no timeout is catched async is enabled
+	// NOTE: no timeout is caught async is enabled
 	if (async)
 		return 0;
 
@@ -125,7 +125,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
 
 // This function is special. After HIF_REQ_ID_SHUT_DOWN, chip won't reply to any
 // request anymore. We need to slightly hack struct wfx_hif_cmd for that job. Be
-// carefull to only call this funcion during device unregister.
+// carefull to only call this function during device unregister.
 int hif_shutdown(struct wfx_dev *wdev)
 {
 	int ret;
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 11dfa088fc86..4263f912760b 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -384,7 +384,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	err = wfx_sl_init(wdev);
 	if (err && wdev->hw_caps.capabilities.link_mode == SEC_LINK_ENFORCED) {
 		dev_err(wdev->dev,
-			"chip require secure_link, but can't negociate it\n");
+			"chip require secure_link, but can't negotiate it\n");
 		goto err0;
 	}
 
diff --git a/drivers/staging/wfx/main.h b/drivers/staging/wfx/main.h
index c59d375dd3ad..63138777e72a 100644
--- a/drivers/staging/wfx/main.h
+++ b/drivers/staging/wfx/main.h
@@ -19,7 +19,7 @@ struct wfx_dev;
 struct hwbus_ops;
 
 struct wfx_platform_data {
-	/* Keyset and ".sec" extention will appended to this string */
+	/* Keyset and ".sec" extension will appended to this string */
 	const char *file_fw;
 	const char *file_pds;
 	struct gpio_desc *gpio_wakeup;
diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 4e30ab17a93d..ad63332f690c 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -214,7 +214,7 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 	if (chan0 && chan1 && chan0->hw_value != chan1->hw_value &&
 	    wvif->vif->type != NL80211_IFTYPE_AP) {
 		// It is necessary to enable powersave if channels
-		// are differents.
+		// are different.
 		if (enable_ps)
 			*enable_ps = true;
 		if (wvif->wdev->force_ps_timeout > -1)
-- 
2.27.0

