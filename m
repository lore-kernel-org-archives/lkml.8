Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB79C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6663320772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgGBOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:01:18 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60527 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgGBOBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:01:15 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id D2CAF20646DD4;
        Thu,  2 Jul 2020 16:01:13 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Change type of module param `ppfeaturemask` to hex
Date:   Thu,  2 Jul 2020 16:01:02 +0200
Message-Id: <20200702140102.26129-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added hex helper is more convenient for bitmasks.

Before:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    4294950911

After:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    0xffffbfff

Cc: amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 126e74758a34..35a66b374e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -391,12 +391,12 @@ MODULE_PARM_DESC(sched_hw_submission, "the max number of HW submissions (default
 module_param_named(sched_hw_submission, amdgpu_sched_hw_submission, int, 0444);
 
 /**
- * DOC: ppfeaturemask (uint)
+ * DOC: ppfeaturemask (hex)
  * Override power features enabled. See enum PP_FEATURE_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
  * The default is the current set of stable power features.
  */
 MODULE_PARM_DESC(ppfeaturemask, "all power features enabled (default))");
-module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, uint, 0444);
+module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, hex, 0444);
 
 /**
  * DOC: forcelongtraining (uint)
-- 
2.26.2

