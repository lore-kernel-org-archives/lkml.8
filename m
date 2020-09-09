Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB98C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B4B221F0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgIINKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:10:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730236AbgIINAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1FCB9E98FF29C9EE4723;
        Wed,  9 Sep 2020 21:00:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:28 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 8/8] drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
Date:   Wed, 9 Sep 2020 21:07:20 +0800
Message-ID: <20200909130720.105234-9-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200909130720.105234-1-zhengbin13@huawei.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:1003:4-9: WARNING: Comparison to bool
drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:1083:5-11: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f975dc4b143a..e8e7d4228b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1000,7 +1000,7 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
 		sdma[i] = &adev->sdma.instance[i].page;

 		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
-			(unset == false)) {
+			(!unset)) {
 			amdgpu_ttm_set_buffer_funcs_status(adev, false);
 			unset = true;
 		}
@@ -1080,7 +1080,7 @@ static void sdma_v4_0_enable(struct amdgpu_device *adev, bool enable)
 	u32 f32_cntl;
 	int i;

-	if (enable == false) {
+	if (!enable) {
 		sdma_v4_0_gfx_stop(adev);
 		sdma_v4_0_rlc_stop(adev);
 		if (adev->sdma.has_page_queue)
--
2.26.0.106.g9fadedd

