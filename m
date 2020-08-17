Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C73C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12242072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690928;
	bh=F5BqKmNXCxfnTxyVjEeUfxaFpUE6H7uybZG57KnE4KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yXaQibHXeqABjY+la2kAnOl81ZEerZgry9p7/317cYYWiMF5jRX4/sm/YQE89zmN5
	 e5jaC1ZiTOjPANHOuBP3gwtUSIKTRkr4wx7XHOGrpwz0OhCWMAJGW7QsQFLJKSuXEO
	 +vgD6ypL6SraMTyXzgcV5t/zp7cFO+DGsu0hRMIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgHQTCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgHQPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:47:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317462067C;
        Mon, 17 Aug 2020 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679242;
        bh=F5BqKmNXCxfnTxyVjEeUfxaFpUE6H7uybZG57KnE4KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bz5Jcokga0fzmWMgtMD5ELhW5orL8oq9R+liVBN07x9vUsPX7WDiJg4Y6DatzdCLx
         T87bg0BE7C2xmdTgCNlI5PHnJWusfsDrzoZ53jkc9rsigG6qFUEA2bEDoQGGJot1h6
         3mfmlHvUs2X3bPNQNinXTgdYUdvKQ9vRnSnbrg60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 144/393] drm/panfrost: Fix inbalance of devfreq record_busy/idle()
Date:   Mon, 17 Aug 2020 17:13:14 +0200
Message-Id: <20200817143826.597783922@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>

[ Upstream commit b99773ef258e628bd53cab22d450a755b73b4d55 ]

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
Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200522153653.40754-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7914b15708412..f9519afca29d9 100644
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
2.25.1



