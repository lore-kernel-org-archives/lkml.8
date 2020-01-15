Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D9C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D89E24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAOC2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:28:06 -0500
Received: from trent.utfs.org ([94.185.90.103]:33164 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgAOC2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:28:06 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5AA0C5FFED;
        Wed, 15 Jan 2020 03:28:04 +0100 (CET)
Date:   Tue, 14 Jan 2020 18:28:04 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     intel-gfx@lists.freedesktop.org
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bugs.freedesktop.org is no longer accepting bugs
Message-ID: <alpine.DEB.2.21.99999.375.2001141825300.21037@trent.utfs.org>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this should apply cleanly to drm-tip.


    drm: bugs.freedesktop.org is no longer accepting bugs.
    
    freedesktop.org Bugzilla is no longer in use and new DRM bugs
    should be reported to https://gitlab.freedesktop.org/drm/intel
    instead. While we're at it, update some URLs of still-open bugs
    that have been moved to the new bug tracker.
    
     drivers/gpu/drm/i915/Kconfig           | 3 +--
     drivers/gpu/drm/i915/i915_gpu_error.c  | 2 +-
     drivers/gpu/drm/i915/i915_utils.c      | 2 +-
     drivers/gpu/drm/radeon/radeon_device.c | 2 +-
     4 files changed, 4 insertions(+), 5 deletions(-)
    
    Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index ba9595960bbe..f2f4bcaaa1d5 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -75,8 +75,7 @@ config DRM_I915_CAPTURE_ERROR
 	help
 	  This option enables capturing the GPU state when a hang is detected.
 	  This information is vital for triaging hangs and assists in debugging.
-	  Please report any hang to
-	    https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
+	  Please report any hang to https://gitlab.freedesktop.org/drm/intel
 	  for triaging.
 
 	  If in doubt, say "Y".
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 4c1836f0a991..9fba5ac9020d 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1852,7 +1852,7 @@ void i915_error_state_store(struct i915_gpu_coredump *error)
 	if (!xchg(&warned, true) &&
 	    ktime_get_real_seconds() - DRIVER_TIMESTAMP < DAY_AS_SECONDS(180)) {
 		pr_info("GPU hangs can indicate a bug anywhere in the entire gfx stack, including userspace.\n");
-		pr_info("Please file a _new_ bug report on bugs.freedesktop.org against DRI -> DRM/Intel\n");
+		pr_info("Please file a new bug report on https://gitlab.freedesktop.org/drm/intel\n");
 		pr_info("drm/i915 developers can then reassign to the right component if it's not a kernel issue.\n");
 		pr_info("The GPU crash dump is required to analyze GPU hangs, so please always attach it.\n");
 		pr_info("GPU crash dump saved to /sys/class/drm/card%d/error\n",
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_utils.c
index c47261ae86ea..f93a4c005d7a 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -8,7 +8,7 @@
 #include "i915_drv.h"
 #include "i915_utils.h"
 
-#define FDO_BUG_URL "https://bugs.freedesktop.org/enter_bug.cgi?product=DRI"
+#define FDO_BUG_URL "https://gitlab.freedesktop.org/drm/intel"
 #define FDO_BUG_MSG "Please file a bug at " FDO_BUG_URL " against DRM/Intel " \
 		    "providing the dmesg log by booting with drm.debug=0xf"
 
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index a522e092038b..b044dd912239 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -144,7 +144,7 @@ static struct radeon_px_quirk radeon_px_quirk_list[] = {
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
 	/* Asus K53TK laptop with AMD A6-3420M APU and Radeon 7670m GPU
-	 * https://bugs.freedesktop.org/show_bug.cgi?id=101491
+	 * https://gitlab.freedesktop.org/drm/amd/issues/803
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
 	/* Asus K73TK laptop with AMD A6-3420M APU and Radeon 7670m GPU

-- 
BOFH excuse #397:

T-1's congested due to porn traffic to the news server.
