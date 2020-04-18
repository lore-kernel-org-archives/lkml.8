Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12E021D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220903;
	bh=9d6dIVVW/eoJFIE97fA3VAir62eKBHLtOhBqUlU/lXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVhZlMrL1pqgpkaGXslkbBWpCfDj8TZcVQqw/R0pNp/8q3km6TE1Y+EP3n1n/8o6Q
	 DAaCMAg2HvBAsZ24s1za2YxvC4aoJHj3XkMexOcG5ow8xtkOJWtmsedwy3WrdqIzT0
	 JTZXL6Vhg8kU1IlTUwNZloL4mX/gLU8IXG1NJ1Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDROlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgDROlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D272224F;
        Sat, 18 Apr 2020 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220895;
        bh=9d6dIVVW/eoJFIE97fA3VAir62eKBHLtOhBqUlU/lXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGwljTc2Ekawwp48D02rXFnwrqRfV94mwtOuNTuMtNHft0sK0DNxdP6t0JkEydiaR
         RYZhsRzjksZHTxy/RswvCCnhOK0xSj5CmIYbJ7zOrNd7n/MGzWIsY4vNNaIyalTEtJ
         wRDyCpfk4LyG4Xel2fwW+v41b4ZTGZvL4xXzhzw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Zhang <Jack.Zhang1@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 37/78] drm/amdkfd: kfree the wrong pointer
Date:   Sat, 18 Apr 2020 10:40:06 -0400
Message-Id: <20200418144047.9013-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
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
index 0dc1084b5e829..ad9483b9eea32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1112,9 +1112,9 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
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

