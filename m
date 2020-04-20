Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F512C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21944214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDTEB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 00:01:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2409 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgDTEB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:01:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ABB55F7DB79F7C0BFBE1;
        Mon, 20 Apr 2020 12:01:25 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 12:01:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <noah.abradjian@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amd/display: remove unneeded conversion to bool
Date:   Mon, 20 Apr 2020 12:28:00 +0800
Message-ID: <20200420042800.18902-1-yanaijie@huawei.com>
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

drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c:485:66-71:
WARNING: conversion to bool not needed here
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c:896:68-73:
WARNING: conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
index 8dc3d1f73984..2feb051a2002 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
@@ -482,7 +482,7 @@ bool dpp20_program_blnd_lut(
 		next_mode = LUT_RAM_A;
 
 	dpp20_power_on_blnd_lut(dpp_base, true);
-	dpp20_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp20_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp20_program_blnd_luta_settings(dpp_base, params);
@@ -893,7 +893,7 @@ bool dpp20_program_shaper(
 	else
 		next_mode = LUT_RAM_A;
 
-	dpp20_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp20_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp20_program_shaper_luta_settings(dpp_base, params);
-- 
2.21.1

