Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF43C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F59207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbgDCOfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:35:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:35:50 -0400
Received: from [123.118.214.4] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1jKNQ8-0003KD-Dj; Fri, 03 Apr 2020 14:35:47 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, xiaojie.yuan@amd.com,
        Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        aaron.ma@canonical.com
Subject: [PATCH] drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event
Date:   Fri,  3 Apr 2020 22:34:19 +0800
Message-Id: <20200403143419.155503-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARCTURUS and RENOIR, powerplay is not supported yet.
When plug in or unplug power jack, ACPI event will issue.
Then kernel NULL pointer BUG will be triggered.
Check for NULL pointers before calling.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index f197f1be0969..611de69f9d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -89,7 +89,8 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
-		if (adev->powerplay.pp_funcs->enable_bapm)
+		if (adev->powerplay.pp_funcs &&
+				adev->powerplay.pp_funcs->enable_bapm)
 			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
 		mutex_unlock(&adev->pm.mutex);
 
-- 
2.17.1

