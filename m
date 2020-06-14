Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7301920714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCxS2eGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFNG1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:27:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61EC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:27:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so14503732iow.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pr9n4V8YJiXG+OQICtAk6o8sqO5Fm3+cCzZ+CtFDMKY=;
        b=aCxS2eGX+Ijgd2aSOJAZ0j+Xd/2Ni3mUe2bPVSeVpcqaLN05++JHFaQ+tcPnM5spHV
         OiPsQF11IErXnCbYOl86IYeo0Df7FeaPxui4jd3H/Ahu8PdzEKfEAiKuTBaeZLOw8qLj
         AN462QCPiiAwnF+Er0dVXpB6SpbF1+bO5TziaIRdM/7S63sdKzT2OfB8Dal+6fh/Sv+U
         ud+4NA4Qly4/EVM4VR9ilH9nDqzp/z36k/GzOdARN9H+oAtOSM/+XYbUjoG0oLLhm5AU
         P33hHC67x8C0P8yzI/W4sgFY8KX6GoHsxNcZ5Xq9/nYcuCNneW3S0l/TbH2ns7Zdaa62
         dd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pr9n4V8YJiXG+OQICtAk6o8sqO5Fm3+cCzZ+CtFDMKY=;
        b=mXO4H0l+n7/Ko/lYIGiHGn9FglobkG4VAHBStVoWW50dhdP0pbEFqUWHXkNf2l8B9w
         6TEYFo54tjhNlhLZfD/mAQ6WEc8TRR3ZdLb2+nBZkMMDE10pNcV85L/iJLmPCrGvmFBo
         4RAPUA8LleTTy9XvHG5pSL3lHg0mAvG2N0twGYneFbcIwRtyVYgQwMpEXO7vifESsg8V
         9Z9KjZ6MpiukQj3EwUfT0PKug4Th1OsBm8TqbgY1zZEOt/mjzoypUQihzZ2xmWJUpZhf
         I0zom7MU5jwTEqR+Q0FYcgdnkoZsYSSN9eDj1RoPh0OJhJsF3hXmYjbo/VgZUeSs9+oI
         ebrw==
X-Gm-Message-State: AOAM530QvUxseTejMXdtUT3rafMvKRYwbpddgcesdNBMymb59Y8kmrSu
        6A+PdzxxB82qucWQtW5SAAo=
X-Google-Smtp-Source: ABdhPJyF7zdFiHw1R+FvBcK1YMq5q5n/oke5Vs1Nd1IDb8neWJZtcKxPDxewjLW0gZuOITzL9Lupcg==
X-Received: by 2002:a05:6602:809:: with SMTP id z9mr21441256iow.79.1592116056556;
        Sat, 13 Jun 2020 23:27:36 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id b22sm5769329ios.21.2020.06.13.23.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:27:36 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/panfrost: fix ref count leak in panfrost_job_hw_submit
Date:   Sun, 14 Jun 2020 01:27:30 -0500
Message-Id: <20200614062730.46489-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in panfrost_job_hw_submit, pm_runtime_get_sync is called which
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7914b1570841..89ac84667eb1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -147,11 +147,10 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	ret = pm_runtime_get_sync(pfdev->dev);
 	if (ret < 0)
-		return;
+		goto out;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		pm_runtime_put_sync_autosuspend(pfdev->dev);
-		return;
+		goto out;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
@@ -184,6 +183,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 				job, js, jc_head);
 
 	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
+out:
+	pm_runtime_put_sync_autosuspend(pfdev->dev);
+	return;
 }
 
 static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
-- 
2.17.1

