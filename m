Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C21206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odgYUcrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGGKS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgGGKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4741CC08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so33432296wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
        b=odgYUcrjBkWubGoKGvf/V/V80vy17B/RnX7fHgsFMRUIpPOJcrJt9dv+tXTEr3zxIH
         4VsYldSNIBGB1DSkbFXTHBa0geEKra9/qralT48dvdSWtNZ7chRn9zar3CUhzrZOp7Hw
         zr8dgtoNbIXHH9at4ApTG7Uu7k0aeDOo2fUnOoFyAotLj2PlDySDbWPhpKQPJFvKG4lz
         gxmvNUMXPop7hY3KcqWMubpQ/jwBvQEy/Rxb55ZVJnbhlrqw/63qx6GNenP/HQK0xkXf
         9RKzqvQVpNRpV1pdZFlvCD7F+DoL0i/coqsXs47ThIYQhKcOL4zpWvIXNMbG3+/omqZj
         tVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
        b=EToIDBb+QlGbVrUKqJsQZaEadO0yPDfjoYZGytNvgE8E5yMwVomIxXIrezeCQo/fy7
         08SE/tytUKeF9DLUXdukLakzt+L3xzZzvn4G7isTY/QaTbzxlTvE4wTSiE1XewEIzqUa
         QknBSAK5IjFtCFA6M37rTGz1VYz5HW0bt7M6ghtONToAMafMfBk6kOMOZ59QH7hZQnEU
         w7Vb7e6eUtUcm44Tk6VaiG2K/C2GNQTpmonKUhUWwJHZhiwGUxOeGZmiQanqeKn9VsCh
         DTXMpZ93u3/gPYmWvZMeg8PHKMvqKXdVbWjrqCO9daPZx3VHsJ0eB6PR/Pe6JeDEA9lN
         nc4Q==
X-Gm-Message-State: AOAM533EPTMs2k5qS+Rv/17pr8PlJy3zrAM0S0ipoekvOcOU0lA+8irr
        4Agun4VKbykDSxuz3UwNMuTdOg==
X-Google-Smtp-Source: ABdhPJwTGPinkE3kiIv2EohNfkljh6vRj8hjjmX611oqnzrxQA4XinO205+FsY+R+JHSOtM4FcmiIQ==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr3331083wmh.174.1594117027926;
        Tue, 07 Jul 2020 03:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrea Venturi <be17068@iperbole.bo.it>
Subject: [PATCH 16/28] ASoC: sunxi: sun4i-i2s: Demote half-documented kerneldoc header
Date:   Tue,  7 Jul 2020 11:16:30 +0100
Message-Id: <20200707101642.1747944-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

