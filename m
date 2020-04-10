Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023EDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FA0206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpwZq9lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJDnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:43:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44062 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJDnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:43:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id 11so544537ybj.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fp5uo2blnQO5x5U8QWVg+iWp8fhYxDKQabKmWmhgMKU=;
        b=HpwZq9lX7j4mTd81CnZjP3/lb7lb17nAhAEj/lJjjRCvAtfIBAFnY65yuPgwr3wsXq
         b2BAnOibKbJRiN6KH6uFIBzm8BhdkOqLR6xQsLIUx6eoKLnK12HOM76K3pAdO8mU0cXi
         7nO/aad4uHLN6ap626KdXIR5Nk448ojhnOr/JB+mSbMa8kDk1PSGpcRKW+iAfhNcMHWI
         u+A3M558hL5xrhZNCtoqysLBydyvAKONnCtNOTyLJ/kyhvwLQgqwL3jvwFM2/tA1e8cw
         VMqTYuu5t9GLhVod/kPv9r67JZf9Thn+0YQYAeCcV1jKPk+VVyeqF8L+1+m25oN3rxyj
         90IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fp5uo2blnQO5x5U8QWVg+iWp8fhYxDKQabKmWmhgMKU=;
        b=eqFnPK63yR+VyTpY9msD2Su8iFk4wC/850miwlSeqkTgtsDx6VW8SgpRBWqZ9O0rkB
         hwyokk2SXy6wJQrNm0SBWkGwrDrMvtAlV+by1DEXA81dh24ieMtMfPJDK1STs4Kr29es
         zfGkOcQJ/x7in+4uu7hwuZVeJU0Oua8aCFcS7BYPHdgpNyRvzLXTdq3ojX+fWi9HAQhw
         nlX3MT+Ieztra+Y6c/rvkQjvz0G4PTI16BOAOjLAYcjquDZ+xNHGcbUz3qVZvgFm5Zx8
         FW2eATj4kaeaUupDtT3ndtvGqa0RgWCKn20p7oCmULJlsWqUyO/4SPC7/+MsJdtkbsm8
         zolA==
X-Gm-Message-State: AGi0Pua0iTx1DV6Hz1dBjRboZwE6jGefswYv+PbGjoqtNCNBz8NSF0lO
        X0dtWwtNSqf6ju1VRaLwCELB9sbSmvE5RMcnBsIR1A==
X-Google-Smtp-Source: APiQypKBfXViLWOegPxWWYPDSq1YgLs+kFlhU9/eMzBWKLyNY/sxwpEyVEB4E9qQpkIxf6koUaveZyDth39SB/nRRnM=
X-Received: by 2002:a25:c64b:: with SMTP id k72mr4865720ybf.177.1586490210345;
 Thu, 09 Apr 2020 20:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com> <20200402154357.107873-5-irogers@google.com>
 <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
 <20200406140951.GE29826@kernel.org> <CAP-5=fVt9ueNm66MrV=CBYQPOXdOxYo2w_jiF-Cm-8i70SD8mQ@mail.gmail.com>
 <20200407123215.GA8452@kernel.org>
In-Reply-To: <20200407123215.GA8452@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 9 Apr 2020 20:43:19 -0700
Message-ID: <CAP-5=fWBHTi7uuwuE=RKfvU4M7QcpgTXtj++BEAy7EOcNv8vbQ@mail.gmail.com>
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

On Tue, Apr 7, 2020 at 5:32 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Apr 06, 2020 at 09:15:51AM -0700, Ian Rogers escreveu:
> > On Mon, Apr 6, 2020 at 7:09 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > Em Sat, Apr 04, 2020 at 12:06:45PM +0900, Namhyung Kim escreveu:
> > > > On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > The synthesize benchmark shows the majority of execution time going to
> > > > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > > > reading library that will be used to replace these calls in a follow-up
> > > > > CL.
>
> > > waiting for some conclusion to this thread,
>
> > Thanks, sorry I was busy at the weekend. I agree with Namhyung's
> > comments, nice catch! Fwiw, it comes from my refactoring this api out
> > of a specific /proc/pid/maps reader. I'll work to address the issue
> > and ideally stick some tests of the corner cases somewhere - any
> > suggestions? This doesn't feel like a perf test, nor is it a kernel
>
> It may not be uniquely useful for perf, but I'd start by adding an entry
> to 'perf test' anyway, as its used by perf, after all what we want is
> that code gets tested regularly, adding it to 'perf test' achieves that.

Thanks, this is hopefully done in:
https://lore.kernel.org/lkml/20200410034048.144150-1-irogers@google.com/T/#t
which also hopefully addresses Namhyung's comments around corner cases
and better documentation.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > side test.
> >
> > Thanks,
> > Ian
> >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 107 insertions(+)
> > > > >  create mode 100644 tools/lib/api/io.h
> > > > >
> > > > > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > > > > new file mode 100644
> > > > > index 000000000000..5aa5b0e26a7a
> > > > > --- /dev/null
> > > > > +++ b/tools/lib/api/io.h
> > > > > @@ -0,0 +1,107 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +/*
> > > > > + * Lightweight buffered reading library.
> > > > > + *
> > > > > + * Copyright 2019 Google LLC.
> > > > > + */
> > > > > +#ifndef __API_IO__
> > > > > +#define __API_IO__
> > > > > +
> > > > > +struct io {
> > > > > +       /* File descriptor being read/ */
> > > > > +       int fd;
> > > > > +       /* Size of the read buffer. */
> > > > > +       unsigned int buf_len;
> > > > > +       /* Pointer to storage for buffering read. */
> > > > > +       char *buf;
> > > > > +       /* End of the storage. */
> > > > > +       char *end;
> > > > > +       /* Currently accessed data pointer. */
> > > > > +       char *data;
> > > > > +       /* Set true on when the end of file on read error. */
> > > > > +       bool eof;
> > > > > +};
> > > > > +
> > > > > +static inline void io__init(struct io *io, int fd,
> > > > > +                           char *buf, unsigned int buf_len)
> > > > > +{
> > > > > +       io->fd = fd;
> > > > > +       io->buf_len = buf_len;
> > > > > +       io->buf = buf;
> > > > > +       io->end = buf;
> > > > > +       io->data = buf;
> > > > > +       io->eof = false;
> > > > > +}
> > > > > +
> > > > > +/* Reads one character from the "io" file with similar semantics to fgetc. */
> > > > > +static inline int io__get_char(struct io *io)
> > > > > +{
> > > > > +       char *ptr = io->data;
> > > > > +
> > > > > +       if (ptr == io->end) {
> > > > > +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> > > > > +
> > > > > +               if (n <= 0) {
> > > > > +                       io->eof = true;
> > > > > +                       return -1;
> > > > > +               }
> > > > > +               ptr = &io->buf[0];
> > > > > +               io->end = &io->buf[n];
> > > > > +       }
> > > > > +       io->data = ptr + 1;
> > > > > +       return *ptr;
> > > > > +}
> > > > > +
> > > > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> > > > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > > > + * after the hexadecimal value.
> > > > > + */
> > > > > +static inline int io__get_hex(struct io *io, __u64 *hex)
> > > > > +{
> > > > > +       bool first_read = true;
> > > > > +
> > > > > +       *hex = 0;
> > > > > +       while (true) {
> > > > > +               char ch = io__get_char(io);
> > > > > +
> > > >
> > > > Maybe you can add this
> > > >
> > > >     if (io->eof)
> > > >         return 0;
> > > >
> > > > Please see below
> > > >
> > > >
> > > > > +               if (ch < 0)
> > > > > +                       return ch;
> > > > > +               if (ch >= '0' && ch <= '9')
> > > > > +                       *hex = (*hex << 4) | (ch - '0');
> > > > > +               else if (ch >= 'a' && ch <= 'f')
> > > > > +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> > > > > +               else if (ch >= 'A' && ch <= 'F')
> > > > > +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> > > > > +               else if (first_read)
> > > > > +                       return -1;
> > > > > +               else
> > > > > +                       return ch;
> > > > > +               first_read = false;
> > > > > +       }
> > > > > +}
> > > >
> > > > What if a file contains hex digits at the end (without trailing spaces)?
> > > > I guess it'd see EOF and return -1, right?
> > > >
> > > > And it'd better to be clear when it sees a big hex numbers -
> > > > it could have a comment that it'd simply discard upper bits
> > > > or return an error.
> > > >
> > > > > +
> > > > > +/* Read a decimal value into the out argument dec.
> > > > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > > > + * after the decimal value.
> > > > > + */
> > > > > +static inline int io__get_dec(struct io *io, __u64 *dec)
> > > > > +{
> > > > > +       bool first_read = true;
> > > > > +
> > > > > +       *dec = 0;
> > > > > +       while (true) {
> > > > > +               char ch = io__get_char(io);
> > > > > +
> > > > > +               if (ch < 0)
> > > > > +                       return ch;
> > > > > +               if (ch >= '0' && ch <= '9')
> > > > > +                       *dec = (*dec * 10) + ch - '0';
> > > > > +               else if (first_read)
> > > > > +                       return -1;
> > > > > +               else
> > > > > +                       return ch;
> > > > > +               first_read = false;
> > > > > +       }
> > > > > +}
> > > >
> > > > Ditto.
> > > >
> > > > Thanks
> > > > Namhyung
> > > >
> > > >
> > > > > +
> > > > > +#endif /* __API_IO__ */
> > > > > --
> > > > > 2.26.0.rc2.310.g2932bb562d-goog
> > > > >
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
