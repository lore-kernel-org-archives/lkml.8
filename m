Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B901C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A18206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqMPCg3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgEMCag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgEMCad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:30:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA245C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:30:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id x5so7342756ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpKvcF6cYRPs0VzgIvpbSSok+xEKbZDD7B97t881690=;
        b=sqMPCg3QfMXcQFjaw5y++wf6akTbJosdSGIyVaJm9w71VV8Hc95x4E+S5im0s5FIm9
         mQMVfAMXxucEo5Qy2klvk5FWU469JLCzitibrEuW48AAyNgw8C9TvXd2ZGb7bFTXxDXC
         vmxUIwnPjAufC9vq8KFfDJDtAQUGaAB8PYUAi5xmchF2Ax/PLc9hmATwDz6uiFeK5dSf
         uxtcncnqHgcQp6MmBZNktKYrFwfVz+cuRl7rVuovioS7eDtOerqssnXLyBt7jUHYDw9a
         1fWxnT/bqc/ulzP9cHhGYMCYdPHfGP6ZaAzMqmaBurU9D2zwWwu+Ny3RrA07xaeP7Bjw
         77XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpKvcF6cYRPs0VzgIvpbSSok+xEKbZDD7B97t881690=;
        b=uJXJ0MFkxmZtdyC2iPPUODftV0vLbmQl0G+yVOjwHTYjMUSoGaqsT2FKWhMBSNXDS7
         Y95WgkhgzkhoO3EsxJuZ3ZS7ROV/K8dkNrX/EC3tH886Mi7YYwu556VFmicg/r7ZDtLS
         VEFeHUdGWCQcrxoy3JJdNPsxnfNwSXeXMP33LVZHbZ7/PZshFMmaohvQekvrZCmk1PaG
         mxHg9vKmg4JKu8dddEPuAIVBSXZ++REGZKqxm3gx8m3J7f86L7pN2vUFuzZ4ZSOMij+5
         fD6RdYhgiAjQ29XzWeKuo3/YWzuGpnrk2JOaau7q5q1xI/UrEJKdb7JGy0RU4aHP8Ib+
         VtUQ==
X-Gm-Message-State: AGi0PuablMSKt4gZJ8Z/ffBsPOSaVpE05y6ljll3BGNYvUrtop6/505i
        jKJoHhDgsdY9tTy/1gQ7PIrSgrht+PWDoiO157la9Q==
X-Google-Smtp-Source: APiQypISzJTNbOMQ+9SG0JmlbXCmMrEOYqOyMAOztDRhjIKcfsUC9WeehbbbAXBTBdPWoVzy6rY8muPb2tvf9asRWTw=
X-Received: by 2002:a6b:ea11:: with SMTP id m17mr17257024ioc.149.1589337031931;
 Tue, 12 May 2020 19:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512121232.GB3150977@krava> <20200512141221.GL28888@kernel.org>
In-Reply-To: <20200512141221.GL28888@kernel.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Wed, 13 May 2020 12:30:20 +1000
Message-ID: <CAATStaOL7ZNnfMb0skgUvgpTFuTczZv6CKNxw9MGMKQGDkxfEA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Use an eventfd to wakeup when done
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 00:12, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, May 12, 2020 at 02:12:32PM +0200, Jiri Olsa escreveu:
> > On Tue, May 12, 2020 at 02:59:36PM +1000, Anand K Mistry wrote:
> >
> > SNIP
> >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 1ab349abe90469..099ecaa66732a2 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -53,6 +53,7 @@
> > >  #include <unistd.h>
> > >  #include <sched.h>
> > >  #include <signal.h>
> > > +#include <sys/eventfd.h>
> > >  #include <sys/mman.h>
> > >  #include <sys/wait.h>
> > >  #include <sys/types.h>
> > > @@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> > >
> > >  static volatile int signr = -1;
> > >  static volatile int child_finished;
> > > +static int done_fd = -1;
> > >
> > >  static void sig_handler(int sig)
> > >  {
> > > +   u64 tmp = 1;
> > >     if (sig == SIGCHLD)
> > >             child_finished = 1;
> > >     else
> > >             signr = sig;
> > >
> > >     done = 1;
> > > +
> > > +   /*
> > > +    * It is possible for this signal handler to run after done is checked
> > > +    * in the main loop, but before the perf counter fds are polled. If this
> > > +    * happens, the poll() will continue to wait even though done is set,
> > > +    * and will only break out if either another signal is received, or the
> > > +    * counters are ready for read. To ensure the poll() doesn't sleep when
> > > +    * done is set, use an eventfd (done_fd) to wake up the poll().
> > > +    */
> > > +   if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> > > +           pr_err("failed to signal wakeup fd\n");
> > >  }
> > >
> > >  static void sigsegv_handler(int sig)
> > > @@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> > >     int fd;
> > >     float ratio = 0;
> > >
> > > +   done_fd = eventfd(0, EFD_NONBLOCK);
> > > +   if (done_fd < 0) {
> > > +           pr_err("Failed to create wakeup eventfd, error: %m\n");
> > > +           return -1;
> > > +   }
> > > +   err = evlist__add_pollfd(rec->evlist, done_fd);
> > > +   if (err < 0) {
> > > +           pr_err("Failed to add wakeup eventfd to poll list\n");
> > > +           return -1;
> > > +   }
> >
> > sorry I did not notice before, but I think we also
> > need to close done_fd descriptor on the exit path
> >
> > also please change subject to PATCHv3 for the next version

Apologies. I'm still getting the hang of this.

>
> Yeah, and, and don't take this as a requirement for this patch to be
> processed, this can be made as a follow up patch by you or someone else
> (me, maybe :)), that maybe tools/perf/builtin-top.c and
> tools/perf/builtin-trace.c have the same issue?
>
> Could you please take a look there as well?

I looked at 'top', 'trace', and 'kvm'. kvm doesn't really have this
issue because
the poll() has a 100ms timeout. Even though it's technically affected,
the timeout
will make it unnoticeable (just delaying the exit for 100ms). top is
in the same boat
(uses a timeout).

trace is the affected one because it has the following code:
int timeout = done ? 100 : -1;
if (!draining && evlist__poll(evlist, timeout) > 0) {

Different logic, but still a gap and an indefinite timeout.

>
> - Arnaldo
>
> > thanks,
> > jirka
> >
> > > +
> > >     atexit(record__sig_exit);
> > >     signal(SIGCHLD, sig_handler);
> > >     signal(SIGINT, sig_handler);
> > > --
> > > 2.26.2.645.ge9eca65c58-goog
> > >
> >
>
> --
>
> - Arnaldo



-- 
Anand K. Mistry
Software Engineer
Google Australia
