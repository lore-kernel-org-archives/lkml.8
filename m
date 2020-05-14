Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD309C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBDA20643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483376;
	bh=AQ5Ja54zZPWJCzN1n8jzY96BFQlAAx9L0kU4hbgVYnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gNNInJDtO6EIXtORMmWK+jbuibDgKW8sFwHO9HrBp0ODhjMoWr18j+6+pMZ/p6aR9
	 NrM92s+zP5J/FXcGHYRSkfwZywanWrpeIZS9OvuFdAum7w/EzQ27Mv1y/9azKzoHXc
	 4/Fi5cAH3VWOGX7TN3+6Ly3UhD/0ZqSyl6pc5uM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgENTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgENSwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E086F206D8;
        Thu, 14 May 2020 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482364;
        bh=AQ5Ja54zZPWJCzN1n8jzY96BFQlAAx9L0kU4hbgVYnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lewh+dHyHa8kqsuku5Yn3eE4DCrl/jfsdFqs6g2wRmsgzQfRF7d8jIavG1aYTR1O0
         FeGciNaBajurBTEsQdtgYQ6aNR1D9gqUQ7q8yN43rU50rR9gTJE1anQj7RUjHc4DfJ
         xOraXTSdGvLT41Cnschg0YdVlvjoyorA/uxjwT3o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sung Lee <sung.lee@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 44/62] drm/amd/display: Update DCN2.1 DV Code Revision
Date:   Thu, 14 May 2020 14:51:29 -0400
Message-Id: <20200514185147.19716-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sung Lee <sung.lee@amd.com>

[ Upstream commit b95e51eb9f2ee7b6d6c3203a2f75122349aa77be ]

[WHY & HOW]
There is a problem in hscale_pixel_rate, the bug
causes DCN to be more optimistic (more likely to underflow)
in upscale cases during prefetch.
This commit ports the fix from DV code to address these issues.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index a38baa73d4841..b8ec08e3b7a36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1200,7 +1200,7 @@ static void dml_rq_dlg_get_dlg_params(
 	min_hratio_fact_l = 1.0;
 	min_hratio_fact_c = 1.0;
 
-	if (htaps_l <= 1)
+	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
 		if ((hratio_l * 2.0) > 4.0)
@@ -1216,7 +1216,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	hscale_pixel_rate_l = min_hratio_fact_l * dppclk_freq_in_mhz;
 
-	if (htaps_c <= 1)
+	if (hratio_c <= 1)
 		min_hratio_fact_c = 2.0;
 	else if (htaps_c <= 6) {
 		if ((hratio_c * 2.0) > 4.0)
@@ -1522,8 +1522,8 @@ static void dml_rq_dlg_get_dlg_params(
 
 	disp_dlg_regs->refcyc_per_vm_group_vblank   = get_refcyc_per_vm_group_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
 	disp_dlg_regs->refcyc_per_vm_group_flip     = get_refcyc_per_vm_group_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
-	disp_dlg_regs->refcyc_per_vm_req_vblank     = get_refcyc_per_vm_req_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
-	disp_dlg_regs->refcyc_per_vm_req_flip       = get_refcyc_per_vm_req_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
+	disp_dlg_regs->refcyc_per_vm_req_vblank     = get_refcyc_per_vm_req_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);
+	disp_dlg_regs->refcyc_per_vm_req_flip       = get_refcyc_per_vm_req_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);
 
 	// Clamp to max for now
 	if (disp_dlg_regs->refcyc_per_vm_group_vblank >= (unsigned int)dml_pow(2, 23))
-- 
2.20.1

