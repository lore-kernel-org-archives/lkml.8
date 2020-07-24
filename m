Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5485C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B011A2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4dp/3ks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIBDLbmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGXIeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgGXIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE1C0619E6;
        Fri, 24 Jul 2020 01:33:49 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rDkYuewnalCkcOX4zXGSU3gNvxiSzpfFhS2OcFgakCo=;
        b=P4dp/3ksof47oKfixiNGXHuYA9w2AyMfaTklwkq8JmjpQMyUjHoMoH8E6wdlAq9KLC/x6m
        bZt6xfrGaTHNaqZAb8/jdF5kqVpF5OOcFsksn5U8+CZ7p9NeuLaYtrc+Kw53czAXqFKTnF
        3I994bWIMxNx81nWVcxzy/O97z2EgstSE0Y5h5WGYSyB1qcBKijIeBsVPn5YmmBXoSaqyX
        jXR9wUaAHOM6yCqCloc2t4LG+htSfoceCoM4IQhOMlkOhL7nSH46MBhbxPfpgc+suvla1u
        Bc2l03kUF4GO8rFwDTYLbe94mjhExI5MKDNF6+OrCVmSLQgHrtCyKMzFiaKK2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rDkYuewnalCkcOX4zXGSU3gNvxiSzpfFhS2OcFgakCo=;
        b=yIBDLbmnHGvUq7+TptFiLfbx7j7/xf39nRu48fadXbJ7+2eszMyduyFj9NTjWeVMbMcNSa
        e6U1+cCcNVlBoVDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,drm/scheduler: Convert to sched_set_fifo*()
Cc:     alexander.deucher@amd.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962770.4006.10477943478653660290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     7b31e940b17bc47ca2f5e332c166231f01317469
Gitweb:        https://git.kernel.org/tip/7b31e940b17bc47ca2f5e332c166231f01317469
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:21 +02:00

sched,drm/scheduler: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

Cc: alexander.deucher@amd.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 2f31910..17cf77e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -760,11 +760,10 @@ static bool drm_sched_blocked(struct drm_gpu_scheduler *sched)
  */
 static int drm_sched_main(void *param)
 {
-	struct sched_param sparam = {.sched_priority = 1};
 	struct drm_gpu_scheduler *sched = (struct drm_gpu_scheduler *)param;
 	int r;
 
-	sched_setscheduler(current, SCHED_FIFO, &sparam);
+	sched_set_fifo_low(current);
 
 	while (!kthread_should_stop()) {
 		struct drm_sched_entity *entity = NULL;
