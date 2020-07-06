Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B217C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0991206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hb6guDzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgGFM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:29:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728885AbgGFM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594038548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Mc/ldKPt/EXYFlwVXR6UGMdQ57wZ+ah4uNI5EbcP1/0=;
        b=hb6guDzdFk9Eb9YYWoTqRmy7Y+VAVoKMwaxUwOxtuG6HONSL44hncN1RpRfjLIXJAOa/YI
        xEEk+kbs8CllVOoQc0PLEQ7IKjWd1PEwX0e9+pIqW6HBDpQzkGYSB544i5VoswsLrq1h+c
        wL8oosYpPe0AB2qVrHm50emcRL9bbRo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-DSvALsx8N9Su7M6bsyTFAw-1; Mon, 06 Jul 2020 08:29:05 -0400
X-MC-Unique: DSvALsx8N9Su7M6bsyTFAw-1
Received: by mail-qv1-f70.google.com with SMTP id u10so1931038qvj.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 05:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mc/ldKPt/EXYFlwVXR6UGMdQ57wZ+ah4uNI5EbcP1/0=;
        b=Lv5ndPVkTv6TW07FXYfZ2dDSFTG/9CNRsCrvoo2x/u8vm7Gpao7Khp3sv1ODsJKCez
         eOt/dfGrisMOomMOZ96vJvxKlvn4qTMR8BMQCQiBQ2KgmMQhbO70x47DZgzZuC53lAEr
         oWec9oIcDlclWWqh9e63cTQWOIUs1g+5O2IMDhgPd1HhIbkUtLNxAq27xFe5v6lPqSBx
         PLQKTsBEx6NBKsTTek8RXNFis4ObXmqKxdHFKpDGqytmNfio3WxAaF5UyH381DdM31JI
         6PxAtMn+K8EyM1O86DN/GgZK6br7uVgIPRo7hoiYL5kcRJibdOCq8ei/F/XmuLJlH35w
         5OQA==
X-Gm-Message-State: AOAM533ekb0dFtg1WOZiSY1uIz12OpoK5QYKZe5340fLlVukUHTG8vjM
        mWnjC/UXMnDroqQDL3O5KQLPSYiyd95eDrJET1oKWraywRMt+WoUl2WbZgCAf7VjCsRu+I/0gTT
        VGk6YKsP2cw5Iyybdx79A4+2+
X-Received: by 2002:a05:6214:d4d:: with SMTP id 13mr13540401qvr.22.1594038544912;
        Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMy8mu7HXUm95aP+rznm4nycrjLabnqqCu0tSzaAU0UirnpXs5EwtEIjiB8f3YLEf4kXnE0A==
X-Received: by 2002:a05:6214:d4d:: with SMTP id 13mr13540380qvr.22.1594038544638;
        Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u6sm22032735qtc.34.2020.07.06.05.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: fix double free
Date:   Mon,  6 Jul 2020 05:28:57 -0700
Message-Id: <20200706122857.27661-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

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
---
 drivers/gpu/drm/radeon/ci_dpm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 86ac032275bb..ba20c6f03719 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5563,6 +5563,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	if (!rdev->pm.dpm.ps)
 		return -ENOMEM;
 	power_state_offset = (u8 *)state_array->states;
+	rdev->pm.dpm.num_ps = 0;
 	for (i = 0; i < state_array->ucNumEntries; i++) {
 		u8 *idx;
 		power_state = (union pplib_power_state *)power_state_offset;
@@ -5572,10 +5573,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
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
@@ -5597,8 +5596,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 			k++;
 		}
 		power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
+		rdev->pm.dpm.num_ps = i + 1;
 	}
-	rdev->pm.dpm.num_ps = state_array->ucNumEntries;
 
 	/* fill in the vce power states */
 	for (i = 0; i < RADEON_MAX_VCE_LEVELS; i++) {
-- 
2.18.1

