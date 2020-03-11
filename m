Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC20C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE8721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXQ0EZxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgCKLgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:36:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgCKLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:36:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so2107295wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGydLBv1yG6IqmA1HcLLSymIojwkdOWZ9F3nvVgVBJA=;
        b=kXQ0EZxjxLgnJQdW6QvzzlgWATLi+m5mPF47WL1MzqQDFw1EiWlnkdIz2pS9VOCc3T
         FDNd8RL3IcXK0Qeckd0aBJUweELOu6IbjOxdxDg+WZMByjrpme7fUed+9tK9TBW4rn9m
         BG/YpsOZanwjplJgTJbZzQbVq87G7lQ8mr8v/HOv41h4BSqMV1s1wkBYsaf5zdPDqbaU
         qioaRRbjEAXWbiUC8bJYgxPXadgqnNe1jLKu98xQxN8HZCfWDJr8lOhaVidMh9D0bcoA
         evF9I+vktMAWp51nt/4HWlIN3luFQEPc2HcdtfH009FF0O5DlbYODKVJ2NvH1yD2VpKp
         DM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGydLBv1yG6IqmA1HcLLSymIojwkdOWZ9F3nvVgVBJA=;
        b=JuZFFzZegba9rnLwnB7YWQE9aXhk8dHffOUon6aeayzx/AYz0PqIVYn0JIX9enIAvi
         IGYmD9PJpEQRZmmHy/kCBwOgdttV1U7r+dF+tS7Fj/meIhAqAeiD21RlyQZREbpvRfF/
         sCXKsan5eHWXyN4jcj+oOebeDLiG7LGK2I+VsKG2lfmAIV/uz4F6ra8GxWQ1o27gZGkI
         g1zW2IkbId28NObAlcO7Lkr4TlQEE/32AL7XgQ/NyFDo8sWn0IjwntLVviYQNK+9P1/J
         AGrKHNhtspmMaLUN4RqwqNHEL9siXQMy0dPRdX/T+3hiddE51f3b5dxMPxtBqNXbY5io
         5fuA==
X-Gm-Message-State: ANhLgQ2Dbah5K8IfhzVXJkMo1uV/IwDaKblke3/oT2rXSBtfmfHOmKjb
        LBIsb17vmtWvfbqP3mWBR+9Fsw==
X-Google-Smtp-Source: ADFU+vuMbN/M6IXL7D0YfyYOzkTFBH0srYm2N5bFT/tMeKkFzGIGsUvO/H40SDljefCGwEFTZmWzbg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr3976144wrm.309.1583926579504;
        Wed, 11 Mar 2020 04:36:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c8sm61650537wru.7.2020.03.11.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:36:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] soundwire: stream: Add read_only_wordlength flag to port properties
Date:   Wed, 11 Mar 2020 11:35:44 +0000
Message-Id: <20200311113545.23773-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to SoundWire Specification Version 1.2.
"A Data Port number X (in the range 0-14) which supports only one
value of WordLength may implement the WordLength field in the
DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
WordLength in response to reads."

As WSA881x interfaces in PDM mode making the only field "WordLength"
in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
register on WSA881x soundwire slave with Qualcomm Soundwire Controller
is throwing up an error. Not sure how other controllers deal with
writing to readonly registers, but this patch provides a way to avoid
writes to DPN_BlockCtrl1 register by providing a read_only_wordlength
flag in struct sdw_dpn_prop

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c    | 16 +++++++++-------
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 178ae92b8cc1..7fb89a94d9c0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -167,13 +167,15 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 	}
 
-	/* Program DPN_BlockCtrl1 register */
-	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
-	if (ret < 0) {
-		dev_err(&s_rt->slave->dev,
-			"DPN_BlockCtrl1 register write failed for port %d\n",
-			t_params->port_num);
-		return ret;
+	if (!dpn_prop->read_only_wordlength) {
+		/* Program DPN_BlockCtrl1 register */
+		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"DPN_BlockCtrl1 register write failed for port %d\n",
+				t_params->port_num);
+			return ret;
+		}
 	}
 
 	/* Program DPN_SampleCtrl1 register */
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b451bb622335..2dfe14ed3bb0 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -284,6 +284,7 @@ struct sdw_dpn_audio_mode {
  * @max_async_buffer: Number of samples that this port can buffer in
  * asynchronous modes
  * @block_pack_mode: Type of block port mode supported
+ * @read_only_wordlength: Read Only wordlength field in DPN_BlockCtrl1 register
  * @port_encoding: Payload Channel Sample encoding schemes supported
  * @audio_modes: Audio modes supported
  */
@@ -307,6 +308,7 @@ struct sdw_dpn_prop {
 	u32 modes;
 	u32 max_async_buffer;
 	bool block_pack_mode;
+	bool read_only_wordlength;
 	u32 port_encoding;
 	struct sdw_dpn_audio_mode *audio_modes;
 };
-- 
2.21.0

