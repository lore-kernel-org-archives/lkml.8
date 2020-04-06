Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354B4C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07E324926
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cnlbsdzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgDFQQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:16:07 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35557 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgDFQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:16:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id i2so154738ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaDH5sS5SxZ/gqL2HVY5h9o1JKm8RSuABz4Ly4lrTyI=;
        b=CnlbsdzciH71Ux7PMYJO3Eh39CwYrXYLBttOyh6I/8La5tiqrVOzHTdv0nQ0n/MyGx
         aj+4SDCWgNlIjT3ZYgSSg46HojCmEQ9+UPex2g6bzB5/6hI+2JMApaHWfpYmNxqEx73M
         EAJbVVRHmMW9Semo4z/pnXlSoEj29ZvbKytxIccBM8kdyWjn60h26c6AYTyneoIZ6XCA
         luguocKQCXxX0J4KsGRwCKXfo1WYPAXnxSmP7aYho/qrK5fjGKqOFyIMwb/fcBVBWOT/
         2RUft+s3l3/Wc9GvdxW09Z/HzDHtdhltX6FbE76xkpX5StYo5OLFzZ/XcMr+uknxAZLm
         Ghjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaDH5sS5SxZ/gqL2HVY5h9o1JKm8RSuABz4Ly4lrTyI=;
        b=T9mThJiw1sCpDZ5VNJz46oFnYcoerob2W19rsOT4m5ma9DRn32kCex6/sh3KIls28H
         618dlyALM7RKgGHX8qSSaivof/WJDfTF5ouNsMlUJ/nQYG5voUx+0jCZ5760KvKCOQY5
         sVNN2YjZLkBHW4zIMeeXO5LOBEFVUnklAvxqA0mkQwAtcanOFM5bWMXdWLfQDI+VDs2g
         HjkHtirUBAMDUio911RrS5y4WpoG/dnYk4TbrWLQ9BidJYFDS4tM8OUTNQeCDsTDr1VW
         fr15P+WceLw6Y73qxCV6h/z/4pOcchPqkGylZinMUmsKN6tcN3+kKZlDNtJNHdIxh4Dn
         djBg==
X-Gm-Message-State: AGi0Puah4jNaaALsUZuy1T1OvK3Y7RQt1tP9Bv3tOBNRuqNbMGfRCaVb
        87QNMQr39w7bZiPnZAmOQ4s1NM/yNolexpO7xpfhZA==
X-Google-Smtp-Source: APiQypIKz6ewkH5fXxoNmikwRfrMoBkb150NFwipEpmBSaNyLaKdUAPdMEdxvGmftC8tGv8sE60464fiN18DmSfb+5g=
X-Received: by 2002:a25:4443:: with SMTP id r64mr11777932yba.41.1586189762624;
 Mon, 06 Apr 2020 09:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com> <20200402154357.107873-5-irogers@google.com>
 <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com> <20200406140951.GE29826@kernel.org>
In-Reply-To: <20200406140951.GE29826@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Apr 2020 09:15:51 -0700
Message-ID: <CAP-5=fVt9ueNm66MrV=CBYQPOXdOxYo2w_jiF-Cm-8i70SD8mQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tools api: add a lightweight buffered reading api
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:09 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Sat, Apr 04, 2020 at 12:06:45PM +0900, Namhyung Kim escreveu:
> > Hello,
> >
> > On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The synthesize benchmark shows the majority of execution time going to
> > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > reading library that will be used to replace these calls in a follow-up
> > > CL.
>
> waiting for some conclusion to this thread,
>
> - Arnaldo

Thanks, sorry I was busy at the weekend. I agree with Namhyung's
comments, nice catch! Fwiw, it comes from my refactoring this api out
of a specific /proc/pid/maps reader. I'll work to address the issue
and ideally stick some tests of the corner cases somewhere - any
suggestions? This doesn't feel like a perf test, nor is it a kernel
side test.

Thanks,
Ian

> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 107 insertions(+)
> > >  create mode 100644 tools/lib/api/io.h
> > >
> > > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > > new file mode 100644
> > > index 000000000000..5aa5b0e26a7a
> > > --- /dev/null
> > > +++ b/tools/lib/api/io.h
> > > @@ -0,0 +1,107 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Lightweight buffered reading library.
> > > + *
> > > + * Copyright 2019 Google LLC.
> > > + */
> > > +#ifndef __API_IO__
> > > +#define __API_IO__
> > > +
> > > +struct io {
> > > +       /* File descriptor being read/ */
> > > +       int fd;
> > > +       /* Size of the read buffer. */
> > > +       unsigned int buf_len;
> > > +       /* Pointer to storage for buffering read. */
> > > +       char *buf;
> > > +       /* End of the storage. */
> > > +       char *end;
> > > +       /* Currently accessed data pointer. */
> > > +       char *data;
> > > +       /* Set true on when the end of file on read error. */
> > > +       bool eof;
> > > +};
> > > +
> > > +static inline void io__init(struct io *io, int fd,
> > > +                           char *buf, unsigned int buf_len)
> > > +{
> > > +       io->fd = fd;
> > > +       io->buf_len = buf_len;
> > > +       io->buf = buf;
> > > +       io->end = buf;
> > > +       io->data = buf;
> > > +       io->eof = false;
> > > +}
> > > +
> > > +/* Reads one character from the "io" file with similar semantics to fgetc. */
> > > +static inline int io__get_char(struct io *io)
> > > +{
> > > +       char *ptr = io->data;
> > > +
> > > +       if (ptr == io->end) {
> > > +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> > > +
> > > +               if (n <= 0) {
> > > +                       io->eof = true;
> > > +                       return -1;
> > > +               }
> > > +               ptr = &io->buf[0];
> > > +               io->end = &io->buf[n];
> > > +       }
> > > +       io->data = ptr + 1;
> > > +       return *ptr;
> > > +}
> > > +
> > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > + * after the hexadecimal value.
> > > + */
> > > +static inline int io__get_hex(struct io *io, __u64 *hex)
> > > +{
> > > +       bool first_read = true;
> > > +
> > > +       *hex = 0;
> > > +       while (true) {
> > > +               char ch = io__get_char(io);
> > > +
> >
> > Maybe you can add this
> >
> >     if (io->eof)
> >         return 0;
> >
> > Please see below
> >
> >
> > > +               if (ch < 0)
> > > +                       return ch;
> > > +               if (ch >= '0' && ch <= '9')
> > > +                       *hex = (*hex << 4) | (ch - '0');
> > > +               else if (ch >= 'a' && ch <= 'f')
> > > +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> > > +               else if (ch >= 'A' && ch <= 'F')
> > > +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> > > +               else if (first_read)
> > > +                       return -1;
> > > +               else
> > > +                       return ch;
> > > +               first_read = false;
> > > +       }
> > > +}
> >
> > What if a file contains hex digits at the end (without trailing spaces)?
> > I guess it'd see EOF and return -1, right?
> >
> > And it'd better to be clear when it sees a big hex numbers -
> > it could have a comment that it'd simply discard upper bits
> > or return an error.
> >
> > > +
> > > +/* Read a decimal value into the out argument dec.
> > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > + * after the decimal value.
> > > + */
> > > +static inline int io__get_dec(struct io *io, __u64 *dec)
> > > +{
> > > +       bool first_read = true;
> > > +
> > > +       *dec = 0;
> > > +       while (true) {
> > > +               char ch = io__get_char(io);
> > > +
> > > +               if (ch < 0)
> > > +                       return ch;
> > > +               if (ch >= '0' && ch <= '9')
> > > +                       *dec = (*dec * 10) + ch - '0';
> > > +               else if (first_read)
> > > +                       return -1;
> > > +               else
> > > +                       return ch;
> > > +               first_read = false;
> > > +       }
> > > +}
> >
> > Ditto.
> >
> > Thanks
> > Namhyung
> >
> >
> > > +
> > > +#endif /* __API_IO__ */
> > > --
> > > 2.26.0.rc2.310.g2932bb562d-goog
> > >
>
> --
>
> - Arnaldo
