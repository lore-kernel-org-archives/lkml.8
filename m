Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA3C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6724959
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877383;
	bh=sEFdBDVeUa29FP+5J+FWkQjaGTd7YhVbv31P4E7P2jU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tSYivsfsvK1s/z1uupLd48o72EgwAA1pZUw7ipKFDdQVZQc2YEtKgdzNSF4MLmF5S
	 L/mURCH4EK4XTS6f0PLHhB8CVTy4t7CH+CwC0U3u2jPg4AFJL23tYII2kwujJBi2+t
	 aXFW+u+fJ8xe13lHW96K2gL9IAQtzG+uN7cuMuuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgEGStn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEGStm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:49:42 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C02324957;
        Thu,  7 May 2020 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877381;
        bh=sEFdBDVeUa29FP+5J+FWkQjaGTd7YhVbv31P4E7P2jU=;
        h=Date:From:To:Cc:Subject:From;
        b=mcn5Al1aAEKclx5SWiiJdTsd2kLre8tYrNjIJxRKV59x1Fz+2iuR6swGbY0XCvIX8
         VG5jAUsgI6x4FCIUCuSkl+x3dEbHbzfvc2vBxyeF9OtS4Zxjdk1joHcNO7kzRPpegt
         juBi/XUi3za70peyxfgkupEvrs1al4jGTuUE22rc=
Date:   Thu, 7 May 2020 13:54:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Replace zero-length array with flexible-array
Message-ID: <20200507185408.GA14561@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |    4 ++--
 drivers/gpu/drm/i915/gt/intel_lrc.c           |    2 +-
 drivers/gpu/drm/i915/i915_gpu_error.h         |    2 +-
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
index 683014e7bc51..f42c99da2580 100644
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

