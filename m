Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9982F20775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCArb9Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgGGOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgGGOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75915C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so34318223wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
        b=tCArb9LsSLq+aVcEfeY/D9+tTEQA8kHXj8jhWU8fUQ/Hfthrxq7wIL0yzRbqiDggKF
         LLb6K/hpGjG6tDzvWLQLDok4RiXnwLVNqo1Ix6PMEE7VUDc/L7RM22VD1/ATUN8Nd+Xo
         SzGI2YL2xDLlGdHYZkf5kWkqnVqyzZ63daz/wUYAPiNfSqNAt9XdYyobyo8fakiRkD6D
         IjsnO/iHnU7jo3f1V5LwfCHwcg9roIE7U06Rm0Y2d8FUXJ/UktGRIySgFCnZelByi3UR
         kO9wusr32JupfE8yYgTpQPQC4wgFjEQplbyc3gahTZvfhO8fiKKCZsL85quYSPIcsm5X
         gGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
        b=nVRGhgPZY35iIyAFYktcb/yE+IDyZaXle8g1ni/FY5LVaXy0ppov76YeTpr2FF+ZCH
         7l6hCWZWmuFh+ri2cq+EMceqtFJx6nh6nkDV7SZHehr1oElB7lnB9XbjpszTsebg87TE
         rX+YYbrs9fvgZivJ3NNULONHk4hIuRIJXs/X/FRsud874+pmKa7RhCMFK1XDZ2qUe5fP
         CamOAkoCheZHix1ED1Mg9VL5XOSoqkIRa1yx6SH+7ksw6rJwqcKnkHMmtwuBGhdTdF4m
         6yK8FgwRwOZ1+XDJDVuZtD2QXwQqhCNztruyiHPq6QNFBD4k04/mQGRJJJ79VTYINs1/
         jC4g==
X-Gm-Message-State: AOAM532tg0M6Vkm5tclABSOQYc3XHakUE5nA9UxgGEbo1Ik/mnqthC9l
        qXS+uDj12SnsZgKGGwdVolsLqQ==
X-Google-Smtp-Source: ABdhPJxi/g4zQkVIJX8OngdL3aznYyoNUDfajtADY4HZRSl9CebNjwejLE0wLy1LX5mEM6UT5D72lQ==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr4499060wme.171.1594132690196;
        Tue, 07 Jul 2020 07:38:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrea Venturi <be17068@iperbole.bo.it>
Subject: [PATCH v2 16/28] ASoC: sunxi: sun4i-i2s: Demote half-documented kerneldoc header
Date:   Tue,  7 Jul 2020 15:37:30 +0100
Message-Id: <20200707143742.2959960-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally the author or someone 'in the know' should come back and
provide the remainder of the documentation.  Until the kerneldoc
checkers have been satisfied, let's just demote the header to a
standard comment block.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'bclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'num_bclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'mclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'num_mclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_bclk_parent_rate' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_sr' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_wss' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'set_chan_cfg' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'set_fmt' not described in 'sun4i_i2s_quirks'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrea Venturi <be17068@iperbole.bo.it>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a5..34c24e3cedc78 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -126,7 +126,7 @@
 
 struct sun4i_i2s;
 
-/**
+/*
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
-- 
2.25.1

