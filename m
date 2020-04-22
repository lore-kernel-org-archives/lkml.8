Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CD120784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fi+k6oPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDVL33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20539C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=x9wcWthAwvbpiZr3N9oM4hH8GIN/owxFHmutNlXGYmo=; b=Fi+k6oPWSFOluIMsriCQGrriLb
        YA/vzakomtEkxtD7gh/d9X43PiQh2TCQIGe91A4DMWdj6lf80U2cHuR1s0IIRQNm6nHr5zJh+Pa6z
        GSOzmTLDh0xqPa0MU4RMIQVFBHm6dlsTvqIwsgztMJcLyjn7AuYDlvCiCrLOApGe9rFjpBX+Eocf1
        spHOYNFdJ8hbGReU7+qXMGl5DjXUZ0e/x8uAL/4sAknL00XMA1+tBkzgtIjXs7uQUEQ/YE26yijB5
        Y3IldiI2CLC3JLSPmSro4WmjbVVs5YUZkNFPTFcnF6O6MhVIKZt84kHlnVMEVluIexrP6VRERWVr2
        1xc6gqzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYv-0003aX-4r; Wed, 22 Apr 2020 11:29:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3405E307943;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD89F200C3E42; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.633583714@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, airlied@redhat.com
Subject: [PATCH 07/23] sched,msm: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Use sched_set_fifo(); Effectively changes prio from 16 to 50.

Cc: airlied@redhat.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -388,7 +388,6 @@ static int msm_drm_init(struct device *d
 	struct msm_kms *kms;
 	struct msm_mdss *mdss;
 	int ret, i;
-	struct sched_param param;
 
 	ddev = drm_dev_alloc(drv, dev);
 	if (IS_ERR(ddev)) {
@@ -494,12 +493,6 @@ static int msm_drm_init(struct device *d
 	ddev->mode_config.funcs = &mode_config_funcs;
 	ddev->mode_config.helper_private = &mode_config_helper_funcs;
 
-	/**
-	 * this priority was found during empiric testing to have appropriate
-	 * realtime scheduling to process display updates and interact with
-	 * other real time and normal priority task
-	 */
-	param.sched_priority = 16;
 	for (i = 0; i < priv->num_crtcs; i++) {
 		/* initialize event thread */
 		priv->event_thread[i].crtc_id = priv->crtcs[i]->base.id;
@@ -515,8 +508,7 @@ static int msm_drm_init(struct device *d
 			goto err_msm_uninit;
 		}
 
-		ret = sched_setscheduler(priv->event_thread[i].thread,
-					 SCHED_FIFO, &param);
+		ret = sched_set_fifo(priv->event_thread[i].thread);
 		if (ret)
 			dev_warn(dev, "event_thread set priority failed:%d\n",
 				 ret);


