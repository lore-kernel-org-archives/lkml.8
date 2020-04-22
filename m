Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6806C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7DC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UI46sCky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgDVL3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726517AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCFC03C1AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yT7zCXasH20UC6NIVxkpNndV6tvyX4o1l6S+JN7w94s=; b=UI46sCkyYaicIu3j/fS/4FtUZa
        QliP64YDd+4nGIGS4JeRra+YtVSnCq48I39wmOafhnFEpTJ6mrPEUf8CP+jm5tGCEqkO4KNb9YXQ2
        XkMS+KzqR4IbygalSm1+GUnmKyvj6RQIbnQkXkyHmlbfbxPzIVHxY8JPWwHFQ/hwQAYCJBnvkYFbz
        0MjiDyw1s8qBVCN/+zg1aUnTqY65rb124ACBcCwnjR2XkvGlYacp5U1pC96thQwDw6Sbur9Pjqk/W
        LdXZHLHFyYq4FlJbgVt/6STAPIJpd8dWJjMWfKmaRFm0obXBr3GmHEcj4bNfRORvlRvligxSl7XeS
        dX5SWNOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0003bS-MF; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58564307981;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 163E022B99F0A; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.403795265@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, paulmck@kernel.org
Subject: [PATCH 20/23] sched,rcutorture: Convert to sched_set_fifo_low()
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

Effectively no change.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rcu/rcutorture.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -802,13 +802,11 @@ static int rcu_torture_boost(void *arg)
 	unsigned long endtime;
 	unsigned long oldstarttime;
 	struct rcu_boost_inflight rbi = { .inflight = 0 };
-	struct sched_param sp;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
-	sp.sched_priority = 1;
-	if (sched_setscheduler(current, SCHED_FIFO, &sp) < 0) {
+	if (sched_set_fifo_low(current) < 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
 		n_rcu_torture_boost_rterror++;
 	}


