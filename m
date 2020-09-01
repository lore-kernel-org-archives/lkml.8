Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F4BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FE020E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974531;
	bh=DZveWCP/S5NghbgnM0iimMiVKVfDLqRuyg/VHFJHzzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhRVi+wOljD3phSn1PEcGZKj/3OLnsyY2NRLmX4xGGrtOqFeDEsGBSN+w/JSniRXG
	 OTB6rkNwgQWHJ2jH2cNVe/c3B8wsr+6NNfC8L3HxnGMsoblH7P/jOEPZyNC3olT/10
	 WMTeieRigefvWE64ao6oIoopZEzVAaLloCKf2YEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgIAPf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgIAPeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B69020866;
        Tue,  1 Sep 2020 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974465;
        bh=DZveWCP/S5NghbgnM0iimMiVKVfDLqRuyg/VHFJHzzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgD5XtydrSKbaUUT1I7fbZ9thrfYb8+Nhz+UWL2bfOdJlejnHyyNgxvSWghG0xg3n
         dHHCSFDC+Ju3vpTvdxLGz+cSi/kEJjf6BGgVfvpCnjngRuQNsr1Yix8riGrIjQf0UN
         3/1kIwrGDSvVXr2YAAzfXeRCAcFdF9qPigdc4zmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 186/214] drm/amd/pm: correct Vega12 swctf limit setting
Date:   Tue,  1 Sep 2020 17:11:06 +0200
Message-Id: <20200901151001.857183465@linuxfoundation.org>
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

commit e0ffd340249699ad27a6c91abdfa3e89f7823941 upstream.

Correct the Vega12 thermal swctf limit.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
@@ -170,6 +170,8 @@ int vega12_thermal_get_temperature(struc
 static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -179,8 +181,8 @@ static int vega12_thermal_set_temperatur
 
 	if (low < range->min)
 		low = range->min;
-	if (high > range->max)
-		high = range->max;
+	if (high > pptable_information->us_software_shutdown_temp)
+		high = pptable_information->us_software_shutdown_temp;
 
 	if (low > high)
 		return -EINVAL;


