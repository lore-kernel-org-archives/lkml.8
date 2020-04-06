Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E0422284
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtFgLkj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgDFOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:09:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41382 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgDFOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:09:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so12864580qtv.8;
        Mon, 06 Apr 2020 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G1rSBURl2zWm9/ISfqkcj4HvKPnz52goe6oMKSgf0oI=;
        b=rtFgLkj0p2RrTrAWhHybESc3oB+VWTYbUa2PeYE/n6ibqiHBMkcCsI9h+iBlU7mER2
         3djYK5HzlapCimAAbDZ40sLBTdS88FINSzM56xLra7q+/FUmeLK7MRqT1bCptMiyuPay
         8R2i0XXqySVKQg+BLYHP8yCLgcEvdumbhEB4IEApLhPf5yd5K9fyOwApT3zcH97+2QRt
         bzwwIKg9KoMUGrH+CJpK8KjmJIPhi33BIu5FESwQVCX39OsRjUbr42JkfWpSWClpD1vq
         eZa3fdcq3l6gmjoPsyDKYFAdwHQtzdEfoG0P+JryG4BFzMMhb7VqXLOU+Xei+wDnR3B8
         pi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1rSBURl2zWm9/ISfqkcj4HvKPnz52goe6oMKSgf0oI=;
        b=QlOyNUy9hSZAPjzXMZbae2o75vvXA+LXbCwXawd32ukY/YMFS9emNN8CID6Pda4nje
         2P27ijkw8o0zcnINbddRFEX2ZTDqO8qUfAqD2An3lNZTtWI4dOsu2xhs9ZRlSPMEtwTR
         K1A8oj8cHWmwSjg5Qaa5TMXPW4VfXMVf15fMUC7hFFg/G85JyrKHgdK4NZ1QOjBB5DfJ
         +hHAcHml9a5Hv4SOzBmB4IUbjBDlsvQaic/7pAemJRn/jy3kRUi1LzHrbmMPOdzqLBxg
         Q1h1RN389EWpJsacfPxOD/SpTZs7qPYBgYKrS6gdUTdudYWofG4B09WTsWgG1X/rsmSN
         lZlg==
X-Gm-Message-State: AGi0PuZmMFsrKlwz8/aE0P/k8qsKxsGYHJX8r/uu/6QOwzBSFgMd9BB6
        4woeVTjTlcaFjikacFn+cN4=
X-Google-Smtp-Source: APiQypJiFuilmxySOSTcg4mbSaBEqnkoUgeoSO7gspSBdPAvYJD/ohLgnqVe/A6XH3xNinJWn0+GqQ==
X-Received: by 2002:ac8:674a:: with SMTP id n10mr8395633qtp.150.1586182194189;
        Mon, 06 Apr 2020 07:09:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h138sm14600509qke.86.2020.04.06.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:09:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53F96409A3; Mon,  6 Apr 2020 11:09:51 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:09:51 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <20200406140951.GE29826@kernel.org>
References: <20200402154357.107873-1-irogers@google.com>
 <20200402154357.107873-5-irogers@google.com>
 <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 04, 2020 at 12:06:45PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The synthesize benchmark shows the majority of execution time going to
> > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > reading library that will be used to replace these calls in a follow-up
> > CL.

waiting for some conclusion to this thread,

- Arnaldo

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 tools/lib/api/io.h
> >
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > new file mode 100644
> > index 000000000000..5aa5b0e26a7a
> > --- /dev/null
> > +++ b/tools/lib/api/io.h
> > @@ -0,0 +1,107 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Lightweight buffered reading library.
> > + *
> > + * Copyright 2019 Google LLC.
> > + */
> > +#ifndef __API_IO__
> > +#define __API_IO__
> > +
> > +struct io {
> > +       /* File descriptor being read/ */
> > +       int fd;
> > +       /* Size of the read buffer. */
> > +       unsigned int buf_len;
> > +       /* Pointer to storage for buffering read. */
> > +       char *buf;
> > +       /* End of the storage. */
> > +       char *end;
> > +       /* Currently accessed data pointer. */
> > +       char *data;
> > +       /* Set true on when the end of file on read error. */
> > +       bool eof;
> > +};
> > +
> > +static inline void io__init(struct io *io, int fd,
> > +                           char *buf, unsigned int buf_len)
> > +{
> > +       io->fd = fd;
> > +       io->buf_len = buf_len;
> > +       io->buf = buf;
> > +       io->end = buf;
> > +       io->data = buf;
> > +       io->eof = false;
> > +}
> > +
> > +/* Reads one character from the "io" file with similar semantics to fgetc. */
> > +static inline int io__get_char(struct io *io)
> > +{
> > +       char *ptr = io->data;
> > +
> > +       if (ptr == io->end) {
> > +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> > +
> > +               if (n <= 0) {
> > +                       io->eof = true;
> > +                       return -1;
> > +               }
> > +               ptr = &io->buf[0];
> > +               io->end = &io->buf[n];
> > +       }
> > +       io->data = ptr + 1;
> > +       return *ptr;
> > +}
> > +
> > +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > + * after the hexadecimal value.
> > + */
> > +static inline int io__get_hex(struct io *io, __u64 *hex)
> > +{
> > +       bool first_read = true;
> > +
> > +       *hex = 0;
> > +       while (true) {
> > +               char ch = io__get_char(io);
> > +
> 
> Maybe you can add this
> 
>     if (io->eof)
>         return 0;
> 
> Please see below
> 
> 
> > +               if (ch < 0)
> > +                       return ch;
> > +               if (ch >= '0' && ch <= '9')
> > +                       *hex = (*hex << 4) | (ch - '0');
> > +               else if (ch >= 'a' && ch <= 'f')
> > +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> > +               else if (ch >= 'A' && ch <= 'F')
> > +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> > +               else if (first_read)
> > +                       return -1;
> > +               else
> > +                       return ch;
> > +               first_read = false;
> > +       }
> > +}
> 
> What if a file contains hex digits at the end (without trailing spaces)?
> I guess it'd see EOF and return -1, right?
> 
> And it'd better to be clear when it sees a big hex numbers -
> it could have a comment that it'd simply discard upper bits
> or return an error.
> 
> > +
> > +/* Read a decimal value into the out argument dec.
> > + * Returns -1 on error or if nothing is read, otherwise returns the character
> > + * after the decimal value.
> > + */
> > +static inline int io__get_dec(struct io *io, __u64 *dec)
> > +{
> > +       bool first_read = true;
> > +
> > +       *dec = 0;
> > +       while (true) {
> > +               char ch = io__get_char(io);
> > +
> > +               if (ch < 0)
> > +                       return ch;
> > +               if (ch >= '0' && ch <= '9')
> > +                       *dec = (*dec * 10) + ch - '0';
> > +               else if (first_read)
> > +                       return -1;
> > +               else
> > +                       return ch;
> > +               first_read = false;
> > +       }
> > +}
> 
> Ditto.
> 
> Thanks
> Namhyung
> 
> 
> > +
> > +#endif /* __API_IO__ */
> > --
> > 2.26.0.rc2.310.g2932bb562d-goog
> >

-- 

- Arnaldo
