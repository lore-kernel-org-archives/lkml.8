Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D82C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0E621835
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648796;
	bh=/8VrXNcNLIf8zNDY6AJSrHlUWb80YHaWdex7BWzbC1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kHIccRJZnITzBZKMullUt+5IEMTrL+R4pfBsqN7kZj/WGT1MjlX7QJdCWSFyR1H09
	 LF3kIRfD0s0hz/XkzQAGcOxX7/LNQ31YKt1hqexZ+YAlcPLiVHaV/klZm92aBmQiZL
	 fMJRxCs71y0El7xyajxaU8KFokpGyjjBp0sS+sic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgDKXFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgDKXFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9944F214D8;
        Sat, 11 Apr 2020 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646307;
        bh=/8VrXNcNLIf8zNDY6AJSrHlUWb80YHaWdex7BWzbC1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUsz//6+NMuYIl/jtsXTIvLXO9/z2KbSG8lSGgdQBqZEHJUmAgen3VVisI3lLlyfq
         VGYHt1FdjueJHXNo93n6RQHsg8JENrvqhafV3oU4ovZRe/OSjJjJ71Qcz5YTsma+sh
         wXmN9VABRqLcfLv/KiDJ+0ZWzu+HWwywKJMxv14I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Oak Zeng <oak.zeng@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 065/149] drm/amdgpu: Fix missing error check in suspend
Date:   Sat, 11 Apr 2020 19:02:22 -0400
Message-Id: <20200411230347.22371-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

[ Upstream commit 70bedd68e7b3a7f1d7f3198bb698fc23bc5aaa68 ]

amdgpu_device_suspend might return an error code since it can be called
from both runtime and system suspend flows. Add the missing return code
in case of a failure.

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 42f4febe24c6d..921e2944255b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1225,6 +1225,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.20.1

