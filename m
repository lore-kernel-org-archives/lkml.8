Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDBC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECA724954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/ikza+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEAP3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgEAP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:29:08 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F437C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:29:07 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id d197so5133065ybh.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKrBtfrpyK1RhI45vNfBQcuDSAhFfyPM1VHFeoWhbaI=;
        b=U/ikza+ZAKeC0wsqjNs5Isu5hLRq2mT/vZh7KBWjsm0KOmBuTZjNauPuU+312Cv4Ms
         JxXq4Z88s/py1qrlUm0pF114rvTgNEeShesJWWUwPky2XxrbbeRq35MxdOjLnNbye9o7
         WSUDUIL9spZP1ggBJ1YS3Xo7toRZRVwymi1zceuZHbFUZte5OUU9CD0bQuYbJ3xSrtPJ
         vyq++C/+KgBXRI21BP8biiU0t+1gP18rh+bJlmyrWIaJP066t2waufMrmINfTZHyEQNA
         uWg+3xyLCwbbCWv5U58fIWevRUSle7QV6FFUvppm8du9LMfeaz1ubYZuraVxwUCGPE92
         n/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKrBtfrpyK1RhI45vNfBQcuDSAhFfyPM1VHFeoWhbaI=;
        b=cJxWdGMjISa1PLfMh4RLIfkyn7wYxl6nDidsxeyDZVUxhdkFz7s2hoBRd6Po5VcgHn
         91OPu+aJBVujv7mZ1I8aBJoXtmpnbS5vaZ8RafcRFELfxI6FS6oqSX8QIPzUZk4xHfM4
         9QcYvpUKQwBcpnnH2F+huGHISH5ubNLtdoplVw/iwqPoTbEQUJvurzH4uYw3quyfA0XD
         Mvdo7R0OiIolH0m6qoG7uFzbWqt445R/1nOrwYHrFdLmvVCvcPHhUci+MhGQhAhvh4oc
         t8YExcAnPGG0n/AbdyvoPVLSx2/G+mvKiLg5oloAvIezTmLeBjFSfJY8KBfcXkuHMXiH
         T0QQ==
X-Gm-Message-State: AGi0PuZFJ0CX/nifNkaBXt+rimtaQKSRquSSPC3pH7Yc5yrEh8iQnKn9
        52NKwSDmMUsqub/gImyD/oirRXBOtgZWq3zidtVBQA==
X-Google-Smtp-Source: APiQypJ+UewnjB0RtS9jgT1Rgck6ixizg0vJadcbF3WU+FqyU2gxg/NAi07uv0dNqXTSbsRagbU6HReXR98cM1XpASU=
X-Received: by 2002:a5b:45:: with SMTP id e5mr4136165ybp.286.1588346946419;
 Fri, 01 May 2020 08:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200430193557.101831-1-irogers@google.com> <20200430193557.101831-3-irogers@google.com>
 <20200501122345.GA1810115@krava>
In-Reply-To: <20200501122345.GA1810115@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 May 2020 08:28:55 -0700
Message-ID: <CAP-5=fU8hrrQTuXCPJyt9Zc6ZK+W9wr9km1+YBBBTabcqvkoeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib kallsyms: parse using io api
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 5:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 30, 2020 at 12:35:57PM -0700, Ian Rogers wrote:
> > Perf record will call kallsyms__parse 4 times during startup and process
> > megabytes of data. This changes kallsyms__parse to use the io library
> > rather than fgets to improve performance of the user code by over 8%.
> >
> > Before:
> >   Running 'internals/kallsyms-parse' benchmark:
> >   Average kallsyms__parse took: 103.988 ms (+- 0.203 ms)
> > After:
> >   Running 'internals/kallsyms-parse' benchmark:
> >   Average kallsyms__parse took: 95.571 ms (+- 0.006 ms)
> >
> > For a workload like:
> > $ perf record /bin/true
> > Run under 'perf record -e cycles:u -g' the time goes from:
> > Before
> > 30.10%     1.67%  perf     perf                [.] kallsyms__parse
> > After
> > 25.55%    20.04%  perf     perf                [.] kallsyms__parse
> > So a little under 5% of the start-up time is removed. A lot of what
> > remains is on the kernel side, but caching kallsyms within perf would
> > at least impact memory footprint.
>
> with your change I'm getting following warnings:
>
> $ sudo ./perf record -a
> Couldn't record kernel reference relocation symbol
> Symbol resolution may be skewed if relocation was used (e.g. kexec).
> Check /proc/kallsyms permission or run as root.

I'll investigate, sorry in advance for sending this out too early.

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/io.h          |  3 ++
> >  tools/lib/symbol/kallsyms.c | 81 +++++++++++++++++++------------------
> >  2 files changed, 44 insertions(+), 40 deletions(-)
> >
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index b7e55b5f8a4a..777c20f6b604 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -7,6 +7,9 @@
> >  #ifndef __API_IO__
> >  #define __API_IO__
> >
> > +#include <stdlib.h>
> > +#include <unistd.h>
>
> was this missing?

Yes, they were getting picked up by a transitive #include in
synthesize-events.c, but given the call to read and use of size_t are
here it makes sense for the #includes to be here.

Thanks,
Ian

> jirka
>
> > +
> >  struct io {
> >       /* File descriptor being read/ */
> >       int fd;
>
> SNIP
>
