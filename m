Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767AC35643
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06A52469F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273480;
	bh=kpxSpiOredmCdN9Q0Stfhh2Dls3j079H4/egN8JsXU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdEFGEWVjzNHx/XyyBMZqpLf49iul3LXTTbK7NlVbNJHDlkWg9EqwK/+H8/gmYNe8
	 LPpzvkSRbxty81fg5QazwZoNi1cjCzStIwb1E+K68STT+qhFhDifVBbp4WgkpFyabO
	 7J+32AqvRIZbhhhA5vunp4j4ui1XSZB1xIdke98I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgBUIYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388667AbgBUIYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA186246A1;
        Fri, 21 Feb 2020 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273471;
        bh=kpxSpiOredmCdN9Q0Stfhh2Dls3j079H4/egN8JsXU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEHMZkXqWIH1Y4dMpFwx8yWHEPRfsE3/a8lrm0pePfSyIrXrpz1PAQjEuRfimOQ32
         1ReK0tXmQ6hqm3CNc7KR8UcLlb/BT44NQprmnwBD07znrO3fBjRLXNcjC7z1KlzL3P
         IykrYTM6bAakIDAqiL0Tegc2JkubokSHjR0Ds0QQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 184/191] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency
Date:   Fri, 21 Feb 2020 08:42:37 +0100
Message-Id: <20200221072312.821201678@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 4d0a72b66065dd7e274bad6aa450196d42fd8f84 ]

Only send non-0 clocks to DC for validation.  This mirrors
what the windows driver does.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 1546bc49004f8..3fa6e8123b8eb 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -994,12 +994,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
-		clocks->data[i].latency_in_us = latency_required ?
-						smu10_get_mem_latency(hwmgr,
-						pclk_vol_table->entries[i].clk) :
-						0;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				pclk_vol_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us = latency_required ?
+				smu10_get_mem_latency(hwmgr,
+						      pclk_vol_table->entries[i].clk) :
+				0;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.20.1



