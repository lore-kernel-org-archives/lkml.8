Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D76222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wU9R/o6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgFSWjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgFSWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:39:19 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1356C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UAMq/M8UvGk+ucSymk22cSZuRucbr6A+o550Ee0ZTWk=; b=wU9R/o6qg5lNvrp5StTukm7zJ2
        CmRx+KwyraYR83/CAiKZ1fCG+9F5Q3tqtcVD0JIx91GLoWhA7cqT02XvUnjVsD0Jy2H1akVQeNx9Z
        RWsPXEHTZ47Lk5VDpW3uuxXWiiRDP+b3vZKYKwkBWegyhykx+TdvHFGr5V8TqceHKt+RRsUpjhF4z
        +isd27eF2cEx/AAZPLeEVzb31T3iq7q+Hox8ERRl6KimNz9D9ZQ8lrmpBI6ufn0LUpzQXbehpn+Fq
        fXFSBRUnMJiAfBKrB0aexl5fuNiYJbdrNPyXpJfrUMAQ/8OCvXV1IwtbzZPNLGkrLaAtS3w2ZN8xA
        n0PdacKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmPeV-00015d-6L; Fri, 19 Jun 2020 22:38:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9FD5301A32;
        Sat, 20 Jun 2020 00:38:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFED420137AC2; Sat, 20 Jun 2020 00:38:23 +0200 (CEST)
Date:   Sat, 20 Jun 2020 00:38:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, philip.li@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] sched: Have BUG_ON() check if linker sched classes don't
 line up correctly
Message-ID: <20200619223823.GL576888@hirez.programming.kicks-ass.net>
References: <20200619180219.0d558512@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619180219.0d558512@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 06:02:19PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> If the sched_class structures do not match how the compiler thinks they
> are in an array, it can cause hard to debug bugs. Change the BUG_ON()
> from making sure each of the sched classes are in the proper order, to
> also making sure they are off by the proper amount.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7ad864dc3ac5..876d7ecdab52 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6635,12 +6635,13 @@ void __init sched_init(void)
>  	unsigned long ptr = 0;
>  	int i;
>  
> -	BUG_ON(&idle_sched_class > &fair_sched_class ||
> -		&fair_sched_class > &rt_sched_class ||
> -		&rt_sched_class > &dl_sched_class);
> +	/* Make sure the linker didn't screw up */
> +	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
> +		&fair_sched_class + 1 != &rt_sched_class ||
> +		&rt_sched_class + 1 != &dl_sched_class);
>  
>  #ifdef CONFIG_SMP
> -	BUG_ON(&dl_sched_class > &stop_sched_class);
> +	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
>  #endif

Nice, I'll fold that.
