Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE13C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDDA2077A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCRU2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:28:40 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:33972 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbgCRU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:28:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 34A63100E7B45;
        Wed, 18 Mar 2020 20:28:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sleep52_2e1ea103be818
X-Filterd-Recvd-Size: 2672
Received: from XPS-9350 (unknown [172.58.30.155])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Mar 2020 20:28:36 +0000 (UTC)
Message-ID: <3a997f4ee640e607a171a19668f5f5484062116c.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize shadow to false in
 gfx_v9_0_rlcg_wreg
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 18 Mar 2020 13:26:44 -0700
In-Reply-To: <20200318002500.52471-1-natechancellor@gmail.com>
References: <20200318002500.52471-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 17:25 -0700, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
> is used uninitialized whenever 'if' condition is
> false [-Wsometimes-uninitialized]
>         if (offset == grbm_cntl || offset == grbm_idx)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
> occurs here
>         if (shadow) {
>             ^~~~~~

Wouldn't it be better to get rid of the shadow variable completely?
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7bc248..496b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
 	static void *spare_int;
 	static uint32_t grbm_cntl;
 	static uint32_t grbm_idx;
-	bool shadow;
 
 	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
 	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
@@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
 		return;
 	}
 
-	if (offset == grbm_cntl || offset == grbm_idx)
-		shadow = true;
-
-	if (shadow) {
+	if (offset == grbm_cntl || offset == grbm_idx) {
 		if (offset  == grbm_cntl)
 			writel(v, scratch_reg2);
 		else if (offset == grbm_idx)


