Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD25C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A0C2064C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1JJpkLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEDX1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgEDX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:27:43 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:27:43 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v9so292276ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyKw+ba1yZRkxHkom61742xjtNSrJ6q9h9MnN2GvcMQ=;
        b=k1JJpkLgOCQT7vcVWkR0e06i3uluqZdrOHdjOPNr839tXFnZGXy35PK3YanQ4srjp6
         GyXU+dZuQxWhBSwW5Vpr6O8F5ls3Aovn9AmHiF6pQcFcZr82Pr6kcS6aTuU+2DonQUiQ
         xSOJiKUbFOFrm8XiUizT3yG3CV/Ol/bxbgaC+7e8ny4sf7QRqO/g3rvwQjeeo9EX5/dY
         9IFhTsmQJISAW8WJQoooHnW+Zz2Qm1BymB/POrsKQd3eJsq/S2I6UQ41rc1DPRPvyku4
         FD01SVJMXhgV1VFbveszucRmdVXr66CKfgu8xkwDwmxGq2x4i4bTVUUwnUK2PGKI2X46
         qrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyKw+ba1yZRkxHkom61742xjtNSrJ6q9h9MnN2GvcMQ=;
        b=GkhHuoCwdRc664jUo/gCVrof4Sn3MCpmdnMBO63Lk5apjf9gSutnNbvbKB9kCDq226
         4E+QUYlcSJa5jK1WvbfEP7MtjzvutfBXg6/XknBg3gbw3VUBClaSXClhu/EUllxtigzV
         gwUmp/I3YELlBLgY8z+e3H8DvPFVO85cc39n0LalGUe/Kc4f77jPURVTBisXtQD2v1xi
         maHBL8LcDwKC+veaq66V9cXnFwECOB0utplXGstjTq89GOr1X6PXttfYUQF9WAc0DLZY
         UUoGSES6jcKpq7BEM/c7VcWyHYdT39oriaHCIyiO7gxC5b2qWhY4WTSVSso+Fw+I2qJt
         uOLw==
X-Gm-Message-State: AGi0PuY7RGof1kW6cOe1WRK5T7QIJtJzBu1HoAu/BYKs1RrokdM0Deu2
        NzkCt9R5TBowMcOorKc5e835JqGcxbN6pIeRfrn+JQ==
X-Google-Smtp-Source: APiQypLzQdaZTAf3tan2b48ef88C9A3sYH0CoAvNqXb3SIsAXbOrJfQ7770SgJ3giv82dfHlVwl/W803/NGr32wBjfU=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr392795ybg.383.1588634862378;
 Mon, 04 May 2020 16:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200501113448.1809037-1-jolsa@kernel.org> <20200504225325.GE1916255@krava>
In-Reply-To: <20200504225325.GE1916255@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 May 2020 16:27:31 -0700
Message-ID: <CAP-5=fWK_NuLx57mX-oJDAUZQEcKD+ZSWvYOcb-v8epzySsZtg@mail.gmail.com>
Subject: Re: [PATCH] perf session: Try to read pipe data from file
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 3:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, May 01, 2020 at 01:34:47PM +0200, Jiri Olsa wrote:
> > From: Jiri Olsa <jolsa@redhat.com>
> >
> > Ian came with the idea of having support to read the pipe
> > data also from file [1]. Currently pipe mode files fails
> > like:
> >
> >   $ perf record -o - sleep 1 > /tmp/perf.pipe.data
> >   $ perf report -i /tmp/perf.pipe.data
> >   incompatible file format (rerun with -v to learn more)
> >
> > This patch adds the support to do that by trying the pipe
> > header first, and if its successfully detected, switching
> > the perf data to pipe mode.
> >
> > [1] https://lore.kernel.org/lkml/20200409185744.255881-1-irogers@google.com/
> > Original-patch-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> actualy.. I found another issue while trying this on tracepoints:
>
>   # ./perf record -g  -e 'raw_syscalls:sys_enter' -o -  true > data
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>   # ./perf script -i ./data
>   perf_event__process_tracing_data: tracing data size mismatch0x1034 [0xc]: failed to process type: 66
>
> it's because some of the pipe synthesize code calls lseek, which
> fails on pipe, but succeeds on normal file (with pipe data)
>
> patch below fixes that for me, but I wonder there are other leftovers
> like this.. I'll check on post it all together

Thanks for testing! I wonder in the 2nd case whether a comment as to
why the seek isn't needed in pipe mode would be useful.

Ian

> jirka
>
>
> ---
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 8ca709f938b8..33e299674121 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3955,13 +3955,8 @@ int perf_event__process_tracing_data(struct perf_session *session,
>  {
>         ssize_t size_read, padding, size = event->tracing_data.size;
>         int fd = perf_data__fd(session->data);
> -       off_t offset = lseek(fd, 0, SEEK_CUR);
>         char buf[BUFSIZ];
>
> -       /* setup for reading amidst mmap */
> -       lseek(fd, offset + sizeof(struct perf_record_header_tracing_data),
> -             SEEK_SET);
> -
>         size_read = trace_report(fd, &session->tevent,
>                                  session->repipe);
>         padding = PERF_ALIGN(size_read, sizeof(u64)) - size_read;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c11d89e0ee55..b75df19feaf1 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1543,7 +1543,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>                 return 0;
>         case PERF_RECORD_HEADER_TRACING_DATA:
>                 /* setup for reading amidst mmap */
> -               lseek(fd, file_offset, SEEK_SET);
> +               if (!perf_data__is_pipe(session->data))
> +                       lseek(fd, file_offset, SEEK_SET);
>                 return tool->tracing_data(session, event);
>         case PERF_RECORD_HEADER_BUILD_ID:
>                 return tool->build_id(session, event);
>
