Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60820C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A032071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAYM0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 07:26:23 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:37975 "EHLO
        2.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAYM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 07:26:23 -0500
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 07:26:22 EST
Received: from player159.ha.ovh.net (unknown [10.108.35.110])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 148091C305D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 12:47:12 +0100 (CET)
Received: from sk2.org (nat-fit.net.vutbr.cz [147.229.117.36])
        (Authenticated sender: steve@sk2.org)
        by player159.ha.ovh.net (Postfix) with ESMTPSA id F2C3EE9AA732;
        Sat, 25 Jan 2020 11:46:57 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] amdgpu: use dma-resv API instead of manual kmalloc
Date:   Sat, 25 Jan 2020 12:46:24 +0100
Message-Id: <20200125114624.2093235-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3080180672509660668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvdejgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpddugeejrddvvdelrdduudejrdefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hand-coding the dma_resv_list allocation, use
dma_resv_list_alloc, which masks the shared_max handling. While we're
at it, since we only need shared_count fences, allocate shared_count
fences rather than shared_max.

(This is the only place in the kernel, outside of dma-resv.c, which
touches shared_max. This suggests we'd probably be better off without
it!)

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 888209eb8cec..aec595752200 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -234,12 +234,11 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	if (!old)
 		return 0;
 
-	new = kmalloc(offsetof(typeof(*new), shared[old->shared_max]),
-		      GFP_KERNEL);
+	new = dma_resv_list_alloc(old->shared_count);
 	if (!new)
 		return -ENOMEM;
 
-	/* Go through all the shared fences in the resevation object and sort
+	/* Go through all the shared fences in the reservation object and sort
 	 * the interesting ones to the end of the list.
 	 */
 	for (i = 0, j = old->shared_count, k = 0; i < old->shared_count; ++i) {
@@ -253,7 +252,6 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 		else
 			RCU_INIT_POINTER(new->shared[k++], f);
 	}
-	new->shared_max = old->shared_max;
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-- 
2.24.1

