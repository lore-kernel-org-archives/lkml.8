Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABDC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E282465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxhlUpBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgAOO5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:57:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zYvfHEkAzcG6x0JYAatDwISXBtxZj7+56kXRS6nreOY=; b=hxhlUpBMsRkFVGusknWLZvV2P
        fmooJozPgiNWV0gIxROWkfciN+O9o2snxCNwrPmc57F1o6SKlNQGDYeY1/HR+l69yEbBYSoHxw12C
        hGzrvvL7cUfpAebtT0xv8fyGyNggD6Cj4FnDs2EPZMy0/56iDrxIVlGE+JWtBoZzPdnUsDRaUc0Y8
        fbahBgG4MMb2jvAoJzcmPAij46QLbY0/lOS7f2gcD8S/RYeTTjE2IOkojWYxyJlrmLZphontdzyQZ
        PxGZHunLCFhQxpvl65UZt3w2nbABTj8P88XzsKj3tlZI5wp5v/zsALxXtTqVlRcxA5a/TT7rdpXf+
        b6q46yVBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irk6C-00073U-S9; Wed, 15 Jan 2020 14:56:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFA9E30257C;
        Wed, 15 Jan 2020 15:55:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 361DD2B6C6D7F; Wed, 15 Jan 2020 15:56:45 +0100 (CET)
Date:   Wed, 15 Jan 2020 15:56:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Steven Rostedt' <rostedt@goodmis.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched/fair: scheduler not running high priority process on idle
 cpu
Message-ID: <20200115145645.GM2827@hirez.programming.kicks-ass.net>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
 <20200114115906.22f952ff@gandalf.local.home>
 <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
 <20200114124812.4d5355ae@gandalf.local.home>
 <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:44:19PM +0000, David Laight wrote:

> Code that runs with a spin-lock held (or otherwise disables preemption)
> for significant periods probably ought to be detected and warned.
> I'm not sure of a suitable limit, 100us is probably excessive on x86.

Problem is, without CONFIG_PREEMPT_COUNT (basically only
PREEMPT/PREEMPT_RT) we can't even tell.

And I think we tried adding warnings to things like softirq, but then we
get into arguments with the pure performance people on how allowing it
longer will make their benchmarks go faster.

There really is no silver bullet here :/
