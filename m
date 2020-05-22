Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3911C206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590168571;
	bh=noVq5vIzK2zOX8f731NA23cZdVRrWDncOL4AESsRsPg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XfhU/oQnNYdSVOhhauFgpOVTldnIJgLVERqtSSIj6E91Qs7Y1MP9I3qEh5oO9lvLv
	 LFPeF1MnHYQFRE5DOw9sscOnVF7b/tTUgVZVuSLlpU5P2Uaqpz+/hQKQWETNOcizfO
	 fHkXauRFRsMwNc5PUmYeKTGyaL1EC17E5VvtgJFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgEVR3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbgEVR3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:29:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7338206C3;
        Fri, 22 May 2020 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590168569;
        bh=noVq5vIzK2zOX8f731NA23cZdVRrWDncOL4AESsRsPg=;
        h=Date:From:To:Cc:Subject:From;
        b=sw+5iUX6i1Ax9MaJRERLYh2ki2CKYhNykMEqas7Ctlfz6msB9sN4MXsg7L1VIWqjx
         3RcjOaMXlp6CL6yNlzef+jlOxjnKn6W9NQqhAcMSd5NVEDKs+f70fdKlcVBFj0c8lv
         XUzwUNpJixMJWyEAI62JI9PKfm3YskgKeQkPkqqM=
Date:   Fri, 22 May 2020 12:34:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] drm/radeon/dpm: Replace one-element array and use
 struct_size() helper
Message-ID: <20200522173419.GA2297@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on. So, replace
the one-element array with a flexible-array member.

Also, make use of the new struct_size() helper to properly calculate the
size of struct NISLANDS_SMC_SWSTATE.

This issue was found with the help of Coccinelle and, audited and fixed
_manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use type size_t instead of u16 for state_size variable.

 drivers/gpu/drm/amd/amdgpu/si_dpm.h | 2 +-
 drivers/gpu/drm/radeon/ni_dpm.c     | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.h b/drivers/gpu/drm/amd/amdgpu/si_dpm.h
index 6b7d292b919f3..bc0be6818e218 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.h
@@ -781,7 +781,7 @@ struct NISLANDS_SMC_SWSTATE
     uint8_t                             levelCount;
     uint8_t                             padding2;
     uint8_t                             padding3;
-    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
+    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
 
 typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index b57c37ddd164c..abb6345bfae32 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2685,11 +2685,12 @@ static int ni_upload_sw_state(struct radeon_device *rdev,
 	struct rv7xx_power_info *pi = rv770_get_pi(rdev);
 	u16 address = pi->state_table_start +
 		offsetof(NISLANDS_SMC_STATETABLE, driverState);
-	u16 state_size = sizeof(NISLANDS_SMC_SWSTATE) +
-		((NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1) * sizeof(NISLANDS_SMC_HW_PERFORMANCE_LEVEL));
+	NISLANDS_SMC_SWSTATE *smc_state;
+	size_t state_size = struct_size(smc_state, levels,
+			NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE);
 	int ret;
-	NISLANDS_SMC_SWSTATE *smc_state = kzalloc(state_size, GFP_KERNEL);
 
+	smc_state = kzalloc(state_size, GFP_KERNEL);
 	if (smc_state == NULL)
 		return -ENOMEM;
 
-- 
2.26.2

