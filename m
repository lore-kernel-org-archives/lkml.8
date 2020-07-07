Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784392078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsW+8Box"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGGQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:36:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so43979940wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=ZsW+8Boxa13kHK1Io/7C/Qx4f3hBk5gCVaHvi2diVxi26KWFdEomSGsr6if93QX/Mj
         h68Z8KrjuRufXLc6w5UouylgX6FE21GeVnZ8cpkPDMwtRV3zSjjHFmuuLhZqpPaNXI2V
         q/tWQr/9vu+88l934fMrIlK/CE2L5lWS28VHQKoV9btv26AC5AIcm65XRbGXHIM5L3YQ
         XGXCYvoj2AuKEbXZuA++4g64j1EHYn4tIFpPRKFyXvKiQedojX7huwiRe0AJzsSJUteH
         LGQFjTRjPbyxLfPS730FojyXp0Hp966NVq5ZDLctgxZDmzyOgeu+eMcY7S/C72mincda
         tK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmFQ91h0GZrG5WahISB8fgmLlciVJglL2OXgg5eRNY4=;
        b=WwlnWRfgo+AgtA9ZTv/JCLZcyYuwMIWxKuP1+D9Jn0mEHrKhXoceRh5luM4HlEgYhl
         FQ0si+jxu4qpNleuRwIa6azwO3dRnhUP7o5iXSsg+typwmsXE0k+eeIQFRDimR9KXwjR
         OdFoZLF0trezqrVI5gOsYU8L/sNWjNJ7d0GaKPKO9Au2g1BL7f7jMUnyuVhUZQnCmltQ
         CBeFxEptFPyfnzN4+I7Pc3RMZ2CEFNuJtoa9ZLVlF1l3Arvxx5KqVoVPb9TVs/xPSRxL
         T6EMb7WFFRftY96UGFriY/m8aR7PyPQnc5nLjH2J9ioFXaZ+qWJp/t5uDCPAtQoitZd8
         8hWg==
X-Gm-Message-State: AOAM531S5aMWMmK84DMwde6J3pfEqNpw9EZbv7IXPGt15xV5PYa9YYaj
        5ETb+BhoHQdJ+4f7UQcncMInDQ==
X-Google-Smtp-Source: ABdhPJzwTYKGlQdJRYeYWGRtVqh6B7nk+3FVEG7vYDvxmBd9jW0ooL1Mt+lKPtC3tqpo/xy4Q1OeCQ==
X-Received: by 2002:a1c:3c83:: with SMTP id j125mr5022283wma.65.1594139812201;
        Tue, 07 Jul 2020 09:36:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/11] ASoC: q6asm: rename misleading session id variable
Date:   Tue,  7 Jul 2020 17:36:32 +0100
Message-Id: <20200707163641.17113-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
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

