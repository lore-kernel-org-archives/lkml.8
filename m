Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95E3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA68320714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wkpo7qVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGWOUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgGWOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:20:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB21C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:20:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so5350200wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntQu/VIUE9Ak1XWr+tVal7WWTvSlvV5WCmELVlSDg/A=;
        b=wkpo7qVfmRQMPMxDfZe4UMyUKZbbfKfNEbl/ATyQ+ZamsFKEYkAJMnnsF70gm8MOJT
         tIeMGGPN/oAeSvdffe4TFe9/EYgHs94i2eaGJHJCQYh0XOo512GHFUdIlei/g7RliGDx
         D5O96c3ZwG2Bzr3+W5nwShYdzfOK89O4fKPNtmdk87x3U7ngJrYSSjHvTbZyfjO7Zf6H
         Zxisg/HN2v9MGvbqicfa8OINsM2xCR3Vb98qLOSCA0bmAQIvu0YRJw2e8NO/+af+e4iw
         fyjNMe4l21vet1zGIgwezkr5OkgUswi3wP/pJLcRDxHYQZkWCXdnNLYbhwozC9Ore0Tl
         GAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntQu/VIUE9Ak1XWr+tVal7WWTvSlvV5WCmELVlSDg/A=;
        b=HMXRv5dzFD9Pw+QGKM+WJRZ4i2Tbc+xDSgBk0yI88gwnM3gMy8zbrrKgpTxqtFzw5y
         rvmqIyeWSheifCf3AF1aCI9pbbnaikPqkHdG4N7pHA/3y5Uo28ghGAHVP3AQLDCbicfb
         Iaa8HKlQeRvqRQxloiXDSdYtU6aaPQ8JuhQUKgnopmt/Qo7qwh8JSTud+8TSEBzL3PED
         cKNe6wJnCdZ6PNmfsD+CPtrid0qlyaB33miEcNxrhE1ryGJh2MUxZDiRtkiTt7QYIs3V
         xXl4J7offQIV8ZBhopMpDhT1dQ2n4dxbcKsT3pOgop0woYqnw22+Z6B8sVvW4VgAdylC
         D+Gw==
X-Gm-Message-State: AOAM533rO+nz7J0vatPbDC7XN7jpVtAF2sChyS/bvXhfi2Y4mLQ7Uetx
        8sQ/XbYEgQGkELEe1Yrd/v3WTg==
X-Google-Smtp-Source: ABdhPJwPVH7gpTvD/ipnOWJvIHkx8CO3yNE7ijv4WaUQj7B8PPGPf7PeZuVShnyjBwPah/vGz1YMDg==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr4352832wrs.345.1595514036969;
        Thu, 23 Jul 2020 07:20:36 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w2sm235204wre.5.2020.07.23.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:20:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: soc-component: don't report of_xlate_dai_name failures
Date:   Thu, 23 Jul 2020 16:20:20 +0200
Message-Id: <20200723142020.1338740-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
every error different for ENOTSUPP or EPROBE_DEFER will log an error.

However, as explained in snd_soc_get_dai_name(), this callback may error
to indicate that the DAI is not matched by the component tested. If the
device provides other components, those may still match. Logging an error
in this case is misleading.

Don't use soc_component_ret() in snd_soc_component_of_xlate_dai_name()
to avoid spamming the log.

Fixes: e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 If we wish to report an error when no name is found for dai phandle,
 I think it would be more approriate to it with with "struct device *"
 of the card, which is the one actually failing to get what it needs.

 These user of snd_soc_get_dai_name() are already reporting the error:
 * sound/soc/samsung/tm2_wm5110.c
 * sound/soc/rockchip/rk3288_hdmi_analog.c

 These could be silently failing:
 * Simple cards
 * Amlogic's cards
 * Samsumg odroid card

 sound/soc/soc-component.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 9565a0dd7cb6..fb6479b22d26 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -344,13 +344,15 @@ int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
 					struct of_phandle_args *args,
 					const char **dai_name)
 {
-	int ret = -ENOTSUPP;
-
 	if (component->driver->of_xlate_dai_name)
-		ret = component->driver->of_xlate_dai_name(component,
-							   args, dai_name);
-
-	return soc_component_ret(component, ret);
+		return component->driver->of_xlate_dai_name(component,
+							    args, dai_name);
+	/*
+	 * Don't use soc_component_ret here because we may not want to report
+	 * the error just yet. If a device has more than one component, the
+	 * first may not match and we don't want spam the log with this.
+	 */
+	return -ENOTSUPP;
 }
 
 void snd_soc_component_setup_regmap(struct snd_soc_component *component)
-- 
2.25.4

