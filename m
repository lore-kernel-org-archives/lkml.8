Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C11C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6242078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591795447;
	bh=PqGKpe3pJAbiB6xHUS1NE9ElT3urY2tQdEw+LXxUfNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dgVKf2xVgB7/w51qYcNCQHh9btec4g8hsU2jPkpTtib6q6GwzfWLkyzrD0ZzQz91m
	 M75Ey4vvuQwli+nhYQdDay+mBL/oAIQ3qQEM6cQWbRdKuTsywgpNf0CAEyzp+beo8s
	 jFhbnyKZBVx2KTnsMIv6M3seeEt9lMIlHZ/gjJGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgFJNYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgFJNYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:24:05 -0400
Received: from localhost (lfbn-ncy-1-1025-94.w92-138.abo.wanadoo.fr [92.138.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3912072E;
        Wed, 10 Jun 2020 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591795445;
        bh=PqGKpe3pJAbiB6xHUS1NE9ElT3urY2tQdEw+LXxUfNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhBTH+zjq9UjbPZoc6Rwziv2sNqsfdxbyhZgO7j9MGR9KKLpb/vIrlV6nzdJF1qFE
         dsx9SUb+4F0ZVqFhoAlqBFg7wed3I8Aw8jemANyCEoIyr25FqcH5OmusXv+5l4VkT5
         JJL+emqZ8baTP2BsGXxw8OWuYRFaPd+XB6aM0AUk=
Date:   Wed, 10 Jun 2020 15:24:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net, sfr@canb.auug.org.au,
        linux@roeck-us.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200610132402.GB26639@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
 <20200529133641.GM706495@hirez.programming.kicks-ass.net>
 <20200605093704.GB2948@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605093704.GB2948@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:37:04AM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 03:36:41PM +0200, Peter Zijlstra wrote:
> > Maybe I can anonymous-union my way around it, dunno. I'll think about
> > it. I'm certainly not proud of this. But at least the BUILD_BUG_ON()s
> > should catch the more blatant breakage here.
> 
> How's this then? Differently ugly, but at least it compiles with that
> horrible struct randomization junk enabled.
> 
> ---
>  include/linux/irq_work.h  |   28 ++++++-------------
>  include/linux/sched.h     |    4 +-
>  include/linux/smp.h       |   25 ++++++-----------
>  include/linux/smp_types.h |   66 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c       |    6 ++--
>  kernel/smp.c              |   18 ------------
>  6 files changed, 89 insertions(+), 58 deletions(-)


Looks good. I don't have a better idea.

Thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
