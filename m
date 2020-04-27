Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E2C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C01206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USImTHS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgD0IOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0IOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:14:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBFC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:14:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so13076619lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FdfIU2NSLi88tCR7YZD3MsDxdEuhmbVZJnaYrUyg/FE=;
        b=USImTHS+2kjnjzTvZI+vUWJujyfWRDkv01ERhF34UHkbrkyZuD1txWGzcFXSWY+YDK
         CIQAOQ2rJrPhgm8dk2ZRlT5u/vPMqogGCQJe+KL9HGR3aLw14Vo+0f8NEieK72B0Eh2c
         UaPBxPidYjOZpx4IvXrgM4/EWxxXIjAxbDGX/+FQmOggRC+eFb9RiQ6srgiQ8n0U6uch
         pDO5IB9Stv9HwGtgkKeOh6s7t1ADYFsA/NVZYEiMyZoxHAAZjVh6jxOboqcTBsfvbgiV
         HRhH72dexIXWO28Mh7cHYZKjQxuNbQt5P0tGKTWSNDs1adrH/A+ONgelIHXSCEJAXl4/
         l3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdfIU2NSLi88tCR7YZD3MsDxdEuhmbVZJnaYrUyg/FE=;
        b=c6GjXpXkSNFiBzxXgQ8HK7jLK7ilNMh4uieAyiaI7Ew5LxVz2G8WSsIMtaGLoHB/WK
         zTiqcACI0OLMee+7Svjkmk0nL9TXtfuqeeuOkfX+VOcEtGHYB4e6SpmJc5CpJx4e+LiP
         ktClPbOsPERvkABd+L7jQF498mBfZ4CAZlQYN84bF8V0yXc+nlvy+ZcHVFbI5RhMrgDF
         sARYVfaiIbnG9PEKyMqeKhGQ/QOHEQBH2CoV/i3scnmyZNNiv0rF9qScyDVhS2WK+VxR
         OYgLmNWBpQTmYcNHQ0VGd4EwWWiMsZHgI+dyYGDG1AX4717C/eR19cJd93WHT/Y4jczx
         1kCw==
X-Gm-Message-State: AGi0PuaiBn1TrzyD0eOrTSqVAkVzyyrwr3GcGZx97FFDZ94PxC3xuKVn
        zVl0NY9PtThCAeEaS6TVFSM=
X-Google-Smtp-Source: APiQypJb8u+s2Yxiz9lf4eiIRKY3+cYu2Oqfifby+TcDNTNf2cVOtw+SmKfnqQEiTDVq3TME2jyUEQ==
X-Received: by 2002:a19:e04a:: with SMTP id g10mr14556853lfj.164.1587975240426;
        Mon, 27 Apr 2020 01:14:00 -0700 (PDT)
Received: from e123311-lin.cambridge.arm.com (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id i20sm11209907lfe.15.2020.04.27.01.13.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:13:59 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ville.syrjala@linux.intel.com,
        chris@chris-wilson.co.uk, jose.souza@intel.com
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH] Remove drm_display_mode.hsync
Date:   Mon, 27 Apr 2020 10:05:17 +0200
Message-Id: <1587974717-14599-1-git-send-email-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by the TODO list of DRM subsystem:
-remove the member hsync of drm_display_mode
-convert code using hsync member to use drm_mode_hsync()

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 drivers/gpu/drm/drm_modes.c                  |  6 +-----
 drivers/gpu/drm/i915/display/intel_display.c |  1 -
 include/drm/drm_modes.h                      | 10 ----------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index d4d6451..0340079 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -752,16 +752,12 @@ EXPORT_SYMBOL(drm_mode_set_name);
  * @mode: mode
  *
  * Returns:
- * @modes's hsync rate in kHz, rounded to the nearest integer. Calculates the
- * value first if it is not yet set.
+ * @modes's hsync rate in kHz, rounded to the nearest integer.
  */
 int drm_mode_hsync(const struct drm_display_mode *mode)
 {
 	unsigned int calc_val;
 
-	if (mode->hsync)
-		return mode->hsync;
-
 	if (mode->htotal <= 0)
 		return 0;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 3468466..ec7e943 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -8891,7 +8891,6 @@ void intel_mode_from_pipe_config(struct drm_display_mode *mode,
 
 	mode->clock = pipe_config->hw.adjusted_mode.crtc_clock;
 
-	mode->hsync = drm_mode_hsync(mode);
 	mode->vrefresh = drm_mode_vrefresh(mode);
 	drm_mode_set_name(mode);
 }
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index 99134d4..7dab7f1 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -391,16 +391,6 @@ struct drm_display_mode {
 	int vrefresh;
 
 	/**
-	 * @hsync:
-	 *
-	 * Horizontal refresh rate, for debug output in human readable form. Not
-	 * used in a functional way.
-	 *
-	 * This value is in kHz.
-	 */
-	int hsync;
-
-	/**
 	 * @picture_aspect_ratio:
 	 *
 	 * Field for setting the HDMI picture aspect ratio of a mode.
-- 
2.7.4

