Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F759C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6400B2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcJyeHuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgF3M6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388113AbgF3M6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:58:52 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:58:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so20874241ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvwmuOxhUd9gYI7ZmOWVfT8VxRuFbGiVGtVR+SU80d8=;
        b=jcJyeHuZhgei633Ns+gF8MPjHBpaLmONY+fD0uvur0WjNqyKe697npjSZTYugGZzq3
         CyeTPqgF4IZwqJ1rNcSJL/5KiWJdfkS4Ew3LbCylq+mNPY2HOG9CAtjA1aAf4RhOlV9n
         p75o2bILLbT5KiPcKXhxrOaF2ruP0LMWj9lA3Irm52wWkuEoil2YgpOWWGxKU9zKfAG7
         2arx33Glcc/hoJvUjyFwVBViwzMPtN/I02Y3rOyRWVEtXk7lenzJ/r3guGziEr1BBPj8
         GvD2Jyjj3p2KUBmK/G2BQL8Xp7rgxdlKoS4rk7tdWUrrhTFEOl7UUyu7ONe48hxWba+b
         LQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvwmuOxhUd9gYI7ZmOWVfT8VxRuFbGiVGtVR+SU80d8=;
        b=tQ/icFFyB8jO48vKGOHB8ZrpNnapymYZ3604jzexKDF1hKRnEkIpkQ/8ZkbNHcLz1E
         h9+EKpLOEl3FEEY6b2JkdxSHErnmEGzkn6jrL6rGbyrMgILG2Pga/drytRY75GpsR3VG
         ZNwkrwRgFQhESENME7e5C27QDbHaHVG4ZbYZCMkpnx8skf8ESp3eJ3RIDqp74fCLZOBU
         xMHpKdxGv+PHEAUIAfoeqMPT1P2xIJocdLzy8JW7bEA6EoadJzg+pbcPxMwaLdqJAilT
         v9q0EcWzOEaiVVbp59aOpapyxquaiyKAU09QYqYYjjQcUpYbcevbsNwACHpANAYmInaJ
         VuCw==
X-Gm-Message-State: AOAM533Jp04l619RXHxhONvHZ+jf7lJorRk6fgar7KXPaN6ya7TqsR3P
        HT4DnfRMne7X7svyV7/ULxmF/w==
X-Google-Smtp-Source: ABdhPJy/o3BU5qhfjlIqHI1EERFkFjHubRTEksLQefAEpHQOUn2DC6DjwWUdI7NT3Ghqm4ggoKjVNw==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr21046408iop.14.1593521931183;
        Tue, 30 Jun 2020 05:58:51 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z9sm1622588ilb.41.2020.06.30.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:58:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: ipa: always report GSI state errors
Date:   Tue, 30 Jun 2020 07:58:44 -0500
Message-Id: <20200630125846.1281988-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630125846.1281988-1-elder@linaro.org>
References: <20200630125846.1281988-1-elder@linaro.org>
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
v2: No change from v1.

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

