Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EBC352B6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CD4215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646654;
	bh=bBys+PJOkk6PEuV5yc15/ZLQS/zF3K910i89yWwVUI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lrmSfb+7U9bwqzKoPTOAXvYDsSqAO7Am6civuihmUG9jNlCYUtFPQXztEFkRWUOEl
	 jkKvt2+521zd6FHqOKqu671BZcCAAC0OmrPznYq2puviaI7x9Oaw/8/WZy+NUd2RES
	 S8lUN9FVjZFTFxNOMXI3GZszCIOibu/Ry+sSACU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgDKXKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbgDKXKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BFCB20708;
        Sat, 11 Apr 2020 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646651;
        bh=bBys+PJOkk6PEuV5yc15/ZLQS/zF3K910i89yWwVUI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FG15aXsmUoIy/7vOkBaUSEe9Y06J5BYWrcHzsDpDqy+xNfAL/fSJgioGosHx1PR/g
         uuSGBpp2gv8BCBxjwNicJtuCop1STjlJHMzlecqzOgq0DzSarBCWN740SsTLVP300x
         bpxsyncs4CaO9OTvcWMwpSPfW6i4IiFoG0DhAGeg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 054/108] drm/amdgpu: fix parentheses in amdgpu_vm_update_ptes
Date:   Sat, 11 Apr 2020 19:08:49 -0400
Message-Id: <20200411230943.24951-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
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
index c7514f7434095..7455581a02b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1443,7 +1443,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = (uint64_t)(mask + 1) << shift;
+		entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
-- 
2.20.1

