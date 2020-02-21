Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18673C11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE6208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxH0eWQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBUAFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:05:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33807 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgBUAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:05:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so248124pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=cG6xfIMmhv4aUUzpLxwO6dmYGKiY4JsX+x1sscFIGBo=;
        b=VxH0eWQXgXV0A37NybzLS45Q1yg3sL2CN8bQswEwr6dJAyeajhuIUPnyWxKhXAoack
         zLheja1zuHdZKtgTRHPqCMlR6riEI0p0ke+O5Re9d9vv1A/qKQvcc5qnOfwkolKwtX5o
         BQ5VEXseArBchh2+vdkPOSwrPuRlA/q1ovt0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=cG6xfIMmhv4aUUzpLxwO6dmYGKiY4JsX+x1sscFIGBo=;
        b=l5IKFAUiPU25fb19HJ7eDGlK8HXuX7Mhe8VLY3KqiD8wdXGRnXQyAr/EM+y2vywape
         3xEZM06/o5qUxMjA838X27wpYLYImkfJtM2soQEWV9+TLJ9PWwd2sikCLVAeX8MVet4R
         gwkG+GGaOLGpJ/QQ5VU+bocfpUKdbhDDQSAs9Bch1vHaWEpqNAyO5pTuiFWxVDc2FlQj
         qVpQyk10uyO343METNzz8CKz+fRbnzj5nSFndFkoRfn2CrB5ucd6QnH4MMA+7VTieEnA
         e1UDBWfBC9SSdTYecfLxrsnEmFEhiP/ZXBp5M2XsqEKP8Gu2dUo0RJ6ejqbTkAusoXtd
         XKLw==
X-Gm-Message-State: APjAAAU2bKCr5GKHkpoNJdRJyGdt2168Chtaxik98JJmGrJtORV0/xnO
        8TktEQCWL8CKKIfOIqsLFYrCFw==
X-Google-Smtp-Source: APXvYqwWrrCqyu+iKf6CKoTvIQXFlxyK58QKsqtU8gZfU9zUdaxuG26kbF1OKSnBPVnJHm/N4i6Ckw==
X-Received: by 2002:a63:7802:: with SMTP id t2mr34514449pgc.352.1582243519903;
        Thu, 20 Feb 2020 16:05:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm688647pfn.113.2020.02.20.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 16:05:18 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:05:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915: Distribute switch variables for initialization
Message-ID: <202002201602.92CADF7D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
drivers/gpu/drm/i915/display/intel_display.c:12963:17: warning: statement will never be executed [-Wswitch-unreachable]
12963 |    unsigned int port_mask;
      |                 ^~~~~~~~~

drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_get_fifo_size’:
drivers/gpu/drm/i915/intel_pm.c:474:7: warning: statement will never be executed [-Wswitch-unreachable]
  474 |   u32 dsparb, dsparb2, dsparb3;
      |       ^~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_atomic_update_fifo’:
drivers/gpu/drm/i915/intel_pm.c:1997:7: warning: statement will never be executed [-Wswitch-unreachable]
 1997 |   u32 dsparb, dsparb2, dsparb3;
      |       ^~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: remove port_mask entirely (Ville Syrjälä)
v1: https://lore.kernel.org/lkml/20200220062258.68854-1-keescook@chromium.org
---
 drivers/gpu/drm/i915/display/intel_display.c | 7 ++-----
 drivers/gpu/drm/i915/intel_pm.c              | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 064dd99bbc49..5f8c61932e82 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -12960,7 +12960,6 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
 		WARN_ON(!connector_state->crtc);
 
 		switch (encoder->type) {
-			unsigned int port_mask;
 		case INTEL_OUTPUT_DDI:
 			if (WARN_ON(!HAS_DDI(to_i915(dev))))
 				break;
@@ -12968,13 +12967,11 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
 		case INTEL_OUTPUT_DP:
 		case INTEL_OUTPUT_HDMI:
 		case INTEL_OUTPUT_EDP:
-			port_mask = 1 << encoder->port;
-
 			/* the same port mustn't appear more than once */
-			if (used_ports & port_mask)
+			if (used_ports & BIT(encoder->port))
 				ret = false;
 
-			used_ports |= port_mask;
+			used_ports |= BIT(encoder->port);
 			break;
 		case INTEL_OUTPUT_DP_MST:
 			used_mst_ports |=
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index bd2d30ecc030..17d8833787c4 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -469,9 +469,9 @@ static void vlv_get_fifo_size(struct intel_crtc_state *crtc_state)
 	struct vlv_fifo_state *fifo_state = &crtc_state->wm.vlv.fifo_state;
 	enum pipe pipe = crtc->pipe;
 	int sprite0_start, sprite1_start;
+	u32 dsparb, dsparb2, dsparb3;
 
 	switch (pipe) {
-		u32 dsparb, dsparb2, dsparb3;
 	case PIPE_A:
 		dsparb = I915_READ(DSPARB);
 		dsparb2 = I915_READ(DSPARB2);
@@ -1969,6 +1969,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 	const struct vlv_fifo_state *fifo_state =
 		&crtc_state->wm.vlv.fifo_state;
 	int sprite0_start, sprite1_start, fifo_size;
+	u32 dsparb, dsparb2, dsparb3;
 
 	if (!crtc_state->fifo_changed)
 		return;
@@ -1994,7 +1995,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 	spin_lock(&uncore->lock);
 
 	switch (crtc->pipe) {
-		u32 dsparb, dsparb2, dsparb3;
 	case PIPE_A:
 		dsparb = intel_uncore_read_fw(uncore, DSPARB);
 		dsparb2 = intel_uncore_read_fw(uncore, DSPARB2);
-- 
2.20.1


-- 
Kees Cook
