Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAFDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDEA22314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgAUOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:01:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbgAUOBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:01:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 327131CA956AD12FCC62;
        Tue, 21 Jan 2020 22:01:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 22:00:58 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <tao.zhou1@amd.com>, <Hawking.Zhang@amd.com>,
        <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 11/14] drm/amdgpu: remove unnecessary conversion to bool in amdgpu_device.c
Date:   Tue, 21 Jan 2020 21:55:37 +0800
Message-ID: <20200121135540.165798-12-chenzhou10@huawei.com>
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

./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2883:68-73: WARNING:
	conversion to bool not needed here

and many more similar messages.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1f0e6b9..29b54d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -986,7 +986,7 @@ static void amdgpu_device_check_vm_size(struct amdgpu_device *adev)
 static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 {
 	struct sysinfo si;
-	bool is_os_64 = (sizeof(void *) == 8) ? true : false;
+	bool is_os_64 = sizeof(void *) == 8;
 	uint64_t total_memory;
 	uint64_t dram_size_seven_GB = 0x1B8000000;
 	uint64_t dram_size_three_GB = 0xB8000000;
@@ -2881,7 +2881,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
 
 	adev->gfx.gfx_off_req_count = 1;
-	adev->pm.ac_power = power_supply_is_system_supplied() > 0 ? true : false;
+	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
@@ -3999,9 +3999,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool use_baco = amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO;
 
 	/*
 	 * Flush RAM to disk so that after reboot
-- 
2.7.4

