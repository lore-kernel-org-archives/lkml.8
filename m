Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D7C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969E521D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgDQKNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:13:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728200AbgDQKNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:13:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C24975D03EC80580986;
        Fri, 17 Apr 2020 18:13:41 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 18:13:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/dc: remove unused variable 'video_optimized_pixel_rates'
Date:   Fri, 17 Apr 2020 18:12:47 +0800
Message-ID: <20200417101247.45616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1017:50:
 warning: ‘video_optimized_pixel_rates’ defined but not used [-Wunused-const-variable=]
 static const struct pixel_rate_range_table_entry video_optimized_pixel_rates[] = {
                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~

commit d8cd587d2bfd ("drm/amd/display: removing MODULO change for dcn2")
left behind this unused vairable, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 2e992fbc0d71..d2ad0504b0de 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1014,39 +1014,6 @@ struct pixel_rate_range_table_entry {
 	unsigned short div_factor;
 };
 
-static const struct pixel_rate_range_table_entry video_optimized_pixel_rates[] = {
-	// /1.001 rates
-	{25170, 25180, 25200, 1000, 1001},	//25.2MHz   ->   25.17
-	{59340, 59350, 59400, 1000, 1001},	//59.4Mhz   ->   59.340
-	{74170, 74180, 74250, 1000, 1001},	//74.25Mhz  ->   74.1758
-	{125870, 125880, 126000, 1000, 1001},	//126Mhz    ->  125.87
-	{148350, 148360, 148500, 1000, 1001},	//148.5Mhz  ->  148.3516
-	{167830, 167840, 168000, 1000, 1001},	//168Mhz    ->  167.83
-	{222520, 222530, 222750, 1000, 1001},	//222.75Mhz ->  222.527
-	{257140, 257150, 257400, 1000, 1001},	//257.4Mhz  ->  257.1429
-	{296700, 296710, 297000, 1000, 1001},	//297Mhz    ->  296.7033
-	{342850, 342860, 343200, 1000, 1001},	//343.2Mhz  ->  342.857
-	{395600, 395610, 396000, 1000, 1001},	//396Mhz    ->  395.6
-	{409090, 409100, 409500, 1000, 1001},	//409.5Mhz  ->  409.091
-	{445050, 445060, 445500, 1000, 1001},	//445.5Mhz  ->  445.055
-	{467530, 467540, 468000, 1000, 1001},	//468Mhz    ->  467.5325
-	{519230, 519240, 519750, 1000, 1001},	//519.75Mhz ->  519.231
-	{525970, 525980, 526500, 1000, 1001},	//526.5Mhz  ->  525.974
-	{545450, 545460, 546000, 1000, 1001},	//546Mhz    ->  545.455
-	{593400, 593410, 594000, 1000, 1001},	//594Mhz    ->  593.4066
-	{623370, 623380, 624000, 1000, 1001},	//624Mhz    ->  623.377
-	{692300, 692310, 693000, 1000, 1001},	//693Mhz    ->  692.308
-	{701290, 701300, 702000, 1000, 1001},	//702Mhz    ->  701.2987
-	{791200, 791210, 792000, 1000, 1001},	//792Mhz    ->  791.209
-	{890100, 890110, 891000, 1000, 1001},	//891Mhz    ->  890.1099
-	{1186810, 1186820, 1188000, 1000, 1001},//1188Mhz   -> 1186.8131
-
-	// *1.001 rates
-	{27020, 27030, 27000, 1001, 1000}, //27Mhz
-	{54050, 54060, 54000, 1001, 1000}, //54Mhz
-	{108100, 108110, 108000, 1001, 1000},//108Mhz
-};
-
 static bool dcn20_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
-- 
2.17.1


