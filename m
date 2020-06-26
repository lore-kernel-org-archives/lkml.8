Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93358C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F0207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgFZMdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:33:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43145 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgFZMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:33:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id j4so6880989wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=WJjMvAbYUXpGH69EpWeNZue8T5gDxGXglYeP5cKTZ98=;
        b=ugVlqMZbI4tEuAjTX2gqy9XaFL0QjANGiXuvuGVz1XvD3cStGXi20nPzmqxFXL+e3K
         mM56g1KAlxW2kLf56FC/e0BAiLzrOEaRXJ2NgLqA70SB5rMwTPQgf01F6NpUolja9zKm
         yRBjgbofW1kCdBdB/4XMtUXsKyOQ0lHfrwsNqpAq0qPVyWMfah4yzw3R0lGOwmr5Sg3t
         jhJbAaMnBh35NSdEjOI34Mh93f/gWpAYz5g/s0ldUqn1+HSXlHGs5AZapT/HoJCHhp5y
         jF3N7vIHAovXNQnILPeSu1PwJ9S3KF2h3wjqKaas0rl8UoKXBb5G8klbBJAILP5yWm6W
         T4gA==
X-Gm-Message-State: AOAM531N7mE89mQZAJIPYHKUrlPDNRrorwZfEQ7r3VKZiGNlQuZG0t24
        njwos7SxDEJv6TrSdlN9wccactGmc44=
X-Google-Smtp-Source: ABdhPJwKrSoSogafSGV/nAqASRZySj/tu3i0DIwo0UjyvvjiPYFUyWvcJeZvROIfLUf3P/3E8EnDAg==
X-Received: by 2002:adf:f546:: with SMTP id j6mr3509045wrp.167.1593174786907;
        Fri, 26 Jun 2020 05:33:06 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id d132sm17322868wmd.35.2020.06.26.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:33:05 -0700 (PDT)
References: <20200625154352.24767-1-qais.yousef@arm.com> <20200625154352.24767-2-qais.yousef@arm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/uclamp: Fix initialization of struct uclamp_rq
In-reply-to: <20200625154352.24767-2-qais.yousef@arm.com>
Message-ID: <87eeq2nh1k.derkling@matbug.net>
Date:   Fri, 26 Jun 2020 14:32:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jun 25, 2020 at 17:43:51 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> struct uclamp_rq was zeroed out entirely in assumption that in the first
> call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> default settings.

Perhaps I was not clear in my previous comment:

   https://lore.kernel.org/lkml/87sgekorfq.derkling@matbug.net/

when I did say:

   Does not this means the problem is more likely with
   uclamp_rq_util_with(), which should be guarded?

I did not mean that we have to guard the calls to that function but
instead that we should just make that function aware of uclamp being
opted in or not.

> But when next patch introduces a static key to skip
> uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> will fail to perform any frequency changes because the
> rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> means all rqs are capped to 0 by default.

The initialization you wants to do here it's needed because with the
current approach you keep calling the same uclamp_rq_util_with() and
keep doing min/max aggregations even when uclamp is not opted in.
But this means also that we have min/max aggregation _when not really
required_.

> Fix it by making sure we do proper initialization at init without
> relying on uclamp_rq_inc() doing it later.

My proposal was as simple as:

---8<---
  static __always_inline
  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
  				  struct task_struct *p)
  {
  	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
  	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
  
+       if (!static_branch_unlikely(&sched_uclamp_used))
+               return rt_task(p) ? uclamp_none(UCLAMP_MAX) : util 
  
  	if (p) {
  		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
  		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
  	}
  
  	/*
  	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
  	 * RUNNABLE tasks with _different_ clamps, we can end up with an
  	 * inversion. Fix it now when the clamps are applied.
  	 */
  	if (unlikely(min_util >= max_util))
  		return min_util;
  
  	return clamp(util, min_util, max_util);
  }
---8<---

Such small change is more self-contained IMHO and does not remove
an existing optimizations like this lazy RQ's initialization at first
usage.

Moreover, it can folded in the following patch, with all the other
static keys shortcuts.

