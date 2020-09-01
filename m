Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E03206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975407;
	bh=5oVvWcrZ767oERhJ8xsKzlCDXFR23KpVPFON8pBBBmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFd4krsCDVAabo5SJ+3k8E3I9AbRLlgPy7xOxLSb983Ja0JrYRfaeH2wtCce3TM01
	 /ofAhJ05o72CmNURJv9kH8Y/iz3o59cMjMzY7c5G0dfHhDdy5jRUb0ueIgthgdgUpi
	 MUcF1qeLWxjwfDQOs5r1I/e7U8hBcCyY4kDiPHgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgIAPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbgIAPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:46:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03143206FA;
        Tue,  1 Sep 2020 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975201;
        bh=5oVvWcrZ767oERhJ8xsKzlCDXFR23KpVPFON8pBBBmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfcTBV0mXfMFvfm18BrBErA3hyHG2PQhlgRvLTchaLSC/bcAVhDo7JLK4DN1TjRXe
         rXu5MoMZLveZW8kswVl+PacocWl55GFzWoFFDbcNJXTjm4O7f+i1j2cV1ldj/Vym0a
         g6WFAt6RP23MlpVjiG2J5xsyqxF24HXJ182Y6b+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.8 218/255] drm/amd/pm: correct Vega10 swctf limit setting
Date:   Tue,  1 Sep 2020 17:11:14 +0200
Message-Id: <20200901151011.147038614@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
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
@@ -363,6 +363,9 @@ int vega10_thermal_get_temperature(struc
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -372,8 +375,8 @@ static int vega10_thermal_set_temperatur
 
 	if (low < range->min)
 		low = range->min;
-	if (high > range->max)
-		high = range->max;
+	if (high > tdp_table->usSoftwareShutdownTemp)
+		high = tdp_table->usSoftwareShutdownTemp;
 
 	if (low > high)
 		return -EINVAL;


