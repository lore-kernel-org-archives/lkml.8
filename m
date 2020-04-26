Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0EC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8E20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDZJko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:40:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3301 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgDZJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:40:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E6F3CA1E8DB84816E46;
        Sun, 26 Apr 2020 17:40:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:40:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <kevin1.wang@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amd/powerplay: remove conversion to bool in navi10_ppt.c
Date:   Sun, 26 Apr 2020 17:39:58 +0800
Message-ID: <20200426093958.22875-1-yanaijie@huawei.com>
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

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

drivers/gpu/drm/amd/powerplay/navi10_ppt.c:698:47-52: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2184d247a9f7..135442c36273 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -695,7 +695,7 @@ static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
-	return dpm_desc->SnapToDiscrete == 0 ? true : false;
+	return dpm_desc->SnapToDiscrete == 0;
 }
 
 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
-- 
2.21.1

