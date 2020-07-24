Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A24C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0312074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qto/vS5/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AszCcNBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGXIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgGXIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B343C0619E5;
        Fri, 24 Jul 2020 01:33:50 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E4ITguZdEUDe5X0toddXQSOiaQBBRQEgw7Lzf6r5p+A=;
        b=qto/vS5/oBbJMlG2jDU0+BoY2fyDv8xTAwi6UwXcdkvG7suY89VWhAHyXDdxENgl613Jrq
        mv7ZBZxdxq8RUfNm01DefrAXWNxinAy4TNGjKAN3lHYNgxHNALiMN7vm5lZQyutsxBQDDO
        s4WN7iCVrPPaK24KWYdxURrJwqVQocF0tFM0PB1fLayFk+tBb9OGJFfJHzg2wZ4sr/vXUo
        pnrgEwHqLFeHFMgfdSnSYmOGMbTJlCldUhzzPbPzEUlXFEqk3jvhyceGblIRY6riltFSjS
        TD09isbPW+0gN5oSyrwubPhvDPYlyuceodXpB5E1Uzzkt4hh8jQ2N0ut5ThV9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E4ITguZdEUDe5X0toddXQSOiaQBBRQEgw7Lzf6r5p+A=;
        b=AszCcNBQeQ30FT2LRnaPYmH0DhjZfjo9GFLSKgAk5995ZnLxx3tkiCFxUCAzvUIyTihL1O
        y7Kyubx5iipHUGCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,msm: Convert to sched_set_fifo*()
Cc:     airlied@redhat.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962834.4006.14615439033632058585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     64419ca67622974f46bf053a7e745d2d0d1c43ef
Gitweb:        https://git.kernel.org/tip/64419ca67622974f46bf053a7e745d2d0d1c43ef
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:21 +02:00

sched,msm: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Use sched_set_fifo(); Effectively changes prio from 16 to 50.

Cc: airlied@redhat.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f6ce40b..89a8b9c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -389,7 +389,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	struct msm_kms *kms;
 	struct msm_mdss *mdss;
 	int ret, i;
-	struct sched_param param;
 
 	ddev = drm_dev_alloc(drv, dev);
 	if (IS_ERR(ddev)) {
@@ -495,12 +494,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
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
@@ -516,8 +509,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 			goto err_msm_uninit;
 		}
 
-		ret = sched_setscheduler(priv->event_thread[i].thread,
-					 SCHED_FIFO, &param);
+		ret = sched_set_fifo(priv->event_thread[i].thread);
 		if (ret)
 			dev_warn(dev, "event_thread set priority failed:%d\n",
 				 ret);
