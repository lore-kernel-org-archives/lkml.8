Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445E6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1B32054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942613;
	bh=Cqr8eghnHCwYfy32Xoq0YNy2OmKR9+KhkhznVTmFUrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wws57O/liJLGFBatxnDAxFqkrO6RIB6vd32hepUY7ir7f4P8NNyQPXLu7bTR20Gq2
	 HpoL6/ljGyb7vP1iG+BDno/Davft7xsK9SKwBzMKcfX+rQR98AY1UooNWyYObhJ352
	 wC0v4U6za7774nnTlKCxYQo2gJEEOCbFe0nSioq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgEHM4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgEHM4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:56:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB80218AC;
        Fri,  8 May 2020 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942582;
        bh=Cqr8eghnHCwYfy32Xoq0YNy2OmKR9+KhkhznVTmFUrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+wzxpbbibs5fHLgYck6ap1v0BmzbbLDzO3Z5vYw7eaJWQdu1z51MBITihZmNG3bb
         HwB6Xx3ijzJ2HqwJieat0uXie9wZuPhorJJkyU0ifBQKriQfOI9N2Emo3kr8KySJsl
         YuYRL00+PMt5FQfpZOETBjuL2t7k3y6g+cP8868k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandeep Raghuraman <sandy.8925@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 24/49] drm/amdgpu: Correctly initialize thermal controller for GPUs with Powerplay table v0 (e.g Hawaii)
Date:   Fri,  8 May 2020 14:35:41 +0200
Message-Id: <20200508123046.472976640@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Raghuraman <sandy.8925@gmail.com>

[ Upstream commit bbc25dadc7ed19f9d6b2e30980f0eb4c741bb8bf ]

Initialize thermal controller fields in the PowerPlay table for Hawaii
GPUs, so that fan speeds are reported.

Signed-off-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/hwmgr/processpptables.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
index 77c14671866c0..719597c5d27d9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
@@ -984,6 +984,32 @@ static int init_thermal_controller(
 			struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
+	hwmgr->thermal_controller.ucType =
+			powerplay_table->sThermalController.ucType;
+	hwmgr->thermal_controller.ucI2cLine =
+			powerplay_table->sThermalController.ucI2cLine;
+	hwmgr->thermal_controller.ucI2cAddress =
+			powerplay_table->sThermalController.ucI2cAddress;
+
+	hwmgr->thermal_controller.fanInfo.bNoFan =
+		(0 != (powerplay_table->sThermalController.ucFanParameters &
+			ATOM_PP_FANPARAMETERS_NOFAN));
+
+	hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution =
+		powerplay_table->sThermalController.ucFanParameters &
+		ATOM_PP_FANPARAMETERS_TACHOMETER_PULSES_PER_REVOLUTION_MASK;
+
+	hwmgr->thermal_controller.fanInfo.ulMinRPM
+		= powerplay_table->sThermalController.ucFanMinRPM * 100UL;
+	hwmgr->thermal_controller.fanInfo.ulMaxRPM
+		= powerplay_table->sThermalController.ucFanMaxRPM * 100UL;
+
+	set_hw_cap(hwmgr,
+		   ATOM_PP_THERMALCONTROLLER_NONE != hwmgr->thermal_controller.ucType,
+		   PHM_PlatformCaps_ThermalController);
+
+	hwmgr->thermal_controller.use_hw_fan_control = 1;
+
 	return 0;
 }
 
-- 
2.20.1



