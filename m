Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E03208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9QQNbSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgEFQ4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729981AbgEFQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:56:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588DC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:56:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so3147613ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGzWREigVi0gy27TVyA7ZnJBxh+sA8DcxHlip3QEgLg=;
        b=K9QQNbSW5DvWRhcbYjot86EYnvfYjnbtFk02iHbc1TWXlqpiSk6gx9ZDHzyTckdCnG
         7aJPEVO4PY3frmrW4cWp4PlPt0jYpoNJJAnAGd07ne9XvfDhZBgG4tIgFpMTeb5mtoDC
         t+7X9Fu20gYUEz1OyWAMzTkIiKprhGCBOvgq4ryewJs2D8e1wVpoAgn9hGppYmjC9oZj
         KBvhcM7CsUEs1G9Lqy7I+e3WBKHJ6zKy4rbfAJTnlxIj9Iel/DoxR2iDknVl5n9WPZdA
         249Y4ntgVR34+9LmgCsMdp0mqt8GrSosXZf0ijTSP//WSnmMWdUvTKTgMJEQK2LT1lcM
         wJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGzWREigVi0gy27TVyA7ZnJBxh+sA8DcxHlip3QEgLg=;
        b=cHq0LsmSwqi9zVoHJMfnPGtgmn9aNNKJwqpr6O9So3Di16DC8StRYcowwfCpgM39ZN
         YKxf6+/foD1jHPiseeOnZ7ul2q4eok27eQM9b3/K5C+GQP8DnJ/TFoWCaOVJx0o4ETKf
         5M09mwDiuBJb7XelFfwI7nD/3e6J96fP4PEYOVlsW1Re4nHRpRLvow2L6+Ku+S1QNmrC
         gPr84FwNYaC2dt8blK8SBKiKkFnLCHiWd1+2BVgL3FlF7PpZfi868yS27JHyuAx5baL0
         ZGKAJr/Nyscv0imXKaDrR9w9r4KOERqiEn2isJujc70Q7wZewLFvUToNoKq/6aSnpjCP
         wbPA==
X-Gm-Message-State: AGi0PuYreMVVfpPxnQe6goJQP6q1oZoAKqY/lQTihvvM52Rb1qpNJre1
        tp++Qc+US4c7MOk+EyBZdp/uUjt0ma56VZib1Vm97g==
X-Google-Smtp-Source: APiQypKDcfkgObuhIxvbjRCvBTdoiuyCxbB+rf/asU81P118j2NSvxhp5ygD/glaxs7sV8SUh6ipzWzeKYtuRAFYqwQ=
X-Received: by 2002:a2e:3209:: with SMTP id y9mr5332790ljy.154.1588784175979;
 Wed, 06 May 2020 09:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
 <jhjftcd1hmx.mognet@arm.com> <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
 <jhjv9l9yrtb.mognet@arm.com>
In-Reply-To: <jhjv9l9yrtb.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 May 2020 18:56:02 +0200
Message-ID: <CAKfTPtAujvP=kN6zuB9N+5H2xGZ2U2ScsDUcUf+3iLeKbrmNKg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 18:03, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
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

If we take my example above and we have CPU0 which is idle at every
tick and selected as ilb_cpu but unluckily CPU0 has to abort before
running ilb for CPU1 everytime, I agree that we can end up trying to
run ilb on CPU0 at every tick without any success. We might consider
to kick_ilb in _nohz_idle_balance if we have to abort to let another
CPU handle the ilb
