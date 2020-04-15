Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25115C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E937D2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955759;
	bh=Q+1ZS5W6jXT+EKzQgp5O3Yy0jxmJ2fHRHozCR6SdLn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K93Fw8VwWN9gRuZFvZyZHR7N0IySCqLREK67boJyqPBio3BurlLnEVKYFaRdt47xF
	 s/aeh13xtIIDkjjjvoTdokQEeBhhvRGL6z5QXwaQsbSgqDSQptxho9BJaAE8T6snDz
	 Gc2pSVh4QVo6RNg5+WX85FE7EvOM1f9BLzdpKkGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370655AbgDONCh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897163AbgDOLgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D81A20768;
        Wed, 15 Apr 2020 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950595;
        bh=Q+1ZS5W6jXT+EKzQgp5O3Yy0jxmJ2fHRHozCR6SdLn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wY7qlxsCUAMolodvCecd3/W06uP0J+d5YOz9qMttdXKmJ9EQSVwqa+zOxD+i1gx/i
         xM24uXh28swDX2us4jTW9ZxLLH9adGNzkULvRf/HGDZ+716cHJmFBIvAUGT/mmxo3S
         enFGtYfi3A5ltj/9t4t5TmHTay0RrPFcJAMfdTyU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Zhang <Jack.Zhang1@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 091/129] drm/amdkfd: kfree the wrong pointer
Date:   Wed, 15 Apr 2020 07:34:06 -0400
Message-Id: <20200415113445.11881-91-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Zhang <Jack.Zhang1@amd.com>

[ Upstream commit 3148a6a0ef3cf93570f30a477292768f7eb5d3c3 ]

Originally, it kfrees the wrong pointer for mem_obj.
It would cause memory leak under stress test.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
Acked-by: Nirmoy Das <nirmoy.das@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2a9e401317353..0d70cb2248fe9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1104,9 +1104,9 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	return 0;
 
 kfd_gtt_no_free_chunk:
-	pr_debug("Allocation failed with mem_obj = %p\n", mem_obj);
+	pr_debug("Allocation failed with mem_obj = %p\n", *mem_obj);
 	mutex_unlock(&kfd->gtt_sa_lock);
-	kfree(mem_obj);
+	kfree(*mem_obj);
 	return -ENOMEM;
 }
 
-- 
2.20.1

