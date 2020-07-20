Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D091C43458
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B402070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263731;
	bh=zbDMcBGs6S9UgwC8NFUnNX/eQby8Z3rJvzWpchGnAew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iMzuB56sHxc+mOX/B5ojUHjcD9FHcwArZU3qMh8uezSQzVK5miAZNpSC43ZhupSeY
	 diDojsUe2V5qbPc1/4fFIe+n3yOhfXVRmGdry0xchNogK8kmQaO6EcTTab98xcttlV
	 GDPxG7TgoBU5EWwDGDKU4pmw2oph0Q6/l9V9BOEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgGTQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgGTPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:37:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB77B22CE3;
        Mon, 20 Jul 2020 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259461;
        bh=zbDMcBGs6S9UgwC8NFUnNX/eQby8Z3rJvzWpchGnAew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEa47ygI57IQ4uu5gVXiR5Aolc4O7XbapCThhgOkcWTlf+egGLNypg53M6llqo9o9
         Oq+53D+UmCZvFL8Pwf0LW3dmFFZIbNB9nYHXGMoXavwiYyPZENoALcD4W4YonnyeRM
         m1FUifCfYS3OhlB4/tgr1uQOJE1jzOktOxnHctUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 16/58] drm/radeon: fix double free
Date:   Mon, 20 Jul 2020 17:36:32 +0200
Message-Id: <20200720152747.961226022@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 41855a898650803e24b284173354cc3e44d07725 upstream.

clang static analysis flags this error

drivers/gpu/drm/radeon/ci_dpm.c:5652:9: warning: Use of memory after it is freed [unix.Malloc]
                kfree(rdev->pm.dpm.ps[i].ps_priv);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/ci_dpm.c:5654:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(rdev->pm.dpm.ps);
        ^~~~~~~~~~~~~~~~~~~~~~

problem is reported in ci_dpm_fini, with these code blocks.

	for (i = 0; i < rdev->pm.dpm.num_ps; i++) {
		kfree(rdev->pm.dpm.ps[i].ps_priv);
	}
	kfree(rdev->pm.dpm.ps);

The first free happens in ci_parse_power_table where it cleans up locally
on a failure.  ci_dpm_fini also does a cleanup.

	ret = ci_parse_power_table(rdev);
	if (ret) {
		ci_dpm_fini(rdev);
		return ret;
	}

So remove the cleanup in ci_parse_power_table and
move the num_ps calculation to inside the loop so ci_dpm_fini
will know how many array elements to free.

Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/ci_dpm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5554,6 +5554,7 @@ static int ci_parse_power_table(struct r
 	if (!rdev->pm.dpm.ps)
 		return -ENOMEM;
 	power_state_offset = (u8 *)state_array->states;
+	rdev->pm.dpm.num_ps = 0;
 	for (i = 0; i < state_array->ucNumEntries; i++) {
 		u8 *idx;
 		power_state = (union pplib_power_state *)power_state_offset;
@@ -5563,10 +5564,8 @@ static int ci_parse_power_table(struct r
 		if (!rdev->pm.power_state[i].clock_info)
 			return -EINVAL;
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(rdev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5588,8 +5587,8 @@ static int ci_parse_power_table(struct r
 			k++;
 		}
 		power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
+		rdev->pm.dpm.num_ps = i + 1;
 	}
-	rdev->pm.dpm.num_ps = state_array->ucNumEntries;
 
 	/* fill in the vce power states */
 	for (i = 0; i < RADEON_MAX_VCE_LEVELS; i++) {


