Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583EDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B33C2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1mK1tGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgIJKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgIJKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:17:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5078C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so6053905wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EKdqRsK8wVtz9cHR3wKpVYkVxvCf4OgD26PR6bDVFQ=;
        b=e1mK1tGz6rZaNFFeQOtX2dk9yd8gvcj3TmaGXRNp1rqBIffPapTSViWj1tmPT/i0Sj
         bX6Jdr3LpJclFl1JAq2XVIrK5Fj5nxWBUryo1a71BZFL9dDYC8G3E6JOLlfUj2oj9x1g
         masAqBHlE0yWtextn4dI95Lwgv0cAvBdVvap5r9e3ezZEd1URr5OsAetuaNMmIKA5T1m
         n+A0dkvgFOX9FJQTn+CZ2b64lGGja+5QvtGMspVRwzDBfYq4n1nrTjFTXschjs/lO141
         Kzxqz9wSjXJmESJR+8zWXkjkN0VTyTAyWQiow+omrnDjuzbQoicZHVUpsGL59+FvvW3d
         w/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EKdqRsK8wVtz9cHR3wKpVYkVxvCf4OgD26PR6bDVFQ=;
        b=Tp5AqFVZmKg3OpXc2JSIA3TAQKijv/DTTK6fgF+W+qPAtjvQqEAlvOebGQaWmQAGZc
         WPXYI0Jw5C2JkWNh3IhJKud33va0HY1rGNsWMoTi3PV1accxsY9XVLFHIge0A/cyi9NK
         oVqikTzluCjxXYEoq5o4ui2Nb8yO6KtbJg9SJdie4K0OxXdzx6cWE1kHjk1iHqHyY+Q3
         E6uPGN76w5kDMYTM6DSQUiSeUmEarry87sB0CtniXpHmvdecmR0SYSa8WoOskt7Cc8yM
         Ecpio4Xmh9EfsNxLq4Yeug0jD3DLM0cl0ulINu3Kj9RvPsFgxQ83+AsOIApAHzNoKA37
         gEiA==
X-Gm-Message-State: AOAM530ytlWfhPac4NLNvLmyTPH2Uthh32uS56ETNyFiWtsUlFnA4k2M
        BKSmQl8oByzioY9zeIyQJY3d+w==
X-Google-Smtp-Source: ABdhPJz6Gm1hlVXhAPmoOB7PYf2rx5xu/cRrmqQk65gftmzu7Hm5sDaEbywIRTAXQiAz5cAbxcYRRg==
X-Received: by 2002:adf:94c1:: with SMTP id 59mr8856155wrr.29.1599733072447;
        Thu, 10 Sep 2020 03:17:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/8] ASoC: q6dsp: q6afe: add global q6afe waitqueue
Date:   Thu, 10 Sep 2020 11:17:28 +0100
Message-Id: <20200910101732.23484-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases like clocks q6afe would have to process commands
without an associated q6afe port, in such cases waitqueue is
required at global level to wait for the command to finish.
This patch also adds the command result to go with this waitqueue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index f934c69f0a14..2a8e3c3acb10 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -362,6 +362,8 @@ struct q6afe {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	struct mutex lock;
+	struct aprv2_ibasic_rsp_result_t result;
+	wait_queue_head_t wait;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
 };
@@ -905,11 +907,20 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port, uint32_t rsp_opcode)
 {
 	wait_queue_head_t *wait = &port->wait;
+	struct aprv2_ibasic_rsp_result_t *result;
 	int ret;
 
 	mutex_lock(&afe->lock);
-	port->result.opcode = 0;
-	port->result.status = 0;
+	if (port) {
+		wait = &port->wait;
+		result = &port->result;
+	} else {
+		result = &afe->result;
+		wait = &afe->wait;
+	}
+
+	result->opcode = 0;
+	result->status = 0;
 
 	ret = apr_send_pkt(afe->apr, pkt);
 	if (ret < 0) {
@@ -918,13 +929,13 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 		goto err;
 	}
 
-	ret = wait_event_timeout(*wait, (port->result.opcode == rsp_opcode),
+	ret = wait_event_timeout(*wait, (result->opcode == rsp_opcode),
 				 msecs_to_jiffies(TIMEOUT_MS));
 	if (!ret) {
 		ret = -ETIMEDOUT;
-	} else if (port->result.status > 0) {
+	} else if (result->status > 0) {
 		dev_err(afe->dev, "DSP returned error[%x]\n",
-			port->result.status);
+			result->status);
 		ret = -EINVAL;
 	} else {
 		ret = 0;
@@ -1594,6 +1605,7 @@ static int q6afe_probe(struct apr_device *adev)
 	q6core_get_svc_api_info(adev->svc_id, &afe->ainfo);
 	afe->apr = adev;
 	mutex_init(&afe->lock);
+	init_waitqueue_head(&afe->wait);
 	afe->dev = dev;
 	INIT_LIST_HEAD(&afe->port_list);
 	spin_lock_init(&afe->port_list_lock);
-- 
2.21.0

