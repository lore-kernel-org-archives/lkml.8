Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFCC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778FF20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976871;
	bh=SS7EWfrjRY1j1A8bE8ajrvkLzZJETMG8Wde8kQlIAQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=phJ+ByrVAgk3qXe2QFSqfOdmHiRtqtHTGNcouK1wCAS0BHGe3mtY7hY0NcVoq8HuA
	 CDowG3pUa3+1RxL/Nt5LfIrkjWRx9GBwfi+9mC70ZSObaqgCzbnU8Ab0WT9BKRnmoO
	 XhBHXC8lc+flD3RLZalwY8RTDMIIHos0m/KHmsPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgIAPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgIAPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89C221534;
        Tue,  1 Sep 2020 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974460;
        bh=SS7EWfrjRY1j1A8bE8ajrvkLzZJETMG8Wde8kQlIAQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVyd+1XTQefQubl4CmvnV/3sbMJDTYTKOxQrup9WilMr53qvZaNmQ9SaMVhPczjts
         PuRAUUArXaiCxuwy2hcX83/TjeId5+J096o6wsjYyOT80m8dvdnuHnTJV3GjZSRyTQ
         oPLIHP6aJ5DHPAfVZr55mhnqNXF1VhD7VT56u3nQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH 5.4 184/214] drm/amd/powerplay: Fix hardmins not being sent to SMU for RV
Date:   Tue,  1 Sep 2020 17:11:04 +0200
Message-Id: <20200901151001.771009399@linuxfoundation.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit e2bf3723db563457c0abe4eaeedac25bbbbd1d76 upstream.

[Why]
DC uses these to raise the voltage as needed for higher dispclk/dppclk
and to ensure that we have enough bandwidth to drive the displays.

There's a bug preventing these from actuially sending messages since
it's checking the actual clock (which is 0) instead of the incoming
clock (which shouldn't be 0) when deciding to send the hardmin.

[How]
Check the clocks != 0 instead of the actual clocks.

Fixes: 9ed9203c3ee7 ("drm/amd/powerplay: rv dal-pplib interface refactor powerplay part")
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -209,8 +209,7 @@ static int smu10_set_min_deep_sleep_dcef
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->need_min_deep_sleep_dcefclk &&
-		smu10_data->deep_sleep_dcefclk != clock) {
+	if (clock && smu10_data->deep_sleep_dcefclk != clock) {
 		smu10_data->deep_sleep_dcefclk = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetMinDeepSleepDcefclk,
@@ -223,8 +222,7 @@ static int smu10_set_hard_min_dcefclk_by
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->dcf_actual_hard_min_freq &&
-		smu10_data->dcf_actual_hard_min_freq != clock) {
+	if (clock && smu10_data->dcf_actual_hard_min_freq != clock) {
 		smu10_data->dcf_actual_hard_min_freq = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetHardMinDcefclkByFreq,
@@ -237,8 +235,7 @@ static int smu10_set_hard_min_fclk_by_fr
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->f_actual_hard_min_freq &&
-		smu10_data->f_actual_hard_min_freq != clock) {
+	if (clock && smu10_data->f_actual_hard_min_freq != clock) {
 		smu10_data->f_actual_hard_min_freq = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetHardMinFclkByFreq,


