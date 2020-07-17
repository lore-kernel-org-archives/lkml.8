Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C050C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CEC2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN/uIpUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGQO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGQO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:27:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D76C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:27:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so5518799plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z0oSgdwYRPiokDQMgtgcehr0uyxaEp6VXyiWo3WZ3mk=;
        b=pN/uIpUQtdL/QX2u1vow40HFw9Jpqi9umoP7RVtwB1HKdKqe3jhXx+rkK1xuLfh/cR
         Cu8fnM5QSVYf6EBPdO5jUFAyHp2rKjHgvCP4rdYAKzJV0VcXJTL0Dt32kC2cNayLLknn
         FrzuMFJtWxyOlO770mGdl2mRCv68fzkrepNuJDT5n9uOFS9RhuVg9nTcu+KGx/7Ep1Ai
         KJf3wznPfnyPgMB1axmu8ZawNzB/p11LRf7dRfouE9mj0DuFGAmBbVjw9nXLR1hGE913
         C0xfTK7hxBkqNX9QqvTjJjANYnFwvEp7VEw7MXk3w/TQqregR7oUV36F8vOjkuYU41eq
         T+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0oSgdwYRPiokDQMgtgcehr0uyxaEp6VXyiWo3WZ3mk=;
        b=S0PQFT3iQZ8JqmZGFDSbOqToNTDzR8tcAek74HgfgV6ix4+aUbp/4nq6c1ueEJ/TEK
         LhNZFGDa6YnQ4OrilQ1z1WuYi7lolm2CXXnilVD68meiB/3RLOAUSGwaYYXw5es29MJX
         IK55COZjNIR8IgCRO5xUj3SHflxu8G5riMRH/osRlswQ11mgKXNrnUtFILGgRmnb2yPd
         38bTYVQvPagEVr13fo5us0Nuw+27hw9nhHFcVa2Y4Qggnt+B21Hg3s2aR1utH2q4hIA6
         h8COMmp2Z10JKJ1Ip4WoblSXhcLUn+6qZDv3d8M5mhmJWqw4JBFm/+Cisxa/jwqaEOcu
         bXLw==
X-Gm-Message-State: AOAM532f45UrBwZCcsJjBmLMUyx9ZWrZZjajZPiGH3aEm3leYw8GGRzZ
        kl6rlPNm34J679JQa5Et7UcGO0D1UzE=
X-Google-Smtp-Source: ABdhPJz5B2CfEFDNa9gbTWp7S8Dg2/n5apKLILDmg1zlRTRPJhTzN5MIwHKm7ez+TR7YPlo1Frp0hQ==
X-Received: by 2002:a17:90a:ab96:: with SMTP id n22mr10314994pjq.52.1594996059456;
        Fri, 17 Jul 2020 07:27:39 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a2sm8036656pfg.120.2020.07.17.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:27:38 -0700 (PDT)
Date:   Fri, 17 Jul 2020 22:27:27 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/17] perf ftrace: add option '--inherit' to trace
 children processes
Message-ID: <20200717142727.qg6pmql73secc5xp@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-8-changbin.du@gmail.com>
 <CAM9d7cgBeHW_Ot2nfBAzbV73gNKiOzp7K5KoTO=V4k=MGrZS6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgBeHW_Ot2nfBAzbV73gNKiOzp7K5KoTO=V4k=MGrZS6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:59:56AM +0900, Namhyung Kim wrote:
> On Sat, Jul 11, 2020 at 9:42 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This adds an option '--inherit' to allow us trace children
> > processes spawned by our target.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > ---
> > v2: option name '--trace-children' -> '--inherit'.
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  3 ++
> >  tools/perf/builtin-ftrace.c              | 38 ++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index 98fe01d354d1..fd632bd9b2c1 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -61,6 +61,9 @@ OPTIONS
> >         Set the size of per-cpu tracing buffer, <size> is expected to
> >         be a number with appended unit character - B/K/M/G.
> >
> > +--inherit::
> > +       Trace children processes spawned by our target.
> > +
> >  -T::
> >  --trace-funcs=::
> >         Only trace functions given by the argument.  Multiple functions
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 887e78b23a82..4efaa7b6a906 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -39,6 +39,7 @@ struct perf_ftrace {
> >         struct list_head        nograph_funcs;
> >         int                     graph_depth;
> >         unsigned long           percpu_buffer_size;
> > +       bool                    inherit;
> >  };
> >
> >  struct filter_entry {
> > @@ -177,9 +178,27 @@ static int write_tracing_file_int(const char *name, int value)
> >         return 0;
> >  }
> >
> > +static int write_tracing_option_file(const char *name, const char *val)
> > +{
> > +       char *file;
> > +       int ret;
> > +
> > +       if (asprintf(&file, "options/%s", name) < 0)
> > +               return -1;
> > +
> > +       ret = __write_tracing_file(file, val, false);
> > +       free(file);
> > +       return ret;
> > +}
> > +
> >  static int reset_tracing_cpu(void);
> >  static void reset_tracing_filters(void);
> >
> > +static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> > +{
> > +       write_tracing_option_file("function-fork", "0");
> > +}
> > +
> >  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> >  {
> >         if (write_tracing_file("tracing_on", "0") < 0)
> > @@ -198,6 +217,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> >                 return -1;
> >
> >         reset_tracing_filters();
> > +       reset_tracing_options(ftrace);
> >         return 0;
> >  }
> >
> > @@ -336,6 +356,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
> >         return 0;
> >  }
> >
> > +static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
> > +{
> > +       if (!ftrace->inherit)
> > +               return 0;
> > +
> > +       if (write_tracing_option_file("function-fork", "1") < 0)
> > +               return -1;
> > +
> > +       return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >         char *trace_file;
> > @@ -405,6 +436,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >                 goto out_reset;
> >         }
> >
> > +       if (set_tracing_trace_inherit(ftrace) < 0) {
> > +               pr_err("failed to set tracing option function-fork\n");
> > +               goto out_reset;
> > +       }
> 
> Can we have set_tracing_options() here instead to make
> the __cmd_ftrace() shorter?  It'd set other options added later.
> It's also symmetric to reset_tracing_options().
>
I appended a patch to do this. Thanks for your suggestion.

> Thanks
> Namhyung
> 
> > +
> >         if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >                 pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >                 goto out_reset;
> > @@ -599,6 +635,8 @@ int cmd_ftrace(int argc, const char **argv)
> >                     "Max depth for function graph tracer"),
> >         OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
> >                      "size of per cpu buffer", parse_buffer_size),
> > +       OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
> > +                   "trace children processes"),
> >         OPT_END()
> >         };
> >
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
