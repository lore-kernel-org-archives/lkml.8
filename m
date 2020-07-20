Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D76C28CFE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A9722C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281144;
	bh=oGUrR/3CifRJrhJzUDoT4zDQtGxfmbqA1TZdgk9HqjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkRtjXrFK8DQK28F6VveyY1/rr6hdK8i7TViqFLTFy1QU+q6dTQzQom5bdCNdV+Do
	 M9Oe5fyJ9yPyRvqYoda3xpUrW1jUml5TJS1FRCFRa9H0hG2aC9a8rh0muD4pspdjqP
	 hq4fJQpUIqZfwAeBprl4/HVrHquR53gTfgOfhDqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgGTVjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgGTVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:38:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C93522CAF;
        Mon, 20 Jul 2020 21:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281113;
        bh=oGUrR/3CifRJrhJzUDoT4zDQtGxfmbqA1TZdgk9HqjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dt/Zcx5hAXics12s2KptXMk/N0LpFuM921zCOGgmsbcoDah1zUbINLAiwsIf7P0lF
         qvywkYTABA6JG9pO2T6eahwcDNZtY1C2PbRob3p3JE1cs/QSQi6gflgb7OX9VYgLer
         c6v20r7/FnTZOTKHrsXuOinRdWTBPwf1NOjEfpnA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 21/34] drm/amdgpu/gfx10: fix race condition for kiq
Date:   Mon, 20 Jul 2020 17:37:54 -0400
Message-Id: <20200720213807.407380-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213807.407380-1-sashal@kernel.org>
References: <20200720213807.407380-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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

