Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C1AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07002075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgDMOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:06:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbgDMOGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:06:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94F0C48F6690EAB73C69;
        Mon, 13 Apr 2020 22:06:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 22:06:07 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <yanaijie@huawei.com>, <sam@ravnborg.org>,
        <y.oudjana@protonmail.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/amdgpu: remove dead code in si_dpm.c
Date:   Mon, 13 Apr 2020 22:32:35 +0800
Message-ID: <20200413143235.22945-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is dead, let's remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 0860e85a2d35..c00ba4b23c9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -345,26 +345,6 @@ static const struct si_dte_data dte_data_tahiti =
 	false
 };
 
-#if 0
-static const struct si_dte_data dte_data_tahiti_le =
-{
-	{ 0x1E8480, 0x7A1200, 0x2160EC0, 0x3938700, 0 },
-	{ 0x7D, 0x7D, 0x4E4, 0xB00, 0 },
-	0x5,
-	0xAFC8,
-	0x64,
-	0x32,
-	1,
-	0,
-	0x10,
-	{ 0x78, 0x7C, 0x82, 0x88, 0x8E, 0x94, 0x9A, 0xA0, 0xA6, 0xAC, 0xB0, 0xB4, 0xB8, 0xBC, 0xC0, 0xC4 },
-	{ 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700 },
-	{ 0x2AF8, 0x2AF8, 0x29BB, 0x27F9, 0x2637, 0x2475, 0x22B3, 0x20F1, 0x1F2F, 0x1D6D, 0x1734, 0x1414, 0x10F4, 0xDD4, 0xAB4, 0x794 },
-	85,
-	true
-};
-#endif
-
 static const struct si_dte_data dte_data_tahiti_pro =
 {
 	{ 0x1E8480, 0x3D0900, 0x989680, 0x2625A00, 0x0 },
-- 
2.21.1

