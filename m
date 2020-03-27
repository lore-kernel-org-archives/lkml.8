Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B73AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C5F2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuAytwDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0RdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:33:21 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40125 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgC0RdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:33:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id a5so1455046ybo.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sBRQDcnBi4EgZ8blnmaGzhDnMGW3FdIMW9Lq2Uq0uI=;
        b=uuAytwDVuxYwdy+sF1jVjujpxN92gOU8VxqkE0sLsR2H48JbzIFj9OFc73KWdHbxIg
         ueoLCDtb3fzR5FiGrG/3D2mGfc8P2hBxEPUET6AEORCm4a5je6r3VgRInI69SaD8mxWc
         mXXpyA8SAEBGw9f4ZlZgVAGd3s0rpJDkMX+a8Fg3pYLONNKMGvgwMrLVFDqpxxZqPlmH
         oCHPV6AmqShkA8w7wzR0InBf6FB/CrRLKteDZvxrAR8wgdmhnpxzdC43YzREvq7ALKdH
         1LCNNFEFjuYmucVTmJR03RbU8O3xr/SW3g1eqy2wdhP7cX6+TiETOtJ3eEYa8SSvrUah
         PLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sBRQDcnBi4EgZ8blnmaGzhDnMGW3FdIMW9Lq2Uq0uI=;
        b=eJk7gHh8SAJpn1uQHRbKVlNGppHAnKE1xYmPRBG2IbC4y5enrNyIcCNJJQvNRxdgu4
         rpZKBi75qlSneQqKCG91L6FQLy3xDHFHQINHmyqPZdgM8qYoVhfKUJ+FCaJlhkdWsG8g
         O3l5Gf8u6QEqpqE/idXcw5Kfe1NlyCg88tQbuipFP3GRS5SM5DmEfjYeuxHqM5eTh//J
         REFYwiKsF/069NIY6Gqyu4Ghw+R2Jkgo1NB04jmx3zunNp0sLEwMTKPAsCA3+7Sfow3b
         naagPfhYT93TR0CKx59EoeIm+8KO6qgsGvc66vRX+pF2Z+QrojvqqRnSS0YBJQ8cFkHT
         O9rw==
X-Gm-Message-State: ANhLgQ2eD7Kj510Y2v7udnlZIDY8frGSBG5z4BnbPpTXBS8GFMKjqU5V
        oj1AgAbWdjEf2Ge9gm3239f1midAI4CB8VFB1jk9dg==
X-Google-Smtp-Source: ADFU+vuiCvo0EYuhYn1Uo9EgXJs6UaIFDTNWmfOgAEfevqM45jTLu4GxZCOmjvUnvprMLeqRP9ppZOVvrs8AvXtKkwI=
X-Received: by 2002:a25:aaa4:: with SMTP id t33mr7006113ybi.324.1585330398821;
 Fri, 27 Mar 2020 10:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200327063651.146969-1-irogers@google.com> <20200327132358.GA2114302@krava>
In-Reply-To: <20200327132358.GA2114302@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 Mar 2020 10:33:07 -0700
Message-ID: <CAP-5=fVc6kRpaKEnA+OeKmK8Zr8KF+JpUw4_mZvesLtHyHA0Ew@mail.gmail.com>
Subject: Re: [PATCH] perf synthetic-events: save 4kb from 2 stack frames
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 6:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Mar 26, 2020 at 11:36:51PM -0700, Ian Rogers wrote:
> > Reduce the scope of PATH_MAX sized char buffers so that the compiler can
> > overlap their usage.
> >
> > perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
> > 'sub $0x35b8,%rsp'.
> >
> > perf_event__get_comm_ids before 'sub $0x2028,%rsp' after 'sub $0x1028,%rsp'.
>
> nice catch.. is this actualy problem somewhere? I thought
> we don't need to care that much about this in user space

I did perhaps a cleaner v2 here:
https://lore.kernel.org/lkml/20200327172914.28603-1-irogers@google.com/T/#u
I have some local changes that required some more arrays in
perf_event__synthesize_mmap_events, this hit a frame limit size with
our compiler set up. This change was the simplest workaround. I agree
this patch isn't essential but it should generally benefit performance
a little.

Thanks,
Ian

> jirka
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/synthetic-events.c | 46 ++++++++++++++++++------------
> >  1 file changed, 27 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 3f28af39f9c6..9ff54707bb30 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -70,7 +70,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
> >  static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> >                                   pid_t *tgid, pid_t *ppid)
> >  {
> > -     char filename[PATH_MAX];
> >       char bf[4096];
> >       int fd;
> >       size_t size = 0;
> > @@ -80,12 +79,16 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> >       *tgid = -1;
> >       *ppid = -1;
> >
> > -     snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
> > +     {
> > +             char filename[PATH_MAX];
> >
> > -     fd = open(filename, O_RDONLY);
> > -     if (fd < 0) {
> > -             pr_debug("couldn't open %s\n", filename);
> > -             return -1;
> > +             snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
> > +
> > +             fd = open(filename, O_RDONLY);
> > +             if (fd < 0) {
> > +                     pr_debug("couldn't open %s\n", filename);
> > +                     return -1;
> > +             }
> >       }
> >
> >       n = read(fd, bf, sizeof(bf) - 1);
> > @@ -280,7 +283,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >                                      struct machine *machine,
> >                                      bool mmap_data)
> >  {
> > -     char filename[PATH_MAX];
> >       FILE *fp;
> >       unsigned long long t;
> >       bool truncation = false;
> > @@ -292,18 +294,22 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >       if (machine__is_default_guest(machine))
> >               return 0;
> >
> > -     snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
> > -              machine->root_dir, pid, pid);
> > +#define FILENAME_FMT_STRING "%s/proc/%d/task/%d/maps"
> > +     {
> > +             char filename[PATH_MAX];
> >
> > -     fp = fopen(filename, "r");
> > -     if (fp == NULL) {
> > -             /*
> > -              * We raced with a task exiting - just return:
> > -              */
> > -             pr_debug("couldn't open %s\n", filename);
> > -             return -1;
> > -     }
> > +             snprintf(filename, sizeof(filename), FILENAME_FMT_STRING,
> > +                     machine->root_dir, pid, pid);
> >
> > +             fp = fopen(filename, "r");
> > +             if (fp == NULL) {
> > +                     /*
> > +                      * We raced with a task exiting - just return:
> > +                      */
> > +                     pr_debug("couldn't open %s\n", filename);
> > +                     return -1;
> > +             }
> > +     }
> >       event->header.type = PERF_RECORD_MMAP2;
> >       t = rdclock();
> >
> > @@ -320,10 +326,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >                       break;
> >
> >               if ((rdclock() - t) > timeout) {
> > -                     pr_warning("Reading %s time out. "
> > +                     pr_warning("Reading " FILENAME_FMT_STRING " time out. "
> >                                  "You may want to increase "
> >                                  "the time limit by --proc-map-timeout\n",
> > -                                filename);
> > +                                machine->root_dir, pid, pid);
> >                       truncation = true;
> >                       goto out;
> >               }
> > @@ -412,6 +418,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >
> >       fclose(fp);
> >       return rc;
> > +
> > +#undef FILENAME_FMT_STRING
> >  }
> >
> >  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
