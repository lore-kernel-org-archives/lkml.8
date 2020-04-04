Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3163C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7E2072B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585969621;
	bh=lBveRU6I+35YUN2TBdvk55OMyTB/c/h7LVpeP+itP68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tN+CY8tKrmknkti5H+bVas4ZYi0IMqU9ovcfD7iiIALeEhHr0AaA6d+aVPi0JNeTl
	 QNcAOYnpAfGgxi7IkftbhG5bvrBDbVYcgAuYATq5gIBSqBM/o/osyXGGMyL/EdN3ma
	 OC9Ff5fQ7q5ODh4pNLU7P7KVVKi4RzzZOEQAOVSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgDDDHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:07:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDDG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:06:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so10830136wrm.4;
        Fri, 03 Apr 2020 20:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouo8YgQXgd8HZdIcFAs9JsZCfSyjmHHb73eHEoHdLM0=;
        b=gGRJyi3uQZvv5ne4zHC82wJnLZBoTKPzf20+JSn/ACyfc+3mC6GUehHJaBgcb7dWNQ
         rObQWLNY3LsztfwcHw/0w6GZzoQm0hr2lZ61rRmu+vB3PwfxeteW2stQYck3jRLVurjx
         D3KklJnhwtU50YLu8KPQQ3r1Zjb9GsNqMyZha4ikNd5oztxTnjeQjbXYUn5+efJKOphc
         /exDE3jkTswl7izi1mbO7qiamP0SR5924g1lysv8MPmmoGsK3F6ATFpJV+OOAppcMfUw
         fVjo/tQODjdec+Cvq/ziD3YwlPBFCOzqtaz3R5gxpeMBcxtqVQy7xi4TP9t5Y1R8Ii3G
         8TuA==
X-Gm-Message-State: AGi0PuZIxzH2PrY1S1Nwb5ksUvw4CsDz7JFoygTfEIGNNSs7O9yM5XO/
        ji7tyrSu9zMjF5/y7LXPuAtGM6h5EBl3JDBKX1M=
X-Google-Smtp-Source: APiQypIWXdRiyTwWl+jXn+9G+GOarvnceKnKtjoe/itIgd8DLoJ8lW9CEdZ8LrTar/YCU06bMSe+k2MtS7f88+y9B3M=
X-Received: by 2002:adf:ff85:: with SMTP id j5mr45751wrr.332.1585969617019;
 Fri, 03 Apr 2020 20:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com> <20200402154357.107873-5-irogers@google.com>
In-Reply-To: <20200402154357.107873-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 4 Apr 2020 12:06:45 +0900
Message-ID: <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tools api: add a lightweight buffered reading api
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Hello,

On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
>
> The synthesize benchmark shows the majority of execution time going to
> fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> reading library that will be used to replace these calls in a follow-up
> CL.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 tools/lib/api/io.h
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> new file mode 100644
> index 000000000000..5aa5b0e26a7a
> --- /dev/null
> +++ b/tools/lib/api/io.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Lightweight buffered reading library.
> + *
> + * Copyright 2019 Google LLC.
> + */
> +#ifndef __API_IO__
> +#define __API_IO__
> +
> +struct io {
> +       /* File descriptor being read/ */
> +       int fd;
> +       /* Size of the read buffer. */
> +       unsigned int buf_len;
> +       /* Pointer to storage for buffering read. */
> +       char *buf;
> +       /* End of the storage. */
> +       char *end;
> +       /* Currently accessed data pointer. */
> +       char *data;
> +       /* Set true on when the end of file on read error. */
> +       bool eof;
> +};
> +
> +static inline void io__init(struct io *io, int fd,
> +                           char *buf, unsigned int buf_len)
> +{
> +       io->fd = fd;
> +       io->buf_len = buf_len;
> +       io->buf = buf;
> +       io->end = buf;
> +       io->data = buf;
> +       io->eof = false;
> +}
> +
> +/* Reads one character from the "io" file with similar semantics to fgetc. */
> +static inline int io__get_char(struct io *io)
> +{
> +       char *ptr = io->data;
> +
> +       if (ptr == io->end) {
> +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> +
> +               if (n <= 0) {
> +                       io->eof = true;
> +                       return -1;
> +               }
> +               ptr = &io->buf[0];
> +               io->end = &io->buf[n];
> +       }
> +       io->data = ptr + 1;
> +       return *ptr;
> +}
> +
> +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the hexadecimal value.
> + */
> +static inline int io__get_hex(struct io *io, __u64 *hex)
> +{
> +       bool first_read = true;
> +
> +       *hex = 0;
> +       while (true) {
> +               char ch = io__get_char(io);
> +

Maybe you can add this

    if (io->eof)
        return 0;

Please see below


> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *hex = (*hex << 4) | (ch - '0');
> +               else if (ch >= 'a' && ch <= 'f')
> +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> +               else if (ch >= 'A' && ch <= 'F')
> +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> +               else if (first_read)
> +                       return -1;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}

What if a file contains hex digits at the end (without trailing spaces)?
I guess it'd see EOF and return -1, right?

And it'd better to be clear when it sees a big hex numbers -
it could have a comment that it'd simply discard upper bits
or return an error.

> +
> +/* Read a decimal value into the out argument dec.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the decimal value.
> + */
> +static inline int io__get_dec(struct io *io, __u64 *dec)
> +{
> +       bool first_read = true;
> +
> +       *dec = 0;
> +       while (true) {
> +               char ch = io__get_char(io);
> +
> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *dec = (*dec * 10) + ch - '0';
> +               else if (first_read)
> +                       return -1;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}

Ditto.

Thanks
Namhyung


> +
> +#endif /* __API_IO__ */
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
