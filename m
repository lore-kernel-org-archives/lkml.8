Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B126420771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0PO5kBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGGOiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGGOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so37339721wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
        b=y0PO5kBlqlUU42SbtXP1vXkvb3j/2BL0FbASY0BSoHRpU3L88y2IKVJ/9oqwLopIlz
         Mr1+MDuG4LoZEL6Ht0QCbQoOPEClwf39CLo47Q/4VJg66UWdQlIBaY1Hy4YBGaIzBbf9
         uVLgyB8ZtS/eh3QtSrUBbcObWC7kXDviDUDHKbvaGv59FZpelKcAn4Xli9lY5wh9wfkJ
         ssg8NL7DiAKLTXmuP4nBrkDuMI9mohfj/dBpAvAwQG9QFk/1vd4ennzfNc1+AxOjZqNu
         StJdHLrm0AUphNY9+g8Pzm/w6cJjVeVnhANfKw5qXTjCSxL6TR/DTW/nx2S52xpjlH5R
         MX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
        b=P9x7q7Tu6P+nhQP99cbVa8CwyZE1jTZj08f+/JBQgZYv/BWti15LIBu98Sj8Yo3+xg
         QNESlmHD/bKceMox2dZqbjoqgk+IcC5PrHm90OP7TMMszXqX5cG6Ym3Fu5u1apnmaXX8
         n5kH5q7TMDozNvBCUbkIatl0MwQa+YIAIksgD40emJhzZN67tKUyatVgC/VW8COsbtSs
         PSKj7wiuQC5CvCF3IcSvNWMT02ZjqVUmUitnA5RNrHfKdeTEOAeS6vx8x++c2RNORyeM
         AwXi7QihpEn6jWdBJWiFu6E8/9CKhNLZmEpwB8jQ+l7vwzDM4KvhQ1yqlUAtSjqhHNRz
         o6Zw==
X-Gm-Message-State: AOAM533RIfrJ0gDyu9qYhUSL+ajpFFTRIe2zDSRkLFB9BWWhv2s/amzo
        +U/LYFBrHLNQV6jWecKusrPjtg==
X-Google-Smtp-Source: ABdhPJy9WLIaGgmiEMVkgFNQzihpEyvUsYv4v0EIE+0+DVUHKbd38T2a6PzO/BRBW3OO4BQb4P/gMg==
X-Received: by 2002:adf:e944:: with SMTP id m4mr55414369wrn.252.1594132686208;
        Tue, 07 Jul 2020 07:38:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 13/28] ASoC: qcom: qdsp6: q6asm: Provide documentation for WMA 'codec_profile'
Date:   Tue,  7 Jul 2020 15:37:27 +0100
Message-Id: <20200707143742.2959960-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 sound/soc/qcom/qdsp6/q6asm.c:924: warning: Function parameter or member 'codec_profile' not described in 'q6asm_open_write'

Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index ae4b2cabdf2d6..58720b18fc8c8 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -915,6 +915,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
  *
  * @ac: audio client pointer
  * @format: audio sample format
+ * @codec_profile: profile to use when WMA
  * @bits_per_sample: bits per sample
  *
  * Return: Will be an negative value on error or zero on success
-- 
2.25.1

