Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB4C206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SG9DVu7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGGKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgGGKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE88C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so36485675wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeJNmc8Tyj+Q0twt9zY+vng7Jbsk0DhIYimyC4Uuyj0=;
        b=SG9DVu7fXCmkADEx1FB+YT3/QUV77NTc0vAi8Aq/OU5JY/5r0nXXfnJqgkyWhfpyGx
         D/UhIe9t7HU7t8lZcbEWpiDr++OlOpU+kL/tqL3Eh1wNadJzD0au75fv1TBcsNZSNkKA
         nOjCXy180Pi8mtF0+NoAX54Kixg2UaD63ENJKA1+YP8Ld65pqMeva44ZXpor7DWQd1ju
         LqVE4zWDY7HKent37Y3VvP8l/uIBW/84nidbsrUq+OOIyYGQIAWbpqZUxcM+8jPgDwz+
         kb+JOM5fpsZC42M0+bwu5CJuC0R7MS7KlmUfHMsPCjS5HD8CfYN6wAditT74bUOm4bkf
         t3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeJNmc8Tyj+Q0twt9zY+vng7Jbsk0DhIYimyC4Uuyj0=;
        b=Zx/HC2z7BrTCjYAT70zMs35mY+V8v6wUnAz/Qzc8Iof7Ib3MFAjMQgODxb+k25dA/e
         F+66kKfC8rBA5TBG6qapxYWM8/VvVCqzByRVne7OYe1IxTl398wA8OV0r3YabvzUQEjX
         YUbgcpgTVVAhT4xw3m6/lMErMusRBr3JWrSE7dC/s3LROfunG40pc/R2rGcccb1e2C+G
         X+NPkGzOrITE5S4mhAf5aLKSeBFzkqrjbkVueV4+Fo2wLuqrtGBvoK2SPb2EtJs8k0Id
         M+TPxePhS1HoHpEwIPXeC+zvDEpoi0CQGjFHeQEapg2n+RF1IDqVTUUqcF4lZue9zDHG
         yVgQ==
X-Gm-Message-State: AOAM533zi4JVD5qrxMSwl1of/i7qaeocpQBqQ5BYFdfw6HyGuabqa4qf
        gRomOTWZHa2enXsXCdI0JsJXAQ==
X-Google-Smtp-Source: ABdhPJxy1qhKfpuwCxgH8O9/dsEgy203Bk85YKuQEh58briez0Nc3pkRWpshwrxQBdavC6rVpap1eg==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr53690649wrn.269.1594117026710;
        Tue, 07 Jul 2020 03:17:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 15/28] ASoC: samsung: spdif: Fix 3 misspelled struct properties
Date:   Tue,  7 Jul 2020 11:16:29 +0100
Message-Id: <20200707101642.1747944-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When documenting structure properties, they must match the names exactly.

Fixes the following W=1 kernel build warning(s):

 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_clkcon' not described in 'samsung_spdif_info'
 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_con' not described in 'samsung_spdif_info'
 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_cstas' not described in 'samsung_spdif_info'

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/samsung/spdif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 759fc66443298..4ae7ff623b826 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -70,9 +70,9 @@
  * @clk_rate: Current clock rate for calcurate ratio.
  * @pclk: The peri-clock pointer for spdif master operation.
  * @sclk: The source clock pointer for making sync signals.
- * @save_clkcon: Backup clkcon reg. in suspend.
- * @save_con: Backup con reg. in suspend.
- * @save_cstas: Backup cstas reg. in suspend.
+ * @saved_clkcon: Backup clkcon reg. in suspend.
+ * @saved_con: Backup con reg. in suspend.
+ * @saved_cstas: Backup cstas reg. in suspend.
  * @dma_playback: DMA information for playback channel.
  */
 struct samsung_spdif_info {
-- 
2.25.1

