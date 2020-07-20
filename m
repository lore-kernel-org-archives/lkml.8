Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A524E206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z37c3HRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGTN4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:56:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgGTN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595253399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=7tMCyaXprYGfI8LnX0MbcX5R8eRYMM3w9rSz3694Vjs=;
        b=Z37c3HRENcZX6otal4B0K9k0TeFsKe0+J6memKTJOiqduwBkY/vCEm5yNmaDsnfS5K0gsO
        q6HQOlF9RW4TDit/ooVA9w57eBK2bRcV/dBYdNiM706ujBPjAbZehGKHSWhyNoR9NiXpc+
        d3fZCF63dfSEl/uOOGNHElJrXdb6toc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-zBukdWr1MWmcHSWRXBrgnQ-1; Mon, 20 Jul 2020 09:56:37 -0400
X-MC-Unique: zBukdWr1MWmcHSWRXBrgnQ-1
Received: by mail-qv1-f70.google.com with SMTP id s2so10178214qvn.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tMCyaXprYGfI8LnX0MbcX5R8eRYMM3w9rSz3694Vjs=;
        b=JaU99wIpDK+0NBlFouK8dojbF75SPgNYIXkDyNW6WqzMvhd/qMJPuAz6caLWmsd+Ce
         FFNnbafZ4lStWlHYiak1U+PuWTHAs4r5MeIkMkq1stwUqnZlp24kmWL78GKRFj3xdTc7
         rMSKcgYpbyZI7786j6rbN79JQOZA3Ph2sSxm1QQFqHQ8BzDlSZ0zTnHBSdnLdHa6UzFo
         /iqpVTf991eX+8iLhLK340P56KEjbVGrWA3z5cwA7XGGNm2A+/zJFXASUpkzeznztWa2
         B9yLdflU1QfC2sSQtcRoIJZcCtcj278J0B/u4mDAsmPcSibkJK7EtLsQZZHLwwr9/OjK
         uKxQ==
X-Gm-Message-State: AOAM5312aQusj6K8KH4s1Hy0iNfazcMwm18cjL/KOFUpV3wECogMfkZK
        KVSv6pwpCP30wQt5QOqm56tEaE1I6Qmn8bUvipNDv8YKL3FJp+hEVICrpeqCdVtNNbUl3PvfUV+
        Y5cEuYzH5DiUY/CnUtTYnUpN7
X-Received: by 2002:a37:7d86:: with SMTP id y128mr19798347qkc.343.1595253397392;
        Mon, 20 Jul 2020 06:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTMQGtS9l84oZcTdxSM7bf/4qQeuw9Loq8FVtpq/6KNdrsJ6rg9R8UUqWj/PRUzlKliYjXiQ==
X-Received: by 2002:a37:7d86:: with SMTP id y128mr19798327qkc.343.1595253397127;
        Mon, 20 Jul 2020 06:56:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s128sm18471192qkd.108.2020.07.20.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:56:36 -0700 (PDT)
From:   trix@redhat.com
To:     eric@anholt.net, airlied@linux.ie, daniel@ffwll.ch,
        itoral@igalia.com, navid.emamdoost@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/v3d: remove second free in v3d_submit_cl_ioctl
Date:   Mon, 20 Jul 2020 06:56:31 -0700
Message-Id: <20200720135631.2854-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this error

v3d_gem.c:573:4: warning: Attempt to free released
  memory [unix.Malloc]
    kfree(bin);
    ^~~~~~~~~~

Problem is in the block of code

	if (ret) {
		kfree(bin);
		v3d_job_put(&render->base);
		kfree(bin);
		return ret;
	}

Obviously bin is freed twice.
So remove one.

Fixes: 0d352a3a8a1f ("drm/v3d: don't leak bin job if v3d_job_init fails.")
Fixes: 29cd13cfd762 ("drm/v3d: Fix memory leak in v3d_submit_cl_ioctl")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 915f8bfdb58c..3cfbdb8e6a91 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -570,7 +570,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		if (ret) {
 			kfree(bin);
 			v3d_job_put(&render->base);
-			kfree(bin);
 			return ret;
 		}
 
-- 
2.18.1

