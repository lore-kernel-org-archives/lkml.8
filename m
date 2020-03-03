Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72E2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957420870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="QDxMwgoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCCW0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:26:41 -0500
Received: from gateway36.websitewelcome.com ([192.185.188.18]:17635 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgCCW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:26:41 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 9D7D340260820
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 15:17:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9Fc3jFW5RAGTX9Fc3jNfcl; Tue, 03 Mar 2020 16:02:03 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ov8U0/V3EL/OzxBcysm37ohdrH/vifyJsx+ocJmx8J0=; b=QDxMwgoNK7dQfmEmgjrj67RHGN
        KUJ6y4wrfcxBIYLAqMLTwTlVBO6e0kZCuWOYBfXDnIzPDcEHdyA6SAstcJbyKb5p9KDjwq/nHOf6F
        hmZwFD6W7wNGH5c3UwjLmvXxdcS3LNV6oBvmvBOBkO8FYQJgYEvJrUuuLdGx2Nqoh8fzGBh3aEEdW
        7laQex2xlTopGAoEGzT35LvvMpREl8ispVH0YLsEswxx7tVFWSvOixDrvlCDWBUEWr/TYMhb5vGdP
        suhga6py/O/LfVsYySMTpW5RJf6zFW1pcsCAyo3AYzauuSe3syZbVbTZ29ZhNxT7t7S9bh1uS+mU3
        PqZF287w==;
Received: from [201.162.240.151] (port=26880 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j9Fbz-00118U-IR; Tue, 03 Mar 2020 16:02:00 -0600
Date:   Tue, 3 Mar 2020 16:05:03 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/i915: Replace zero-length array with
 flexible-array member
Message-ID: <20200303220503.GA2663@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.151
X-Source-L: No
X-Exim-ID: 1j9Fbz-00118U-IR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.151]:26880
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/display/intel_vbt_defs.h | 4 ++--
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
index 05c7cbe32eb4..aef7fe932d1a 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -462,7 +462,7 @@ struct bdb_general_definitions {
 	 * number = (block_size - sizeof(bdb_general_definitions))/
 	 *	     defs->child_dev_size;
 	 */
-	u8 devices[0];
+	u8 devices[];
 } __packed;
 
 /*
@@ -839,7 +839,7 @@ struct bdb_mipi_config {
 
 struct bdb_mipi_sequence {
 	u8 version;
-	u8 data[0]; /* up to 6 variable length blocks */
+	u8 data[]; /* up to 6 variable length blocks */
 } __packed;
 
 /*
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index b9b3f78f1324..a49ddda649b9 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -216,7 +216,7 @@ struct virtual_engine {
 
 	/* And finally, which physical engines this virtual engine maps onto. */
 	unsigned int num_siblings;
-	struct intel_engine_cs *siblings[0];
+	struct intel_engine_cs *siblings[];
 };
 
 static struct virtual_engine *to_virtual_engine(struct intel_engine_cs *engine)
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 0d1f6c8ff355..5a6561f7a210 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -42,7 +42,7 @@ struct i915_vma_coredump {
 	int num_pages;
 	int page_count;
 	int unused;
-	u32 *pages[0];
+	u32 *pages[];
 };
 
 struct i915_request_coredump {
-- 
2.25.0

