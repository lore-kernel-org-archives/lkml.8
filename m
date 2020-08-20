Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673FA22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916789;
	bh=mdP55MQ5hZd+LjwfofX9mTruh9HHZctyninsRPIAus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGlSNOdZAA1NwPIjssmvc5hkQHotdkKYFcoqBLSJw4WKpcSxMDOqS8eovgMdf7WOh
	 xxe3oMR54Vl0P7MCddmrKfC3q7V4x5fHCxFZIFRNwte67GXDQnHxLYkKfyqUJ7Pl5l
	 oqq3X1cxggQlQwL/4We6LbwOJkSlzR9VuIQMvIpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgHTJq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgHTJoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:44:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E25622CF7;
        Thu, 20 Aug 2020 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916645;
        bh=mdP55MQ5hZd+LjwfofX9mTruh9HHZctyninsRPIAus0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vV68AjZEvkX64i9slCa6rI6RgITA+yr922xNVWP03OG3IMgXbxKrU8C+F9Ny/caex
         eukIhlK41R0K6pvC1BgxC/LDfC2AXpDXGLkiY4TW5bBmDZYcwa9riAiNxKkICCbnI6
         83jO32aFuyRD2pu/x/BS1AhXxIkFibXFOOkhowbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandeep Raghuraman <sandy.8925@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 202/204] drm/amdgpu: Fix bug where DPM is not enabled after hibernate and resume
Date:   Thu, 20 Aug 2020 11:21:39 +0200
Message-Id: <20200820091616.272171291@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Raghuraman <sandy.8925@gmail.com>

commit f87812284172a9809820d10143b573d833cd3f75 upstream.

Reproducing bug report here:
After hibernating and resuming, DPM is not enabled. This remains the case
even if you test hibernate using the steps here:
https://www.kernel.org/doc/html/latest/power/basic-pm-debugging.html

I debugged the problem, and figured out that in the file hardwaremanager.c,
in the function, phm_enable_dynamic_state_management(), the check
'if (!hwmgr->pp_one_vf && smum_is_dpm_running(hwmgr) && !amdgpu_passthrough(adev) && adev->in_suspend)'
returns true for the hibernate case, and false for the suspend case.

This means that for the hibernate case, the AMDGPU driver doesn't enable DPM
(even though it should) and simply returns from that function.
In the suspend case, it goes ahead and enables DPM, even though it doesn't need to.

I debugged further, and found out that in the case of suspend, for the
CIK/Hawaii GPUs, smum_is_dpm_running(hwmgr) returns false, while in the case of
hibernate, smum_is_dpm_running(hwmgr) returns true.

For CIK, the ci_is_dpm_running() function calls the ci_is_smc_ram_running() function,
which is ultimately used to determine if DPM is currently enabled or not,
and this seems to provide the wrong answer.

I've changed the ci_is_dpm_running() function to instead use the same method that
some other AMD GPU chips do (e.g Fiji), which seems to read the voltage controller.
I've tested on my R9 390 and it seems to work correctly for both suspend and
hibernate use cases, and has been stable so far.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208839
Signed-off-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2725,7 +2725,10 @@ static int ci_initialize_mc_reg_table(st
 
 static bool ci_is_dpm_running(struct pp_hwmgr *hwmgr)
 {
-	return ci_is_smc_ram_running(hwmgr);
+	return (1 == PHM_READ_INDIRECT_FIELD(hwmgr->device,
+					     CGS_IND_REG__SMC, FEATURE_STATUS,
+					     VOLTAGE_CONTROLLER_ON))
+		? true : false;
 }
 
 static int ci_smu_init(struct pp_hwmgr *hwmgr)


