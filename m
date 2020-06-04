Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05AC433F8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0822420738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lnZAfT6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgFDINq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgFDIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:12:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739CC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:12:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so4284158wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO6albsu9ail3aAxe1jjEWcSoPjULvK53jZ9O0zdFWo=;
        b=lnZAfT6Yff+IJyU+6wsUrqsOgP2Gj+BMlZtMrYghbDpPPGSv/zoqP2grdoO4AOw05E
         uLOJb/YvDpIETJrOA8RWtcCTW3/8iagYeIGfCzBgEwAJEkP3SyZ5oE2wCQuq2Ve1iyQR
         bh1mKlhPqlAZFzfugxhI6xRlys9QcfRU1N110=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO6albsu9ail3aAxe1jjEWcSoPjULvK53jZ9O0zdFWo=;
        b=kwpCw/PLp+drRtprqjwMJ5U4NdwreekqbYqwZwyL78aWY3B17mN3UwAZjBxhGL/7ks
         0qZ4+mACEkTXBx65u1F/bM4uzbzFIwjShHG/inBQ7DzEi3VyrD5Zkf31rWcXGRoRzm7z
         L3D6tKIpYqCDslJpcHLNtzm8rM6GHIVmPrYvY3ktPS93sUGoUSEhRaQ/2jVa5rnSmziM
         GS9lNAq0MUqQjxXxRPOfeDMFBhVGGEjPKeQ2fLSJ2fHjeopr8Zn7jTYpSkMsj68bxtuR
         ZY4UNXqxRNoPSdG4Q4HzNhUVQrBbUqHdWjMc33CoeDpowv4NYNBAArCiTfTU+U/BkJZV
         /Y/Q==
X-Gm-Message-State: AOAM532Q4C8SkyeXkd6Sqq1Jv3YAW7UIldtdMoAT2xA/UXjrEp2qco/9
        BSIh3kScU7cWopdlZd2UWBjHqg==
X-Google-Smtp-Source: ABdhPJyn8WC4htH2TFhAJzXT32NdRtoD972Y+p3loDxohFz/ONHD+IEVEXE5SDKPFz9SSfLivB0maw==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr3041559wmj.121.1591258364877;
        Thu, 04 Jun 2020 01:12:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:44 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 10/18] drm/amdgpu: use dma-fence annotations in cs_submit()
Date:   Thu,  4 Jun 2020 10:12:16 +0200
Message-Id: <20200604081224.863494-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit tricky, since ->notifier_lock is held while calling
dma_fence_wait we must ensure that also the read side (i.e.
dma_fence_begin_signalling) is on the same side. If we mix this up
lockdep complaints, and that's again why we want to have these
annotations.

A nice side effect of this is that because of the fs_reclaim priming
for dma_fence_enable lockdep now automatically checks for us that
nothing in here allocates memory, without even running any userptr
workloads.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a25fb59c127c..e109666aec14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1212,6 +1212,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_job *job;
 	uint64_t seq;
 	int r;
+	bool fence_cookie;
 
 	job = p->job;
 	p->job = NULL;
@@ -1226,6 +1227,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 */
 	mutex_lock(&p->adev->notifier_lock);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
 	 */
@@ -1262,12 +1265,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
-- 
2.26.2

