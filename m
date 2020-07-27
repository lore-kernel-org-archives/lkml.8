Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9151220825
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859402;
	bh=oGUrR/3CifRJrhJzUDoT4zDQtGxfmbqA1TZdgk9HqjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvYF4m1w9j1wmRyrZnCqMcU9ZsYmLe1G8bUs4T+DEx2ShUfShwdFRGCAzgU4UaswG
	 XWWvy6RVBl4A74PAPApmBqXB84/JsBnoN+Wc1Q2K5142zMVldfDxbWoi9TYzkcQ+ib
	 d9CN8vqt/BKK1H2C1X1aE5YNbokyYhgFFXCKWIIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgG0OQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbgG0OQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:16:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B87F20825;
        Mon, 27 Jul 2020 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859396;
        bh=oGUrR/3CifRJrhJzUDoT4zDQtGxfmbqA1TZdgk9HqjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ePP3CXmBhiiQacLmFC8LVMrsWRfwxsqHwoZSkVAGM7zI3ctYHtrY9cnLEOHFKW0F
         BVCSqeiN/kd/APF0oxDWzF0+2a02nSee/7zUdVQ+5VxFhbcZRrXMBsOVMgxIeHEDvf
         lE/7tMfbiFGDGK6ASorOgkjyogkm0LKanUjXov34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/138] drm/amdgpu/gfx10: fix race condition for kiq
Date:   Mon, 27 Jul 2020 16:04:46 +0200
Message-Id: <20200727134929.915011392@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Xiao <Jack.Xiao@amd.com>

[ Upstream commit 7d65a577bb58d4f27a3398a4c0cb0b00ab7d0511 ]

During preemption test for gfx10, it uses kiq to trigger
gfx preemption, which would result in race condition
with flushing TLB for kiq.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6f118292e40fb..64d96eb0a2337 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4683,12 +4683,17 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size))
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		return -ENOMEM;
+	}
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
@@ -4699,6 +4704,8 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 				   ++ring->trail_seq);
 	amdgpu_ring_commit(kiq_ring);
 
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
 	/* poll the trailing fence */
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (ring->trail_seq ==
-- 
2.25.1



