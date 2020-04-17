Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D08C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BECE21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgDQHGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:06:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2387 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgDQHGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:06:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E3852DE581F6460A0D08;
        Fri, 17 Apr 2020 15:06:08 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:05:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <yanaijie@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/amd/powerplay: remove defined but not used variables
Date:   Fri, 17 Apr 2020 15:32:19 +0800
Message-ID: <20200417073219.40320-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:710:46:
warning: ‘PSMGCEDCThresholdConfig_vega10’ defined but not used
[-Wunused-const-variable=]
 static const struct vega10_didt_config_reg
PSMGCEDCThresholdConfig_vega10[] =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:654:46:
warning: ‘PSMSEEDCThresholdConfig_Vega10’ defined but not used
[-Wunused-const-variable=]
 static const struct vega10_didt_config_reg
PSMSEEDCThresholdConfig_Vega10[] =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 .../amd/powerplay/hwmgr/vega10_powertune.c    | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index ca9b23b5abc9..9757d47dd6b8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -651,18 +651,6 @@ static const struct vega10_didt_config_reg   PSMSEEDCStallDelayConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMSEEDCThresholdConfig_Vega10[] =
-{
-/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- *      Offset                             Mask                                                 Shift                                                  Value
- * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- */
-	/* SQ EDC THRESHOLD */
-	{   ixDIDT_SQ_EDC_THRESHOLD,           DIDT_SQ_EDC_THRESHOLD__EDC_THRESHOLD_MASK,           DIDT_SQ_EDC_THRESHOLD__EDC_THRESHOLD__SHIFT,            0x0000 },
-
-	{   0xFFFFFFFF  }  /* End of list */
-};
-
 static const struct vega10_didt_config_reg   PSMSEEDCCtrlResetConfig_Vega10[] =
 {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -707,17 +695,6 @@ static const struct vega10_didt_config_reg   PSMSEEDCCtrlConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMGCEDCThresholdConfig_vega10[] =
-{
-/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- *      Offset                             Mask                                                 Shift                                                  Value
- * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- */
-	{   mmGC_EDC_THRESHOLD,                GC_EDC_THRESHOLD__EDC_THRESHOLD_MASK,                GC_EDC_THRESHOLD__EDC_THRESHOLD__SHIFT,                 0x0000000 },
-
-	{   0xFFFFFFFF  }  /* End of list */
-};
-
 static const struct vega10_didt_config_reg   PSMGCEDCDroopCtrlConfig_vega10[] =
 {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 
2.21.1

