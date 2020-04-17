Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C1C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482BB221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwLKqxpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgDQK6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729558AbgDQK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:58:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B857C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/2YlwCzJRJlnoyEyjEn/iO2aTqhf18fTLsV6UABgCs=; b=YwLKqxpJXP7CJdYsKALylmyJfs
        X6EAKvORcQm+NIE0RrPIW0ZuEAUNGqCfXw78Sgb0fHJ6jXe/gSOvggzV95QcGY8JemE7aySNdhEla
        zVBhH4Pkroe+06Dop5917C5wXZgtMsx4NbnqZH+zm6p82Hp4sumEUv1zAJzyzx+ovLcjUTWKUBqpl
        9oBCRGHLEFovEhxRqKUz0sPbD2VkV0Sd83Z3CDv1Zdb1YbmhTbvzbceaKPy33pPNHr7kkcrKv7P9f
        ThAVQz00UPFk1oweyudaRFyG38NFIIahhUejf4JuzF5Lb15EkfG5GOS3Q0rnPMfF6TVl6HPR2DpwR
        LU7W1xvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPOh3-00051p-7c; Fri, 17 Apr 2020 10:57:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A879D304E03;
        Fri, 17 Apr 2020 12:57:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BA882B1213E8; Fri, 17 Apr 2020 12:57:54 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:57:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200417105754.GY20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200414133559.GT20730@hirez.programming.kicks-ass.net>
 <1e587d48-2e61-e425-81cf-d304e13c91d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e587d48-2e61-e425-81cf-d304e13c91d4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:32:28PM -0700, Tim Chen wrote:
> 
> 
> On 4/14/20 6:35 AM, Peter Zijlstra wrote:
> > On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
> >> +static struct task_struct *
> >> +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >> +{
> >> +	struct task_struct *next, *max = NULL;
> >> +	const struct sched_class *class;
> >> +	const struct cpumask *smt_mask;
> >> +	int i, j, cpu;
> >> +	bool need_sync = false;
> > 
> > AFAICT that assignment is superfluous. Also, you violated the inverse
> > x-mas tree.
> > 
> >> +
> >> +	cpu = cpu_of(rq);
> >> +	if (cpu_is_offline(cpu))
> >> +		return idle_sched_class.pick_next_task(rq);
> > 
> > Are we actually hitting this one?
> > 
> 
> I did hit this race when I was testing taking cpu offline and online,
> which prompted the check of cpu being offline.

This is the schedule from the stop task to the idle task I presume,
there should really not be any other. And at that point the rq had
better be empty, so why didn't the normal task selection work?
