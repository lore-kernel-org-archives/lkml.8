Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120EDC3B1B7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30A32187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704104;
	bh=RH/40Ut+9piaDQ+a1B7aQX3vadBeoW1qkQgrLS0+VgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZILcUrg52gv+DvK62yF0l7Na8ZNHwTnebDek7i+h6MvliMfvCd7S5WcWA2xJjY0x8
	 /bxP0keKDJfd4xfFyQksFqKmA8uEH3CY27PCurfBnjPqVFObWi0d7kXOVJKoyaj0q6
	 6q3VdMXSya17IGkGECmMdPOULwRMQOUNwWdDZPJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394340AbgBNSPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbgBNPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E7A24685;
        Fri, 14 Feb 2020 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695528;
        bh=RH/40Ut+9piaDQ+a1B7aQX3vadBeoW1qkQgrLS0+VgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlTFuh+TF0aPIVujUaagx9AXFnQTk7VrHyrivI0c+90r83blryGFPYhUw/lOJeDm+
         jdBzIwIqD14BUKJT+lxjPoebXg+vhffGedF1dF12+BXHYET7AcJ9ZfAabBOSXStepB
         qYCR0a+FgsBFqb8T3/RY1E5qjFSWLe5IQ+9b3nyo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 149/542] drm/amdgpu: remove set but not used variable 'invalid'
Date:   Fri, 14 Feb 2020 10:42:21 -0500
Message-Id: <20200214154854.6746-149-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 9e089a29c696d86d26e79737bafbce94738fb462 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function
‘amdgpu_amdkfd_evict_userptr’:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1665:6: warning:
variable ‘invalid’ set but not used [-Wunused-but-set-variable]

'invalid' is never used, so can be removed. Thus 'atomic_inc_return'
can be replaced as 'atomic_inc'

Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 888209eb8cecd..8cf2e8f647065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1674,10 +1674,10 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 				struct mm_struct *mm)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
-	int invalid, evicted_bos;
+	int evicted_bos;
 	int r = 0;
 
-	invalid = atomic_inc_return(&mem->invalid);
+	atomic_inc(&mem->invalid);
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-- 
2.20.1

