Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9CC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E3920784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OfkSuJ9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgDVLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D9C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=llWoNTl7a6WItJGcLBTC8j7ePN5aoj4IZ6+7VC2n6DI=; b=OfkSuJ9norfNio6+xaZkqCPpmL
        uNvQeSVJwV5Oekx6j971guWZ8znLdsuxfPzj8d/G6v9sjYot0CoKmY5mgCPKovW/DaU2bsjb8VbS+
        h0NAlhdvBWEA5SDk79bbtEBTlg05I38pZCnmblEg67hikwX+mZt//ogXYs0+UXuDGBcRS38oNMWoZ
        p0bZotU0LRp31LYLnI58R3VrSaZrf1rr4+2IEkc0fqgKROgNJDYM/rZ0Ij9MOKdTGhxT240nAmSlQ
        YVUFRTA32gMMw2dy+vH9DQMq1yfIeW5728QgDY3Mgl9oPp/ApK/MXWZ5IvkzdqfNeUJhtXdPT0fpS
        fbq8R3Dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0003bO-KM; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5719D30797F;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 07F5C22B99F04; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.283981577@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, paulmck@kernel.org
Subject: [PATCH 18/23] sched,locktorture: Convert to sched_set_fifo()
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

Effectively changes prio from 99 to 50.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/locktorture.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -436,8 +436,6 @@ static int torture_rtmutex_lock(void) __
 
 static void torture_rtmutex_boost(struct torture_random_state *trsp)
 {
-	int policy;
-	struct sched_param param;
 	const unsigned int factor = 50000; /* yes, quite arbitrary */
 
 	if (!rt_task(current)) {
@@ -448,8 +446,7 @@ static void torture_rtmutex_boost(struct
 		 */
 		if (trsp && !(torture_random(trsp) %
 			      (cxt.nrealwriters_stress * factor))) {
-			policy = SCHED_FIFO;
-			param.sched_priority = MAX_RT_PRIO - 1;
+			sched_set_fifo(current);
 		} else /* common case, do nothing */
 			return;
 	} else {
@@ -462,13 +459,10 @@ static void torture_rtmutex_boost(struct
 		 */
 		if (!trsp || !(torture_random(trsp) %
 			       (cxt.nrealwriters_stress * factor * 2))) {
-			policy = SCHED_NORMAL;
-			param.sched_priority = 0;
+			sched_set_normal(current, 0);
 		} else /* common case, do nothing */
 			return;
 	}
-
-	sched_setscheduler_nocheck(current, policy, &param);
 }
 
 static void torture_rtmutex_delay(struct torture_random_state *trsp)


