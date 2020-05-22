Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B157C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E654220823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgEVPhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:37:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgEVPhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE4F55D;
        Fri, 22 May 2020 08:37:06 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0046D3F305;
        Fri, 22 May 2020 08:37:04 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Fix inbalance of devfreq record_busy/idle()
Date:   Fri, 22 May 2020 16:36:53 +0100
Message-Id: <20200522153653.40754-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calls to panfrost_devfreq_record_busy() and
panfrost_devfreq_record_idle() must be balanced to ensure that the
devfreq utilisation is correctly reported. But there are two cases where
this doesn't work correctly.

In panfrost_job_hw_submit() if pm_runtime_get_sync() fails or the
WARN_ON() fires then no call to panfrost_devfreq_record_busy() is made,
but when the job times out the corresponding _record_idle() call is
still made in panfrost_job_timedout(). Move the call up to ensure that
it always happens.

Secondly panfrost_job_timedout() only makes a single call to
panfrost_devfreq_record_idle() even if it is cleaning up multiple jobs.
Move the call inside the loop to ensure that the number of
_record_idle() calls matches the number of _record_busy() calls.

Fixes: 9e62b885f715 ("drm/panfrost: Simplify devfreq utilisation tracking")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index b2f09c038d35..ac87ef675e8a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -145,6 +145,8 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	u64 jc_head = job->jc;
 	int ret;
 
+	panfrost_devfreq_record_busy(pfdev);
+
 	ret = pm_runtime_get_sync(pfdev->dev);
 	if (ret < 0)
 		return;
@@ -155,7 +157,6 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
-	panfrost_devfreq_record_busy(pfdev);
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
@@ -410,12 +411,12 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		if (pfdev->jobs[i]) {
 			pm_runtime_put_noidle(pfdev->dev);
+			panfrost_devfreq_record_idle(pfdev);
 			pfdev->jobs[i] = NULL;
 		}
 	}
 	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
 
-	panfrost_devfreq_record_idle(pfdev);
 	panfrost_device_reset(pfdev);
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
-- 
2.20.1

