Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC22C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B3820692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586444865;
	bh=H+jTrKo76nvM1lKDaILVzTNeKxxR//JWLzZ/G8Xf44c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vJZlCdH0COAxJczvumZskBhybKoUy43PEdBjzayXDI0ixYYZZ8uTyrrvWSbU5cf9Q
	 kjksxInGe0vJ73+r7ZMDpAuE4TLrXc+5BSyaaVwkJ8ENQOXLTSwEElYf1n7UGWm2Ym
	 w5HPimEIMgIWiC33AfJvuLoo+v/M2knxcJkqYkVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgDIPHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:07:43 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:22789 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgDIPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:07:42 -0400
Received: from grover.flets-west.jp (softbank126125134031.bbtec.net [126.125.134.31]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 039F6Zj6025357;
        Fri, 10 Apr 2020 00:06:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 039F6Zj6025357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586444797;
        bh=3FWc8C25LITNQQg0scvue6NeZtoknDzBN+lCFDj1JxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOfo+Iv88S2F74NASApAzGboR82EULxA/WbLaWS1Sl3Uf3q91pcLBNWTeKeX9pUAv
         X+75wDSUj+frCAPA2h4WrKgenfG7uo8M9EiFlyj1+IhUW5iVaipT24ng/soW0coUWj
         sYtgbj5GFQk5W0s5xEzV3K7GLPta6E78A6Y8VzekpTb7qV/px7uoCP8VQJZA/XF3gm
         7i+/0um1vVt+w0P30BIbdMognQ1+KCNt9H19zUBeKjvf3A3f3pNJWmprhLOlDyvmft
         tD31ALtzXKnY7RwE1ywOKbbeOvCOJ8dCignjBz+Hno0nZBPWXYhNt0njIaWzWcv2AT
         CfUQSWTMhfsYQ==
X-Nifty-SrcIP: [126.125.134.31]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915: remove gvt/Makefile
Date:   Fri, 10 Apr 2020 00:06:27 +0900
Message-Id: <20200409150627.29205-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409150627.29205-1-masahiroy@kernel.org>
References: <20200409150627.29205-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including subdirectory Makefile from the driver main Makefile does not
buy us much because this is not real isolation.

Having a single Makefile at the top of the module is clearer, and
it is what this driver almost does.

Move all gvt objects to the i915 main Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/i915/Makefile     | 28 ++++++++++++++++++++++++----
 drivers/gpu/drm/i915/gvt/Makefile |  8 --------
 2 files changed, 24 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gvt/Makefile

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 6cd1f6253814..74e965882a98 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -275,10 +275,30 @@ i915-$(CONFIG_DRM_I915_SELFTEST) += \
 # virtual gpu code
 i915-y += i915_vgpu.o
 
-ifeq ($(CONFIG_DRM_I915_GVT),y)
-i915-y += intel_gvt.o
-include $(src)/gvt/Makefile
-endif
+i915-$(CONFIG_DRM_I915_GVT) += \
+	intel_gvt.o \
+	gvt/gvt.o \
+	gvt/aperture_gm.o \
+	gvt/handlers.o \
+	gvt/vgpu.o \
+	gvt/trace_points.o \
+	gvt/firmware.o \
+	gvt/interrupt.o \
+	gvt/gtt.o \
+	gvt/cfg_space.o \
+	gvt/opregion.o \
+	gvt/mmio.o \
+	gvt/display.o \
+	gvt/edid.o \
+	gvt/execlist.o \
+	gvt/scheduler.o \
+	gvt/sched_policy.o \
+	gvt/mmio_context.o \
+	gvt/cmd_parser.o \
+	gvt/debugfs.o \
+	gvt/fb_decoder.o \
+	gvt/dmabuf.o \
+	gvt/page_track.o
 
 obj-$(CONFIG_DRM_I915) += i915.o
 obj-$(CONFIG_DRM_I915_GVT_KVMGT) += gvt/kvmgt.o
diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
deleted file mode 100644
index 4d70f4689479..000000000000
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-GVT_DIR := gvt
-GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
-	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
-	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
-	fb_decoder.o dmabuf.o page_track.o
-
-i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
-- 
2.17.1

