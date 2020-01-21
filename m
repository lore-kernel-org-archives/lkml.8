Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4484D2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAUOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:01:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbgAUOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:01:14 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40F61A60D87D0269834C;
        Tue, 21 Jan 2020 22:01:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 22:01:04 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <tao.zhou1@amd.com>, <Hawking.Zhang@amd.com>,
        <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 14/14] drm/amdgpu: remove unnecessary conversion to bool in gfx_v9_0.c
Date:   Tue, 21 Jan 2020 21:55:40 +0800
Message-ID: <20200121135540.165798-15-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200121135540.165798-1-chenzhou10@huawei.com>
References: <20200121135540.165798-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

./drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:4737:43-48: WARNING:
	conversion to bool not needed here

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2f782c3..e4744ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4672,7 +4672,7 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_PG_STATE_GATE) ? true : false;
+	bool enable = state == AMD_PG_STATE_GATE;
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -4734,7 +4734,7 @@ static int gfx_v9_0_set_clockgating_state(void *handle,
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
 		gfx_v9_0_update_gfx_clock_gating(adev,
-						 state == AMD_CG_STATE_GATE ? true : false);
+						 state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
-- 
2.7.4

