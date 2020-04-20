Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A132021744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrKzWgfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgDTXON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727815AbgDTXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:14:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=27KaiegQqmdcm9B+pUH7hIl4A0TAcBMPiIQ8gIM46QU=; b=GrKzWgfWNorVWSbTQDrFtZ68K7
        JjL/Tikglg+YFWy4zmFXDJSECV/DgQnaPG+JQfbnKVskN9ittRveQjNYLqfFt0rT6OorhSTxXKuqU
        ILl5GyfTnWw8ydpKY++mMJIiBT6MjZ5PsdtcofdDaXYGsTYOk96sNS0Mfr6Ou+GC5pX8HnnoCP1Oz
        nh5Q8TeGONB2F9j9+OQ2xRuF/JQW2mQwra6xwGsDG2/7q9DBS8VlGxYzVWf5cmUVTA94O7nxhRFuH
        IGSVFiVSUxKqqHNUgw12AhGaZpLA/MeQBYQDieIzhSrZvIMfNC20uwnSgkQ0NrLH2Q71QuRFS4gSV
        y34q2vew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQfby-0002RB-9V; Mon, 20 Apr 2020 23:13:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2BF19834D4; Tue, 21 Apr 2020 01:13:55 +0200 (CEST)
Date:   Tue, 21 Apr 2020 01:13:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200420231355.GU2483@worktop.programming.kicks-ass.net>
References: <cover.1587309963.git.yu.c.chen@intel.com>
 <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
 <20200420183232.16b83374@gandalf.local.home>
 <jhjwo69lqcm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjwo69lqcm.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:55:21PM +0100, Valentin Schneider wrote:

> >> +	finish_prev_task(rq, prev, rf);
> >
> > I'm not sure I like the name of this function. Perhaps
> > "balance_and_put_prev_task()"? Something more in kind to what the function
> > does.
> >
> 
> The 'finish' thing isn't too far from the truth; it's the last thing we
> need to do with the prev task (in terms of sched bookkeeping, I mean) -
> and in Chen's defence ISTR Peter suggested that name.
> 
> Seeing as it's a "supercharged" put_prev_task(), I could live with the
> marginally shorter "put_prev_task_balance()".

What Valentin said; it's the last put we do before picking a new task.
Also, I don't like long names. That said, I'm open to short and
appropriate suggestions.
