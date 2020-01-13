Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3088C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DDD207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFs7/wmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMLKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:10:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:10:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so8094442wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwOMo9RWTvjYspMQqt6dm8ILGLsYUwrg2cS9QS90yqM=;
        b=hFs7/wmyTfbC7PWGh95ZKuoSvVelOoO/NOxBSt4H2zGyD11no2dGvtZ26PiEmlHUfu
         4JEu9ow2GQAn+JNaQFQKk4Od/fX1UsLavzR1+i8ATdPQS1SfEHeNGucFFBG/DWZvubVM
         OEHcyUjDXFc+34qu6O9HA8KO52dfzbCZbmhfGlxJgGJUEj4GfFIcLCSjbMJ5rq1zfPS8
         scGKcBz69u0/DMJmDxiTDGC0o/919tN/70fZmvgqIe3sfntcXUE3zBRlSTdqM/qBuARb
         m1qVXctjNJz3dPkPkjlvUeQLd49pEUTMMv/VgeVu+ST8yIcv3JPxai246wvBTF+Gm6qj
         xqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwOMo9RWTvjYspMQqt6dm8ILGLsYUwrg2cS9QS90yqM=;
        b=VlIYfPSF/TloxV9kEGc7KLACg7Xa71HznSdSxR/31MVrLXAc4YebPqY4eh5w7J4tdB
         smB67vsxCv8ynrX1qGIG9X1lwmJljzGw6WB/Fjtj4EhMZG2NFdPGEny5StHyz0apW1rV
         8Dq6R5lpoGYrTjRpsQhwr6clC+YjLiRc17kN62fHYobJDXoV48IcqEbntNNIq4n/nrt0
         uCTkIjiMZalSGBU9QKYaRLrh9wyYiN89eC7mzVeKCzfdk8ClGRu2AKWnHEn8sQngmESV
         R/YbEKVhpabnI1WslvRgnDRDynNt5StHzueeckMe3Lc9QKgIXuzkW5X4PrDrR4XLBIQC
         cGjA==
X-Gm-Message-State: APjAAAWslW5Z/XhIzoDoeG+w2dKqpJdvLQXGfvG24WfjLQH3ATmS/yxy
        b4I5KO51n+4DLiNcM5ZwLn8=
X-Google-Smtp-Source: APXvYqzLO1asWyUUWyzPK9XCsDnmHI1+4ggdX7Nq4vXAxBcJ1kPkqEtlIRkpA6l9TYatk/ui8c6JRw==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr17236521wrm.135.1578913832384;
        Mon, 13 Jan 2020 03:10:32 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id k11sm13390955wmc.20.2020.01.13.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 03:10:31 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: convert to new logging macros based on struct intel_engine_cs.
Date:   Mon, 13 Jan 2020 14:10:25 +0300
Message-Id: <20200113111025.2048-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extracts the struct drm_i915_private device from struct
intel_engine_cs and converts the printk based logging macros to the
struct drm_based logging macros using the extracted struct.
This transformation was achieved using the following coccinelle script:
@rule1@
identifier fn, T, E;
@@

fn(struct intel_engine_cs *T,...) {
struct drm_i915_private *E = ...;
<+...
(
-DRM_INFO(
+drm_info(&E->drm,
...)
|
-DRM_ERROR(
+drm_err(&E->drm,
...)
|
-DRM_WARN(
+drm_warn(&E->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&E->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&E->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&E->drm,
...)
)
...+>
}

@rule2@
identifier fn, E;
@@

fn(...) {
...
struct intel_engine_cs *E = ...;
+struct drm_i915_private *dev_priv = E->i915;
<+...
(
-DRM_INFO(
+drm_info(&dev_priv->drm,
...)
|
-DRM_ERROR(
+drm_err(&dev_priv->drm,
...)
|
-DRM_WARN(
+drm_warn(&dev_priv->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&dev_priv->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&dev_priv->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&E->drm,
...)
)
...+>
}

@rule3@
identifier fn, E;
@@

fn(struct intel_engine_cs *E,...) {
+struct drm_i915_private *dev_priv = E->i915;
<+...
(
-DRM_INFO(
+drm_info(&dev_priv->drm,
...)
|
-DRM_ERROR(
+drm_err(&dev_priv->drm,
...)
|
-DRM_WARN(
+drm_warn(&dev_priv->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&dev_priv->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&dev_priv->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&dev_priv->drm,
...)
)
...+>
}

Checkpatch warnings were addressed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  3 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 12 ++-
 drivers/gpu/drm/i915/gt/intel_reset.c         | 19 ++--
 .../gpu/drm/i915/gt/intel_ring_submission.c   | 33 +++----
 drivers/gpu/drm/i915/i915_cmd_parser.c        | 88 +++++++++++--------
 5 files changed, 94 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index f451ef376548..10b4ed74b416 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -532,6 +532,7 @@ static int pin_ggtt_status_page(struct intel_engine_cs *engine,
 
 static int init_status_page(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	void *vaddr;
@@ -546,7 +547,7 @@ static int init_status_page(struct intel_engine_cs *engine)
 	 */
 	obj = i915_gem_object_create_internal(engine->i915, PAGE_SIZE);
 	if (IS_ERR(obj)) {
-		DRM_ERROR("Failed to allocate status page\n");
+		drm_err(&dev_priv->drm, "Failed to allocate status page\n");
 		return PTR_ERR(obj);
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 9af1b2b493f4..f2a260efb75f 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -2943,6 +2943,7 @@ typedef u32 *(*wa_bb_func_t)(struct intel_engine_cs *engine, u32 *batch);
 
 static int intel_init_workaround_bb(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct i915_ctx_workarounds *wa_ctx = &engine->wa_ctx;
 	struct i915_wa_ctx_bb *wa_bb[2] = { &wa_ctx->indirect_ctx,
 					    &wa_ctx->per_ctx };
@@ -2978,7 +2979,8 @@ static int intel_init_workaround_bb(struct intel_engine_cs *engine)
 
 	ret = lrc_setup_wa_ctx(engine);
 	if (ret) {
-		DRM_DEBUG_DRIVER("Failed to setup context WA page: %d\n", ret);
+		drm_dbg(&dev_priv->drm,
+			"Failed to setup context WA page: %d\n", ret);
 		return ret;
 	}
 
@@ -3037,10 +3039,12 @@ static void enable_execlists(struct intel_engine_cs *engine)
 
 static bool unexpected_starting_state(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	bool unexpected = false;
 
 	if (ENGINE_READ_FW(engine, RING_MI_MODE) & STOP_RING) {
-		DRM_DEBUG_DRIVER("STOP_RING still set in RING_MI_MODE\n");
+		drm_dbg(&dev_priv->drm,
+			"STOP_RING still set in RING_MI_MODE\n");
 		unexpected = true;
 	}
 
@@ -3976,6 +3980,7 @@ static void rcs_submission_override(struct intel_engine_cs *engine)
 
 int intel_execlists_submission_setup(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct intel_engine_execlists * const execlists = &engine->execlists;
 	struct drm_i915_private *i915 = engine->i915;
 	struct intel_uncore *uncore = engine->uncore;
@@ -3998,7 +4003,8 @@ int intel_execlists_submission_setup(struct intel_engine_cs *engine)
 		 * because we only expect rare glitches but nothing
 		 * critical to prevent us from using GPU
 		 */
-		DRM_ERROR("WA batch buffer initialization failed\n");
+		drm_err(&dev_priv->drm,
+			"WA batch buffer initialization failed\n");
 
 	if (HAS_LOGICAL_RING_ELSQ(i915)) {
 		execlists->submit_reg = uncore->regs +
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index beee0cf89bce..4a9c787ce677 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -337,6 +337,7 @@ static int gen6_reset_engines(struct intel_gt *gt,
 
 static int gen11_lock_sfc(struct intel_engine_cs *engine, u32 *hw_mask)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct intel_uncore *uncore = engine->uncore;
 	u8 vdbox_sfc_access = RUNTIME_INFO(engine->i915)->vdbox_sfc_access;
 	i915_reg_t sfc_forced_lock, sfc_forced_lock_ack;
@@ -401,7 +402,8 @@ static int gen11_lock_sfc(struct intel_engine_cs *engine, u32 *hw_mask)
 		return 0;
 
 	if (ret) {
-		DRM_DEBUG_DRIVER("Wait for SFC forced lock ack failed\n");
+		drm_dbg(&dev_priv->drm,
+			"Wait for SFC forced lock ack failed\n");
 		return ret;
 	}
 
@@ -487,6 +489,7 @@ static int gen11_reset_engines(struct intel_gt *gt,
 
 static int gen8_engine_reset_prepare(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct intel_uncore *uncore = engine->uncore;
 	const i915_reg_t reg = RING_RESET_CTL(engine->mmio_base);
 	u32 request, mask, ack;
@@ -515,9 +518,10 @@ static int gen8_engine_reset_prepare(struct intel_engine_cs *engine)
 	ret = __intel_wait_for_register_fw(uncore, reg, mask, ack,
 					   700, 0, NULL);
 	if (ret)
-		DRM_ERROR("%s reset request timed out: {request: %08x, RESET_CTL: %08x}\n",
-			  engine->name, request,
-			  intel_uncore_read_fw(uncore, reg));
+		drm_err(&dev_priv->drm,
+			"%s reset request timed out: {request: %08x, RESET_CTL: %08x}\n",
+			engine->name, request,
+			intel_uncore_read_fw(uncore, reg));
 
 	return ret;
 }
@@ -1103,6 +1107,7 @@ static inline int intel_gt_reset_engine(struct intel_engine_cs *engine)
  */
 int intel_engine_reset(struct intel_engine_cs *engine, const char *msg)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	struct intel_gt *gt = engine->gt;
 	bool uses_guc = intel_engine_in_guc_submission_mode(engine);
 	int ret;
@@ -1126,9 +1131,9 @@ int intel_engine_reset(struct intel_engine_cs *engine, const char *msg)
 		ret = intel_guc_reset_engine(&engine->gt->uc.guc, engine);
 	if (ret) {
 		/* If we fail here, we expect to fallback to a global reset */
-		DRM_DEBUG_DRIVER("%sFailed to reset %s, ret=%d\n",
-				 uses_guc ? "GuC " : "",
-				 engine->name, ret);
+		drm_dbg(&dev_priv->drm, "%sFailed to reset %s, ret=%d\n",
+			uses_guc ? "GuC " : "",
+			engine->name, ret);
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index bc44fe8e5ffa..bf6ab719d8a0 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -577,8 +577,9 @@ static void flush_cs_tlb(struct intel_engine_cs *engine)
 				    RING_INSTPM(engine->mmio_base),
 				    INSTPM_SYNC_FLUSH, 0,
 				    1000))
-		DRM_ERROR("%s: wait for SyncFlush to complete for TLB invalidation timed out\n",
-			  engine->name);
+		drm_err(&dev_priv->drm,
+			"%s: wait for SyncFlush to complete for TLB invalidation timed out\n",
+			engine->name);
 }
 
 static void ring_setup_status_page(struct intel_engine_cs *engine)
@@ -601,8 +602,9 @@ static bool stop_ring(struct intel_engine_cs *engine)
 					    MODE_IDLE,
 					    MODE_IDLE,
 					    1000)) {
-			DRM_ERROR("%s : timed out trying to stop ring\n",
-				  engine->name);
+			drm_err(&dev_priv->drm,
+				"%s : timed out trying to stop ring\n",
+				engine->name);
 
 			/*
 			 * Sometimes we observe that the idle flag is not
@@ -640,22 +642,23 @@ static int xcs_resume(struct intel_engine_cs *engine)
 	/* WaClearRingBufHeadRegAtInit:ctg,elk */
 	if (!stop_ring(engine)) {
 		/* G45 ring initialization often fails to reset head to zero */
-		DRM_DEBUG_DRIVER("%s head not reset to zero "
+		drm_dbg(&dev_priv->drm, "%s head not reset to zero "
+			"ctl %08x head %08x tail %08x start %08x\n",
+			engine->name,
+			ENGINE_READ(engine, RING_CTL),
+			ENGINE_READ(engine, RING_HEAD),
+			ENGINE_READ(engine, RING_TAIL),
+			ENGINE_READ(engine, RING_START));
+
+		if (!stop_ring(engine)) {
+			drm_err(&dev_priv->drm,
+				"failed to set %s head to zero "
 				"ctl %08x head %08x tail %08x start %08x\n",
 				engine->name,
 				ENGINE_READ(engine, RING_CTL),
 				ENGINE_READ(engine, RING_HEAD),
 				ENGINE_READ(engine, RING_TAIL),
 				ENGINE_READ(engine, RING_START));
-
-		if (!stop_ring(engine)) {
-			DRM_ERROR("failed to set %s head to zero "
-				  "ctl %08x head %08x tail %08x start %08x\n",
-				  engine->name,
-				  ENGINE_READ(engine, RING_CTL),
-				  ENGINE_READ(engine, RING_HEAD),
-				  ENGINE_READ(engine, RING_TAIL),
-				  ENGINE_READ(engine, RING_START));
 			ret = -EIO;
 			goto out;
 		}
@@ -696,7 +699,7 @@ static int xcs_resume(struct intel_engine_cs *engine)
 				    RING_CTL(engine->mmio_base),
 				    RING_VALID, RING_VALID,
 				    50)) {
-		DRM_ERROR("%s initialization failed "
+		drm_err(&dev_priv->drm, "%s initialization failed "
 			  "ctl %08x (valid? %d) head %08x [%08x] tail %08x [%08x] start %08x [expected %08x]\n",
 			  engine->name,
 			  ENGINE_READ(engine, RING_CTL),
diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
index a0e437aa65b7..b66c5e3bdd2a 100644
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -786,6 +786,7 @@ static bool validate_cmds_sorted(const struct intel_engine_cs *engine,
 				 const struct drm_i915_cmd_table *cmd_tables,
 				 int cmd_table_count)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	int i;
 	bool ret = true;
 
@@ -803,10 +804,11 @@ static bool validate_cmds_sorted(const struct intel_engine_cs *engine,
 			u32 curr = desc->cmd.value & desc->cmd.mask;
 
 			if (curr < previous) {
-				DRM_ERROR("CMD: %s [%d] command table not sorted: "
-					  "table=%d entry=%d cmd=0x%08X prev=0x%08X\n",
-					  engine->name, engine->id,
-					  i, j, curr, previous);
+				drm_err(&dev_priv->drm,
+					"CMD: %s [%d] command table not sorted: "
+					"table=%d entry=%d cmd=0x%08X prev=0x%08X\n",
+					engine->name, engine->id,
+					i, j, curr, previous);
 				ret = false;
 			}
 
@@ -821,6 +823,7 @@ static bool check_sorted(const struct intel_engine_cs *engine,
 			 const struct drm_i915_reg_descriptor *reg_table,
 			 int reg_count)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	int i;
 	u32 previous = 0;
 	bool ret = true;
@@ -829,10 +832,11 @@ static bool check_sorted(const struct intel_engine_cs *engine,
 		u32 curr = i915_mmio_reg_offset(reg_table[i].addr);
 
 		if (curr < previous) {
-			DRM_ERROR("CMD: %s [%d] register table not sorted: "
-				  "entry=%d reg=0x%08X prev=0x%08X\n",
-				  engine->name, engine->id,
-				  i, curr, previous);
+			drm_err(&dev_priv->drm,
+				"CMD: %s [%d] register table not sorted: "
+				"entry=%d reg=0x%08X prev=0x%08X\n",
+				engine->name, engine->id,
+				i, curr, previous);
 			ret = false;
 		}
 
@@ -935,6 +939,7 @@ static void fini_hash_table(struct intel_engine_cs *engine)
  */
 void intel_engine_init_cmd_parser(struct intel_engine_cs *engine)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	const struct drm_i915_cmd_table *cmd_tables;
 	int cmd_table_count;
 	int ret;
@@ -1010,18 +1015,21 @@ void intel_engine_init_cmd_parser(struct intel_engine_cs *engine)
 	}
 
 	if (!validate_cmds_sorted(engine, cmd_tables, cmd_table_count)) {
-		DRM_ERROR("%s: command descriptions are not sorted\n",
-			  engine->name);
+		drm_err(&dev_priv->drm,
+			"%s: command descriptions are not sorted\n",
+			engine->name);
 		return;
 	}
 	if (!validate_regs_sorted(engine)) {
-		DRM_ERROR("%s: registers are not sorted\n", engine->name);
+		drm_err(&dev_priv->drm, "%s: registers are not sorted\n",
+			engine->name);
 		return;
 	}
 
 	ret = init_hash_table(engine, cmd_tables, cmd_table_count);
 	if (ret) {
-		DRM_ERROR("%s: initialised failed!\n", engine->name);
+		drm_err(&dev_priv->drm, "%s: initialised failed!\n",
+			engine->name);
 		fini_hash_table(engine);
 		return;
 	}
@@ -1199,11 +1207,13 @@ static bool check_cmd(const struct intel_engine_cs *engine,
 		      const struct drm_i915_cmd_descriptor *desc,
 		      const u32 *cmd, u32 length)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	if (desc->flags & CMD_DESC_SKIP)
 		return true;
 
 	if (desc->flags & CMD_DESC_REJECT) {
-		DRM_DEBUG("CMD: Rejected command: 0x%08X\n", *cmd);
+		drm_dbg(&dev_priv->drm, "CMD: Rejected command: 0x%08X\n",
+			*cmd);
 		return false;
 	}
 
@@ -1223,8 +1233,9 @@ static bool check_cmd(const struct intel_engine_cs *engine,
 				find_reg(engine, reg_addr);
 
 			if (!reg) {
-				DRM_DEBUG("CMD: Rejected register 0x%08X in command: 0x%08X (%s)\n",
-					  reg_addr, *cmd, engine->name);
+				drm_dbg(&dev_priv->drm,
+					"CMD: Rejected register 0x%08X in command: 0x%08X (%s)\n",
+					reg_addr, *cmd, engine->name);
 				return false;
 			}
 
@@ -1234,22 +1245,25 @@ static bool check_cmd(const struct intel_engine_cs *engine,
 			 */
 			if (reg->mask) {
 				if (desc->cmd.value == MI_LOAD_REGISTER_MEM) {
-					DRM_DEBUG("CMD: Rejected LRM to masked register 0x%08X\n",
-						  reg_addr);
+					drm_dbg(&dev_priv->drm,
+						"CMD: Rejected LRM to masked register 0x%08X\n",
+						reg_addr);
 					return false;
 				}
 
 				if (desc->cmd.value == MI_LOAD_REGISTER_REG) {
-					DRM_DEBUG("CMD: Rejected LRR to masked register 0x%08X\n",
-						  reg_addr);
+					drm_dbg(&dev_priv->drm,
+						"CMD: Rejected LRR to masked register 0x%08X\n",
+						reg_addr);
 					return false;
 				}
 
 				if (desc->cmd.value == MI_LOAD_REGISTER_IMM(1) &&
 				    (offset + 2 > length ||
 				     (cmd[offset + 1] & reg->mask) != reg->value)) {
-					DRM_DEBUG("CMD: Rejected LRI to masked register 0x%08X\n",
-						  reg_addr);
+					drm_dbg(&dev_priv->drm,
+						"CMD: Rejected LRI to masked register 0x%08X\n",
+						reg_addr);
 					return false;
 				}
 			}
@@ -1276,8 +1290,9 @@ static bool check_cmd(const struct intel_engine_cs *engine,
 			}
 
 			if (desc->bits[i].offset >= length) {
-				DRM_DEBUG("CMD: Rejected command 0x%08X, too short to check bitmask (%s)\n",
-					  *cmd, engine->name);
+				drm_dbg(&dev_priv->drm,
+					"CMD: Rejected command 0x%08X, too short to check bitmask (%s)\n",
+					*cmd, engine->name);
 				return false;
 			}
 
@@ -1285,11 +1300,12 @@ static bool check_cmd(const struct intel_engine_cs *engine,
 				desc->bits[i].mask;
 
 			if (dword != desc->bits[i].expected) {
-				DRM_DEBUG("CMD: Rejected command 0x%08X for bitmask 0x%08X (exp=0x%08X act=0x%08X) (%s)\n",
-					  *cmd,
-					  desc->bits[i].mask,
-					  desc->bits[i].expected,
-					  dword, engine->name);
+				drm_dbg(&dev_priv->drm,
+					"CMD: Rejected command 0x%08X for bitmask 0x%08X (exp=0x%08X act=0x%08X) (%s)\n",
+					*cmd,
+					desc->bits[i].mask,
+					desc->bits[i].expected,
+					dword, engine->name);
 				return false;
 			}
 		}
@@ -1404,6 +1420,7 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 			    struct i915_vma *shadow,
 			    bool trampoline)
 {
+	struct drm_i915_private *dev_priv = engine->i915;
 	u32 *cmd, *batch_end, offset = 0;
 	struct drm_i915_cmd_descriptor default_desc = noop_desc;
 	const struct drm_i915_cmd_descriptor *desc = &default_desc;
@@ -1419,7 +1436,7 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 
 	cmd = copy_batch(shadow->obj, batch->obj, batch_offset, batch_length);
 	if (IS_ERR(cmd)) {
-		DRM_DEBUG("CMD: Failed to copy batch\n");
+		drm_dbg(&dev_priv->drm, "CMD: Failed to copy batch\n");
 		return PTR_ERR(cmd);
 	}
 
@@ -1445,7 +1462,8 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 
 		desc = find_cmd(engine, *cmd, desc, &default_desc);
 		if (!desc) {
-			DRM_DEBUG("CMD: Unrecognized command: 0x%08X\n", *cmd);
+			drm_dbg(&dev_priv->drm,
+				"CMD: Unrecognized command: 0x%08X\n", *cmd);
 			ret = -EINVAL;
 			break;
 		}
@@ -1456,10 +1474,9 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 			length = (*cmd & desc->length.mask) + LENGTH_BIAS;
 
 		if ((batch_end - cmd) < length) {
-			DRM_DEBUG("CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
-				  *cmd,
-				  length,
-				  batch_end - cmd);
+			drm_dbg(&dev_priv->drm,
+				"CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
+				*cmd, length, batch_end - cmd);
 			ret = -EINVAL;
 			break;
 		}
@@ -1482,7 +1499,8 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 		cmd += length;
 		offset += length;
 		if  (cmd >= batch_end) {
-			DRM_DEBUG("CMD: Got to the end of the buffer w/o a BBE cmd!\n");
+			drm_dbg(&dev_priv->drm,
+				"CMD: Got to the end of the buffer w/o a BBE cmd!\n");
 			ret = -EINVAL;
 			break;
 		}
-- 
2.24.1

