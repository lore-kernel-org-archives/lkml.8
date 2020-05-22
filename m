Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C18C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C0D20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590169147;
	bh=uZktogMIldBXs3EnkclH2OcbwF2xvrt9qAcFBj9JxyA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RMjMF7BQivd0UG8YFs8eoZIxhSuI/D/wREMC9Jx/is3DX1BJwUD5J2gx6cHmDRnIh
	 AyCDj3JLA2kBuV9yJPVQJP8enPX54tQaZcpRmgFESV0WeOjrAoAk/aSd1eQgS+Lnuz
	 yK1jkmf71Dvuh2IwhC2FDoZR+bIMxwcdlm6/tsOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgEVRjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgEVRjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:39:05 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F0F20723;
        Fri, 22 May 2020 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169145;
        bh=uZktogMIldBXs3EnkclH2OcbwF2xvrt9qAcFBj9JxyA=;
        h=Date:From:To:Cc:Subject:From;
        b=CVlVu6Tl94Ujfw9k+IunjftvcjK9C0E5co+apqaj98AFWqlF1k/xFfB1D4Tn8Mz1R
         b+mYAeybR5/5Tk1oGForFgLQgPWPhUFM3BCr3kFzjllepPyv3cM4eHTOVMa1j5ZaDr
         DGq2QtamnmFGWx9kw7NSfnWlTcOVm1PJBa3r43Jg=
Date:   Fri, 22 May 2020 12:43:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/[radeon|amdgpu]: Replace one-element array and use
 struct_size() helper
Message-ID: <20200522174355.GA4406@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
size of struct SISLANDS_SMC_SWSTATE.

This issue was found with the help of Coccinelle and, audited and fixed
_manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c       | 5 ++---
 drivers/gpu/drm/amd/amdgpu/sislands_smc.h | 2 +-
 drivers/gpu/drm/radeon/si_dpm.c           | 5 ++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a6..0fc56c5bac080 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -5715,10 +5715,9 @@ static int si_upload_sw_state(struct amdgpu_device *adev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
-	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
-		((new_state->performance_level_count - 1) *
-		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
+	size_t state_size = struct_size(smc_state, levels,
+					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
index d2930eceaf3c8..a089dbf8f7a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
+++ b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
@@ -186,7 +186,7 @@ struct SISLANDS_SMC_SWSTATE
     uint8_t                             levelCount;
     uint8_t                             padding2;
     uint8_t                             padding3;
-    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
+    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
 
 typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index a167e1c36d243..bab01ca864c63 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5253,10 +5253,9 @@ static int si_upload_sw_state(struct radeon_device *rdev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
-	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
-		((new_state->performance_level_count - 1) *
-		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
+	size_t state_size = struct_size(smc_state, levels,
+					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
-- 
2.26.2

