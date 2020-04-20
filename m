Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E0C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E373820722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8vJiVfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgDTVhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDTVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:37:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA97C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:37:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so9968516qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGpR1rIaKdDduSGmslkbgwO1HLCBO6wZTx9DKYZPcys=;
        b=P8vJiVfMaQcO0jKGtW7wH+FAbz8kXDXPqrJWejAU0NGX4Cgjg/9Cu1iHQyAMgY5kO5
         5nhJbfjZRWuWpz41LXkq2xCBD1LcxaT3rQoQSUYKwotBwFvjroSAhYiHMc82PwQZswLg
         UT6XCOrBFry8UdNu/tc4aC+eySS3HLPKGT0dLPMztZKg0P7s4QqmWX4fDcykPK4ne/dS
         yCEjv/VlPjMStwqvMiZCXte/76PwTVVF//S4qhmHDJbkxsRh0Q2R/6a9KcP79PHVyqSf
         ApGR9P0NyQ4DlduFCRO0HkQLACFqywkhdrjYEFFFT6S2QsOUxXuA3JUK2iYGHAdDLFmN
         ysiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGpR1rIaKdDduSGmslkbgwO1HLCBO6wZTx9DKYZPcys=;
        b=Br8BSUS2UWUh/YxsCPTerEDVAC6cZKTqobfNJ/5hHEjaJ6o465v2sEfjDVksvKAAcI
         1qtuSsDHiOehPJ4C/t2uFergNX8xiEGs68iSiTnFQs1q4pqVHPoAz01rxhAmlcqpx8IK
         em3Le7jcdb0hcz7lotvs3pnvcI6xnBlFGXZDQy0RhSsMCtkp98TFnSoADqc5uk7IuNDv
         J9gLiVRSgDVTa682bwk12jvAYYSLSP4FTE/WcGRl6xntlttAVudKlOJoPqot/RsTf+6A
         esBdc+EtrdLvm/PtUi7amyc+oxKd/N+pzx/n5BEkRoLykHZ/ggBMKn/ckHPPHu5v/ZBX
         5EDw==
X-Gm-Message-State: AGi0PuZ5dxumhNl7DaVUUyHbIC61cpfP6qd9+zB2OfnHfyub/aP8hvyS
        TUwnNwhstqKvP5hHl1cdWMtAGq6Ize/gGR5UPRINqw==
X-Google-Smtp-Source: APiQypLVUySyb08Bv9qnAioLafiJuLQTQKZ18k9/vbZvwcqAxM1HYKaPULs0p08vm88dSki28hqGRP1aymIgXeqALRk=
X-Received: by 2002:ac8:748b:: with SMTP id v11mr18067843qtq.238.1587418621139;
 Mon, 20 Apr 2020 14:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150556.10920-1-qais.yousef@arm.com> <20200414150556.10920-3-qais.yousef@arm.com>
 <20200414121956.3687d6e9@gandalf.local.home> <20200415093617.GZ20730@hirez.programming.kicks-ass.net>
 <20200420154317.klwoztvdybmvykwe@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200420154317.klwoztvdybmvykwe@e107158-lin.cambridge.arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 20 Apr 2020 14:36:49 -0700
Message-ID: <CABk29NskBLS+s2J-FjzdmnrxvKR_+zQ1GxGkgiui=A1b-fvXtQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpumask: Make cpumask_any() truly random
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:43 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/15/20 11:36, Peter Zijlstra wrote:
> > On Tue, Apr 14, 2020 at 12:19:56PM -0400, Steven Rostedt wrote:
> > > Do we care if this gets preempted and migrated to a new CPU where we read
> > > "prev" from one distribute_cpu_mask_prev on one CPU and write it to another
> > > CPU?
> >
> > I don't think we do; that just adds to the randomness ;-), but you do
>
> Yep we don't care and it should enhance the randomness.
>
> > raise a good point in that __this_cpu_*() ops assume preemption is
> > already disabled, which is true of the one exiting
> > cpumask_any_and_distribute() caller, but is no longer true after patch
> > 1, and this patch repeats the mistake.
> >
> > So either we need to disable preemption across the function or
> > transition to this_cpu_*() ops.
>
> Sorry wasn't aware about the preemption check in __this_cpu_write().
>
> Transitioning to this_cpu_write() makes sense. Unless Josh comes back it'll
> break something he noticed.

Yep, this_cpu_* makes sense to me.  Preemption is ok, since prev must
always be a valid cpu id, thus we just get a little more _random_ from
this pseudorandom implementation.
