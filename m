Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B97C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926DF2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRS7vofa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgG0JiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgG0JiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so14153449wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=iRS7vofa4J8zmxsEDII42gfJgszCaqgth1nT6MJzl/o2Ne/5UFf5Aw8ZigFDURPIyZ
         V3kQCYXrPr/G8X3l0hdpr6yDnxzEdK5l6IcxZjJl8NqaL4rdPtO/0bjiElIzmnITRAAs
         a0T3l2cQxquXvuEZXLqA4purNnP7Zw55/SXIY1GmzJXo9cp9GyXX6pE1VNi0b4dYMtyG
         YngNIQKPzu0J/ZyHp94WUQXsm3DLdNgyd+Of3w+/CPHdLNCvUdEvRfvv2ig5axxivImg
         3LlQz0fwM0iVymO208cBo6wJX1qMpacvMlSxCbF/GxNH7UlPBvcJfjCFdfJx+DeEAyek
         MDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=Lr1LMsOEa44D9FOxXymUTNfqjt86afjkV91cQG7l3ySYMubE2SLtxWLmf9lm+kGbFW
         w5THcafy4cqgJjbDmeSIp6r84iU9IL+ZqiatQYbzGbPxT6I4+RLFb4kSE0D1c63UQ36W
         /WHZRsFSMTsLxt0M0vaZDylamWqRKJw9QakZIZUPetvY9EzAosqmemq7SpQMjVyQptY1
         rcU4UxWe+rtDt/I8zstIzj/rOAtBajQNtOK8dPMJrRXZcAvYPcSMh8ktoC58imu8IX2d
         cyv8XOFshscbSzt4JMvXK0ueNE+wgjW2ltWnsmMlPWll2Da2uKKEpJFDJ1/6JjxBbB1T
         fIAA==
X-Gm-Message-State: AOAM533sUWqzLYYxttAxU/Ls49nhSgu5EiAZ9aJJo0IV2rJer3Lf5PzC
        UsIExyl/L9AD3t9w08TrDl75cw==
X-Google-Smtp-Source: ABdhPJwFZJgNsmBQxchH9gOwIzssFTkFWdmxFcOb7dHoHRFPfVpfia0IZSSV2YRgdXbwBgOihXQc4A==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr16219109wru.272.1595842694746;
        Mon, 27 Jul 2020 02:38:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 01/10] ASoC: q6asm: rename misleading session id variable
Date:   Mon, 27 Jul 2020 10:37:57 +0100
Message-Id: <20200727093806.17089-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each q6asm session can have multiple streams, mixing usage of these
names in variable are bit misleading to reader, so rename them accordingly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index e0983970cba9..51da3717a6a6 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -828,21 +828,21 @@ EXPORT_SYMBOL_GPL(q6asm_get_session_id);
  * @dev: Pointer to asm child device.
  * @cb: event callback.
  * @priv: private data associated with this client.
- * @stream_id: stream id
+ * @session_id: session id
  * @perf_mode: performace mode for this client
  *
  * Return: Will be an error pointer on error or a valid audio client
  * on success.
  */
 struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
-					      void *priv, int stream_id,
+					      void *priv, int session_id,
 					      int perf_mode)
 {
 	struct q6asm *a = dev_get_drvdata(dev->parent);
 	struct audio_client *ac;
 	unsigned long flags;
 
-	ac = q6asm_get_audio_client(a, stream_id + 1);
+	ac = q6asm_get_audio_client(a, session_id + 1);
 	if (ac) {
 		dev_err(dev, "Audio Client already active\n");
 		return ac;
@@ -853,9 +853,9 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_irqsave(&a->slock, flags);
-	a->session[stream_id + 1] = ac;
+	a->session[session_id + 1] = ac;
 	spin_unlock_irqrestore(&a->slock, flags);
-	ac->session = stream_id + 1;
+	ac->session = session_id + 1;
 	ac->cb = cb;
 	ac->dev = dev;
 	ac->q6asm = a;
-- 
2.21.0

