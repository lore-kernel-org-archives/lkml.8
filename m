Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0C0206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZWd/qtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgF2ViV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgF2Vho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:37:44 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFFC03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:37:44 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c16so18803754ioi.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3I76P37Yz2wf4pLUPaNpx3FXvV0p8jPdg/DBK+vqw3Q=;
        b=GZWd/qtlc+92FjMe/OMEp2bIn0RAaMb+EeHyk6vppCzb085oe1L6NG+NgY0/Vz8ybB
         ZVXyWeltVBqIzzAOme9mNQjf+d8a0Q7PcjtfiKXNSXqG+AE62c09mGCnYaz7k91QPJBz
         0uAY7NtwK6oTExqGJYYguVLlODHcdsXrag/TiriZuwAA/ty+FTsYEG6eBWkIQCqdpHsj
         RDpL9IMB4aUb3XRz3XZdO2ZlvY/udBEUmD55/5iw8mhaQm+Id7o9zu+HaNq2AAG5bLpB
         5rUPu2mUbTWW+G6p3nJNLqSdWilR5KI1cq/eMtXBGbUpeIQuSI+z0kRuGbYHQypeSwyR
         swdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3I76P37Yz2wf4pLUPaNpx3FXvV0p8jPdg/DBK+vqw3Q=;
        b=I/9luN2YhCSuJS4q1Vhp63xdY13rvJi2TaSUPTSKFTrY9C4NXfyk6Cesk/q0v3Rmiv
         CT1Z20n7r/9bCg0yMvB/xBcPxYhrKWCTUi1K1EWcCgQbn6AZaduzRNgazXpnDdgrciJv
         EFO4rQ+25hpmYc5MC51vDzTG+jbmTrV4YQvszeg6F7qghGaGjtLh5xx2pd4AYvvbty2A
         hd1fEJppGo8q8E01Fg6JvpB8bej/02s/jBlJsLF4L5VeV465SsZi+4IjYmK/jXX1A5pB
         SQjpyxyyv3JHxh2TeZARv9zTxfAlm1i56DopB9V7klqHc2r02+mMQbrvQsNKB6Nk5DZq
         8ijg==
X-Gm-Message-State: AOAM532nzIs8z9N6RfAu7PTwm4kMzfcNLeX3BTlG3snF/yGR5y9ropD8
        wP1Wdufg/3cJcrhz2f8tbdZOTw==
X-Google-Smtp-Source: ABdhPJyI5WhewIb4jHcE1fDjCf/mXvO4wP6i+SfwrhN3JqRZDw7gomj86EHSwfm2LZTvcvXd+SbMgQ==
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr9163980jat.43.1593466663340;
        Mon, 29 Jun 2020 14:37:43 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u6sm571353ilg.32.2020.06.29.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:37:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: ipa: always report GSI state errors
Date:   Mon, 29 Jun 2020 16:37:36 -0500
Message-Id: <20200629213738.1180618-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629213738.1180618-1-elder@linaro.org>
References: <20200629213738.1180618-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We check the state of an event ring or channel both before and after
any GSI command issued that will change that state.  In most--but
not all--cases, if the state is something different than expected we
report an error message.

Add error messages where missing, so that all unexpected states
provide information about what went wrong.  Drop the parentheses
around the state value shown in all cases.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 54 ++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 55226b264e3c..7e4e54ee09b1 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -358,13 +358,15 @@ static int gsi_evt_ring_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 
 	/* Get initial event ring state */
 	evt_ring->state = gsi_evt_ring_state(gsi, evt_ring_id);
-
-	if (evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED)
+	if (evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED) {
+		dev_err(gsi->dev, "bad event ring state %u before alloc\n",
+			evt_ring->state);
 		return -EINVAL;
+	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
 	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
-		dev_err(gsi->dev, "bad event ring state (%u) after alloc\n",
+		dev_err(gsi->dev, "bad event ring state %u after alloc\n",
 			evt_ring->state);
 		ret = -EIO;
 	}
@@ -381,14 +383,14 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 
 	if (state != GSI_EVT_RING_STATE_ALLOCATED &&
 	    state != GSI_EVT_RING_STATE_ERROR) {
-		dev_err(gsi->dev, "bad event ring state (%u) before reset\n",
+		dev_err(gsi->dev, "bad event ring state %u before reset\n",
 			evt_ring->state);
 		return;
 	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
 	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED)
-		dev_err(gsi->dev, "bad event ring state (%u) after reset\n",
+		dev_err(gsi->dev, "bad event ring state %u after reset\n",
 			evt_ring->state);
 }
 
@@ -399,14 +401,14 @@ static void gsi_evt_ring_de_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 	int ret;
 
 	if (evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
-		dev_err(gsi->dev, "bad event ring state (%u) before dealloc\n",
+		dev_err(gsi->dev, "bad event ring state %u before dealloc\n",
 			evt_ring->state);
 		return;
 	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
 	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED)
-		dev_err(gsi->dev, "bad event ring state (%u) after dealloc\n",
+		dev_err(gsi->dev, "bad event ring state %u after dealloc\n",
 			evt_ring->state);
 }
 
@@ -448,21 +450,23 @@ gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 static int gsi_channel_alloc_command(struct gsi *gsi, u32 channel_id)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct device *dev = gsi->dev;
 	enum gsi_channel_state state;
 	int ret;
 
 	/* Get initial channel state */
 	state = gsi_channel_state(channel);
-	if (state != GSI_CHANNEL_STATE_NOT_ALLOCATED)
+	if (state != GSI_CHANNEL_STATE_NOT_ALLOCATED) {
+		dev_err(dev, "bad channel state %u before alloc\n", state);
 		return -EINVAL;
+	}
 
 	ret = gsi_channel_command(channel, GSI_CH_ALLOCATE);
 
 	/* Channel state will normally have been updated */
 	state = gsi_channel_state(channel);
 	if (!ret && state != GSI_CHANNEL_STATE_ALLOCATED) {
-		dev_err(gsi->dev, "bad channel state (%u) after alloc\n",
-			state);
+		dev_err(dev, "bad channel state %u after alloc\n", state);
 		ret = -EIO;
 	}
 
@@ -472,21 +476,23 @@ static int gsi_channel_alloc_command(struct gsi *gsi, u32 channel_id)
 /* Start an ALLOCATED channel */
 static int gsi_channel_start_command(struct gsi_channel *channel)
 {
+	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
 	int ret;
 
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_ALLOCATED &&
-	    state != GSI_CHANNEL_STATE_STOPPED)
+	    state != GSI_CHANNEL_STATE_STOPPED) {
+		dev_err(dev, "bad channel state %u before start\n", state);
 		return -EINVAL;
+	}
 
 	ret = gsi_channel_command(channel, GSI_CH_START);
 
 	/* Channel state will normally have been updated */
 	state = gsi_channel_state(channel);
 	if (!ret && state != GSI_CHANNEL_STATE_STARTED) {
-		dev_err(channel->gsi->dev,
-			"bad channel state (%u) after start\n", state);
+		dev_err(dev, "bad channel state %u after start\n", state);
 		ret = -EIO;
 	}
 
@@ -496,13 +502,16 @@ static int gsi_channel_start_command(struct gsi_channel *channel)
 /* Stop a GSI channel in STARTED state */
 static int gsi_channel_stop_command(struct gsi_channel *channel)
 {
+	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
 	int ret;
 
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_STARTED &&
-	    state != GSI_CHANNEL_STATE_STOP_IN_PROC)
+	    state != GSI_CHANNEL_STATE_STOP_IN_PROC) {
+		dev_err(dev, "bad channel state %u before stop\n", state);
 		return -EINVAL;
+	}
 
 	ret = gsi_channel_command(channel, GSI_CH_STOP);
 
@@ -515,8 +524,7 @@ static int gsi_channel_stop_command(struct gsi_channel *channel)
 	if (state == GSI_CHANNEL_STATE_STOP_IN_PROC)
 		return -EAGAIN;
 
-	dev_err(channel->gsi->dev,
-		"bad channel state (%u) after stop\n", state);
+	dev_err(dev, "bad channel state %u after stop\n", state);
 
 	return -EIO;
 }
@@ -524,6 +532,7 @@ static int gsi_channel_stop_command(struct gsi_channel *channel)
 /* Reset a GSI channel in ALLOCATED or ERROR state. */
 static void gsi_channel_reset_command(struct gsi_channel *channel)
 {
+	struct device *dev = channel->gsi->dev;
 	enum gsi_channel_state state;
 	int ret;
 
@@ -532,8 +541,7 @@ static void gsi_channel_reset_command(struct gsi_channel *channel)
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_STOPPED &&
 	    state != GSI_CHANNEL_STATE_ERROR) {
-		dev_err(channel->gsi->dev,
-			"bad channel state (%u) before reset\n", state);
+		dev_err(dev, "bad channel state %u before reset\n", state);
 		return;
 	}
 
@@ -542,21 +550,20 @@ static void gsi_channel_reset_command(struct gsi_channel *channel)
 	/* Channel state will normally have been updated */
 	state = gsi_channel_state(channel);
 	if (!ret && state != GSI_CHANNEL_STATE_ALLOCATED)
-		dev_err(channel->gsi->dev,
-			"bad channel state (%u) after reset\n", state);
+		dev_err(dev, "bad channel state %u after reset\n", state);
 }
 
 /* Deallocate an ALLOCATED GSI channel */
 static void gsi_channel_de_alloc_command(struct gsi *gsi, u32 channel_id)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct device *dev = gsi->dev;
 	enum gsi_channel_state state;
 	int ret;
 
 	state = gsi_channel_state(channel);
 	if (state != GSI_CHANNEL_STATE_ALLOCATED) {
-		dev_err(gsi->dev,
-			"bad channel state (%u) before dealloc\n", state);
+		dev_err(dev, "bad channel state %u before dealloc\n", state);
 		return;
 	}
 
@@ -565,8 +572,7 @@ static void gsi_channel_de_alloc_command(struct gsi *gsi, u32 channel_id)
 	/* Channel state will normally have been updated */
 	state = gsi_channel_state(channel);
 	if (!ret && state != GSI_CHANNEL_STATE_NOT_ALLOCATED)
-		dev_err(gsi->dev,
-			"bad channel state (%u) after dealloc\n", state);
+		dev_err(dev, "bad channel state %u after dealloc\n", state);
 }
 
 /* Ring an event ring doorbell, reporting the last entry processed by the AP.
-- 
2.25.1

