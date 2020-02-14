Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA470C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917582082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700354;
	bh=hEqE9s7hwqc0TcLQaHrv60bKO82V3yKIzTCuzVp1MNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N5KogU7d7cOBEl6nti27Ncop6isRz6ZstUVZPPK0i+vtbnpHkLiIXd2YHxHdlrCgc
	 ce4I6osKVe+v5eZou3qy6S24qy0YBWK5OswKsJ6C8xkLupqr2+n7O1dZc03XLAVYHy
	 5TU73GMwAm7ouvcGljLE4ZdgnFILDmaJQbsUsjwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbgBNRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392095AbgBNQNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97483246A1;
        Fri, 14 Feb 2020 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696783;
        bh=hEqE9s7hwqc0TcLQaHrv60bKO82V3yKIzTCuzVp1MNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRdfvZHi+h3n+36WffgnNhjGYETdOZBy1lSwSi8dyNCOg4/QfuTwhGD8OX5TV+POm
         BO5xGHaiajuNJf4rZji/wYnbM5TzAFe4KZiSLxOkpUawAIGYJYnbGx/4hwvmmtzyRX
         nMS3l017KgvWUhJeGQtymU5PB5wOgJL6eRlncXao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 059/252] drm/amd/powerplay: remove set but not used variable 'threshold', 'state'
Date:   Fri, 14 Feb 2020 11:08:34 -0500
Message-Id: <20200214161147.15842-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit f5ac1595156a8b63812ed6fa0803ddf7207cced7 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c: In function fiji_populate_single_graphic_level:
drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c:943:11: warning: variable threshold set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c: In function fiji_populate_memory_timing_parameters:
drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c:1504:8: warning: variable state set but not used [-Wunused-but-set-variable]

They are introduced by commit 2e112b4ae3ba ("drm/amd/pp:
remove fiji_smc/smumgr split."), but never used,
so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 40df5c2706cce..d517fbd6809c9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -950,7 +950,7 @@ static int fiji_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 {
 	int result;
 	/* PP_Clocks minClocks; */
-	uint32_t threshold, mvdd;
+	uint32_t mvdd;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
@@ -983,8 +983,6 @@ static int fiji_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 	level->VoltageDownHyst = 0;
 	level->PowerThrottle = 0;
 
-	threshold = clock * data->fast_watermark_threshold / 100;
-
 	data->display_timing.min_clock_in_sr = hwmgr->display_config->min_core_set_clock_in_sr;
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_SclkDeepSleep))
@@ -1510,7 +1508,7 @@ static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
 	uint32_t dram_timing;
 	uint32_t dram_timing2;
 	uint32_t burstTime;
-	ULONG state, trrds, trrdl;
+	ULONG trrds, trrdl;
 	int result;
 
 	result = atomctrl_set_engine_dram_timings_rv770(hwmgr,
@@ -1522,7 +1520,6 @@ static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
 	dram_timing2 = cgs_read_register(hwmgr->device, mmMC_ARB_DRAM_TIMING2);
 	burstTime = cgs_read_register(hwmgr->device, mmMC_ARB_BURST_TIME);
 
-	state = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, STATE0);
 	trrds = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, TRRDS0);
 	trrdl = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, TRRDL0);
 
-- 
2.20.1

