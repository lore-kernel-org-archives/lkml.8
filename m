Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA4C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4BA21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056321;
	bh=y9U6rC3LTMKq0Qm3wMCVS0WNBwTbzqPIBo8FLLQkrks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsQQXZAB2IMWfUhN1SRqdhARcVBnmSdrh9xUvizM1ifs33HD2OvVAdI9gspBMJaqQ
	 ++6fy8Ez7qgDnMXx0n6JZ61zx4qmtKMXGTST5Jg1yrNfhmYgbj8YYrYNd4uSvsyM1B
	 X1qdg7zCEryhfEWFuuDFSi91OnNj9t5ozmrJZlDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBRUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgBRUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:02:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1491024670;
        Tue, 18 Feb 2020 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056123;
        bh=y9U6rC3LTMKq0Qm3wMCVS0WNBwTbzqPIBo8FLLQkrks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXa2f1ylWTFf56PDBibdK3vDMpcCxCxwKO1RaClCJfLKdOBkCtRD7MM7nizgXUnW4
         VO0R7xj08BtqQdRkucKnU5/5rt5K/SGfELWPXzAyOFeouqivzIxchua60N0nvbwt0n
         elgZyxz89hwGc0zMXz95BNU0ztjBO2cZyhEo7f+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 44/80] drm/amdgpu:/navi10: use the ODCAP enum to index the caps array
Date:   Tue, 18 Feb 2020 20:55:05 +0100
Message-Id: <20200218190436.563820202@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit e33a8cfda5198fc09554fdd77ba246de42c886bd upstream.

Rather than the FEATURE_ID flags.  Avoids a possible reading past
the end of the array.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Reported-by: Aleksandr Mezin <mezin.alexander@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.5.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -705,9 +705,9 @@ static bool navi10_is_support_fine_grain
 	return dpm_desc->SnapToDiscrete == 0 ? true : false;
 }
 
-static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_ID feature)
+static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
 {
-	return od_table->cap[feature];
+	return od_table->cap[cap];
 }
 
 static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_table,
@@ -815,7 +815,7 @@ static int navi10_print_clk_levels(struc
 	case SMU_OD_SCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_LIMITS))
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
 			break;
 		size += sprintf(buf + size, "OD_SCLK:\n");
 		size += sprintf(buf + size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
@@ -823,7 +823,7 @@ static int navi10_print_clk_levels(struc
 	case SMU_OD_MCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX))
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
 			break;
 		size += sprintf(buf + size, "OD_MCLK:\n");
 		size += sprintf(buf + size, "1: %uMHz\n", od_table->UclkFmax);
@@ -831,7 +831,7 @@ static int navi10_print_clk_levels(struc
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_CURVE))
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
 			break;
 		size += sprintf(buf + size, "OD_VDDC_CURVE:\n");
 		for (i = 0; i < 3; i++) {
@@ -856,7 +856,7 @@ static int navi10_print_clk_levels(struc
 			break;
 		size = sprintf(buf, "%s:\n", "OD_RANGE");
 
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_LIMITS)) {
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
 						    &min_value, NULL);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
@@ -865,14 +865,14 @@ static int navi10_print_clk_levels(struc
 					min_value, max_value);
 		}
 
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX)) {
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
 						    &min_value, &max_value);
 			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_CURVE)) {
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
 						    &min_value, &max_value);
 			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
@@ -1956,7 +1956,7 @@ static int navi10_od_edit_dpm_table(stru
 
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_LIMITS)) {
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			pr_warn("GFXCLK_LIMITS not supported!\n");
 			return -ENOTSUPP;
 		}
@@ -2002,7 +2002,7 @@ static int navi10_od_edit_dpm_table(stru
 		}
 		break;
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX)) {
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
 			pr_warn("UCLK_MAX not supported!\n");
 			return -ENOTSUPP;
 		}
@@ -2043,7 +2043,7 @@ static int navi10_od_edit_dpm_table(stru
 		}
 		break;
 	case PP_OD_EDIT_VDDC_CURVE:
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_CURVE)) {
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
 			pr_warn("GFXCLK_CURVE not supported!\n");
 			return -ENOTSUPP;
 		}


