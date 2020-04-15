Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73865C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E26720787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411475AbgDORrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:47:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411463AbgDORrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:47:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so943966wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tt9jGk27RUEZdriKQKnNadilLNMr7u5VeRjTwIA+GTo=;
        b=sDxRbgu9boNvVDHWDzdV+dJezucg9p9p2j789+DV8E9neqJLJhxwuMt2WCXuEet4E8
         R4ZxxqDNgDT3xRFp24jewTYIYBYNRqz83jbqS28Yi+t5NvhSTF7sBUYQEO8SoUhOMqEp
         QzBTcDa/DuyKhvqleEwlBvwYOE6z2d1G2ZKhB/rYmob9yYTpHnuXFpsAqOI6aysNTEVO
         yNYfuUCEnVvyQP7+vXGYpCqftxKIV7O3Z5636BmBUPpUUyOQQi97vcXrucEjprCoBDJH
         +3cflQ2UnCclQP4rTLdQe22Rwfmb0kv1jTViDCnBBgDPnzd882NGuzsvbjcPfpHLqIWi
         kJqw==
X-Gm-Message-State: AGi0PuY0UtkYO0Nk01NDJ9QNALZcLJznFjho0RYYwSPz3bv4hjp6g+5+
        o3N8ah3QjOk9zRwYHHy9+w4=
X-Google-Smtp-Source: APiQypJB/p4MatVZffcSF5ONnFLJfkY1S/YSslQZuXOqXLCr2YdyaVBmDvHdxdeOkIDKmHz9ffPBOw==
X-Received: by 2002:a5d:6688:: with SMTP id l8mr13162749wru.179.1586972841688;
        Wed, 15 Apr 2020 10:47:21 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id 17sm366542wmo.2.2020.04.15.10.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 10:47:20 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:47:18 +0200
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        ctheegal@codeaurora.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200415174718.GA30565@darkstar>
References: <20200414161320.251897-1-qperret@google.com>
 <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
 <20200415082001.GA256573@google.com>
 <CAD=FV=UB7OZzQO46dV7KOHGqRkgbtaSgLfq55yddyx0L_e37Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UB7OZzQO46dV7KOHGqRkgbtaSgLfq55yddyx0L_e37Fg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Apr 09:31, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 15, 2020 at 1:20 AM Quentin Perret <qperret@google.com> wrote:
> >
> > Hi Doug,
> > On Tuesday 14 Apr 2020 at 13:45:03 (-0700), Doug Anderson wrote:
> > > Hi,
> > > On Tue, Apr 14, 2020 at 9:13 AM Quentin Perret <qperret@google.com> wrote:

[...]

> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 3a61a3b8eaa9..9ea3e484eea2 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
> > > >         for_each_clamp_id(clamp_id) {
> > > >                 unsigned int clamp_value = uclamp_none(clamp_id);
> > > >
> > > > -               /* By default, RT tasks always get 100% boost */
> > > > -               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > > > -                       clamp_value = uclamp_none(UCLAMP_MAX);
> > > > -
> > > >                 uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> > >
> > > The local variable "clamp_value" doesn't have a lot of value anymore,
> > > does it?  (Pun intended).
> >
> > :)
> >
> > > Remove it?
> >
> > Right, but I figured the generated code should be similar, and
> > 'uclamp_se_set(&p->uclamp_req[clamp_id], uclamp_none(clamp_id), false);'
> > doesn't fit in 80 cols at this identation level, so I kept the local
> > var. No strong opinion, though.
> 
> OK.  It's definitely a bikeshed color issue and since you'll spend
> more time in this bikeshed than I will I'll leave it to you to pick
> the color.
> 
> I'm not at all an expert on this code but it sure looks sane to me.
> If you think my review tag is worth anything in this context feel free
> to add it, but since you already have Patrick's mine probably adds
> very little value.

Honestly I was almost there to ask for the same cleanup. :)

If you get rid of the useless variable we can go back to the exact
same code modified by the commit we are fixing, i.e. 1a00d999971c.

So, not strong opinions here too, but if it's not a big problem I
would post a cleaned up v2.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
