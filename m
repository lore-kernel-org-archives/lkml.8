Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3BC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7975F2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f++FdS/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDKFqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:46:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37196 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:46:36 -0400
Received: by mail-io1-f67.google.com with SMTP id n20so3811232ioa.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WiNGtbaTEgFI2Ambw/NBjeXjSKphhfC2LjH8nGfubE=;
        b=f++FdS/1K/hAONc1GYsMc4l3FNQXu/bZO3znxAgObdFW8zHNlK9yRPvUF/q3GJYSJK
         fBAblfrG2987eHf6lRFRMNqoVsQa4HZAZG6fB06kWJ48CO4HXt2tTpPWQTa/8CvnDvV2
         nlMtJC6us9ZodxrDn7rvctlez/9PiOQ/lL51hxT+VGBxspLDqeptVWNFc6TSg/cIviM7
         ve5NPYGzejpW7pzft9jYzIiOmWA5bWjIaC9W8ilZ8NDf7E7G91BnvtQe5bnxpRah/wHU
         qfO6Ml882P6E9LxVspzvpRI9YJ/F48QgoOk2FhRz2vS/WpjWaybm71KKLuvKlNMiXnPH
         UhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WiNGtbaTEgFI2Ambw/NBjeXjSKphhfC2LjH8nGfubE=;
        b=UEmR25SCl3soKz5UU6lTTjd8t/WeheBIc1VjpmZ42DNR82nyFz7F8sY/JIxKndxeWW
         G4mYc6xbhaqeKrfcwTvao5PAf3wfqBIk/5Tn8yJSfR70Xvfm7EKq55ZYEGAJJyihli5U
         8sWNfyHWDXimEXXDTXKR06EElGV7duE8cbS7+Dy2kigpkyzj6UF9v8sHoPo0+/BRl+Ot
         sg/ViW9kIQd2cmBbveu1ctSzBHfHdI6BiVctJ5HlXA13qOySTtKsEn1RCZdnG/PEMFlS
         Vxz2KuGi/2QnhbXASKK4y8yB+my865uI1H+kqrZ11zF3YuWWIA+HolGIulEGR6kbd0ZR
         GUsg==
X-Gm-Message-State: AGi0PuYIk98YowzRGPocILU2pVJYh86iIcT3/q784CRcuiAnywx7qrfe
        /EBgw6/uHiYZokwD5zZLC8Y=
X-Google-Smtp-Source: APiQypL4T1XANVKA4cYdcSxOvp9eDvywSjs6+0UJNv7O4UQgMT2TzxevSei5HattpSlJq2OhushA2Q==
X-Received: by 2002:a6b:ba07:: with SMTP id k7mr7408801iof.24.1586583995731;
        Fri, 10 Apr 2020 22:46:35 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-253.hlrn.qwest.net. [97.118.146.253])
        by smtp.gmail.com with ESMTPSA id m4sm1464114ill.78.2020.04.10.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 22:46:34 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH] drm/vc4: hdmi: Silence pixel clock error on -EPROBE_DEFER
Date:   Fri, 10 Apr 2020 23:46:11 -0600
Message-Id: <20200411054611.25647-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.20.1
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
2.20.1

