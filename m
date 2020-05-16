Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7FAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EF620671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGmFPqdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEPCgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 22:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgEPCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 22:36:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B3C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:36:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i13so4055924oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPeuzuHEDvzwNnkRCqowgBAU6EUQ7TCPeetBb+t1Bdo=;
        b=aGmFPqdutHEPouBg3Si9ID8mt8l+QV684XJPaZrlFTWA7mam49jOuR0mXI2jOavU8z
         lrkl20RBQ0BVaopc7Yb3YJqEUcJnp3ShFPF6HjwKi31C1ZqciisHIWuGF6Nu0c+75mKx
         nMNYULyB0bTOEw/EAx5Pn3EMUZcEUwXjbJ0GomitQYbc73J0qApYBwf+gQz8ygkF3Au8
         n2/uk/gL2wQJ0KDNbbGonwu02NtWBXva+NKSKSZG5MBrVFEV+AwhLGzJc3/DfDWTkYCQ
         eCPhu6V+nHt37Ub/Yy+Zpwcoki+EAfgTtg8e23OWIlxwNPpAUjWZlInl31PJ1r8H/tuU
         Ch6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPeuzuHEDvzwNnkRCqowgBAU6EUQ7TCPeetBb+t1Bdo=;
        b=UlxnDqm2N/juHZo55BfuN6rHj16CZQA9jl8gbYuuWQKGoOw94iyOr14Aj5X52uo4EC
         K7gCbW0AuR0eHw/6Tc9OV+L6ja+oAQqsly8aEI/BVwqkshzKH4G+OJM9GxfEHj8RMan/
         2u3HNUa6v0mJexEjBqvvVZUsJuiGjo0O3nIbZ2Z/ZnbBMkqnwUYtuvwoW6eObK1BBEdq
         vlYv8aZeZ8IDLKo6UzsjVwNlLT9eAcScooXnifvtGYKK//FPohKB2uUksNI7QVrxI1rf
         iD8Bz5ipCagTf0L8V4xi7+zHXFlEOkN7Ky0i7iQzvOmitKZvoZa49B5BtdS8Q3v4ehYN
         9H0w==
X-Gm-Message-State: AOAM532vcC/SHgDVvT74V6XwSjzRqriS26q/4nwFZjZb4G2rR7lR7oX+
        5EShhkld0VFnunOmTdQ0A924z2is
X-Google-Smtp-Source: ABdhPJy47Nsv2i4H/OPmjeTG+IFTltW99Dl2+E64qa4UnzF9iYY27a+pUPAga7zdZ/0Ztw3+0h5YWA==
X-Received: by 2002:aca:908:: with SMTP id 8mr4438837oij.170.1589596563884;
        Fri, 15 May 2020 19:36:03 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t15sm1112821oov.32.2020.05.15.19.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 19:36:03 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Mark check_shadow_context_ppgtt as maybe unused
Date:   Fri, 15 May 2020 19:35:45 -0700
Message-Id: <20200516023545.3332334-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DRM_I915_DEBUG_GEM is not set, clang warns:

drivers/gpu/drm/i915/gvt/scheduler.c:884:1: warning: function
'check_shadow_context_ppgtt' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
check_shadow_context_ppgtt(struct execlist_ring_context *c, struct
intel_vgpu_mm *m)
^
1 warning generated.

This warning is similar to -Wunused-function but rather than warning
that the function is completely unused, it warns that it is used in some
expression within the file but that expression will be evaluated to a
constant or be optimized away in the final assembly, essentially making
it appeared used but really isn't. Usually, this happens when a function
or variable is only used in sizeof, where it will appear to be used but
will be evaluated at compile time and not be required to be emitted.

In this case, the function is only used in GEM_BUG_ON, which is defined
as BUILD_BUG_ON_INVALID, which intentionally follows this pattern. To
fix this warning, add __maybe_unused to make it clear that this is
intentional depending on the configuration.

Fixes: bec3df930fbd ("drm/i915/gvt: Support PPGTT table load command")
Link: https://github.com/ClangBuiltLinux/linux/issues/1027
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index f776c92de8d7..0fb1df71c637 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -880,7 +880,7 @@ static void update_guest_pdps(struct intel_vgpu *vgpu,
 				gpa + i * 8, &pdp[7 - i], 4);
 }
 
-static bool
+static __maybe_unused bool
 check_shadow_context_ppgtt(struct execlist_ring_context *c, struct intel_vgpu_mm *m)
 {
 	if (m->ppgtt_mm.root_entry_type == GTT_TYPE_PPGTT_ROOT_L4_ENTRY) {

base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9
-- 
2.26.2

