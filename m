Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100D521D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIJC4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:56:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729298AbgIJCzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:55:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60DAF3647B9752C439E5;
        Thu, 10 Sep 2020 10:55:41 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 10:55:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Yong.Zhao@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdkfd: Fix -Wunused-const-variable warning
Date:   Thu, 10 Sep 2020 10:55:32 +0800
Message-ID: <20200910025532.19616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KFD_SUPPORT_IOMMU_V2 is not set, gcc warns:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:121:37: warning: ‘raven_device_info’ defined but not used [-Wunused-const-variable=]
 static const struct kfd_device_info raven_device_info = {
                                     ^~~~~~~~~~~~~~~~~

Move it to ifdef block.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e71a0543f98..cae4df259e26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -116,7 +116,6 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
-#endif
 
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
@@ -135,6 +134,7 @@ static const struct kfd_device_info raven_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
+#endif
 
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
-- 
2.17.1


