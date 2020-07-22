Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C0DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BB120672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgGVBwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:52:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731632AbgGVBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:52:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 46135F10C8CAD54FD757;
        Wed, 22 Jul 2020 09:52:30 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 09:52:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <Jack.Zhang1@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu/vcn3.0: Remove set but not used variable 'direct_poll'
Date:   Wed, 22 Jul 2020 09:52:10 +0800
Message-ID: <20200722015210.29488-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: In function vcn_v3_0_start_sriov:
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1235:3:
 warning: variable direct_poll set but not used [-Wunused-but-set-variable]

It is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 910a4a32ff78..53f680134c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1231,8 +1231,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
 		direct_rd_mod_wt = { {0} };
-	struct mmsch_v3_0_cmd_direct_polling
-		direct_poll = { {0} };
 	struct mmsch_v3_0_cmd_end end = { {0} };
 	struct mmsch_v3_0_init_header header;
 
@@ -1240,8 +1238,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
 	direct_rd_mod_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
-	direct_poll.cmd_header.command_type =
-		MMSCH_COMMAND__DIRECT_REG_POLLING;
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
-- 
2.17.1


