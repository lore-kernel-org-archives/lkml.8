Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF3C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62892206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326441;
	bh=IVxeqr4maGdVeGsANKq/cHGkCtuGHPd9mer7vwQfsLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V+W0BDVgvevz66B72Qjnr2alcAKFgHUYyHZl+4OxWCVtJzfDBYP//CBkEKdpwJV0h
	 5NRc3W8ZKAaoGOz/DPT9auADLZBNWq+n2bsVE06bsMABIihPr5AV9/LW/vd9us/qZC
	 0TT7Tbakef3AEMJrMWxwQZFhjzoqxfV5V10Z+p1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgCPCkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbgCPCeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771452072A;
        Mon, 16 Mar 2020 02:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326039;
        bh=IVxeqr4maGdVeGsANKq/cHGkCtuGHPd9mer7vwQfsLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUdaQPr9JHTf3j3Q8wmweEkhxrGZQwzhK1yLpQObbPt9IdzoU13u19/m5P1HS5R0J
         vPu9LsWiE2OqGONpveJrmU5TI9NfG9xCxw++mandzSOfSqDTzvXhekilQThrxYSZNp
         AJ5NGqNJBTzvhfUa6D+geduCwVNHVrTpAoDq/UBs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yintian Tao <yttao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 33/41] drm/amdgpu: clean wptr on wb when gpu recovery
Date:   Sun, 15 Mar 2020 22:33:11 -0400
Message-Id: <20200316023319.749-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 6b5b243af15dc..1a80423b1d4f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3496,6 +3496,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 085b84322e928..67f30fec94df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3538,6 +3538,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
-- 
2.20.1

