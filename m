Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC9DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59782467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHFXPAe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgAVM6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:58:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33452 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAVM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:58:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so4369695wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=eV/GSup/J+DPyjODj/IKt5fwIjXuxUSgJpb75W8LC6U=;
        b=VHFXPAe4iU834A+nM/yebS6BcrV6A+JdNS2XMgAfq1IjA7eSoZcuX5Owoc2fy4soVJ
         W7iqONNpfEOrg3PGPSFLYrEpYxEVLVYfqgPkVof6oeOig3QJgHjKnDGA2RNGiVYGVCvl
         65q4B3ZV954fCPQPmRXX04jTi7QpHMBZ+CgewH9i6xAiiIHxfLQUTjSmlfostp3y6+rA
         /e2qi7prHVNlzYDxZ7861lc/sBfbbu4iS8CW4W5lLocX0Gq4ilpwmV9xgmih52tWbNQr
         yRCtncVRaEcZkfVO7CvgyOFs0xkt/dKpsz42HZgQG6TcYiCMQIaqVh0IX6ZQKJ5sY+yS
         KPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=eV/GSup/J+DPyjODj/IKt5fwIjXuxUSgJpb75W8LC6U=;
        b=tCKq3R2Te/wj647LytA+xCtGtiECvU+miLhkGlnhfqj55FcD7wmEqfUar/P2zhPHci
         lfMMFHj/3/hXNrzNT7ggMnyAkcTes829Q6+dqAWfUMlFHEHYuj1hkVWrXDCjt8kV6ezD
         1nSKnMLWiPOCgoZpDsuiFW38eSFLFignJjjIBNvArzKpdr5BXEnJ6m3URnARRo5pt7tM
         H1G/TFrN0CfTco/03avaa4JLE7/WAKK95B3rcWjnP5k2x8u1Px9gyDe+FW8PsiuXCqrm
         SlS1z+wo6/LRKnqSQGxpn8q9Okk7URKvFvGfySUpFvZB1TXJESpQSGcNYoGHVSPHoZyM
         zVOw==
X-Gm-Message-State: APjAAAXyFKM455DSP5suQSirh9WpRVcyWu+nBdw112yqjC4DHYGLx+Wd
        ddimFzCYKuRljiwlDiAtBYw=
X-Google-Smtp-Source: APXvYqwg1UmK/8t4IPer6lnKvVxW0UlqpaxYbwEOYeb1DCJgWunFozUH5IDawHx9YeRgeC99ZNE+oA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr2889122wmg.140.1579697884756;
        Wed, 22 Jan 2020 04:58:04 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id p26sm3736109wmc.24.2020.01.22.04.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 04:58:04 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915/gem: manual conversion to struct drm_device logging macros.
Date:   Wed, 22 Jan 2020 15:57:50 +0300
Message-Id: <20200122125750.9737-3-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122125750.9737-1-wambui.karugax@gmail.com>
References: <20200122125750.9737-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert most of the remaining uses of the printk based logging macros to
the new struct drm_device based logging macros in drm/i915/gem.
This also involves extracting the struct drm_i915_private device
from various types, and using it in the various macros.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 41 +++++++++++--------
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 23 ++++++-----
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  4 +-
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 5432da2abda0..28b8794695be 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1444,6 +1444,7 @@ set_engines__load_balance(struct i915_user_extension __user *base, void *data)
 	struct i915_context_engines_load_balance __user *ext =
 		container_of_user(base, typeof(*ext), base);
 	const struct set_engines *set = data;
+	struct drm_i915_private *i915 = set->ctx->i915;
 	struct intel_engine_cs *stack[16];
 	struct intel_engine_cs **siblings;
 	struct intel_context *ce;
@@ -1451,24 +1452,25 @@ set_engines__load_balance(struct i915_user_extension __user *base, void *data)
 	unsigned int n;
 	int err;
 
-	if (!HAS_EXECLISTS(set->ctx->i915))
+	if (!HAS_EXECLISTS(i915))
 		return -ENODEV;
 
-	if (USES_GUC_SUBMISSION(set->ctx->i915))
+	if (USES_GUC_SUBMISSION(i915))
 		return -ENODEV; /* not implement yet */
 
 	if (get_user(idx, &ext->engine_index))
 		return -EFAULT;
 
 	if (idx >= set->engines->num_engines) {
-		DRM_DEBUG("Invalid placement value, %d >= %d\n",
-			  idx, set->engines->num_engines);
+		drm_dbg(&i915->drm, "Invalid placement value, %d >= %d\n",
+			idx, set->engines->num_engines);
 		return -EINVAL;
 	}
 
 	idx = array_index_nospec(idx, set->engines->num_engines);
 	if (set->engines->engines[idx]) {
-		DRM_DEBUG("Invalid placement[%d], already occupied\n", idx);
+		drm_dbg(&i915->drm,
+			"Invalid placement[%d], already occupied\n", idx);
 		return -EEXIST;
 	}
 
@@ -1500,12 +1502,13 @@ set_engines__load_balance(struct i915_user_extension __user *base, void *data)
 			goto out_siblings;
 		}
 
-		siblings[n] = intel_engine_lookup_user(set->ctx->i915,
+		siblings[n] = intel_engine_lookup_user(i915,
 						       ci.engine_class,
 						       ci.engine_instance);
 		if (!siblings[n]) {
-			DRM_DEBUG("Invalid sibling[%d]: { class:%d, inst:%d }\n",
-				  n, ci.engine_class, ci.engine_instance);
+			drm_dbg(&i915->drm,
+				"Invalid sibling[%d]: { class:%d, inst:%d }\n",
+				n, ci.engine_class, ci.engine_instance);
 			err = -EINVAL;
 			goto out_siblings;
 		}
@@ -1538,6 +1541,7 @@ set_engines__bond(struct i915_user_extension __user *base, void *data)
 	struct i915_context_engines_bond __user *ext =
 		container_of_user(base, typeof(*ext), base);
 	const struct set_engines *set = data;
+	struct drm_i915_private *i915 = set->ctx->i915;
 	struct i915_engine_class_instance ci;
 	struct intel_engine_cs *virtual;
 	struct intel_engine_cs *master;
@@ -1548,14 +1552,15 @@ set_engines__bond(struct i915_user_extension __user *base, void *data)
 		return -EFAULT;
 
 	if (idx >= set->engines->num_engines) {
-		DRM_DEBUG("Invalid index for virtual engine: %d >= %d\n",
-			  idx, set->engines->num_engines);
+		drm_dbg(&i915->drm,
+			"Invalid index for virtual engine: %d >= %d\n",
+			idx, set->engines->num_engines);
 		return -EINVAL;
 	}
 
 	idx = array_index_nospec(idx, set->engines->num_engines);
 	if (!set->engines->engines[idx]) {
-		DRM_DEBUG("Invalid engine at %d\n", idx);
+		drm_dbg(&i915->drm, "Invalid engine at %d\n", idx);
 		return -EINVAL;
 	}
 	virtual = set->engines->engines[idx]->engine;
@@ -1573,11 +1578,12 @@ set_engines__bond(struct i915_user_extension __user *base, void *data)
 	if (copy_from_user(&ci, &ext->master, sizeof(ci)))
 		return -EFAULT;
 
-	master = intel_engine_lookup_user(set->ctx->i915,
+	master = intel_engine_lookup_user(i915,
 					  ci.engine_class, ci.engine_instance);
 	if (!master) {
-		DRM_DEBUG("Unrecognised master engine: { class:%u, instance:%u }\n",
-			  ci.engine_class, ci.engine_instance);
+		drm_dbg(&i915->drm,
+			"Unrecognised master engine: { class:%u, instance:%u }\n",
+			ci.engine_class, ci.engine_instance);
 		return -EINVAL;
 	}
 
@@ -1590,12 +1596,13 @@ set_engines__bond(struct i915_user_extension __user *base, void *data)
 		if (copy_from_user(&ci, &ext->engines[n], sizeof(ci)))
 			return -EFAULT;
 
-		bond = intel_engine_lookup_user(set->ctx->i915,
+		bond = intel_engine_lookup_user(i915,
 						ci.engine_class,
 						ci.engine_instance);
 		if (!bond) {
-			DRM_DEBUG("Unrecognised engine[%d] for bonding: { class:%d, instance: %d }\n",
-				  n, ci.engine_class, ci.engine_instance);
+			drm_dbg(&i915->drm,
+				"Unrecognised engine[%d] for bonding: { class:%d, instance: %d }\n",
+				n, ci.engine_class, ci.engine_instance);
 			return -EINVAL;
 		}
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 61c0a837f163..cae0581d7e47 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1924,7 +1924,7 @@ static int i915_reset_gen7_sol_offsets(struct i915_request *rq)
 	int i;
 
 	if (!IS_GEN(rq->i915, 7) || rq->engine->id != RCS0) {
-		DRM_DEBUG("sol reset is gen7/rcs only\n");
+		drm_dbg(&rq->i915->drm, "sol reset is gen7/rcs only\n");
 		return -EINVAL;
 	}
 
@@ -2847,6 +2847,7 @@ int
 i915_gem_execbuffer_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *file)
 {
+	struct drm_i915_private *i915 = to_i915(dev);
 	struct drm_i915_gem_execbuffer *args = data;
 	struct drm_i915_gem_execbuffer2 exec2;
 	struct drm_i915_gem_exec_object *exec_list = NULL;
@@ -2856,7 +2857,7 @@ i915_gem_execbuffer_ioctl(struct drm_device *dev, void *data,
 	int err;
 
 	if (!check_buffer_count(count)) {
-		DRM_DEBUG("execbuf2 with %zd buffers\n", count);
+		drm_dbg(&i915->drm, "execbuf2 with %zd buffers\n", count);
 		return -EINVAL;
 	}
 
@@ -2881,8 +2882,9 @@ i915_gem_execbuffer_ioctl(struct drm_device *dev, void *data,
 	exec2_list = kvmalloc_array(count + 1, eb_element_size(),
 				    __GFP_NOWARN | GFP_KERNEL);
 	if (exec_list == NULL || exec2_list == NULL) {
-		DRM_DEBUG("Failed to allocate exec list for %d buffers\n",
-			  args->buffer_count);
+		drm_dbg(&i915->drm,
+			"Failed to allocate exec list for %d buffers\n",
+			args->buffer_count);
 		kvfree(exec_list);
 		kvfree(exec2_list);
 		return -ENOMEM;
@@ -2891,8 +2893,8 @@ i915_gem_execbuffer_ioctl(struct drm_device *dev, void *data,
 			     u64_to_user_ptr(args->buffers_ptr),
 			     sizeof(*exec_list) * count);
 	if (err) {
-		DRM_DEBUG("copy %d exec entries failed %d\n",
-			  args->buffer_count, err);
+		drm_dbg(&i915->drm, "copy %d exec entries failed %d\n",
+			args->buffer_count, err);
 		kvfree(exec_list);
 		kvfree(exec2_list);
 		return -EFAULT;
@@ -2939,6 +2941,7 @@ int
 i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file)
 {
+	struct drm_i915_private *i915 = to_i915(dev);
 	struct drm_i915_gem_execbuffer2 *args = data;
 	struct drm_i915_gem_exec_object2 *exec2_list;
 	struct drm_syncobj **fences = NULL;
@@ -2946,7 +2949,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 	int err;
 
 	if (!check_buffer_count(count)) {
-		DRM_DEBUG("execbuf2 with %zd buffers\n", count);
+		drm_dbg(&i915->drm, "execbuf2 with %zd buffers\n", count);
 		return -EINVAL;
 	}
 
@@ -2958,14 +2961,14 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 	exec2_list = kvmalloc_array(count + 1, eb_element_size(),
 				    __GFP_NOWARN | GFP_KERNEL);
 	if (exec2_list == NULL) {
-		DRM_DEBUG("Failed to allocate exec list for %zd buffers\n",
-			  count);
+		drm_dbg(&i915->drm, "Failed to allocate exec list for %zd buffers\n",
+			count);
 		return -ENOMEM;
 	}
 	if (copy_from_user(exec2_list,
 			   u64_to_user_ptr(args->buffers_ptr),
 			   sizeof(*exec2_list) * count)) {
-		DRM_DEBUG("copy %zd exec entries failed\n", count);
+		drm_dbg(&i915->drm, "copy %zd exec entries failed\n", count);
 		kvfree(exec2_list);
 		return -EFAULT;
 	}
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 54aca5c9101e..24f4cadea114 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -83,10 +83,12 @@ void __i915_gem_object_set_pages(struct drm_i915_gem_object *obj,
 
 int ____i915_gem_object_get_pages(struct drm_i915_gem_object *obj)
 {
+	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	int err;
 
 	if (unlikely(obj->mm.madv != I915_MADV_WILLNEED)) {
-		DRM_DEBUG("Attempting to obtain a purgeable object\n");
+		drm_dbg(&i915->drm,
+			"Attempting to obtain a purgeable object\n");
 		return -EFAULT;
 	}
 
-- 
2.17.1

