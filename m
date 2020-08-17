Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4820738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691027;
	bh=HM15DRQruEOLK3MMp93V+owjUYiahA5zhe7I8I3MwYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpJQThNSpQVsRMJxu9s1Ohm674FsBBi/BDHN7b4q0fA3G8SKjbnZQ0x46oRuW6gRN
	 dx+LHkz3D8GN2JnOc2cx72cLmNvjmk1zgcTWFQd4Q9taBatTPTT+hn1Zvu5EeIzjCs
	 gxXsX0WW63tg12EqwO99DnTSD8ADcoqLzp1gofGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391767AbgHQTDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbgHQPqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:46:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B3B2067C;
        Mon, 17 Aug 2020 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679189;
        bh=HM15DRQruEOLK3MMp93V+owjUYiahA5zhe7I8I3MwYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYsD10D1cAabwuEX15msB1Nxlr2jcRp5Qu1Mntm/N+2qMpffh0ckSHyQ5NWYjX4rv
         BHoTwyJPt+4uK34IhvkePAqi2C50Tmvu3ofX7Qki0YNfHEvoHNGVWEXeq+7gFYJTtD
         exS7PXYVTjMJWI09aqf3lLgd47rMs5RQYQ0+4QyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 096/393] drm/amdgpu/display: properly guard the calls to swSMU functions
Date:   Mon, 17 Aug 2020 17:12:26 +0200
Message-Id: <20200817143824.283043751@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 4072327a2622af8688b88f5cd0a472136d3bf33d ]

It's only applicable on newer asics.  We could end up here when
using DC on older asics like SI or KV.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1170
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 7cee8070cb113..5c6a6ae48d396 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -106,7 +106,7 @@ bool dm_pp_apply_display_requirements(
 			adev->powerplay.pp_funcs->display_configuration_change(
 				adev->powerplay.pp_handle,
 				&adev->pm.pm_display_cfg);
-		else
+		else if (adev->smu.ppt_funcs)
 			smu_display_configuration_change(smu,
 							 &adev->pm.pm_display_cfg);
 
@@ -592,7 +592,7 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
 	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
 		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
 							   &wm_with_clock_ranges);
-	else
+	else if (adev->smu.ppt_funcs)
 		smu_set_watermarks_for_clock_ranges(&adev->smu,
 				&wm_with_clock_ranges);
 }
-- 
2.25.1



