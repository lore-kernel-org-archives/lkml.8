Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAEA2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdfEQq5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgGUQyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGUQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so3577855wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=PdfEQq5Z5muq5Isok7PUgCsn76OXXgu5yWQuJDKHk5rZanJoGFa+2qkQOnSDpLRJch
         A4wzPDhUWeVnZBNHj7FiyHadEhZ3rl2my6XEnFCoW8OeMWOQxLxmUiCNV4cx/QS/GsSR
         FpTrDNeSluQ+xAAcfqTh19We5XjkUlWfe3lmSON/EAyVUKYHxuoyxCQfxlSTResOJm01
         CDrM0q0DjcwZw2SvWs3Bo230SiJl4MfN4LVJ2Cr8GqKfM36Lge/GLdMxsVK5SE9zAt5g
         tA9oxD47wNyl/mLB7kN1fRqfDaIDtEpa02TcWQGP5SAnnqrZLfq77KEu0Usp+65dgI02
         u7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=tWoI27CZ6wn0o1hmBejoVS/wf/flnUchOlwsDjpSMvXwPWW+mFBFm2NoXYd3VU/J/3
         98QQa91rkPESm48RGTauhorI6WX962ggPcqbNg3+tQmAfWyun2sSDtsOPrU+PvTbi7TE
         N0rj7uqXr4G4ZRsnZlRdtjYzSwWLx7o97oO9i3g/iu5c/bPVaj26MlleseLAJMD47BBW
         iQ9c0Ti4tLev3BLDE0ffZIJXXlbVHsUMm+699MAjSfFFgtO4jzXNYTvQ+nzC5eEn5iUx
         sBzg60HmfqUw2ow9oj8jhRmsimVdL2zg+wKfEj42mjqwkntuJ2Eq7n94wd6wuRAbUnro
         86qQ==
X-Gm-Message-State: AOAM533FKER2aLN7axBqiVJQUbNWyWLYrcUJ/yinxnmpOdnQBT0HGBpq
        vWmEM3EZiGcYMUJs+kOqqxgGLg==
X-Google-Smtp-Source: ABdhPJxeMl1VRzhAfTUwlCTFyw+8lWWqASHdvER9v0OppOghrYq8wBV6Q3RRQp7aF4tBlPkD8CfqMg==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr5317404wmg.68.1595350402557;
        Tue, 21 Jul 2020 09:53:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/9] ASoC: q6asm: rename misleading session id variable
Date:   Tue, 21 Jul 2020 17:52:58 +0100
Message-Id: <20200721165306.29082-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
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

