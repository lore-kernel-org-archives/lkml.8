Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8464C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7743206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJo1+ouw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGGKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgGGKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FEC08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so44518447wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3fyU5lC2kiQoR/Tx6i2htjANdo4PmUgTNG8kh6JAhc=;
        b=kJo1+ouwbe5ipI7BlC5Ic4kTj8wrYnx05NhCanfvRd3nkj5ATUjqLzGEfPRFCp2ulE
         KlBv/4imh5BYzeZCn2F/hHtgC47bvGB4fduIIt+wknpl41OgBzDF+cPpVYzYmTyVMfmn
         fyL0juesSL2d0Mvlsdth1UFm/UcrSurKgPRTyvbJvnMdRe1jh7ljFlsf6qXnrhkrWm4S
         w/kvER9sdviBe2wO7C5yDsga3UBqektYMCTs5TnCXRD398XXHiALQmZCob/PqQRJQo2W
         S9xILBqXWTrhiJbJvgqPcatbuL4E5Gzn5H/TkKAlV4+/nMN2pxueG5HoYl4kOqGmLPMe
         mlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3fyU5lC2kiQoR/Tx6i2htjANdo4PmUgTNG8kh6JAhc=;
        b=EKaGp5d+WWuFn2pUC9oGfRGl0yDdoCZjEoPwyRZg2a8XkK93YZRjR8xegX4FjH3f/H
         fATHqM9Vs54VA1A2eywqvtli5PvZamve0Vb7HbzR/nuVE9wYuSMgba0I/xVszi607N61
         /E1N58oCqiwxNwX2TIBlK3Dr6gK3eWEg46uw2Y/OpslZLQbEycsd2sg/8d6fu4kOSsxH
         Ww16gqvLtLjH+nsABYjifRTUSEVYqPxSDr09Y/gW4+PnL28TbjrB445YqV+3K+QsN+qE
         J1dJwqv4RRhIg4HBnuLlJN9hRp8j5ho0lPJ27OJl6a+hRKNhBXj0WyVZGbMfKcEREeK6
         +9oA==
X-Gm-Message-State: AOAM530OS5Zp95sKwedogNhTwqMrjBVo7Xzx4Qpu8WJEPbNSs6BqlDjd
        j9Shg3mWNRNW1DgBHGBltTVsTA==
X-Google-Smtp-Source: ABdhPJw3IxiVYR6WmuTK9z+sTSUJZ6MQnqXOW88rUyFa86F5H3CyEoVayXplHB7xTuQyEIOgTW+qOg==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr17550261wrm.327.1594117035204;
        Tue, 07 Jul 2020 03:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        David Chen <Dajun.chen@diasemi.com>,
        Kuninori Morimoto <morimoto.kuninori@renesas.com>
Subject: [PATCH 22/28] ASoC: codecs: da7210: Fix formatting issues in da7210_set_dai_pll() header
Date:   Tue,  7 Jul 2020 11:16:36 +0100
Message-Id: <20200707101642.1747944-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects parameter documentation to be in the format '@.*: '.
If that convention is not followed, the kerneldoc checker gets confused.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'codec_dai' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'pll_id' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'source' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'fref' not described in 'da7210_set_dai_pll'
 sound/soc/codecs/da7210.c:985: warning: Function parameter or member 'fout' not described in 'da7210_set_dai_pll'

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: David Chen <Dajun.chen@diasemi.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/da7210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 0c99dcf242e42..159b5f0eb7100 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -971,11 +971,13 @@ static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 /**
  * da7210_set_dai_pll	:Configure the codec PLL
- * @param codec_dai	: pointer to codec DAI
- * @param pll_id	: da7210 has only one pll, so pll_id is always zero
- * @param fref		: MCLK frequency, should be < 20MHz
- * @param fout		: FsDM value, Refer page 44 & 45 of datasheet
- * @return int		: Zero for success, negative error code for error
+ * @codec_dai:	pointer to codec DAI
+ * @pll_id:	da7210 has only one pll, so pll_id is always zero
+ * @source:	unused
+ * @fref:	MCLK frequency, should be < 20MHz
+ * @fout:	FsDM value, Refer page 44 & 45 of datasheet
+ *
+ * Returns: Zero for success, negative error code for error
  *
  * Note: Supported PLL input frequencies are 12MHz, 13MHz, 13.5MHz, 14.4MHz,
  *       19.2MHz, 19.6MHz and 19.8MHz
-- 
2.25.1

