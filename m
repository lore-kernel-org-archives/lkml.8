Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EA52064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261851;
	bh=gY7M0vHhcIvdmRdJ5D1OZsFINYfqQm6+7Tw5ej3VREQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r0URAN6WT/Jbb62mkeKng9nYyZ4VGeb42QlkOa4RiF8hE2HzAO/ryhxIIFLInXNdB
	 Z68neHoWzepO2xkvSjakU2vxt38bnOV7jzH0UabOlVVMPQOn7jdkC1ldbzHQWS7pRC
	 9EFWVGeKcjCKkMipfTqLvsEN7ACNRmIs5q7opGsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbgGTQRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388435AbgGTQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:15:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFC82064B;
        Mon, 20 Jul 2020 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261741;
        bh=gY7M0vHhcIvdmRdJ5D1OZsFINYfqQm6+7Tw5ej3VREQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRAJH28trldXeX8FQN1hO4Tt0Z7V5H1+nPHySmAvp0FaYX7iWU8L5PKZ3qKzQ11fY
         rUZWpn1I0TzZacC2uNjOrGR4r03/NcmAJ06ggNM0kYYDezKdVdzc8sVnN72vw3dCGN
         jQamrKT18gmi+ySBfZUi3HgMfl6sehtuCsSJ66qY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Le Ma <le.ma@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 225/244] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
Date:   Mon, 20 Jul 2020 17:38:16 +0200
Message-Id: <20200720152836.554700704@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaojie Yuan <xiaojie.yuan@amd.com>

commit 05051496b2622e4d12e2036b35165969aa502f89 upstream.

"u64 *wptr" points to the the wptr value in write back buffer and
"*wptr = (*wptr) >> 2;" results in the value being overwritten each time
when ->get_wptr() is called.

umr uses /sys/kernel/debug/dri/0/amdgpu_ring_sdma0 to get rptr/wptr and
decode ring content and it is affected by this issue.

fix and simplify the logic similar as sdma_v4_0_ring_get_wptr().

v2: fix for sdma5.2 as well
v3: drop sdma 5.2 changes for 5.8 and stable

Suggested-by: Le Ma <le.ma@amd.com>
Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -286,30 +286,20 @@ static uint64_t sdma_v5_0_ring_get_rptr(
 static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u64 *wptr = NULL;
-	uint64_t local_wptr = 0;
+	u64 wptr;
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = ((u64 *)&adev->wb.wb[ring->wptr_offs]);
-		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", *wptr);
-		*wptr = (*wptr) >> 2;
-		DRM_DEBUG("wptr/doorbell after shift == 0x%016llx\n", *wptr);
+		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		u32 lowbit, highbit;
-
-		wptr = &local_wptr;
-		lowbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR)) >> 2;
-		highbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI)) >> 2;
-
-		DRM_DEBUG("wptr [%i]high== 0x%08x low==0x%08x\n",
-				ring->me, highbit, lowbit);
-		*wptr = highbit;
-		*wptr = (*wptr) << 32;
-		*wptr |= lowbit;
+		wptr = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = wptr << 32;
+		wptr |= RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
-	return *wptr;
+	return wptr >> 2;
 }
 
 /**


