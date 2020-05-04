Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EFE206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E12Zl5rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgEDXhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgEDXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:37:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EFC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:37:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so522878qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SVKEsIIeMIoq0nGWFOrPILES0nl3fNBl6idp0P/1Ps=;
        b=E12Zl5rs1mRKdlFDSASU1tgCY+SeIsOLtN7ovHj47a+ZyyGQIF66PyT0qFDSgakdvp
         7k2Jd1MzK0s6JWerc6Ddu8x5QMo5Ldt1mItM7t1sI8Vhzdj2iLqKjD7qu8BsizJTjgRf
         N50yS8cDquc7OFGFpc4MhgfIRd+4m5XEMrMkv+cu1wbloUNEQ1yixeV8mn1+i2LBbLTP
         hXQIanuyvhqXHOgRGEEEaFwQjcWpjGoy1VYDO7kDXMPjSlXHO5fPtpCvzaQeiyPBk6ET
         widFwsXxvWSjbOFTL43UcTKdec7dPizHXs2a6YVK2p0ELrpMRBJ1M9zHAQNLC1Y6snBh
         Zk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SVKEsIIeMIoq0nGWFOrPILES0nl3fNBl6idp0P/1Ps=;
        b=CgDjkH5cvvwsI1yQR6+iiu/gyGuATW4uotHgt+lZx7s1qdWGhLuf29io8+jEJmcxQh
         d7fsbwhqwWubzOCDt2iFxVfvvZNQeg4I7CILE8DcW60OPJp6eec1fV81/u7RUw3wJ4FO
         fAeCgw7Q54cK0qNKnWmsBxM2HZz3NGVpF3PUSHKdPCFn4O1EGHeDjTSHch4boOHWpQW8
         OyW/LTS8FMWZX92dMGAv9f4xg39OfiZS+Es9MGOgPq3YhVfjr5XReVYF2cdU3ZYIPrNE
         8VTSu7aksvtmjv3mWErfYGVGgAjCFvPSeU8QL282fbhhXJQAYdlk8erNxpjv3ZhFWFfW
         t1Zg==
X-Gm-Message-State: AGi0PuYq6InmYTPIg1L2TkWPn7W2tKSmpffiBJi4V/y2+QyLxBnPq79j
        pcmN5yAoa+0ppdMb+kSFsQPP2oJydRM=
X-Google-Smtp-Source: APiQypJnW5ZwyFqr8n/awhxvGwG8XA52esUciJmhc+bO1jvWdIgr8hDfe2WTyJoPS28OP5JvaLXT6A==
X-Received: by 2002:ac8:a02:: with SMTP id b2mr1870qti.95.1588635441007;
        Mon, 04 May 2020 16:37:21 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x125sm494311qke.34.2020.05.04.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:37:20 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: ipa: introduce ipa_endpoint_program_suspend()
Date:   Mon,  4 May 2020 18:37:12 -0500
Message-Id: <20200504233713.16954-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504233713.16954-1-elder@linaro.org>
References: <20200504233713.16954-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new helper function that encapsulates enabling or disabling
suspend on an RX endpoint.  It returns the previous state of the
endpoint (true means suspend mode was enabled).

Create another function that handles enabling or disabling delay mode
on a TX endpoint.  Delay mode does not work correctly on IPA version
4.2, so we don't currently use it (and shouldn't).

We only set delay mode in one case, and although we don't expect an
endpoint to already be in delay mode, it doesn't really matter if it
was.  So the delay function doesn't return a value.

Stop issuing warnings if the previous suspend or delay mode state
differs from what is expected.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 67 +++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index ad72adff653e..a830101b8edb 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -293,7 +293,14 @@ ipa_endpoint_init_ctrl(struct ipa_endpoint *endpoint, bool suspend_delay)
 	u32 mask;
 	u32 val;
 
-	/* assert(ipa->version == IPA_VERSION_3_5_1 */
+	/* Suspend is not supported for IPA v4.0+.  Delay doesn't work
+	 * correctly on IPA v4.2.
+	 *
+	 * if (endpoint->toward_ipa)
+	 * 	assert(ipa->version != IPA_VERSION_4.2);
+	 * else
+	 * 	assert(ipa->version == IPA_VERSION_3_5_1);
+	 */
 	mask = endpoint->toward_ipa ? ENDP_DELAY_FMASK : ENDP_SUSPEND_FMASK;
 
 	val = ioread32(ipa->reg_virt + offset);
@@ -307,13 +314,31 @@ ipa_endpoint_init_ctrl(struct ipa_endpoint *endpoint, bool suspend_delay)
 	return state;
 }
 
+/* We currently don't care what the previous state was for delay mode */
+static void
+ipa_endpoint_program_delay(struct ipa_endpoint *endpoint, bool enable)
+{
+	/* assert(endpoint->toward_ipa); */
+
+	(void)ipa_endpoint_init_ctrl(endpoint, enable);
+}
+
+/* Returns previous suspend state (true means it was enabled) */
+static bool
+ipa_endpoint_program_suspend(struct ipa_endpoint *endpoint, bool enable)
+{
+	/* assert(!endpoint->toward_ipa); */
+
+	return ipa_endpoint_init_ctrl(endpoint, enable);
+}
+
 /* Enable or disable delay or suspend mode on all modem endpoints */
 void ipa_endpoint_modem_pause_all(struct ipa *ipa, bool enable)
 {
 	bool support_suspend;
 	u32 endpoint_id;
 
-	/* DELAY mode doesn't work right on IPA v4.2 */
+	/* DELAY mode doesn't work correctly on IPA v4.2 */
 	if (ipa->version == IPA_VERSION_4_2)
 		return;
 
@@ -327,8 +352,10 @@ void ipa_endpoint_modem_pause_all(struct ipa *ipa, bool enable)
 			continue;
 
 		/* Set TX delay mode, or for IPA v3.5.1 RX suspend mode */
-		if (endpoint->toward_ipa || support_suspend)
-			(void)ipa_endpoint_init_ctrl(endpoint, enable);
+		if (endpoint->toward_ipa)
+			ipa_endpoint_program_delay(endpoint, enable);
+		else if (support_suspend)
+			(void)ipa_endpoint_program_suspend(endpoint, enable);
 	}
 }
 
@@ -1135,8 +1162,8 @@ static int ipa_endpoint_reset_rx_aggr(struct ipa_endpoint *endpoint)
 {
 	struct device *dev = &endpoint->ipa->pdev->dev;
 	struct ipa *ipa = endpoint->ipa;
-	bool endpoint_suspended = false;
 	struct gsi *gsi = &ipa->gsi;
+	bool suspended = false;
 	dma_addr_t addr;
 	bool db_enable;
 	u32 retries;
@@ -1166,7 +1193,7 @@ static int ipa_endpoint_reset_rx_aggr(struct ipa_endpoint *endpoint)
 
 	/* Make sure the channel isn't suspended */
 	if (endpoint->ipa->version == IPA_VERSION_3_5_1)
-		endpoint_suspended = ipa_endpoint_init_ctrl(endpoint, false);
+		suspended = ipa_endpoint_program_suspend(endpoint, false);
 
 	/* Start channel and do a 1 byte read */
 	ret = gsi_channel_start(gsi, endpoint->channel_id);
@@ -1211,8 +1238,8 @@ static int ipa_endpoint_reset_rx_aggr(struct ipa_endpoint *endpoint)
 err_endpoint_stop:
 	ipa_endpoint_stop(endpoint);
 out_suspend_again:
-	if (endpoint_suspended)
-		(void)ipa_endpoint_init_ctrl(endpoint, true);
+	if (suspended)
+		(void)ipa_endpoint_program_suspend(endpoint, true);
 	dma_unmap_single(dev, addr, len, DMA_FROM_DEVICE);
 out_kfree:
 	kfree(virt);
@@ -1313,30 +1340,18 @@ int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 
 static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 {
-	struct device *dev = &endpoint->ipa->pdev->dev;
-	int ret;
-
 	if (endpoint->toward_ipa) {
 		bool delay_mode = endpoint->data->tx.delay;
 
-		/* Endpoint is expected to not be in delay mode */
-		if (ipa_endpoint_init_ctrl(endpoint, delay_mode))
-			dev_warn(dev,
-				"TX endpoint %u was %sin delay mode\n",
-				endpoint->endpoint_id,
-				delay_mode ? "already " : "");
+		if (endpoint->ipa->version != IPA_VERSION_4_2)
+			ipa_endpoint_program_delay(endpoint, delay_mode);
 		ipa_endpoint_init_hdr_ext(endpoint);
 		ipa_endpoint_init_aggr(endpoint);
 		ipa_endpoint_init_deaggr(endpoint);
 		ipa_endpoint_init_seq(endpoint);
 	} else {
-		/* Endpoint is expected to not be suspended */
-		if (endpoint->ipa->version == IPA_VERSION_3_5_1) {
-			if (ipa_endpoint_init_ctrl(endpoint, false))
-				dev_warn(dev,
-					"RX endpoint %u was suspended\n",
-					endpoint->endpoint_id);
-		}
+		if (endpoint->ipa->version == IPA_VERSION_3_5_1)
+			(void)ipa_endpoint_program_suspend(endpoint, false);
 		ipa_endpoint_init_hdr_ext(endpoint);
 		ipa_endpoint_init_aggr(endpoint);
 	}
@@ -1448,7 +1463,7 @@ void ipa_endpoint_suspend_one(struct ipa_endpoint *endpoint)
 		 * aggregation frame, then simulating the arrival of such
 		 * an interrupt.
 		 */
-		WARN_ON(ipa_endpoint_init_ctrl(endpoint, true));
+		(void)ipa_endpoint_program_suspend(endpoint, true);
 		ipa_endpoint_suspend_aggr(endpoint);
 	}
 
@@ -1471,7 +1486,7 @@ void ipa_endpoint_resume_one(struct ipa_endpoint *endpoint)
 	/* IPA v3.5.1 doesn't use channel start for resume */
 	start_channel = endpoint->ipa->version != IPA_VERSION_3_5_1;
 	if (!endpoint->toward_ipa && !start_channel)
-		WARN_ON(!ipa_endpoint_init_ctrl(endpoint, false));
+		(void)ipa_endpoint_program_suspend(endpoint, false);
 
 	ret = gsi_channel_resume(gsi, endpoint->channel_id, start_channel);
 	if (ret)
-- 
2.20.1

