Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA8CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578A2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq5Sj1vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgDGMcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:32:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38760 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:32:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so1368942qke.5;
        Tue, 07 Apr 2020 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXfkv1G0Lz+UcHIZnaf78/cXd++W3mTTWiLtv0MGDKg=;
        b=nq5Sj1vdkVIinV47uKusx+/IAaxPorzbZ0bpNu0hoqO92OIO8KW65Cn3Eud9lzmTOz
         J/uel0MXGV7EAQoxZBCa4lC6et8tGhjgju+KgulMZq0manmR3kV1IuntfGygoRYNLW4Q
         9yAlO1LEVeBF72c+JjSuhIjEFEd4amS41Xbaj8oUueL34Wku4m27s5hSC6B1xX18otq/
         2lwFTtoaNiyYJMdXTrf/W9TvurJuPgCae54MmMhny+O5sCgOhDeEndUqpL3AyrOvaDx2
         f9jjQNdCxknVsiVVZQ8LWNYEDXv1sKcfuk4B5WR4aww1S4/e2xazl59bfCSQlG3BQfIP
         /vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXfkv1G0Lz+UcHIZnaf78/cXd++W3mTTWiLtv0MGDKg=;
        b=kFQuvs1fOz5WMx8p8TbMC5yOr9Ky7M2aN1VIpdNnfTvHdpqGLl8D4rgm7U8PcnSR99
         ejSHRmwos8ycqLU3H6gNeVGSZw6AjUUcu0hyW9GNFrWkxVJO4A0JUo97+vqaN43drBOc
         v0XnEKBigYa4K5KWNrOeg4xDFRD3AAOV8obu8V1kS3cm8PAXvgFHFO1NSngigo6VeAsE
         MskoKTJJqSZ7/xsMCk/myEJt8sZ/W75j39+zQDSljZhNcUS1Nb7OWAWAoxfDMarPC680
         JcxDvbXHqnuQZCtmih8I3xg78hndcZn/Npo2oAu/mSUxhaWBnndGWX83RD55kaLLRiXR
         WuSw==
X-Gm-Message-State: AGi0PubMZFaPQaTjd6a7VSr5KbfViizVbuRRGQEZIu8/wbXKBr9Y0Ob4
        luinhafhtHYRQsEhQ4ePylU=
X-Google-Smtp-Source: APiQypLebGaYj1oLCVg67ZweYiLjid3Gs93MfJOn0wrXL3dKmJRwIN8Od+7n97Ecv5WuuGbXloyzsQ==
X-Received: by 2002:a05:620a:12fa:: with SMTP id f26mr1900865qkl.374.1586262738547;
        Tue, 07 Apr 2020 05:32:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l42sm17747121qtf.51.2020.04.07.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:32:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5DB5A409A3; Tue,  7 Apr 2020 09:32:15 -0300 (-03)
Date:   Tue, 7 Apr 2020 09:32:15 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v2 4/5] tools api: add a lightweight buffered reading api
Message-ID: <20200407123215.GA8452@kernel.org>
References: <20200402154357.107873-1-irogers@google.com>
 <20200402154357.107873-5-irogers@google.com>
 <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
 <20200406140951.GE29826@kernel.org>
 <CAP-5=fVt9ueNm66MrV=CBYQPOXdOxYo2w_jiF-Cm-8i70SD8mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVt9ueNm66MrV=CBYQPOXdOxYo2w_jiF-Cm-8i70SD8mQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 06, 2020 at 09:15:51AM -0700, Ian Rogers escreveu:
> On Mon, Apr 6, 2020 at 7:09 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Sat, Apr 04, 2020 at 12:06:45PM +0900, Namhyung Kim escreveu:
> > > On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The synthesize benchmark shows the majority of execution time going to
> > > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > > reading library that will be used to replace these calls in a follow-up
> > > > CL.

> > waiting for some conclusion to this thread,
 
> Thanks, sorry I was busy at the weekend. I agree with Namhyung's
> comments, nice catch! Fwiw, it comes from my refactoring this api out
> of a specific /proc/pid/maps reader. I'll work to address the issue
> and ideally stick some tests of the corner cases somewhere - any
> suggestions? This doesn't feel like a perf test, nor is it a kernel

It may not be uniquely useful for perf, but I'd start by adding an entry
to 'perf test' anyway, as its used by perf, after all what we want is
that code gets tested regularly, adding it to 'perf test' achieves that.

Thanks,

- Arnaldo

> side test.
> 
> Thanks,
> Ian
> 
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 107 insertions(+)
> > > >  create mode 100644 tools/lib/api/io.h
> > > >
> > > > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > > > new file mode 100644
> > > > index 000000000000..5aa5b0e26a7a
> > > > --- /dev/null
> > > > +++ b/tools/lib/api/io.h
> > > > @@ -0,0 +1,107 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Lightweight buffered reading library.
> > > > + *
> > > > + * Copyright 2019 Google LLC.
> > > > + */
> > > > +#ifndef __API_IO__
> > > > +#define __API_IO__
> > > > +
> > > > +struct io {
> > > > +       /* File descriptor being read/ */
> > > > +       int fd;
> > > > +       /* Size of the read buffer. */
> > > > +       unsigned int buf_len;
> > > > +       /* Pointer to storage for buffering read. */
> > > > +       char *buf;
> > > > +       /* End of the storage. */
> > > > +       char *end;
> > > > +       /* Currently accessed data pointer. */
> > > > +       char *data;
> > > > +       /* Set true on when the end of file on read error. */
> > > > +       bool eof;
> > > > +};
> > > > +
> > > > +static inline void io__init(struct io *io, int fd,
> > > > +                           char *buf, unsigned int buf_len)
> > > > +{
> > > > +       io->fd = fd;
> > > > +       io->buf_len = buf_len;
> > > > +       io->buf = buf;
> > > > +       io->end = buf;
> > > > +       io->data = buf;
> > > > +       io->eof = false;
> > > > +}
> > > > +
> > > > +/* Reads one character from the "io" file with similar semantics to fgetc. */
> > > > +static inline int io__get_char(struct io *io)
> > > > +{
> > > > +       char *ptr = io->data;
> > > > +
> > > > +       if (ptr == io->end) {
> > > > +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> > > > +
> > > > +               if (n <= 0) {
> > > > +                       io->eof = true;
> > > > +                       return -1;
> > > > +               }
> > > > +               ptr = &io->buf[0];
> > > > +               io->end = &io->buf[n];
> > > > +       }
> > > > +       io->data = ptr + 1;
> > > > +       return *ptr;
> > > > +}
> > > > +
> > > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> > > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > > + * after the hexadecimal value.
> > > > + */
> > > > +static inline int io__get_hex(struct io *io, __u64 *hex)
> > > > +{
> > > > +       bool first_read = true;
> > > > +
> > > > +       *hex = 0;
> > > > +       while (true) {
> > > > +               char ch = io__get_char(io);
> > > > +
> > >
> > > Maybe you can add this
> > >
> > >     if (io->eof)
> > >         return 0;
> > >
> > > Please see below
> > >
> > >
> > > > +               if (ch < 0)
> > > > +                       return ch;
> > > > +               if (ch >= '0' && ch <= '9')
> > > > +                       *hex = (*hex << 4) | (ch - '0');
> > > > +               else if (ch >= 'a' && ch <= 'f')
> > > > +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> > > > +               else if (ch >= 'A' && ch <= 'F')
> > > > +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> > > > +               else if (first_read)
> > > > +                       return -1;
> > > > +               else
> > > > +                       return ch;
> > > > +               first_read = false;
> > > > +       }
> > > > +}
> > >
> > > What if a file contains hex digits at the end (without trailing spaces)?
> > > I guess it'd see EOF and return -1, right?
> > >
> > > And it'd better to be clear when it sees a big hex numbers -
> > > it could have a comment that it'd simply discard upper bits
> > > or return an error.
> > >
> > > > +
> > > > +/* Read a decimal value into the out argument dec.
> > > > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > > > + * after the decimal value.
> > > > + */
> > > > +static inline int io__get_dec(struct io *io, __u64 *dec)
> > > > +{
> > > > +       bool first_read = true;
> > > > +
> > > > +       *dec = 0;
> > > > +       while (true) {
> > > > +               char ch = io__get_char(io);
> > > > +
> > > > +               if (ch < 0)
> > > > +                       return ch;
> > > > +               if (ch >= '0' && ch <= '9')
> > > > +                       *dec = (*dec * 10) + ch - '0';
> > > > +               else if (first_read)
> > > > +                       return -1;
> > > > +               else
> > > > +                       return ch;
> > > > +               first_read = false;
> > > > +       }
> > > > +}
> > >
> > > Ditto.
> > >
> > > Thanks
> > > Namhyung
> > >
> > >
> > > > +
> > > > +#endif /* __API_IO__ */
> > > > --
> > > > 2.26.0.rc2.310.g2932bb562d-goog
> > > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
