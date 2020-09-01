Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F8C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A4E2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976983;
	bh=hzbE5Q8JyF3Til59Di3MlB4Ya08M9rfNAcyBI6sA62E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guG8mDvBB+/XXB23W47tBeRsuVbP+F8NHVPuYAuJShbpr1Flm9ZzVI4wPTy/eE9JN
	 debqOWgIB3Zc9H6//lZOLlNk8wnRPAxIrHZEJ8y7ejjBoK38GW0or9yG4/1HIFoPMI
	 KuujyuPTM/YROGmJqr5/J3mGjqx9J9SWRIXSDhO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgIAQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgIAPeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D462158C;
        Tue,  1 Sep 2020 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974463;
        bh=hzbE5Q8JyF3Til59Di3MlB4Ya08M9rfNAcyBI6sA62E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ag2+NzW7ScGZcqbd3nG54F590TZ+r46dBjMog2OXaguRQCavBH6Ja1y1BLfQiikNB
         /t5+eF9n7wFUlLF+Wd55l1VqVVnmY7SixzhMeorxS7lN4MBhcLb6drXXauHqe6kYuC
         4U4+nw/f2ITC9+2Sxn9fC3Q4vXVGb581FTcdRiTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 185/214] drm/amd/pm: correct Vega10 swctf limit setting
Date:   Tue,  1 Sep 2020 17:11:05 +0200
Message-Id: <20200901151001.817656231@linuxfoundation.org>
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

commit b05d71b51078fc428c6b72582126d9d75d3c1f4c upstream.

Correct the Vega10 thermal swctf limit.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1267

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -364,6 +364,9 @@ int vega10_thermal_get_temperature(struc
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -373,8 +376,8 @@ static int vega10_thermal_set_temperatur
 
 	if (low < range->min)
 		low = range->min;
-	if (high > range->max)
-		high = range->max;
+	if (high > tdp_table->usSoftwareShutdownTemp)
+		high = tdp_table->usSoftwareShutdownTemp;
 
 	if (low > high)
 		return -EINVAL;


