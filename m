Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D23C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F406208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055788;
	bh=88/XO/N93K3OgCv2drcOHgS1Mvwynwf+rNzOUc7lL+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Puyay+BACzZyVAZlcajo2lGGqndHtYxymkxD/l/xYe3iU0L43dX7jouc7NgYPgw0P
	 0RDROLyufx9fPhVihV/dCchg7Bj3P/02dtGqg+wJEpPoNskITqe1Z2ZLuuFm5ucXOU
	 +gvL8Yu7BZM01m4J2q9v426mzcJ/LwPjvynMQtXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgCXNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgCXNQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:16:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088F320775;
        Tue, 24 Mar 2020 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055784;
        bh=88/XO/N93K3OgCv2drcOHgS1Mvwynwf+rNzOUc7lL+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snY7veSKT+p1kInSHALOlJCGY9KJxgcEPnWsWlwbwxwDo7/M67ijw6R3Dr2YT0IcS
         GdYSGOO0UWAHVxCUiPO4KkAf2dRFQaWP2CTbEeFwy+xDHkhPK3o19P1BNxfDhUlUTd
         txdyBtwBT8pIrSUxzYU+balIA1/0etm8Hk/6ouEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yintian Tao <yttao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 028/102] drm/amdgpu: clean wptr on wb when gpu recovery
Date:   Tue, 24 Mar 2020 14:10:20 +0100
Message-Id: <20200324130809.342801187@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yintian Tao <yttao@amd.com>

[ Upstream commit 2ab7e274b86739f4ceed5d94b6879f2d07b2802f ]

The TDR will be randomly failed due to compute ring
test failure. If the compute ring wptr & 0x7ff(ring_buf_mask)
is 0x100 then after map mqd the compute ring rptr will be
synced with 0x100. And the ring test packet size is also 0x100.
Then after invocation of amdgpu_ring_commit, the cp will not
really handle the packet on the ring buffer because rptr is equal to wptr.

Signed-off-by: Yintian Tao <yttao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Monk Liu <Monk.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2816d03297385..14417cebe38ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3555,6 +3555,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d85e1e559c826..40034efa64bbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3756,6 +3756,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
-- 
2.20.1



