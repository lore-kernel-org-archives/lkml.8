Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C00F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEqHjWMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGGKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGGKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E2C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so1411762wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3kHcmoqkZhWZ4oxxNqqC7HGSrDg94q7cDYwU1R7wZ0=;
        b=fEqHjWMcV3QH7QNn2Owlf7RTYFuOqYPb28IOEN+o8frgMg6wAk8EIXNIqfXOBqZq/J
         eeNF4yNNT3ZzEc5lsIJ/W04R1U22wzOJwlIgEaSxbcmxd8TAEG0DB9MI6zZ2RgNDZckd
         17shoR7zE9yCtAQjpGYYM0SiDGaB5u/gxtfv3XELzdDRrwTwbclyndNJxB4BZeFnqY1I
         OyjOspkNXEZtkGE0QSucKXF5JuLvxRciMy6CiAGnjOdgV9USRqYyNr2lNLA3NgF7RVh1
         6vqRw2pZ7C5/IkR610hR7hIDqT6R4cHYaecuXnKDtPOQ+LZUCIFg/+NHbIdNw+HgVsiF
         BGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3kHcmoqkZhWZ4oxxNqqC7HGSrDg94q7cDYwU1R7wZ0=;
        b=O40fbDepR8MXIfEFHEfl3NolDBeDmlb9DbQ1ym7AWiL1IyOkDm+x5IkW3Z/4r9/qsu
         aZSszszRPQ/KVvFu03eeDzixt+JxYzlpC5Vk1cidQbRo/aeWDLpy1lFrNMrUD38Xh2D4
         cimjbk46R/4k7ay9P8TB2d0+SOKFM48k1LaI/lYc2cEiE6m8Zg9Pl8nlIzzy1NpbECgh
         diGWZv7oWioh7zciZiv3pzYBcmfrra2dzJUvZgUuwpfM23dB5pMSCO3054+1LcOTPzUw
         /fKDi3hlQ8OHTEg4TyF78XHaIGf/IfGDxNYbdG84k7BkrIXWyCDjyJORR5gUbrVJo4lQ
         Jx4g==
X-Gm-Message-State: AOAM533PNe2VuCChPVNUrEnxnBYz4kEew+i+D5ODe9IjYU0fyLorUg+1
        p8txgTMte69EDuTRwp4Pp3Kx/w==
X-Google-Smtp-Source: ABdhPJxvtg3nk0eX5HE4sSuL+1NhcMKYEL2lfzfo5OK/+r0EuBSISL2ieYbjgHLSGSKA8gV8c787RA==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr3231907wmh.166.1594117030396;
        Tue, 07 Jul 2020 03:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrea Venturi <be17068@iperbole.bo.it>,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 18/28] ASoC: sunxi: sun4i-spdif: Fix misspelling of 'reg_dac_txdata'
Date:   Tue,  7 Jul 2020 11:16:32 +0100
Message-Id: <20200707101642.1747944-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property name descriptions need to match exactly.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sunxi/sun4i-spdif.c:178: warning: Function parameter or member 'reg_dac_txdata' not described in 'sun4i_spdif_quirks'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrea Venturi <be17068@iperbole.bo.it>
Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 86779a99df751..326dd45e39dab 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -167,7 +167,7 @@
 /**
  * struct sun4i_spdif_quirks - Differences between SoC variants.
  *
- * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @reg_dac_txdata: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
  * @val_fctl_ftx: TX FIFO flush bitmask.
  */
-- 
2.25.1

