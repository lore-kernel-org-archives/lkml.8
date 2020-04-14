Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24484C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0664720857
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439488AbgDNLl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:41:57 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:14790 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439471AbgDNLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:41:52 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 07:41:51 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 8F71F4E1434;
        Tue, 14 Apr 2020 19:35:23 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Bernard Zhao <bernard@vivo.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Oak Zeng <Oak.Zeng@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] Optimized division operation to shift operation
Date:   Tue, 14 Apr 2020 04:35:08 -0700
Message-Id: <1586864113-30682-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VOS01LS0tLT0pCTUpNTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6Ajo*Tjg1TwoNNAg1Fz4v
        Lk0KFDJVSlVKTkNNQ01PSklIQk5OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBT0NPSTcG
X-HM-Tid: 0a717878efd19376kuws8f71f4e1434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some processors, the / operate will call the compiler`s div lib,
which is low efficient, We can replace the / operation with shift,
so that we can replace the call of the division library with one
shift assembly instruction.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b205039..66cd078 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -175,10 +175,10 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	new_io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	new_fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 9da9596..ca26d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -193,10 +193,10 @@ static int gmc_v7_0_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 27d83204..295039c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -318,10 +318,10 @@ static int gmc_v8_0_tonga_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-- 
2.7.4

