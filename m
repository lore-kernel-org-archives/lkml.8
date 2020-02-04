Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E787C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768E21741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/8fpH8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDKYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:24:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50502 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgBDKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:24:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so2618857wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HcMMJQIo94sDORwN3NPMMwEJv40Fu1AswMuILXzE1Po=;
        b=e/8fpH8ceuC4QoxlYq1ClcUtM2PODeUMfpJQVju6Mlfe8tnwBG3nua1c7vvNfJkFfN
         da+Mtu98/b2qv6F7NTaVmM2grfa8zYx/ceaeIFzBIYBcDErELlJjFA8wn+FERBGM2MND
         XW/aP3jrLK3ZP/39W0crG1IqpoRkvC43ukJr9tOD983vIxCy12cAeFvAiA19OmBVyxbw
         9oxGO3bcEXwyTwOOEBipHBU+F/+Y7cCSx+gJ8GEkc6Cskba4rp2yqoCKcwtoLHrgGVpZ
         z9a49nzX3ww7wtvkr1yJL2He1Gpqwkqc5jewKSkwY1wcqeyR9MxB3veKpheScwA9FqMF
         8ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HcMMJQIo94sDORwN3NPMMwEJv40Fu1AswMuILXzE1Po=;
        b=PI8p8bdwLlk6qoPv9Q+v4SIwl6gKkiNCQwjLc/rrMBCX9DdRnbcem2eO82WlQoqAH4
         3ph1Nwur6hGCcUBZeDFsxhCusi23gHclQA0IQka8UiEbpB0iXDSbBc8uf9pddcGwJ1PC
         z6ig0CPAZO2dFklcDCL3Uv3Bf5bg+2GhC+g/18NkCo/3SPA2rdoUpwItFxsyAymrsk7L
         XM/ZELucjs3QwYGxIJ9c3EwqCyMPBgrBw+6hcyrTh1ubmPRP9uKm7h6V35luzegK3UHF
         07HMc2HQPGlGLnpu+NZOxngZanw4jv7iUVzMkdstG4yn3faoN9MkipcXKeFc/t2aj/Gp
         cJIA==
X-Gm-Message-State: APjAAAVVxjwrTHlkEeuxf455Fakk07ix1LYYOEEjQH3dOsnChcm/xKJ1
        CzSD41n+kQ57EXtz5zBuq8GpXw==
X-Google-Smtp-Source: APXvYqxDK+9e46ZWTzRKuIJLw0hzd2ajwQLTt6vfG5+a3lenp3SiWluj5c+iJSQ2CDghW6bOiOtIaw==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr4825881wme.64.1580811878171;
        Tue, 04 Feb 2020 02:24:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b18sm29558987wru.50.2020.02.04.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 02:24:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, sfr@canb.auug.org.au,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency
Date:   Tue,  4 Feb 2020 10:24:28 +0000
Message-Id: <20200204102428.26021-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like some platforms are not yet using COMMON CLK.

PowerPC allyesconfig failed with below error in next

ld: sound/soc/codecs/wcd934x.o:(.toc+0x0):
	 undefined reference to `of_clk_src_simple_get'
ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
wcd934x.c:(.text.wcd934x_codec_probe+0x3d4):
	 undefined reference to `.__clk_get_name'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438):
	 undefined reference to `.clk_hw_register'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474):
	 undefined reference to `.of_clk_add_provider'

Add the missing COMMON_CLK dependency to fix this errors.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d5b0d5a73d3..3e2396ee727f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1280,6 +1280,7 @@ config SND_SOC_WCD9335
 config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
 	depends on SLIMBUS
+	depends on COMMON_CLK
 	select REGMAP_SLIMBUS
 	select REGMAP_IRQ
 	help
-- 
2.21.0

