Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB36C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6F3217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+MtMhp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBFIAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41073 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBFIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so5912922wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9TXvvAIv1ktc+lOadfyH5nxwAQLabCXMU6OIGPJWpw=;
        b=c+MtMhp5ZKhGl6B/gzNdkWwofaDl7lu6dQxLnOxh//RXZQ48/WJQyFxxvZHmw4/cRM
         hvA4lKv/P7BxiwtDry6R48mpcRLgQmexuU7O95vajdmRfHNHOA7rkrXK+QBl9h46LNm8
         4rMVwjgDU8yFSQBFykU9BP1xMhLGbd8xCfeLRXZPF+SP33dv+seAqnuTVh/a6kib7BW/
         Co+WrChHzDLwnFJi9UTp9Y9DtAl/SJKvcNHXlpZ2Rm+qGPcU5H7+7yfQBR+QetinZrhX
         Wjvs+iGH9H38QQo80qU1ffruUbvSNPuQa5zVltXIazzZULlLm7XnqlSpalRhIhYXZWUv
         TNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9TXvvAIv1ktc+lOadfyH5nxwAQLabCXMU6OIGPJWpw=;
        b=LpL+kytog98rgNGY7YKv+bjSIcNnEEo0NHXQgqEmakZ9iKTXHjCqX7yPSoq2Pdl15m
         x39lRrq5j1NQ//5p/1qe02dyseGkfyXS3dsN5e7xmug4XN3Rs5R9K6dOXKhFCjSH+ave
         vjaTDtNawN96qcsVlW1X/pTX1s0KPHKTJl1TKuKfv1mw+aT6CBQUq1Dzcttc2E690gk/
         HNlOp0uKEH77fwwKFqOYY6FOZarRZA10UkWAoM43KV5QOBfD906yjcNknZpYrNXwZnyJ
         rUEWujsSsMYqcEIxW58ivCf76a5I0Qe5B+N8obQk0wXq3GHWLhQV8BeUztHV1+9RW/6/
         FNAQ==
X-Gm-Message-State: APjAAAWAZh1ql/jrhVJhi5G42YDvqZfWjWT82C+OeTeDQ3XXLjefQiOi
        32TPuwb16rzFrIcug106frg=
X-Google-Smtp-Source: APXvYqwjMe2XeMZHYpE496JlFECUDB7RuG3298/fC33PX2NY+dNAw9YhF34ToPQVv6iXKS+gxV2Agg==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr2320668wra.8.1580976035462;
        Thu, 06 Feb 2020 00:00:35 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:34 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] drm/i915/atomic: conversion to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:04 +0300
Message-Id: <20200206080014.13759-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of the printk based drm logging macros to the struct
drm_device based logging macros in i915/display/intel_atomic.c
This change was achieved using the following coccinelle script that
matches based on the existence of a drm_i915_private device pointer:
@@
identifier fn, T;
@@

fn(...,struct drm_i915_private *T,...) {
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
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

@@
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
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

Checkpatch warnings were fixed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_atomic.c | 23 ++++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index 379c12f3b1d4..d043057d2fa0 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -66,8 +66,9 @@ int intel_digital_connector_atomic_get_property(struct drm_connector *connector,
 	else if (property == dev_priv->broadcast_rgb_property)
 		*val = intel_conn_state->broadcast_rgb;
 	else {
-		DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
-				 property->base.id, property->name);
+		drm_dbg_atomic(&dev_priv->drm,
+			       "Unknown property [PROP:%d:%s]\n",
+			       property->base.id, property->name);
 		return -EINVAL;
 	}
 
@@ -103,8 +104,8 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
 		return 0;
 	}
 
-	DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
-			 property->base.id, property->name);
+	drm_dbg_atomic(&dev_priv->drm, "Unknown property [PROP:%d:%s]\n",
+		       property->base.id, property->name);
 	return -EINVAL;
 }
 
@@ -362,8 +363,8 @@ static void intel_atomic_setup_scaler(struct intel_crtc_scaler_state *scaler_sta
 		mode = SKL_PS_SCALER_MODE_DYN;
 	}
 
-	DRM_DEBUG_KMS("Attached scaler id %u.%u to %s:%d\n",
-		      intel_crtc->pipe, *scaler_id, name, idx);
+	drm_dbg_kms(&dev_priv->drm, "Attached scaler id %u.%u to %s:%d\n",
+		    intel_crtc->pipe, *scaler_id, name, idx);
 	scaler_state->scalers[*scaler_id].mode = mode;
 }
 
@@ -414,8 +415,9 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 
 	/* fail if required scalers > available scalers */
 	if (num_scalers_need > intel_crtc->num_scalers){
-		DRM_DEBUG_KMS("Too many scaling requests %d > %d\n",
-			num_scalers_need, intel_crtc->num_scalers);
+		drm_dbg_kms(&dev_priv->drm,
+			    "Too many scaling requests %d > %d\n",
+			    num_scalers_need, intel_crtc->num_scalers);
 		return -EINVAL;
 	}
 
@@ -460,8 +462,9 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 				plane = drm_plane_from_index(&dev_priv->drm, i);
 				state = drm_atomic_get_plane_state(drm_state, plane);
 				if (IS_ERR(state)) {
-					DRM_DEBUG_KMS("Failed to add [PLANE:%d] to drm_state\n",
-						plane->base.id);
+					drm_dbg_kms(&dev_priv->drm,
+						    "Failed to add [PLANE:%d] to drm_state\n",
+						    plane->base.id);
 					return PTR_ERR(state);
 				}
 			}
-- 
2.25.0

