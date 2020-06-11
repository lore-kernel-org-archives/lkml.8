Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA266C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EF0207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdEQrWYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFKMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFKMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B1C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so5985502wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=VdEQrWYs2Uqc2Ff7VpJtv1mSFf9m6Ugbt1BOFmKKvAN6xEchlHWIOcLuP+mjyslQb9
         foXUJjSZurXBRLrt8jabAIuejWX/fdwZKdtRrawNaGIz4SvUmGyJzHVpHIJh+16Cmdm3
         66pfsdmIG6BgIKMocfQC0niEPRpxZ5W8xB6qJ9Ae2b/O+XP6SgDFEbSyd9PJQWSD7zTm
         9aw9Vyc24x6+eDhFTcPLXyyjRBir5cq3qS5ec5nvz6/1uy6LxBZLYaso4NQ8C+SxYjqA
         7IAUuJyZg9o8SAPF8PodoqQqvnAX512t3lrkTVYYN7qHKjDpBu1gXNH1eIP4l1jOvylo
         L+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=X6a4DTEDR0skItI4uWjzhjqaszz9/gvF08GP2oBrpaw6/yWyKI//A3YNKLiaztHx4F
         eLczkBtmEXM+k5jS9jCcb61SjBbli/1hWzckHKGDv3NJwMzs/wq2wtyLBbSSn57ZlrBR
         GUNBjaDr9+GMzdmkXq/tqCoXoIwOJtY6EW0SBmAjjGCEIgV+eaR902GSTMBGvt+5x18v
         brhkar2CDcTjsiG5DMAW2F0N8IJQW5QYhiXvf7Bja9odOnrqcpBv13gwMPvWE8MSzIFx
         6pcteUOnHXEc/LVx7Bx542j+Riy8EXDvZOvf2N9sXLx0W1yyA5S28N/eUd242dtfx23d
         du1w==
X-Gm-Message-State: AOAM5307TDVxv5NiLDVdd5CTTXIHIyn/NxzDcEUFVN1TqXiFSK2+JCW2
        OJG42v+4nA61K0//Y2jXzvMmcg==
X-Google-Smtp-Source: ABdhPJxbLRxb3pVa6kGKVQjFbdxlVetJsMnut5Ck76cBOeP9CLWnh9yMeXxDXOKDLBn/O5OnCR4ROA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr9137648wrx.214.1591879326516;
        Thu, 11 Jun 2020 05:42:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/8] ASoC: q6asm: rename misleading session id variable
Date:   Thu, 11 Jun 2020 13:41:54 +0100
Message-Id: <20200611124159.20742-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
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

