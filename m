Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9582075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG0i9AGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgEYB3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgEYB3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:29:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B922C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:29:34 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j3so15988776ilk.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R71dV7S9rJQPlMHMjk6Vu0NBsTKVA0V6AR1/+ijdTXU=;
        b=YG0i9AGd6c2S5ULFReX3uDyCO0YWpEQCkwusIvHlXGkiFJT+GtuhdBKe9bqYDEGHPb
         E3+x+B/bMoy6IQPVjsI7AggtSBmpul1UTgun/A+Q2EOnJlbgXz7On0eFGyvM62Jcq7TB
         0e6p3z/qn1cDJ54BSMybkDq/gImwKoRitLte8r8ujFU5kvQuKUP/haYS5ztBh5IQkiDh
         eBo7a6dG4doC9fuPhpq6/5Veb5dmh532DftU9nhEHXRZwxNZ3Cxd0qrGxDy/Q1dv6Smw
         mYrc1BOsvh5Me6Ghy6A/PUZTwGaIkt67xwxK5HvPqmsw4BnfM8sJ5IpaaJ+eBhTnJ38Z
         AM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R71dV7S9rJQPlMHMjk6Vu0NBsTKVA0V6AR1/+ijdTXU=;
        b=rck1+bCWeMBy0DMyFYSZY0S/7Bfqr+3OXx6dVvU00PHkduQMVz/DA3LNmbiJDrtw+Z
         jG4T3jaUQ2suqlXskGunZDZQcZ2CNCBpKkVfZxx/s1JWSJNK10hDgReAo6eI59lom1mn
         2eDBY7qI+ng3Jht2K/52G9rX8T7bJUwDDVpPKUy49ukNVXoZXmOn/QzcFRu90CUtsHG6
         nkq0B/ADrv52iH6fkHlpSXs3D7tSOn2uOxJVT/AlBTG2DzmRDay9Q4+XJ6BRxWMmI/TP
         Y+dBGK7xbw4A8VUwfT3hYj0juynk4qsjvkoMtkRA+fYDEVeYfVnyrt22ewu1WrXB0CeJ
         fK4Q==
X-Gm-Message-State: AOAM531R22Xk2Os5QuZPtMCdIUUWI5kQgcg3upR+P12kSPch5Y1gwYxb
        /iCeUl72apb948kCn1kwRuc=
X-Google-Smtp-Source: ABdhPJypDVQv9J77hH8HwSGLN96MDsXiBlnK/6+cLrJxFiV/47Xdl8IvjqMmRo6j1STXYHmMcm0URg==
X-Received: by 2002:a92:da52:: with SMTP id p18mr23324203ilq.173.1590370173505;
        Sun, 24 May 2020 18:29:33 -0700 (PDT)
Received: from james-x399.localdomain (71-218-100-23.hlrn.qwest.net. [71.218.100.23])
        by smtp.gmail.com with ESMTPSA id t10sm8396302ilq.62.2020.05.24.18.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 18:29:32 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] drm/vc4: hdmi: Silence pixel clock error on -EPROBE_DEFER
Date:   Sun, 24 May 2020 19:28:59 -0600
Message-Id: <20200525012859.267433-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the vc4 hdmi driver loads before the pixel clock is available we
see a spurious "*ERROR* Failed to get pixel clock" error.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
no response in over 2 weeks
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 340719238753..6d4ee3f6b445 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1338,8 +1338,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	hdmi->pixel_clock = devm_clk_get(dev, "pixel");
 	if (IS_ERR(hdmi->pixel_clock)) {
-		DRM_ERROR("Failed to get pixel clock\n");
-		return PTR_ERR(hdmi->pixel_clock);
+		ret = PTR_ERR(hdmi->pixel_clock);
+		if (ret != -EPROBE_DEFER)
+			DRM_ERROR("Failed to get pixel clock\n");
+		return ret;
 	}
 	hdmi->hsm_clock = devm_clk_get(dev, "hdmi");
 	if (IS_ERR(hdmi->hsm_clock)) {
-- 
2.25.1

