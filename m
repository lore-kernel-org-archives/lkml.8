Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94EBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1E222314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707547;
	bh=UXIkgo0yNij33cB0aDYQI9sIE0yqcJ+fwu6Xzi18Voo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4L6viLDa/Ku/qXMrw5Hhh7DX0nw/BoGXf4rL5YysaFwYfcr93UytdAkCEkai75/+
	 /1R7evTSQCtMv1AUtw3mNRT5mtWYJN4QMsWMQbRI7Ra9or6PhXpIdxyJSVvk85BcWL
	 rCDoUL9DKCRU8IHbdFJzQD89MnDP4Lg+YOgeAwmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgBNTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgBNTMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:22 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDFF824650;
        Fri, 14 Feb 2020 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707542;
        bh=UXIkgo0yNij33cB0aDYQI9sIE0yqcJ+fwu6Xzi18Voo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaLZ56ta2FNCaPJ/poG2rlwBcyXT/4O1qcEjnSA6lcDSqt9AbGam8LgCDWpXHuiuV
         VU9pQexxBCQhuhXV2Wb8pOzpDhOg7Qi6xG33S63mb4g+P9QC3YGFo6M9JFvoqQu8aK
         ADpleSjY8F0NifXDRImK6vurwCWz+90XwJ3z1wOM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 15/23] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date:   Fri, 14 Feb 2020 16:10:49 -0300
Message-Id: <20200214191057.26266-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  cc662126b413 ("drm/i915: Introduce DRM_I915_GEM_MMAP_OFFSET")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Abdiel Janulgue <abdiel.janulgue@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 5400d7e057f1..829c0a48577f 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -395,6 +395,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GEM_PWRITE	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_PWRITE, struct drm_i915_gem_pwrite)
 #define DRM_IOCTL_I915_GEM_MMAP		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP, struct drm_i915_gem_mmap)
 #define DRM_IOCTL_I915_GEM_MMAP_GTT	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_gtt)
+#define DRM_IOCTL_I915_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_offset)
 #define DRM_IOCTL_I915_GEM_SET_DOMAIN	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SET_DOMAIN, struct drm_i915_gem_set_domain)
 #define DRM_IOCTL_I915_GEM_SW_FINISH	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SW_FINISH, struct drm_i915_gem_sw_finish)
 #define DRM_IOCTL_I915_GEM_SET_TILING	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_SET_TILING, struct drm_i915_gem_set_tiling)
@@ -793,6 +794,37 @@ struct drm_i915_gem_mmap_gtt {
 	__u64 offset;
 };
 
+struct drm_i915_gem_mmap_offset {
+	/** Handle for the object being mapped. */
+	__u32 handle;
+	__u32 pad;
+	/**
+	 * Fake offset to use for subsequent mmap call
+	 *
+	 * This is a fixed-size type for 32/64 compatibility.
+	 */
+	__u64 offset;
+
+	/**
+	 * Flags for extended behaviour.
+	 *
+	 * It is mandatory that one of the MMAP_OFFSET types
+	 * (GTT, WC, WB, UC, etc) should be included.
+	 */
+	__u64 flags;
+#define I915_MMAP_OFFSET_GTT 0
+#define I915_MMAP_OFFSET_WC  1
+#define I915_MMAP_OFFSET_WB  2
+#define I915_MMAP_OFFSET_UC  3
+
+	/*
+	 * Zero-terminated chain of extensions.
+	 *
+	 * No current extensions defined; mbz.
+	 */
+	__u64 extensions;
+};
+
 struct drm_i915_gem_set_domain {
 	/** Handle for the object */
 	__u32 handle;
-- 
2.21.1

