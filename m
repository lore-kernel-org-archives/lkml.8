Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E12C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132DA2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1XcyxDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGGKRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGGKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC01C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so45915033wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
        b=J1XcyxDnRmpZz0W4IPrMVJKymtJ07od5/Ui2uKeAXQgpc0qotceonG0/oloTEdbH7s
         h9+dfh0LSbVUcJW+pc/XyHocqcTsyqzJb8LmBvxq6MpxjTnaT9VZNdirDOfgB5bWoWDq
         niIIONlBk6sA9+rBm5/Zf0rtNPutp2de6yaHctV6VNL88YoptrE7bzN9P2c95z9yX8TU
         WwB1XVGi9t17KxFLcrnyiAgHFMMynYQSuE2RBzJTnvTVRfnVq3tEgvIXuDERBUvrzOkJ
         JpljX451HY8DEy3VySwa2mAmhxKDg2TS61UqmnWH5Dn1LD8i/9kIhADrwvWC7PFYhZae
         S8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
        b=DisTR3bd5GxsInsDogX7M2W9ebRjW5vbIo3hZoiq3FqvTqDRZJLiBpaPgYn2dHCJRp
         8aa2HMU2/65qgVw0nx9dCr00pweXLNwoEYVxqJpelbsItcgzZDjnXJOwXyJYvjiQxzGz
         3lWRBezSjEZajenIEwafmtjllQKqDuZ1k+DwB43EVLvjQ9pDTJgI8tNRRSotPOSbF61E
         +1vz+G88nqocMwos/nUZ2sX6mOhKucfVcLMREFo0vyJDEE9ASag/Djs3GHEy/XuqR8Gi
         0QIG9RcaPYAOlMmYGJxbdfPPKogtzttyFNne9f5Z33f5MnHSx3upOx3663PRyvohG9XA
         l72A==
X-Gm-Message-State: AOAM533qgbPG5D5LCg9kSONdzaC5kP80gAHRK2P79YPAzUg2mCWjKBZa
        VM68ysEUehst0a0oQOk2I/miyw==
X-Google-Smtp-Source: ABdhPJzZOEjZmejJdYRsgb4UUUE3sZTs8G1LEoJTOp7Viz61ZnkIYUsK9D/hnCyJv8g4p3iI/k5fcQ==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr3274840wmm.163.1594117024429;
        Tue, 07 Jul 2020 03:17:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 13/28] ASoC: qcom: qdsp6: q6asm: Provide documentation for WMA 'codec_profile'
Date:   Tue,  7 Jul 2020 11:16:27 +0100
Message-Id: <20200707101642.1747944-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

