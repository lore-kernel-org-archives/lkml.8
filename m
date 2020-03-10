Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36660C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F255E24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845256;
	bh=N0oeHqaNHMwHKF0xJfnEyQKeRl69pwS6XSWHxDsDKos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBOiNnQ2CfqrevhQZ2Q8AhV2VSfhIjk9bmdeeuRlWrEpmAuH3Nk/cXUBZoNHTrzJt
	 wCod/zLygWnhC/0X/HwZGw0lFKaDwF0l9PJVBOitEsX9aYVbibPZ/dxQ4tu3VYsxw6
	 aXGSynXugvnO0wTzpUsxFx8RJt+QB/1Lgdr/6ox0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgCJNAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgCJNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ECD20674;
        Tue, 10 Mar 2020 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845248;
        bh=N0oeHqaNHMwHKF0xJfnEyQKeRl69pwS6XSWHxDsDKos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tazTQIDXxWrrRawA0OEKM6VwdaF9iRuT3bNr0b0UeDjTUy4XoWhEd2CyExuJ2mrxl
         FH3TGkHofAfaSQjbXEECq29/1KInhPYbQzp4OLcBGyrTmHJuZ9aM17bZWqDPpq6zn6
         DuUKBdrMAqOHTkabJWe0PMSP3b3AhqqsK3px4V9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 113/189] drm/amd/powerplay: fix pre-check condition for setting clock range
Date:   Tue, 10 Mar 2020 13:39:10 +0100
Message-Id: <20200310123651.170961721@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

commit 80381d40c9bf5218db06a7d7246c5478c95987ee upstream.

This fix will handle some MP1 FW issue like as mclk dpm table in renoir has a reverse
dpm clock layout and a zero frequency dpm level as following case.

cat pp_dpm_mclk
0: 1200Mhz
1: 1200Mhz
2: 800Mhz
3: 0Mhz

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |    2 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c  |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -222,7 +222,7 @@ int smu_set_soft_freq_range(struct smu_c
 {
 	int ret = 0;
 
-	if (min <= 0 && max <= 0)
+	if (min < 0 && max < 0)
 		return -EINVAL;
 
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -373,9 +373,6 @@ int smu_v12_0_set_soft_freq_limited_rang
 {
 	int ret = 0;
 
-	if (max < min)
-		return -EINVAL;
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:


