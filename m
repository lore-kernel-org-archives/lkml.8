Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3A12065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976965;
	bh=aGgHT+5YW0rya1YT6guN5gDHONKVDiEyMzGTbVdyBKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CacC1/Oy83W/M6Ht571s2s2jRpR/U/Z4YKS9kzjOENiqOqJ/y6zqj6kATy7VrC66g
	 FZeNPbFnvkkv+BJbSfb0QnLhiMeQeNP9qSCsmBoeiw2Mx3+D85NEQK6QlMHcTv85JO
	 CDOWZyNDFut67dJ3tX7X40dQdI5IsaSt7hjky+K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgIAQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbgIAPeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E637215A4;
        Tue,  1 Sep 2020 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974472;
        bh=aGgHT+5YW0rya1YT6guN5gDHONKVDiEyMzGTbVdyBKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3pzhAE2H6TFEfroBrCnzr02dTHZSXtYgoP8FYz6+q+1tUYcpRhSSKe47VFZRToW1
         ieS6+muYyQZ75wqhtcT2IYOFur22JTp5ndCKvBr08bsd24JrArhxpQTW3I1MK33ogM
         5p4x6G6IAGz2rgBanlZ1YOL+AtYBp7uz6NEa89a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 188/214] drm/amd/pm: correct the thermal alert temperature limit settings
Date:   Tue,  1 Sep 2020 17:11:08 +0200
Message-Id: <20200901151001.955321614@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit 28e628645333b7e581c4a7b04d958e4804ea10fe upstream.

Do the maths in celsius degree. This can fix the issues caused
by the changes below:

drm/amd/pm: correct Vega20 swctf limit setting
drm/amd/pm: correct Vega12 swctf limit setting
drm/amd/pm: correct Vega10 swctf limit setting

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c |   15 +++++++--------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c |   15 +++++++--------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c |   15 +++++++--------
 3 files changed, 21 insertions(+), 24 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -368,14 +368,13 @@ static int vega10_thermal_set_temperatur
 		(struct phm_ppt_v2_information *)(hwmgr->pptable);
 	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > tdp_table->usSoftwareShutdownTemp)
 		high = tdp_table->usSoftwareShutdownTemp;
 
@@ -386,8 +385,8 @@ static int vega10_thermal_set_temperatur
 
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val &= (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK) &
 			(~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK) &
 			(~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK);
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
@@ -173,14 +173,13 @@ static int vega12_thermal_set_temperatur
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA12_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA12_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > pptable_information->us_software_shutdown_temp)
 		high = pptable_information->us_software_shutdown_temp;
 
@@ -191,8 +190,8 @@ static int vega12_thermal_set_temperatur
 
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
@@ -243,14 +243,13 @@ static int vega20_thermal_set_temperatur
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA20_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA20_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA20_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA20_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > pptable_information->us_software_shutdown_temp)
 		high = pptable_information->us_software_shutdown_temp;
 
@@ -261,8 +260,8 @@ static int vega20_thermal_set_temperatur
 
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);


