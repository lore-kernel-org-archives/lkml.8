Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE6C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C217E2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9S0dV0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895738AbgDOJkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895721AbgDOJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:40:15 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XM1Z8cdaxW1gEH8XQB3f7fNbxixDQWXVOYGx3dfIihk=; b=Y9S0dV0t/YeSgy4L/RLwRlkYiv
        Z7Fkjr/gFed11uPUOn+zTOtYFinIXW3jjeriZ4DmvbNf5dPzO1zvMREfDakzTlBAe2kAO+wbrXSU8
        LSPa+qM7Q/HlIaPOV8ikP27M49+ldf8TwaySmcpqKsslmMH3H0pIbQthSp7jugwllyZCJ4OD7uvHq
        ySVc6Mkaz9eQxhJ9lUy1LIItSvlJDP+VO6zekMTJpYU5zCfY1SWpmheQnuSZWcPblt2ht5H646P3T
        WsaMS5bfYk/ZdAtBVdJY4WyhnNyR5yTBAymiRRFh1wT1IIiYFr/rdhtPDiZI5JKH14YuOQha6Rqri
        z4/fiwOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOeW9-0006G1-1l; Wed, 15 Apr 2020 09:39:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50D3C30066E;
        Wed, 15 Apr 2020 11:39:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 336532BC6F2D8; Wed, 15 Apr 2020 11:39:35 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:39:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200415093935.GA20730@hirez.programming.kicks-ass.net>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200414162742.0ef4d9ee@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414162742.0ef4d9ee@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:27:42PM -0400, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 19:58:49 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
> > To move this forward, I would suggest renaming the current cpumask_any_*()
> > into cpumask_first_*(), and THEN introduce the new pseudo-random
> > ones. People are then free to hand-fix specific locations if it makes sense
> > there, like you're doing for RT.
> 
> Or leave "cpumask_any()" as is, and create a new "cpumask_random()" for
> this purpose.

Well, that's just twisting words, not sure I like that. 'Any' really
means 'any'. So in order to preserve long term sanity, I'd vote for
Valentin's approach of converting existing users over to first.
