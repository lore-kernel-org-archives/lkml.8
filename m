Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53592C11D41
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C2324656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXqOb0Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBTGXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38301 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1388710pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbfAO2fSu64pq6u1mWmQFfQ48eFbdaGtUu7sTtkiZVI=;
        b=eXqOb0Xq8yLMYkfMLFRWCv/9zeTHUJq2FN9U8UeFKeGFdm0DD5tRSl8YdQnwOJyO03
         X7mT5Htx9fTxmkf6Diejdm6vkmBC94zAgA6RqlYSMdwekesiRIWnmujIHQYBfo9nil7i
         LyWoECEDCeGzvEdh6DJrR01qVSjrXeuBbI9hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbfAO2fSu64pq6u1mWmQFfQ48eFbdaGtUu7sTtkiZVI=;
        b=Xyonv7/GAuNMWbKkNbzGhCr6sAlQ/Q4R4ruoCMgZBBrGcP/bCpWVbuIYbBKgkzW62q
         zty6IOvzwJvwIV4r1W1JCQSR2Bco3Qjx5twErX6JpLB/3uADaSoZMFWpc+lyqAQlpRoq
         8SckH2tflpoM6OXRWZHEzTR4eBf+rxtERxXDxTO+7mp+6RsodyuU36vChSWuryRLUMe1
         qV19cVSQqvFhe/GRhY3gdHZ7dgdjkus6IJ38zZTw0E56lm6BtS3RtJW9/FC9AUZxv3xE
         g0N16pPunVnIsMEjTYoJZ4fz4QJPxOE+/+VMAanT6LyX+SDVkQX5wjNMcatJtgoNO8Ys
         /1zA==
X-Gm-Message-State: APjAAAXCQJ1ijfQ594gbOWHkm7oeDgoXUzvmav5oHHtoYE3ncO8WI6Y5
        1n+g5kP5T62ROWbnVfwcAxIV/w==
X-Google-Smtp-Source: APXvYqxKdc3dx637nl+ZE7CYGKAsYw2ovD42uVb8xBeno/jiHtEqLviKrb5hssJUvWcJDdL7B+eXyA==
X-Received: by 2002:a63:594a:: with SMTP id j10mr32381690pgm.227.1582179783832;
        Wed, 19 Feb 2020 22:23:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2sm1747574pff.139.2020.02.19.22.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:22:58 -0800
Message-Id: <20200220062258.68854-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/gpu/drm/i915/display/intel_display.c |    6 ++++--
 drivers/gpu/drm/i915/intel_pm.c              |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 064dd99bbc49..c829cd26f99e 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -12960,14 +12960,15 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
 		WARN_ON(!connector_state->crtc);
 
 		switch (encoder->type) {
-			unsigned int port_mask;
 		case INTEL_OUTPUT_DDI:
 			if (WARN_ON(!HAS_DDI(to_i915(dev))))
 				break;
 			/* else, fall through */
 		case INTEL_OUTPUT_DP:
 		case INTEL_OUTPUT_HDMI:
-		case INTEL_OUTPUT_EDP:
+		case INTEL_OUTPUT_EDP: {
+			unsigned int port_mask;
+
 			port_mask = 1 << encoder->port;
 
 			/* the same port mustn't appear more than once */
@@ -12976,6 +12977,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
 
 			used_ports |= port_mask;
 			break;
+		}
 		case INTEL_OUTPUT_DP_MST:
 			used_mst_ports |=
 				1 << encoder->port;
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

