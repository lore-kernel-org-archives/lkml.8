Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C4AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9189E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693403;
	bh=OZgnXvx23vXflLx+ujm4Ke0HulmPUTb8NcBv6f2uvVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPZAm8gK+bFXC3kJM1TvjXlOcrko4rZePpJJOuY+yna5GlbdZI4cOPRPChiJm00+a
	 AX0Ztb6M5sNxW/n/z/0fpXEZF5lmUD+E+vyBV0W2v9j3dCrrtv6kkkYOiHil36hcXv
	 3NCauoILTLBrjUz5S6QNYL/9FV6aO5nDn52kruYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbgHQTnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgHQPXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:23:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B681923371;
        Mon, 17 Aug 2020 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677835;
        bh=OZgnXvx23vXflLx+ujm4Ke0HulmPUTb8NcBv6f2uvVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xAh7GeHSmltY5re1w/sZccT3W1yjlkcKG3miSeJ9xlAapIb0W0zbpceHG99mZjxwQ
         Q09Xv3Ip/wtZIWi30NDRF+6C/qHX/G+xt7RGSuvFXUEah2JBs8atqNRXZoNtqYsC9Z
         DFFaUqJMiiaUox2Vp95FuUy9sWD3Myrq2FoloX+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Xiao <Jack.Xiao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 085/464] drm/amdgpu: avoid dereferencing a NULL pointer
Date:   Mon, 17 Aug 2020 17:10:38 +0200
Message-Id: <20200817143837.858834537@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Xiao <Jack.Xiao@amd.com>

[ Upstream commit 55611b507fd6453d26030c0c0619fdf0c262766d ]

Check if irq_src is NULL to avoid dereferencing a NULL pointer,
for MES ring is uneccessary to recieve an interrupt notification.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d878fe7fee51c..3414e119f0cbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -416,7 +416,9 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 		ring->fence_drv.gpu_addr = adev->uvd.inst[ring->me].gpu_addr + index;
 	}
 	amdgpu_fence_write(ring, atomic_read(&ring->fence_drv.last_seq));
-	amdgpu_irq_get(adev, irq_src, irq_type);
+
+	if (irq_src)
+		amdgpu_irq_get(adev, irq_src, irq_type);
 
 	ring->fence_drv.irq_src = irq_src;
 	ring->fence_drv.irq_type = irq_type;
@@ -537,8 +539,9 @@ void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
 			/* no need to trigger GPU reset as we are unloading */
 			amdgpu_fence_driver_force_completion(ring);
 		}
-		amdgpu_irq_put(adev, ring->fence_drv.irq_src,
-			       ring->fence_drv.irq_type);
+		if (ring->fence_drv.irq_src)
+			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
+				       ring->fence_drv.irq_type);
 		drm_sched_fini(&ring->sched);
 		del_timer_sync(&ring->fence_drv.fallback_timer);
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
@@ -574,8 +577,9 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
 		}
 
 		/* disable the interrupt */
-		amdgpu_irq_put(adev, ring->fence_drv.irq_src,
-			       ring->fence_drv.irq_type);
+		if (ring->fence_drv.irq_src)
+			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
+				       ring->fence_drv.irq_type);
 	}
 }
 
@@ -601,8 +605,9 @@ void amdgpu_fence_driver_resume(struct amdgpu_device *adev)
 			continue;
 
 		/* enable the interrupt */
-		amdgpu_irq_get(adev, ring->fence_drv.irq_src,
-			       ring->fence_drv.irq_type);
+		if (ring->fence_drv.irq_src)
+			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
+				       ring->fence_drv.irq_type);
 	}
 }
 
-- 
2.25.1



