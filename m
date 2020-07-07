Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFF2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCg08VN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGGKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGGKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847BDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so45915304wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvkfvflL72kN7LZNfXrEA+gETlAfB400MfXaywOwHac=;
        b=uCg08VN2KG7tt0Tx0AckaREPBcmh1YeIiZN5oAjKUDygIZCzkIvg51lyzxafwIyAf4
         pXk2PHOrb083JCm4EbyHGCsuyFFpJg2QOKk11tqTTDZSB7wzNDHdngRCxLwvhh5fvUw1
         LQt1EQ32PAvvFjqfsjatkVitUxHKb+Oltn50+vBxConSiEzzt6Yw0QV1abss/+635/J+
         mUotE25yq7r4tQiY0YspR/OoLPVaZW8wnMxGqUpkPBBhnfzlJPQdxUwG3qPsHNqgqYOf
         g4cXGoim7zhet6+9Fpo3F8/F3GvNynrAUwV60Z2GADKjANPHfrqYPsz+1S/wTZWiJkAE
         DtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvkfvflL72kN7LZNfXrEA+gETlAfB400MfXaywOwHac=;
        b=erAioiaAQj+bgnkYjua67XI7MkdAuergEh67eO0Fw3pibEsPd18JfQE4n7MN+VTqKq
         4EBtae+iMn7NLjQQMWkKJ6wrrR0GArHMc32aC0zD5WN5lMv2Sjh0WKqaWBfwpcx73Hb1
         4iqNkGQ5ESeJyRwg1QXHAwfTIjmQ0mNe3VyT9y7D8Q4L/ir7Re709Wa2WTUOc1mbQ5BX
         mnhIxOmfx1vWQTSAnJXFXRbSnQDKVd3Yq4G8e4ke4hfHGshB+psXtBKz63P/OhxufOp6
         zvEdXUFwkaIzu7bAkP6xxV4fgontTEn9idqcb/qlGWJ10baClOpaSdWe9z+16PNDL03B
         Fedg==
X-Gm-Message-State: AOAM531NS7aXq3AE8HQDE4coyHLSWJPWFRl1KtkI/7DSweMKvcz1BcMk
        GNGJpx0spXOXtf1+rdbY1GCKQA==
X-Google-Smtp-Source: ABdhPJwGVhbK5W+Z5vcbZBvlNHt5B5X22zSccrN72IuuGIypiyRyY/iE9EBTD1QWpJfGc7dtm4tawA==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr3382942wma.73.1594117029172;
        Tue, 07 Jul 2020 03:17:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 17/28] ASoC: uniphier: aio-core: Fix incorrectly named struct property and remove another
Date:   Tue,  7 Jul 2020 11:16:31 +0100
Message-Id: <20200707101642.1747944-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both issues are likely due to bitrot.  Let's bring them up-to-date.

Fixes the following W=1 kernel build warning(s):

 sound/soc/uniphier/aio-core.c:107: warning: Function parameter or member 'pll_id' not described in 'aio_chip_set_pll'
 sound/soc/uniphier/aio-core.c:107: warning: Excess function parameter 'source' description in 'aio_chip_set_pll'
 sound/soc/uniphier/aio-core.c:279: warning: Excess function parameter 'ch' description in 'aio_port_set_ch'

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/uniphier/aio-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 9bcba06ba52ea..86eb0915d80ad 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -93,9 +93,9 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
 
 /**
  * aio_chip_set_pll - set frequency to audio PLL
- * @chip  : the AIO chip pointer
- * @source: PLL
- * @freq  : frequency in Hz, 0 is ignored
+ * @chip:	the AIO chip pointer
+ * @pll_id:	PLL
+ * @freq:	frequency in Hz, 0 is ignored
  *
  * Sets frequency of audio PLL. This function can be called anytime,
  * but it takes time till PLL is locked.
@@ -267,7 +267,6 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 /**
  * aio_port_set_ch - set channels of LPCM
  * @sub: the AIO substream pointer, PCM substream only
- * @ch : count of channels
  *
  * Set suitable slot selecting to input/output port block of AIO.
  *
-- 
2.25.1

