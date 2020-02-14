Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3668C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834362468D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695564;
	bh=t5Y/Zm4seotTIHhBofWx+0RaQMh/3PyaQzKGzUIzxro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OI8KSCXYG3L+LVcE4YL0lAqusZNy/TAFXlNiuYlqxUKtynkHEp/t+5yckwEZPEppe
	 aMaA7x9ILECG9GXoucvviufsl3sl/sF/uH+bm5jSmtjEt3tOXktsi42U+lnzSzGdEQ
	 flNqHHLaNin3Bm50KYFsbAB1IwthrpA7cEeUN/Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgBNPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbgBNPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD642468C;
        Fri, 14 Feb 2020 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695536;
        bh=t5Y/Zm4seotTIHhBofWx+0RaQMh/3PyaQzKGzUIzxro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAiROEE5ycYD7fzTtT6Tm9C1o6XcLSnonuy0jmlPjflNiiZr7AP5RbNFZHrYet9Yk
         Q4nOGYlr1dHhpdL6zN7g7gNvhZNf8Tcpk1JcNnT57NfrlGpl8SOHEtScinHP32gsno
         O6G45st0+33g52QiNnX3DI7xBjSfEyGZYgU0rwmw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 155/542] drm/amdkfd: remove set but not used variable 'top_dev'
Date:   Fri, 14 Feb 2020 10:42:27 -0500
Message-Id: <20200214154854.6746-155-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit d191bd678153307573d615bb42da4fcca19fe477 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdkfd/kfd_iommu.c: In function kfd_iommu_device_init:
drivers/gpu/drm/amd/amdkfd/kfd_iommu.c:65:30: warning: variable top_dev set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1ae99eab34f9 ("drm/amdkfd: Initialize HSA_CAP_ATS_PRESENT capability in topology codes")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 193e2835bd4d2..8d871514671eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -62,9 +62,6 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	unsigned int pasid_limit;
 	int err;
-	struct kfd_topology_device *top_dev;
-
-	top_dev = kfd_topology_device_by_id(kfd->id);
 
 	if (!kfd->device_info->needs_iommu_device)
 		return 0;
-- 
2.20.1

