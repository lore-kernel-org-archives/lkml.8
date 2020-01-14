Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22392C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB524676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDK4+Znj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgANJwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:52:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgANJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:52:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so12964522wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6RanNdUoczCExPmVTmgRD9iBfpF1gCk763s4qX8JSY=;
        b=PDK4+Znj3pDpGScOLb1jD7Y+GaEdkIlqrSBrgCHVt11xjztSfFj/Gnf69dHZrZIObD
         TDil1nTHkIP5Qf1oxy+FJJJtQUA6VsAYfDXHs0Ce9gfxFZNWdZ95Htsx/pBOmHbnXcw4
         +D86kt+FYYGmwpih7Udj34mguk2k943d5fpgI4kHK3cDDK6/HlIJ8X4H/6ss7OtvCHwF
         GPWi/wwzT1Gy0UoHRYEddbcCgvMysVUSR7xykVTaks8ERO+1hpv75X27pDJ+vX1zmSeL
         zHFFwNXA4Hjy2sE3B/23xbBKCiyiXLC4fcY4Z5MpCtLNh8epREuyHLFpGjftzEbGR0l9
         qvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6RanNdUoczCExPmVTmgRD9iBfpF1gCk763s4qX8JSY=;
        b=ATQyasQDo2uIG2FNzFuUFv6A4FsMgqYkwIKWfkIdeDgKcnSGYFjHG813n/dHl5loei
         fKL90QLQISBnwFxx6dy+xZyp6Vc6UxjwTZvaldZjXft3jNRMnb3M/A3RSdQIBmI2uav9
         m+mZbviHJqppV+QMa6SQ1Ra58/QkAtvLWpbwL9fkVzq1hLnPML3L2qfovuumRXZe4aKK
         0ZHTIQMc5iGPaomcC5xtk5PC4cLV04sMNnxp/8D5kUID1RMvhCGqmon1jd0ncJ+6SJhS
         LHTpqs8ShRQEO85dPwDVuTv+fa9w0nEQsyhzgahFm7PXOBWEX86LDHfyGEWU8TSb/KfF
         e1pQ==
X-Gm-Message-State: APjAAAU76D7p/JBRd74zBis+1CqhnMZs55M0wcXTzNx0rrRL12QPM2zO
        q/FM2ntmal4VliH/6e0IwZU=
X-Google-Smtp-Source: APXvYqwO7YZvaRCdvWf6/tVZNRsaC/bTSPpG3XW22QHjcte+N4+0Qmt2jsbdDrO8+JXv+rZEO2n5Ow==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr26335879wme.151.1578995528477;
        Tue, 14 Jan 2020 01:52:08 -0800 (PST)
Received: from localhost.localdomain ([154.70.37.104])
        by smtp.googlemail.com with ESMTPSA id y20sm17454881wmi.25.2020.01.14.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:52:08 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/i915/bw: convert to new drm_device based logging macros.
Date:   Tue, 14 Jan 2020 12:51:06 +0300
Message-Id: <20200114095107.21197-5-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114095107.21197-1-wambui.karugax@gmail.com>
References: <20200114095107.21197-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the printk based logging macros with the struct drm_based
macros in i915/display/intel_bw.c
This transformation was achieved by using the following coccinelle
script that matches based on the existence of a struct drm_i915_private
device in the functions:

@rule1@
identifier fn, T;
@@

fn(struct drm_i915_private *T,...) {
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
)
...+>
}

@rule2@
identifier fn, T;
@@

fn(...) {
...
struct drm_i915_private *T = ...;
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
)
...+>
}

Resulting checkpatch warnings were addressed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_bw.c | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index b228671d5a5d..9c40ad52dd73 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -132,9 +132,10 @@ static int icl_get_qgv_points(struct drm_i915_private *dev_priv,
 		if (ret)
 			return ret;
 
-		DRM_DEBUG_KMS("QGV %d: DCLK=%d tRP=%d tRDPRE=%d tRAS=%d tRCD=%d tRC=%d\n",
-			      i, sp->dclk, sp->t_rp, sp->t_rdpre, sp->t_ras,
-			      sp->t_rcd, sp->t_rc);
+		drm_dbg_kms(&dev_priv->drm,
+			    "QGV %d: DCLK=%d tRP=%d tRDPRE=%d tRAS=%d tRCD=%d tRC=%d\n",
+			    i, sp->dclk, sp->t_rp, sp->t_rdpre, sp->t_ras,
+			    sp->t_rcd, sp->t_rc);
 	}
 
 	return 0;
@@ -187,7 +188,8 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 
 	ret = icl_get_qgv_points(dev_priv, &qi);
 	if (ret) {
-		DRM_DEBUG_KMS("Failed to get memory subsystem information, ignoring bandwidth limits");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Failed to get memory subsystem information, ignoring bandwidth limits");
 		return ret;
 	}
 	num_channels = qi.num_channels;
@@ -228,8 +230,9 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 			bi->deratedbw[j] = min(maxdebw,
 					       bw * 9 / 10); /* 90% */
 
-			DRM_DEBUG_KMS("BW%d / QGV %d: num_planes=%d deratedbw=%u\n",
-				      i, j, bi->num_planes, bi->deratedbw[j]);
+			drm_dbg_kms(&dev_priv->drm,
+				    "BW%d / QGV %d: num_planes=%d deratedbw=%u\n",
+				    i, j, bi->num_planes, bi->deratedbw[j]);
 		}
 
 		if (bi->num_planes == 1)
@@ -424,10 +427,11 @@ int intel_bw_atomic_check(struct intel_atomic_state *state)
 		bw_state->data_rate[crtc->pipe] = new_data_rate;
 		bw_state->num_active_planes[crtc->pipe] = new_active_planes;
 
-		DRM_DEBUG_KMS("pipe %c data rate %u num active planes %u\n",
-			      pipe_name(crtc->pipe),
-			      bw_state->data_rate[crtc->pipe],
-			      bw_state->num_active_planes[crtc->pipe]);
+		drm_dbg_kms(&dev_priv->drm,
+			    "pipe %c data rate %u num active planes %u\n",
+			    pipe_name(crtc->pipe),
+			    bw_state->data_rate[crtc->pipe],
+			    bw_state->num_active_planes[crtc->pipe]);
 	}
 
 	if (!bw_state)
@@ -441,8 +445,9 @@ int intel_bw_atomic_check(struct intel_atomic_state *state)
 	data_rate = DIV_ROUND_UP(data_rate, 1000);
 
 	if (data_rate > max_data_rate) {
-		DRM_DEBUG_KMS("Bandwidth %u MB/s exceeds max available %d MB/s (%d active planes)\n",
-			      data_rate, max_data_rate, num_active_planes);
+		drm_dbg_kms(&dev_priv->drm,
+			    "Bandwidth %u MB/s exceeds max available %d MB/s (%d active planes)\n",
+			    data_rate, max_data_rate, num_active_planes);
 		return -EINVAL;
 	}
 
-- 
2.24.1

