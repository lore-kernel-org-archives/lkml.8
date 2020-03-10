Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E697C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6098B20409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845249;
	bh=tWIk8AwSY/0NBQXlgC+ZuTX6afc1+pa/Job7hLICDa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o62n76LOZuYPLSPqHRXH9b2fxR7dyYn8o29V1p9SVbKW94KHb43yu82CQAqADYLz6
	 TEir6Zp0mTB1lHtADfkHzpiVxHBx1nGFs7E4HwznRShbPC8iw2pUGCFroGPpH+6g23
	 6AmBoyL2eTSrEIglJfREuaxEGbbY4l2fGk8EBkO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgCJNAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgCJNAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409472468D;
        Tue, 10 Mar 2020 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845242;
        bh=tWIk8AwSY/0NBQXlgC+ZuTX6afc1+pa/Job7hLICDa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHVjH5Oqca4jhYCE+VYzPq3ld05QN1G8PK2Ni6/h3r9CPLSu1bw2fm9S8/V7/3AWV
         SHc9Qhwqn4HPP5amdBQQjlS++jURSQnjX0vOBSxGEXbpBvm9NYZu5BMtTiO4PAoAHo
         7SzJLI6+Ghm7DNO/XkJcFPegUQfF42zNbnKpITAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feifei Xu <Feifei.Xu@amd.com>,
        Monk Liu <monk.liu@amd.com>, "Tianci.Yin" <tianci.yin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 112/189] drm/amdgpu: disable 3D pipe 1 on Navi1x
Date:   Tue, 10 Mar 2020 13:39:09 +0100
Message-Id: <20200310123651.038850283@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianci.Yin <tianci.yin@amd.com>

commit 194bcf35bce4a236059816bc41b3db9c9c92a1bb upstream.

[why]
CP firmware decide to skip setting the state for 3D pipe 1 for Navi1x as there
is no use case.

[how]
Disable 3D pipe 1 on Navi1x.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Monk Liu <monk.liu@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   95 +++++++++++++++++----------------
 1 file changed, 50 insertions(+), 45 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -54,7 +54,7 @@
  * In bring-up phase, it just used primary ring so set gfx ring number as 1 at
  * first.
  */
-#define GFX10_NUM_GFX_RINGS	2
+#define GFX10_NUM_GFX_RINGS_NV1X	1
 #define GFX10_MEC_HPD_SIZE	2048
 
 #define F32_CE_PROGRAM_RAM_SIZE		65536
@@ -1286,7 +1286,7 @@ static int gfx_v10_0_sw_init(void *handl
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -2692,18 +2692,20 @@ static int gfx_v10_0_cp_gfx_start(struct
 	amdgpu_ring_commit(ring);
 
 	/* submit cs packet to copy state 0 to next available state */
-	ring = &adev->gfx.gfx_ring[1];
-	r = amdgpu_ring_alloc(ring, 2);
-	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-		return r;
-	}
-
-	amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
-	amdgpu_ring_write(ring, 0);
+	if (adev->gfx.num_gfx_rings > 1) {
+		/* maximum supported gfx ring is 2 */
+		ring = &adev->gfx.gfx_ring[1];
+		r = amdgpu_ring_alloc(ring, 2);
+		if (r) {
+			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			return r;
+		}
 
-	amdgpu_ring_commit(ring);
+		amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
+		amdgpu_ring_write(ring, 0);
 
+		amdgpu_ring_commit(ring);
+	}
 	return 0;
 }
 
@@ -2800,39 +2802,41 @@ static int gfx_v10_0_cp_gfx_resume(struc
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Init gfx ring 1 for pipe 1 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
-	ring = &adev->gfx.gfx_ring[1];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
-	tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
-	WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-	/* Initialize the ring buffer's write pointers */
-	ring->wptr = 0;
-	WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
-	/* Set the wb address wether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
-	WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-		CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
-		lower_32_bits(wptr_gpu_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
-		upper_32_bits(wptr_gpu_addr));
-
-	mdelay(1);
-	WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-
-	rb_addr = ring->gpu_addr >> 8;
-	WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
-	WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
-
-	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-	mutex_unlock(&adev->srbm_mutex);
+	if (adev->gfx.num_gfx_rings > 1) {
+		mutex_lock(&adev->srbm_mutex);
+		gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
+		/* maximum supported gfx ring is 2 */
+		ring = &adev->gfx.gfx_ring[1];
+		rb_bufsz = order_base_2(ring->ring_size / 8);
+		tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
+		tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
+		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+		/* Initialize the ring buffer's write pointers */
+		ring->wptr = 0;
+		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
+		/* Set the wb address wether it's enabled or not */
+		rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
+			     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
+		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
+			     lower_32_bits(wptr_gpu_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
+			     upper_32_bits(wptr_gpu_addr));
+
+		mdelay(1);
+		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+
+		rb_addr = ring->gpu_addr >> 8;
+		WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
+		WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
 
+		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+		mutex_unlock(&adev->srbm_mutex);
+	}
 	/* Switch to pipe 0 */
 	mutex_lock(&adev->srbm_mutex);
 	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
@@ -3952,7 +3956,8 @@ static int gfx_v10_0_early_init(void *ha
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS;
+	adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_NV1X;
+
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 
 	gfx_v10_0_set_kiq_pm4_funcs(adev);


