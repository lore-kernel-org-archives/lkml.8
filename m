Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3344C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85A206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHvFJmKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGMlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:41:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D40C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:41:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so2451681pgq.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8c9q9HwIlY5AfaLgnx0KWStuV7A8AOhfcyJqN4XE9wo=;
        b=KHvFJmKYoTlB97pcuu+A6InFN+r4daaWv7gWek1RY91j0qeNFUupsImboDff56xBd5
         BO6ZlKOf5WS8vPDk6/PcFUI3EOZ2xRK4CZkqAUGlKiL9pWsmB3QVYoNDY+gglIIXdszk
         lshDP30zDYG2eZ61SszIgjcUoUT/yF5RuBp2LWxoZWp8BF8yfjBe3mpnpj3p1zdc8VlE
         kF+aBnI99THFLj8XnEWMmsLZ0orL/TI96AmGlxxFiDMSiff58ABP9RfCdRFxHnMN75Qm
         ibXMAcLeTRsKBodcikwthbbhqELSVWyn8FOg/8fdCiYrIj3sBahftCWOeJEBS9Wm1Ql5
         N60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8c9q9HwIlY5AfaLgnx0KWStuV7A8AOhfcyJqN4XE9wo=;
        b=G+3o3hNJTMMMuvklEU2+zjg0rMvJpVhUTGiN96xe7zMMDPoRTl93WO4+kgRk+JsKqe
         +0yRfn0iFN6clDP/fCOh8oPaV6BYhbtDVaM5hZ+EbHMwiV1enzBwGKBWWeXiz/DGe1OX
         K7YP4RmH/oVl2D9PRbidTSZDnktN+w70YZYmop/iGo++oq2KPUXISoDocYofetJocHP3
         iQARspeSqDbtC+y57qbstxgzQcuNTuUfywPRN/FPMHAgkVM4q14HjLkYeyjgPdwfgqmG
         hDzgMF/CJ2/bYEg/zXXd/NEWwNCbDDgITSCzzk87WWzx71lDjTl9Ljkk7T+iUY3R//04
         0bPQ==
X-Gm-Message-State: AGi0PuaBEQZby7EN85mS31sg4WOnvmiw/IrCsc42BuQcyJ3S2o4+quHp
        jnOK6FDo8fPf64ZwR051GegDwop9
X-Google-Smtp-Source: APiQypIskh99Mv3+wLyayZ2yGu04d2ofDHLLrUDtwB/E9yBSuSBUwZ0Mbq3Ic+GEk8PRHoB0B1gatw==
X-Received: by 2002:aa7:842b:: with SMTP id q11mr13774173pfn.302.1588855268841;
        Thu, 07 May 2020 05:41:08 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id cc8sm2904652pjb.11.2020.05.07.05.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 05:41:07 -0700 (PDT)
Date:   Thu, 7 May 2020 20:41:04 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        iwtbavbm@gmail.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200507124104.GA2769@iZj6chx1xj0e0buvshuecpZ>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
 <20200505142711.GA12952@vingu-book>
 <jhjftcd1hmx.mognet@arm.com>
 <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
 <jhjv9l9yrtb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjv9l9yrtb.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:02:56PM +0100, Valentin Schneider wrote:
> 
> On 06/05/20 14:45, Vincent Guittot wrote:
> >> But then we may skip an update if we goto abort, no? Imagine we have just
> >> NOHZ_STATS_KICK, so we don't call any rebalance_domains(), and then as we
> >> go through the last NOHZ CPU in the loop we hit need_resched(). We would
> >> end in the abort part without any update to nohz.next_balance, despite
> >> having accumulated relevant data in the local next_balance variable.
> >
> > Yes but on the other end, the last CPU has not been able to run the
> > rebalance_domain so we must not move  nohz.next_balance otherwise it
> > will have to wait for at least another full period
> > In fact, I think that we have a problem with current implementation
> > because if we abort because  local cpu because busy we might end up
> > skipping idle load balance for a lot of idle CPUs
> >
> > As an example, imagine that we have 10 idle CPUs with the same
> > rq->next_balance which equal nohz.next_balance.  _nohz_idle_balance
> > starts on CPU0, it processes idle lb for CPU1 but then has to abort
> > because of need_resched. If we update nohz.next_balance like
> > currently, the next idle load balance  will happen after a full
> > balance interval whereas we still have 8 CPUs waiting for running an
> > idle load balance.
> >
> > My proposal also fixes this problem
> >
> 
> That's a very good point; so with NOHZ_BALANCE_KICK we can reduce
> nohz.next_balance via rebalance_domains(), and otherwise we would only
> increase it if we go through a complete for_each_cpu() loop in
> _nohz_idle_balance().
> 
> That said, if for some reason we keep bailing out of the loop, we won't
> push nohz.next_balance forward and thus may repeatedly nohz-balance only
> the first few CPUs in the NOHZ mask. I think that can happen if we have
> say 2 tasks pinned to a single rq, in that case nohz_balancer_kick() will
> kick a NOHZ balance whenever now >= nohz.next_balance.

If we face the risk of "repeatly nohz-balance only the first few CPUs",
Maybe we could remember the interrupted CPU and start nohz-balance from
it next time. Just replace the loop in _nohz_idle_balance() like:

for_each_cpu_wrap(cpu, nohz.idle_cpus_mask, nohz.anchor) {
	...
	if (need_resched()) {
		...
		nohz.anchor = cpu;
		...
	}
	...
}

This can mitigate the problem, but this can't help the extreme situation
as @Vincent put, it always failed in the same CPU.
