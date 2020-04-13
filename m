Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E15720678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGB+nycY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgDMQWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731410AbgDMQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:22:05 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905BC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:22:05 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id t10so5516170ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aueNGgz6u3sNtqkhsSGk625u8jz/OXUXnCvNarHkXT8=;
        b=hGB+nycYyNsDh4L32k/R1uYGR4IRpyEYRsOwgkriU5fTc8OksiLctdiTLpU2s073vl
         MAG+w+dgbosjLaBxj8qWlIwAgzfTwk2MRMc3zgWHL5vev1K0SzQJEvl74VC3Ypn6f8hw
         IQU9E8jisraw6BFfntWvn6gqQxXSa2bDF5nzRvFB/hgU0LKQnL/krN0qOt5buKck2Yal
         BN0+s1mHskAl9JPblhCLHdNvdmiy1bzQkJTeIOwYOHLqTZBrOWuKjB4/XQSU35G2E7Fq
         Abq8DxVMV6iQxyKR41OCwoF9JO538QbEibpUkdbQI3ZgPDyGEpFAY4uqWqfxcnT1wdAD
         T3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aueNGgz6u3sNtqkhsSGk625u8jz/OXUXnCvNarHkXT8=;
        b=Qpln/i9r0cgYCSdjn43aZdI7YSkgSROzXN51hVnHfFK14acFAuMn3BBVlhonL0NN9L
         S+ei6TccLhXufq7kHnJ7BMVP4GT6lGR+DRcNuFFqVoLVhDkoAMtzWk84Oe52QUdhr2Yh
         gcmRik+LhkYTi02NsORU374tM0ba+jO+R3mGvmTxqDGGb+2d5zKhB3uy2zasiij6WXdM
         DCPMglRp2WcfUO69OCV/XtXYCKdHXFrMgyYf0sVCz9aWLSZ/+1FLo9xnkngyAp+Da2hr
         FJZYw/5fAgTLQMfNe0gytP2bPhQNKPC7i6QEsvXCzZrvWA5AYJPz5kaH6RPP0I0i34vS
         /tqQ==
X-Gm-Message-State: AGi0PuZkvdfQLAxF7wcr8SD+HEdbkIfvYLZud2p+WXvp6DGhW1uh0TSU
        /+l4zrHgYKjTFH+39/bVLH6bgzHduULfSiMfd0XMdg==
X-Google-Smtp-Source: APiQypIt2LisAlLfGLmw/+IXHMYb9k9Pia4hK9rSJOo3OZHgZQyGjIXO9+invjB/a7PiPX9vABydpaTJmz8GIdJm9p4=
X-Received: by 2002:a25:be81:: with SMTP id i1mr28871733ybk.184.1586794924465;
 Mon, 13 Apr 2020 09:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200411064248.247530-1-irogers@google.com> <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
In-Reply-To: <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Apr 2020 09:21:53 -0700
Message-ID: <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
To:     Namhyung Kim <namhyung@kernel.org>
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

On Mon, Apr 13, 2020 at 12:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The synthesize benchmark shows the majority of execution time going to
> > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > reading library that will be used to replace these calls in a follow-up
> > CL. Add tests for the library to perf test.
> >
> > v4 adds the test file missed in v3.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> > + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> > + * returns the character after the hexadecimal value which may be -1 for eof.
>
> I'm not sure returning -1 is good when it actually reads something and
> meets EOF.
> Although it would have a valid value, users might consider it an error IMHO.
> Why not returning 0 instead? (I'm ok with -1 for the later use of the API).

Thanks for the feedback! In the code for /proc/pid/maps this is a
hypothetical, but I think having the API right is important. I didn't
go with 0 as you mention 0 'could' encode a character, for example,
7fffabcd\0 wouldn't be distinguishable from 7fffabcd<EOF>. The updated
code distinguishes the cases as 0 meaning character \0, -1 meaning EOF
and -2 meaning bad encoding. Your worry is that a hex number that's
next to EOF will get a result of -1 showing the EOF came next. and
code that does 'if ( .. < 0)' would trigger. While clunky, it'd be
possible in those cases to change the code to 'if ( .. < -1)'. So my
thoughts are:
1) being able to tell apart the 3 cases could be important - this is
all hypothetical;
2) keeping EOF and error as negative numbers has a degree of consistency;
3) using -1 for EOF comes from get_char, it'd be nice to have one
value mean EOF.
Perhaps the issue is the name of the function? It isn't a standard API
to return the next character, but it simplified things for me as I
didn't need to add a 'rewind' operation. The function names could be
something like io__get_hex_then_char and io__get_dec_then_char, EOF
for the 'then_char' part would be more consistent. I'd tried to keep
the names short and have a load bearing comment, which isn't ideal but
generally I believe the style is that function names are kept short.
Let me know what you think.

Thanks,
Ian

> > + * If the read value is larger than a u64 the high-order bits will be dropped.
> > + */
> > +static inline int io__get_hex(struct io *io, __u64 *hex)
> > +{
> > +       bool first_read = true;
> > +
> > +       *hex = 0;
> > +       while (true) {
> > +               int ch = io__get_char(io);
> > +
> > +               if (ch < 0)
> > +                       return ch;
> > +               if (ch >= '0' && ch <= '9')
> > +                       *hex = (*hex << 4) | (ch - '0');
> > +               else if (ch >= 'a' && ch <= 'f')
> > +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> > +               else if (ch >= 'A' && ch <= 'F')
> > +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> > +               else if (first_read)
> > +                       return -2;
> > +               else
> > +                       return ch;
> > +               first_read = false;
> > +       }
> > +}
> > +
> > +/* Read a positive decimal value with out argument dec. If the first character
> > + * isn't a decimal returns -2, io->eof returns -1, otherwise returns the
> > + * character after the decimal value which may be -1 for eof. If the read value
> > + * is larger than a u64 the high-order bits will be dropped.
>
> Ditto.
>
> Thanks
> Namhyung
>
>
> > + */
> > +static inline int io__get_dec(struct io *io, __u64 *dec)
> > +{
> > +       bool first_read = true;
> > +
> > +       *dec = 0;
> > +       while (true) {
> > +               int ch = io__get_char(io);
> > +
> > +               if (ch < 0)
> > +                       return ch;
> > +               if (ch >= '0' && ch <= '9')
> > +                       *dec = (*dec * 10) + ch - '0';
> > +               else if (first_read)
> > +                       return -2;
> > +               else
> > +                       return ch;
> > +               first_read = false;
> > +       }
> > +}
> > +
> > +#endif /* __API_IO__ */
