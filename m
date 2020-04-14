Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0441BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17A2206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbU4ZDol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438678AbgDNKyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438668AbgDNKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:53:01 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 03:53:00 PDT
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E93C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7tWVbvGiPmUL+5/a7kVu+C/k/gNV3SCUDwyJsyfKaoQ=; b=hbU4ZDolbD+uMn1/7xI9CGb3Zn
        DBJTF21BxGgDv37qCgNaxSD6t2FPztNCjABiUP93iVN1fVsK941S4Sm1KzCE0ecm48iPdfHZv6D2g
        Fj4o4TYbgp9+Wx0nM7rWmbmotfBnlSTuHSaHWgXOeYshnUQKPGdKsqMQkE5ccMtPiKtdlUvNVWmdS
        9AdY0P3O9gs6JCh1+hqy4cW1u3rIj5bXfejyt2PLGLbwiDYjhHXil+ivQdcsSzbzsTByv2UZmzUfF
        1KOMGpEb6wqUz4lvzGFjcSBLlZaO1ZDAxLjT+M/jhPyNngMzhN8q4NWMUD3X+ETpOMEgIfDYBd4oa
        op8miyYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJB1-0003x5-9E; Tue, 14 Apr 2020 10:52:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 418DC300483;
        Tue, 14 Apr 2020 12:52:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032CB2038BC52; Tue, 14 Apr 2020 12:52:20 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:52:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhead.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: eliminate bandwidth race between throttling
 and distribution
Message-ID: <20200414105220.GL20713@hirez.programming.kicks-ass.net>
References: <20200410225208.109717-1-joshdon@google.com>
 <20200410225208.109717-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410225208.109717-2-joshdon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 03:52:07PM -0700, Josh Don wrote:

> -/* returns 0 on failure to allocate runtime */
> +/* returns 0 on failure to allocate runtime, called with cfs_b->lock held */

That's a gross mis-spelling of lockdep_assert_held(); and since I was
editing things anyway it now looks like so:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4587,11 +4587,13 @@ static inline struct cfs_bandwidth *tg_c
 	return &tg->cfs_bandwidth;
 }
 
-/* returns 0 on failure to allocate runtime, called with cfs_b->lock held */
+/* returns 0 on failure to allocate runtime */
 static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
 				   struct cfs_rq *cfs_rq, u64 target_runtime)
 {
-	u64 amount = 0, min_amount;
+	u64 min_amount, amount = 0;
+
+	lockdep_assert_held(cfs_rq->lock);
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = target_runtime - cfs_rq->runtime_remaining;
@@ -4616,12 +4618,11 @@ static int __assign_cfs_rq_runtime(struc
 /* returns 0 on failure to allocate runtime */
 static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
-	int ret;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+	int ret;
 
 	raw_spin_lock(&cfs_b->lock);
-	ret = __assign_cfs_rq_runtime(cfs_b, cfs_rq,
-				      sched_cfs_bandwidth_slice());
+	ret = __assign_cfs_rq_runtime(cfs_b, cfs_rq, sched_cfs_bandwidth_slice());
 	raw_spin_unlock(&cfs_b->lock);
 
 	return ret;

