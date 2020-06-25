Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54122076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNGCKrSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406455AbgFYQmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgFYQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:42:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:42:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so5131399qtg.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajYOFa9RNa+fkb/XbSWsB7IMrHTJGpich6Ue1AybJFQ=;
        b=VNGCKrSeLExJEhmOQDhpUn1GkLhd/we+OpUYpZOESGY3EwrtRZl12ItQ99ZjHrvS8q
         p+Dqr2rXdKtiW2nNWE2WlWNHMRUZZeVK2uBSD4IJqHtJqGEiXRrbrEKfXJFCpfX15PBK
         xvqmn1nlKzj/sh99OHQz0dMc+ne+s2fYHOjrVFabLPXHYXT0t0nfj4uJyA972bpa2bqL
         QDVmhkYR8+71f+L/zMi/YfCPjqddsvYuEK3AJ67lBHLg4f/jTvaMlCxnwQTLdRvaYb3J
         9YMd5uuyyNbCFD3eeZzAbV70Lf59SO8x+b6Arf3uLO5ImETiLqOT/9xCaSLZQs+pvBb3
         /4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajYOFa9RNa+fkb/XbSWsB7IMrHTJGpich6Ue1AybJFQ=;
        b=etIz02s5knki2fPMss9UFfP4xyg0uz6zQxl98w2wxqFO04h/P6CS6pPvtuQec1cuVh
         EcvabFzzJfLADzUwLVIscncGKUFrPYGo5WdRBSXVCQRYHLQFWPt0xcBxaPIuNkzmMwx2
         B7TJN9toYaH3w33+W/K7y76Mpt8IjgZJy+9A9HApg12+8Me5qXJuQy+648kBGnf0Ag77
         wS5as4U7E2MY9Nm2g2cDYpO7yz8N4cgerv0PxbZe/5Be18ZxIw6kkjrWXlYIzrD7pcIH
         bOZEli+GAkjyJT9U/OyhxCQpfbELOIJjMr42e1f63LRf0CFKn+LYT7JbiS6rwaPoFBn3
         HHYg==
X-Gm-Message-State: AOAM531YMiV4aUQ99Qn8kS0wNpK5HMHl6c9PmAlwiXCNXDtzJ1ur2fHZ
        0lnj1sGK39kksHEeZ6Z0PpaGYumffshTPaFOf0CGkQ==
X-Google-Smtp-Source: ABdhPJzB4AN3BsDj6ONWiQzQfx3JtHJeiIuJOAFa5GwD1B3xPiwryZmEsOmr8/JN7hGYq7esOuAK2k4+nLTMON5tlxQ=
X-Received: by 2002:ac8:5149:: with SMTP id h9mr2536769qtn.341.1593103365806;
 Thu, 25 Jun 2020 09:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200625094454.732790f7@oasis.local.home> <126813531.12266.1593093195147.JavaMail.zimbra@efficios.com>
 <20200625103753.4ac4a9a2@oasis.local.home>
In-Reply-To: <20200625103753.4ac4a9a2@oasis.local.home>
From:   Korben Rusek <korben@google.com>
Date:   Thu, 25 Jun 2020 09:42:34 -0700
Message-ID: <CAPo_bq3Bd4gRTeZHqD0p3KR+-339C=cmqgjgYMz1hvu1f+QAAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record running
 time stamp
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 7:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>
> > ----- On Jun 25, 2020, at 9:44 AM, rostedt rostedt@goodmis.org wrote:
> >
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > >
> > > [ SEVEN YEAR PROBLEM SOLVED! ]
> > >
> > > Up until now, if an event is interrupted while it is recorded by an
> > > interrupt, and that interrupt records events, the time of those events will
> > > all be the same. This is because events only record the delta of the time
> > > since the previous event (or beginning of a page), and to handle updating
> > > the time keeping for that of nested events is extremely racy. After years of
> > > thinking about this and several failed attempts, I finally have a solution
> > > to solve this puzzle.
> >
> > Out of curiosity, considering that LTTng has solved this problem 10+ years ago
> > with a simpler concurrency-friendly time-stamping model, why not simply use it
> > rather than add complexity to the current ftrace timestamp scheme ?
>
> Because it requires updating all the tools that read this from user
> space.
>
> I found a solution that works, so why change it and cause the backward
> compatibility pain now?
>
> -- Steve

Great work! I'm not exactly qualified to review the code, but the
logic seems correct. I'm curious how unlikely a zero delta is now and
how you quantify it. Also does it negate the patch that I emailed out
last week that adds a `force_abs_timestamp` trace/option in an attempt
to get around this particular issue?

In reading through, I did notice a couple simple typos in the comments
that are probably worth pointing out:

> If preempting an event time update, we may need absolute timestamp.

Not a big deal, but it should be "may need *an* absolute timestamp"

> * Preempted beween C and E:
> * Lost the previous events time stamp. Just set the
> * delta to zero, and this will be the same time as
> * the veent this event preempted. And the events that
> * came after this will still be correct (as they would
> * have built their delta on the previous event.

Should be "the *event* this event preempted." It also needs a
parenthesis at the end of the comment to close the parenthetical
statement.

Thanks, Korben
