Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD12C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC33421924
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646517;
	bh=zBiznQ4vy/QHiHdic6RZO1pzloRdk2UmaY60wJRZ9Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKH/ck4mTII/LOL4Hw2JCx5VCYGlxvxUjjJPLw4VZpb8iHFyaItH3QbUYJs7k+MJ0
	 TFB6gafh+pGt5QpIRk4ol8GDDVT2L4rjp8fSHa4Qwa271owIBNEOfPcxscuP8Ba5l2
	 sL6lv5dEriIfDVMeSH1NKU2bq0XLMRFwL+TYadbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgDKXIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgDKXIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:08:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FED821835;
        Sat, 11 Apr 2020 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646502;
        bh=zBiznQ4vy/QHiHdic6RZO1pzloRdk2UmaY60wJRZ9Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AomB5NAVTENVXHiFtO6bg4IbJpwlOmg5OXBXoynJ2pRm48kBXueGcMSmrTflf5G+E
         ZK5EE2C+oTDt3fdHQggalmIPY8xyC8vvSjlrtG3CZdtY2OZRgd1RXhQucSleyGe0l2
         Z7RuPiHEvzqNObnTPooFTafnkiMbpGR74823zL+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 062/121] drm/amdgpu: fix parentheses in amdgpu_vm_update_ptes
Date:   Sat, 11 Apr 2020 19:06:07 -0400
Message-Id: <20200411230706.23855-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit bfcd6c69e4c3f73f2f92b997983537f9a3ac3b29 ]

For the root PD mask can be 0xffffffff as well which would
overrun to 0 if we don't cast it before we add one.

Signed-off-by: Christian König <christian.koenig@amd.com>
Tested-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 598c24505c73b..d37d9c372e7d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1468,7 +1468,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = (uint64_t)(mask + 1) << shift;
+		entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
-- 
2.20.1

