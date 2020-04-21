Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649AC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D1206CD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5U6IPR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDUAby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgDUAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:53 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3074C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:31:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f13so6438240ybk.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvIRjiKdvX2vd+CZBm43c0dKC0hRi+RpPihK1fsqsIk=;
        b=X5U6IPR+Sszxyj+2S44sawa1Sxh7UGkyzRBCOpho/MBpPXdI6lvjs+QJbi55uNGTbK
         hEI2sKLj7vLLadKZyN6aNfzmt550XSre2ycVgVC+ntrpqxJLPqLepPKd66RfpsFK+Qv5
         Hck+4D9TSeCkgiQMduX13rfsZ9z1ovwQI0pa+zW5OG4OYngUXtAmfBUE8YvFauWOrZNn
         ZnYa3VMtVPLyKQ4yqIVM6YxIcjdMKrIN+fGylf8GDtj0iMU+pM8oQi8pCZCJUOy5v+hL
         CPY2m6zoG3YOa+IZenoT4Rkm0GoG/xvc1YQFd8E2hD00O6D0JRKqdAH8pgIwKT/SKEe2
         QAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvIRjiKdvX2vd+CZBm43c0dKC0hRi+RpPihK1fsqsIk=;
        b=dd/vOnQXGk5Rk4qCjuhAERPrPiwgrAphAWdeMzpSLRUJ5cMtlxIWoUbI6S3ARa+ukv
         X/PPqtUIg0OnLFNB+fF20YHj03/B1xN5bMy/9c+ASaPfjHyOqjRhE0X/LypY93fSPg3L
         eqJmZ3gWokijnS1l+E2SXxsMmmnw931t9TLBG9wIuwYdFr8dP5H+de+QmoV21kbI03eG
         NVuO7mDnN8tiKWoGV6xZ14iuCpjLFeAaZKKYn3wOtA590MWOcss9zMaDxuHizSJU/irT
         vkIxnzl8F+/G+y5RkXqJPxjCZD8lMWRzP1ABAuRbKkNgX1CEUKPtnvzqnwbutqdlodX2
         cDGg==
X-Gm-Message-State: AGi0PubUkzB83LdJ8rmZHahOM/Pz0wDF3U7YDuqTh2kuamR5l160yKPO
        U3W2L1equ2oPmS2YnOXxFViu5ukpykbuowkZkNIb8A==
X-Google-Smtp-Source: APiQypIADR6TiGyWfT90iQFsbEO0uQYveHPR8F/EwNWWMDo3QROSukZOorvbEiTcRJMGzTcpCRokR87l/FN3P8OX0CI=
X-Received: by 2002:a25:d993:: with SMTP id q141mr23736603ybg.403.1587429112499;
 Mon, 20 Apr 2020 17:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200416001303.96841-1-irogers@google.com> <20200420075919.GA718574@krava>
In-Reply-To: <20200420075919.GA718574@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Apr 2020 17:31:41 -0700
Message-ID: <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 05:13:03PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..2f97d0c32a75 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -43,6 +43,7 @@
> >  #include "util/time-utils.h"
> >  #include "util/units.h"
> >  #include "util/bpf-event.h"
> > +#include "util/util.h"
> >  #include "asm/bug.h"
> >  #include "perf.h"
> >
> > @@ -50,6 +51,7 @@
> >  #include <inttypes.h>
> >  #include <locale.h>
> >  #include <poll.h>
> > +#include <pthread.h>
> >  #include <unistd.h>
> >  #include <sched.h>
> >  #include <signal.h>
> > @@ -503,6 +505,20 @@ static int process_synthesized_event(struct perf_tool *tool,
> >       return record__write(rec, NULL, event, event->header.size);
> >  }
> >
> > +static int process_locked_synthesized_event(struct perf_tool *tool,
> > +                                  union perf_event *event,
> > +                                  struct perf_sample *sample __maybe_unused,
> > +                                  struct machine *machine __maybe_unused)
> > +{
> > +     static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> > +     int ret;
> > +
> > +     pthread_mutex_lock(&synth_lock);
> > +     ret = process_synthesized_event(tool, event, sample, machine);
> > +     pthread_mutex_unlock(&synth_lock);
>
> hum, so how much faster is the synthesizing with threads in record,
> given that we serialize it on every event that goes to the file?

We see long synthesis times of the order seconds on loaded >100 core
servers. I've not been able to create a reproduction on my desktop.
You are right that making synthesis multithreaded will suffer from
Amdahl's law if the write is a synchronization point. Measuring with
the following patch in place:
https://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com/
without threads the portion that needs a lock is less than 1.5% of
execution time and so there's plenty to still run in parallel:
...
      - 32.59% __perf_event__synthesize_threads
         - 32.54% __event__synthesize_thread
            + 22.13% perf_event__synthesize_mmap_events
            + 6.68% perf_event__get_comm_ids.constprop.0
            + 1.49% process_synthesized_event
            + 1.29% __GI___readdir64
            + 0.60% __opendir
...

The multi-threaded benchmark in this patch (pass -t):
https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
shows:

Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:
 Number of synthesis threads: 1
   Average synthesis took: 127729.000 usec (+- 3372.880 usec)
   Average num. events: 21548.600 (+- 0.306)
   Average time per event 5.927 usec
 Number of synthesis threads: 2
   Average synthesis took: 88863.500 usec (+- 385.168 usec)
   Average num. events: 21552.800 (+- 0.327)
   Average time per event 4.123 usec
 Number of synthesis threads: 3
   Average synthesis took: 83257.400 usec (+- 348.617 usec)
   Average num. events: 21553.200 (+- 0.327)
   Average time per event 3.863 usec
 Number of synthesis threads: 4
   Average synthesis took: 75093.000 usec (+- 422.978 usec)
   Average num. events: 21554.200 (+- 0.200)
   Average time per event 3.484 usec
 Number of synthesis threads: 5
   Average synthesis took: 64896.600 usec (+- 353.348 usec)
   Average num. events: 21558.000 (+- 0.000)
   Average time per event 3.010 usec
 Number of synthesis threads: 6
   Average synthesis took: 59210.200 usec (+- 342.890 usec)
   Average num. events: 21560.000 (+- 0.000)
   Average time per event 2.746 usec
 Number of synthesis threads: 7
   Average synthesis took: 54093.900 usec (+- 306.247 usec)
   Average num. events: 21562.000 (+- 0.000)
   Average time per event 2.509 usec
 Number of synthesis threads: 8
   Average synthesis took: 48938.700 usec (+- 341.732 usec)
   Average num. events: 21564.000 (+- 0.000)
   Average time per event 2.269 usec

The event logic there is using an atomic rather than a lock and the
scaling isn't linear as not all the logic is threaded. Still with 8
threads we see things going about 2.6 times faster. On a large loaded
machine that may bring 10 seconds of event synthesis down to less than
4. On a desktop there's no measurable difference and the
--num-thread-synthesize is defaulted to 1.

> > +     return ret;
> > +}
> > +
> >  static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >  {
> >       struct record *rec = to;
> > @@ -1288,6 +1304,8 @@ static int record__synthesize(struct record *rec, bool tail)
> >       struct perf_tool *tool = &rec->tool;
> >       int fd = perf_data__fd(data);
> >       int err = 0;
> > +     int (*f)(struct perf_tool *, union perf_event *, struct perf_sample *,
> > +             struct machine *) = process_synthesized_event;
>
> there's event_op typedef in util/tools.h

Thanks! Updated here:
https://lore.kernel.org/lkml/20200421003020.37611-1-irogers@google.com/

Ian

> jirka
>
