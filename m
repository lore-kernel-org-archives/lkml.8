Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037EBC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D09207CD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chie8Xjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgGUQ5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgGUQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F48C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so3601293wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4d6uJsLJvDI3EJji05BLPVCBZ1m0E3vug5jjH5kFXI=;
        b=chie8XjtT37iTiWXV3e9tqsfxkDgQ44yavVsczy53hYtGLnOVDMK5CDq6rymQQxA5B
         GdOXxKfqAqy3L+DhC+3OKB5HO9runPNSsM1frOp/ayKh8yikxDXiBmX4X9V/RwR9Keq5
         eJ+W529TTLghEKp53X4rWGHTDAcD26a2tpxEyLPBvOQt8S6gpr7jq5QEH3Mcjn00Zwrb
         JBIwo9E5RnGdk0auEcyTllGM7EAi4vw8YmW150LovoWUGEfhTeqq0Vbz3DLcf6HNCgq3
         PKDIDT5mZ6cNtPBtRe7SwDFY8cGGNm3Qiat1SXpPMwlbiPGGxByV+7nohDYEfSXoF7Vf
         rEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4d6uJsLJvDI3EJji05BLPVCBZ1m0E3vug5jjH5kFXI=;
        b=pRzk+Qd6dKHyJrLIgtl0v4Tce1QyYtCyPZggVTW31X2Ldu9nsAJkF8X0oDgsL9JkoA
         USt1td+L1Luiy1NCqp5Du1eJYB2zhIZn0H77EDX2x76VadFrx+3nsgFbUfJoGJhmPAED
         Zf+pAXIO4HK7tDh2M1v4zbHdxBDRfsBhuyKcarQVK8XFlBkMS9gBtA0G9Ufe8JNNoZWr
         vH/kKM9q3n8zvuqey43zW3orG7ucfv+r9USXH8LNCda7py+CoAEGxJ9r7r8QfVTfC8m/
         1S0rV1Jzw+fp1ZhrwkJKLwxZQtGaD/k5/qkRe2ZKBV4QNnx48URXPh5Rp3WG0qlCT3NW
         nIXA==
X-Gm-Message-State: AOAM530JJ9gFrG+FCx/Fek4XmXP2fRWTiiScuKz157RFevcSoiAQhK4J
        poPST/PgL7oz0HimO67dzqARvQ==
X-Google-Smtp-Source: ABdhPJw7o3sUFFHWUSJehrm8NF6cu/74FiVHutUKWnF0yTjmioNJ5QwT490SHkdX3h/XL2YYY5i0JQ==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr5319125wme.91.1595350405320;
        Tue, 21 Jul 2020 09:53:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/9] ASoC: q6asm: use flags directly from q6asm-dai
Date:   Tue, 21 Jul 2020 17:53:00 +0100
Message-Id: <20200721165306.29082-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use flags set by q6asm-dais directly!

This will be useful gapless case where write needs a special flag to indicate
that last buffer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index f5d1f3c2c1ec..d6728304ce6a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1546,10 +1546,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	write->mem_map_handle =
 	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
 
-	if (wflags == NO_TIMESTAMP)
-		write->flags = (wflags & 0x800000FF);
-	else
-		write->flags = (0x80000000 | wflags);
+	write->flags = wflags;
 
 	port->dsp_buf++;
 
-- 
2.21.0

