Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C5C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885E2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bc2yIIOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBUN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:29:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39587 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgBUN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:29:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id n30so682117lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NATODsU2yjaJrA6FSD/IewEgDQ5Oohivlua/nWpA3M=;
        b=bc2yIIOE7wkIMGyad4qn7bu3AxsOsBLEg/0ViMXFg9Kh7TOjkbFUDYIs0QeUD0iIL1
         1Yvsd0l0+eAr4LXVLoNWPWZykKEcqax4lX4vAnjjxcfHpFWIlt5nvNYq3UWU6J4SELQt
         RT5AoqFu//UZMeRDl4djtYxzARROJ7qbdlDDzzX0UGlAgLOzTXm5cWafJix/CsMSPy6V
         EWZOwjXlPnvc0/O9dgp/Qz9l9GKmcGmHWpzgWxDI3QvimNKpUeea6JBC/46YJhoCV+tP
         4/kLtCFOjBqMGHEFaId1fbX8fEXNk38H8WiOHG+/bxZSPw7RXo4x1Rq9upkwCtUGyhPO
         LsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NATODsU2yjaJrA6FSD/IewEgDQ5Oohivlua/nWpA3M=;
        b=Lnsq6J4I3AhXTsVVBa/uq83wi8ZKBw3Sx19iIgpxKugzrIRjzIDJ2HX5tAN6uqOzJs
         AmCuIlKu6dN6kcuQbn/harz+/z/N+9D7T6Qy4lC+b1/M3hNNbO9ibbBtWtuc4o05juUx
         zloatY3PceyB7x7/9CiHMnzmsVOtJeLYedZdhT/ScD0zyhn1amlvUGLpp2WU/TWlq2J5
         c/ZtY/olSjBok1jtkxGfAWBnKQwywRolwHdf9RWC5lHqCnYhSSpPviZPiZUCVTZo/81k
         KtS9f7xnCmh+1sq3i31GM8DbCXYDJrBbTHXldkH7pnIe882UAWwGaw/9yskcK5g+eKEU
         M5zA==
X-Gm-Message-State: APjAAAWGGs/WbbPLg+FpOalPsp6paKkkzn2iVJoUEbdsdmVQc4z/OsnF
        RYZ/M1utz8efE3kAMXDyCJ+8CSqmxCoqntnIrNkZyA==
X-Google-Smtp-Source: APXvYqyb+M2CIaNBeAgYY8KsqoMswRx7p6cPD+rt9zsxw7Toqetk2C0psjthf2j5Haq8E/EaKKB7j/fr+s5PNStqi+Y=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr19896983lfm.189.1582291742525;
 Fri, 21 Feb 2020 05:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org> <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
 <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com> <20200221090448.GQ3420@suse.de>
 <CAKfTPtAgyGrYaiUEm-MjLxH+pSYMnk4LFJ+_ogJ=cWVvaHMnsg@mail.gmail.com> <20200221104018.GR3420@suse.de>
In-Reply-To: <20200221104018.GR3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Feb 2020 14:28:50 +0100
Message-ID: <CAKfTPtC+sfkZgSzWdYqtHoZu4a8-LF+qsKYAvZ+DHJyOqh-Rqg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Mel Gorman <mgorman@suse.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 11:40, Mel Gorman <mgorman@suse.de> wrote:
>
> On Fri, Feb 21, 2020 at 10:25:27AM +0100, Vincent Guittot wrote:
> > On Fri, 21 Feb 2020 at 10:04, Mel Gorman <mgorman@suse.de> wrote:
> > >
> > > On Thu, Feb 20, 2020 at 04:11:18PM +0000, Valentin Schneider wrote:
> > > > On 20/02/2020 14:36, Vincent Guittot wrote:
> > > > > I agree that setting by default to SCHED_CAPACITY_SCALE is too much
> > > > > for little core.
> > > > > The problem for little core can be fixed by using the cpu capacity instead
> > > > >
> > > >
> > > > So that's indeed better for big.LITTLE & co. Any reason however for not
> > > > aligning with the initialization of util_avg ?
> > > >
> > > > With the default MC imbalance_pct (117), it takes 875 utilization to make
> > > > a single CPU group (with 1024 capacity) overloaded (group_is_overloaded()).
> > > > For a completely idle CPU, that means forking at least 3 tasks (512 + 256 +
> > > > 128 util_avg)
> > > >
> > > > With your change, it only takes 2 tasks. I know I'm being nitpicky here, but
> > > > I feel like those should be aligned, unless we have a proper argument against
> > > > it - in which case this should also appear in the changelog with so far only
> > > > mentions issues with util_avg migration, not the fork time initialization.
> > > >
> > >
> > > So, what is the way forward here? Should this patch be modified now,
> > > a patch be placed on top or go with what we have for the moment that
> > > works for symmetric CPUs and deal with the asym case later?
> > >
> > > I do not have any asym systems at all so I've no means of checking
> > > whether there is a problem or not.
> >
> > I'm going to send a new version at least for patch 4 and 5 using
> > cpu_scale as initial value and fixing update_sg_wakeup_stats()
> >
>
> No problem. FWIW, when I see them, I'll slot them in and rerun the tests
> as the previous results will be invalidated. Obviously the asym case will

I have just sent the new version.
Thanks for testing

> not be tested by me but I imagine you or Valentin have that covered.
>
> Thanks.
>
> --
> Mel Gorman
> SUSE Labs
