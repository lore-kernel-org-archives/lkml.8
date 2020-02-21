Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFCC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CA224650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUM2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:28:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgBUM2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:28:31 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF8D1A7198EF02918178;
        Fri, 21 Feb 2020 20:28:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 20:28:11 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <kenneth.feng@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: Use bitwise instead of arithmetic operator for flags
Date:   Fri, 21 Feb 2020 20:21:39 +0800
Message-ID: <20200221122139.148664-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences the following coccinelle warning:

"WARNING: sum of probable bitmasks, consider |"

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 92a65e3d..f29f95b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3382,7 +3382,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_levels(
 	}
 
 	if (data->need_update_dpm_table &
-			(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK + DPMTABLE_UPDATE_SOCCLK)) {
+			(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK | DPMTABLE_UPDATE_SOCCLK)) {
 		result = vega10_populate_all_graphic_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 == result),
 				"Failed to populate SCLK during PopulateNewDPMClocksStates Function!",
@@ -3390,7 +3390,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_levels(
 	}
 
 	if (data->need_update_dpm_table &
-			(DPMTABLE_OD_UPDATE_MCLK + DPMTABLE_UPDATE_MCLK)) {
+			(DPMTABLE_OD_UPDATE_MCLK | DPMTABLE_UPDATE_MCLK)) {
 		result = vega10_populate_all_memory_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 == result),
 				"Failed to populate MCLK during PopulateNewDPMClocksStates Function!",
-- 
2.7.4

