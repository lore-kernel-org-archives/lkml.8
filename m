Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F7DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C911A2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mOlrm/yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHTF0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHTF0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:26:05 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:26:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 130so590643pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lsbX1Xry7gppehECQgaCRYNE8or1PEFLIhmR1NXSOR0=;
        b=mOlrm/ypAWHV53bMT3Ty7Jh+auz977mwz7G2JytM7UUrOhtUX/Gx554bonVEsH8D+X
         n7EsfeRFgRsTd7fqJ6DGZi/OA2wlnW+LGGsLaN0fj/gFqnY4CqsjHgJZN0iyWBMDu/3a
         /xfrlcz6YiHxaw8TVMZZP/MvtrqfyIGOhLCn3vmSki/qgPs91Eu8Es6nLqhme6jpNHVw
         5uHNPVl9bAmg0ooISIwvdf3XtWpBlCW9V9DM/nAGGpxbjm1QAk6yFcTTjWax49GTa+60
         +hvFa0oTQm2qStaSIEAe+eq+HOvyDpzQ0vjxnwL3Ou49EV0FWnS4N8bE3PoIvOSOmi8o
         YgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lsbX1Xry7gppehECQgaCRYNE8or1PEFLIhmR1NXSOR0=;
        b=eBvEVRvUp4tIs4OR/XnhQe+W7ve+YzjbRamN00WI7WEJcxtksdE6A3ItehkToVaL+k
         pDlDka1uqndrOgAapjHl+lfwT8aW9krD5r/I/fWFlnGJ3O1clh39OOEWlymQnpkSEtut
         9tYrEYaj+U1VP6sHVxuqdrcFyKtYpGr7aZUwlmSXwaD0bZ8YFis0dCMqSbstwpTJzDnc
         i46b+1hPkXC6qAHXzjwyM2psMdVnjBZdA2dlG4Di8cKIHQOlUbU9K+PdB38RV1ESFqFx
         M4UhOI88NZ73ThacoMU4Hvfu6iCKzJe8Ri+u+x5EzTU9Pvc01jl+6GbzwvIxYBTnPJde
         ttzA==
X-Gm-Message-State: AOAM532SWtELzLOo6WbbFdfd62ZtZzhM3rZi0FkidYFtLUwZ8/uokabP
        V5T1wp4a6yFKHUcC1IzkE4yr6oYrmzfL
X-Google-Smtp-Source: ABdhPJyih8WdgObyYBpQNCGv4zrgvvHc7FA9Luht98sh6VTtC3hEyRDd6ObmxGoUW4L6Dtpjj42SS2nGdSg1
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a62:aa05:: with SMTP id
 e5mr1051919pff.70.1597901163900; Wed, 19 Aug 2020 22:26:03 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:26:00 -0700
Message-Id: <20200820052600.3069895-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object
 to 0 in amdgpu_dm_update_backlight_caps
From:   Furquan Shaikh <furquan@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Roman Li <roman.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, adurbin@google.com,
        deepak.sharma@amd.com, Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4b33c67b634..725d8af634ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2853,7 +2853,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 {
 #if defined(CONFIG_ACPI)
-	struct amdgpu_dm_backlight_caps caps;
+	struct amdgpu_dm_backlight_caps caps = { 0 };
 
 	if (dm->backlight_caps.caps_valid)
 		return;
-- 
2.28.0.297.g1956fa8f8d-goog

