Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195AAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66A92074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CuS1tL1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgFONSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgFONSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:18:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FD0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ukk+S+6VDFtMqnhGfuXIhIfQfuXiKx0l0jEYqrT9IpI=; b=CuS1tL1B6E+4EYC3fg2FbI9LwE
        KJYUS0i5Nb0R7aPojvRrtb+hztz+Fs1Y0AxZPuUuznOBxQxRxcl074oHHpc3IOlvmJb9bwi3JbMbi
        OTytuWAOo+h0woKpr62+WEvhnERnu7rQcN65L568HBsS/KLcsd9NlcQtqhW9v81iSBAWL4CirCZZO
        6eeBIvtlyRZCvRe2Yeeg5wK/ewQJZYBw6VhKqe7/DJo7p+XPdEoqRxxWSePHhROeyMlgzpq5G0c4z
        WapP+DaTDCEQs5GtybX+m5THF1MrwvztAMlhsvPtiwEsvEk8AYubg8x3c35aPlyw20dW9gIyA1A6g
        YboLnSng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp0F-0003Xl-4p; Mon, 15 Jun 2020 13:18:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1DE5301A32;
        Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9D0F7201ECFB6; Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Message-ID: <20200615131143.130326165@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Jun 2020 14:56:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org
Subject: [PATCH 1/6] sched: Fix ttwu_queue_cond()
References: <20200615125654.678940605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where the condition:

  !cpus_share_cache(smp_processor_id(), cpu)

already implies 'cpu != smp_processor_id()', because a CPU always
shares cache with itself, the secondary condition added in commit:

  2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")

voids that implication, resulting in attempting to do local wake-ups
through the queue mechanism.

Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2356,11 +2356,22 @@ bool cpus_share_cache(int this_cpu, int
 
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 {
+	int this_cpu = smp_processor_id();
+
+	/*
+	 * Only ever queue for remote wakeups. The on_cpu case can only ever
+	 * happen remotely, and for the normal case it makes no sense to
+	 * involve IPIs here, and would be broken, as many architectures cannot
+	 * trivially IPI self in any case.
+	 */
+	if (cpu == this_cpu)
+		return false;
+
 	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (!cpus_share_cache(this_cpu, cpu))
 		return true;
 
 	/*


