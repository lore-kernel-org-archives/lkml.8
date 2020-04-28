Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51558206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD1Gbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:31:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgD1Gbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:31:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFF1AB7B043C4871D755;
        Tue, 28 Apr 2020 14:31:44 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:31:35 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Anthony.Koo@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amd/display: remove duplicate assignment of dcn21_funcs members
Date:   Tue, 28 Apr 2020 14:31:01 +0800
Message-ID: <20200428063101.25556-1-yanaijie@huawei.com>
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

Fix the following coccicheck warning:

drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
exit_optimized_pwr_state: first occurrence line 86, second occurrence
line 92
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
optimize_pwr_state: first occurrence line 85, second occurrence line 91
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_attribute: first occurrence line 71, second occurrence line
89
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_position: first occurrence line 70, second occurrence line 88
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_sdr_white_level: first occurrence line 72, second occurrence
line 90

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 8410a6305a9a..fe64bcb49456 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -85,11 +85,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
-	.set_cursor_position = dcn10_set_cursor_position,
-	.set_cursor_attribute = dcn10_set_cursor_attribute,
-	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
-	.optimize_pwr_state = dcn21_optimize_pwr_state,
-	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.power_down = dce110_power_down,
 };
 
-- 
2.21.1

