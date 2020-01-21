Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12559C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9492070C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUthgRS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAUNqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:46:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46089 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAUNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:46:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so3198460wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oTa1VqITVge6WV7oRjAnmHlhAXizGmEu7HI8M0yFGwM=;
        b=cUthgRS12TpM7g1AxGRgWUIcrNCbJURnzhaA7ucQr0Z522J3XcMc4YzSKTDlxKtIj7
         BCd+mPAeF+e1xyi5ohFY8nzyiLgyOqsuG+plw9bz5h5KW9KuZJXRIMXlwApGQ6a5bvpD
         KKvycetfNYRCfD4PFpiU63fqNCNm3SbluHEKCQz5e9muXczTTJYsLwnAX3NTZb8j6RaB
         JKFPRu0KmPBxD7ih5VvEwKUL06t+8km8tql78+MlpMFEBJiyZmuBDnC4XK/t1Db0isoB
         30XY14LmYefU8bsVZsDG9zbAPTVPJnByOETAe7k6J4x1LNUDgvNsNrnY8s+NIVTSQgcr
         kPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oTa1VqITVge6WV7oRjAnmHlhAXizGmEu7HI8M0yFGwM=;
        b=lBAPdtqqxVq52tE1KtBOdNA7b73+t+rJuynA0wWMKMBUL45MFrDs0/KVJ40I4FgJYl
         b/Baxwbs/H6z0rTQwGxSri6CzQslbgwapCZ3AjKjHvwRrUenZd6v8uGJwlJkqDnXkPTm
         0QzqJ/658Gf6rwE2s0y5o7BPlpbQvRTDoJpdusOUCTLNYtOSEYdhIMm9atuVA0JvEPmN
         7LyTljuUWkTZJVaodH8Itg33HIw8j+FvkdUDAnaycPxBIwIcdVh+1t//pYwq1qtnL15y
         NEWoSlR7Rloh7gcH+ZrwQCuzvwpFU0/F4y6GAfT7DHH9zRV8nY5Uq+fKGcMYgOzMDI72
         XflA==
X-Gm-Message-State: APjAAAUo7oiHjo5Ss1RhK1Fp80ZbbiCWsWxZxN2lMYNpb8N0I0iqnDHc
        8giMI5np3giCPEUxvi0Wj+4=
X-Google-Smtp-Source: APXvYqxqlmArV62RmaLNb0cFMTMjuJYURYQ3LxnTyTtF4Gy7gMvwx+xwmcYyIv++Uzvrz/jHPUHB/Q==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr4889882wrp.388.1579614381048;
        Tue, 21 Jan 2020 05:46:21 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id x17sm51590093wrt.74.2020.01.21.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:46:20 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drm/i915/bw: convert to drm_device based logging macros
Date:   Tue, 21 Jan 2020 16:45:58 +0300
Message-Id: <20200121134559.17355-5-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121134559.17355-1-wambui.karugax@gmail.com>
References: <20200121134559.17355-1-wambui.karugax@gmail.com>
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
2.17.1

