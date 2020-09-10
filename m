Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ECAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67B620809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIJHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:50:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbgIJHuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:50:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 904FD2B01B300031E483;
        Thu, 10 Sep 2020 15:50:44 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 15:50:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Yong.Zhao@amd.com>, <ray.huang@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/amdkfd: Fix -Wunused-const-variable warning
Date:   Thu, 10 Sep 2020 15:50:06 +0800
Message-ID: <20200910075006.41484-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200910025532.19616-1-yuehaibing@huawei.com>
References: <20200910025532.19616-1-yuehaibing@huawei.com>
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

As Huang Rui suggested, Raven already has the fallback path,
so it should be out of IOMMU v2 flag.

Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e71a0543f98..e3fc6ed7b79c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -503,8 +503,8 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 #ifdef KFD_SUPPORT_IOMMU_V2
 	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
 	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
-	[CHIP_RAVEN] = {&raven_device_info, NULL},
 #endif
+	[CHIP_RAVEN] = {&raven_device_info, NULL},
 	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
 	[CHIP_TONGA] = {&tonga_device_info, NULL},
 	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
-- 
2.17.1


