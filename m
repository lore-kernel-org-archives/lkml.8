Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C4C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3202074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GADU9VxD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtlPilg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGXIdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgGXIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C61C0619D3;
        Fri, 24 Jul 2020 01:33:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PigvJTJ1IXMtfAX4SR4/VMXZsEI5VpZH2UY2zxTsh50=;
        b=GADU9VxDtUnguvca6eRPy43cXL8i8AvbcyBlPRYcZ0vJsDPZg0hnIz10LsjF6ywVrIRgBj
        nWLS5Ty6CIsc1mY513JmOVAxi578oWvC11tg4Qixg7u/FwkI6+V36Hf9uwUjguXcDC5Ail
        Ck42H73Se6MAWj6ZlOqA0nJNbXj3fY+852MKpKZ6QuyZjhcQg6F4zTMIlCkv0hjDoEPWzM
        VoIOGJOPk2sy/h2oZ/hVWlfMt2zijmm7K2xG8axWsyJCbzSl6mIv4wahJxK6FRkLhkKIo3
        Vvw06w+lhELTR3g/5/f/aERRpW1jxGVn48u5PGWcI3tsgIaeBhglMoBbG37J/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PigvJTJ1IXMtfAX4SR4/VMXZsEI5VpZH2UY2zxTsh50=;
        b=AtlPilg8zAVIRW0jJxh1nHhzxR6MtyoqmyLPQZodKhsUzoba5vq22BRgomv8Pza7WJpLNy
        gmW24UXZHUdzzECA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,ion: Convert to sched_set_normal()
Cc:     john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962457.4006.12981963462257250028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     9309de08f14f49a29f6cc8a20653731235692b1f
Gitweb:        https://git.kernel.org/tip/9309de08f14f49a29f6cc8a20653731235692b1f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:23 +02:00

sched,ion: Convert to sched_set_normal()

In an attempt to take away sched_setscheduler() from modules, change
this into sched_set_normal(.nice = 19).

Cc: john.stultz@linaro.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/staging/android/ion/ion_heap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 0755b11..563b84c 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *data)
 
 int ion_heap_init_deferred_free(struct ion_heap *heap)
 {
-	struct sched_param param = { .sched_priority = 0 };
-
 	INIT_LIST_HEAD(&heap->free_list);
 	init_waitqueue_head(&heap->waitqueue);
 	heap->task = kthread_run(ion_heap_deferred_free, heap,
@@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct ion_heap *heap)
 		       __func__);
 		return PTR_ERR_OR_ZERO(heap->task);
 	}
-	sched_setscheduler(heap->task, SCHED_IDLE, &param);
+	sched_set_normal(heap->task, 19);
 
 	return 0;
 }
