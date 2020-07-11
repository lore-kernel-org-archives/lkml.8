Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129F5206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOacYYyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGKMTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGKMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:19:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F127C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:19:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so3330133pld.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3VoxAVyfvGSyy1qH0WPeEcXvaJrXVn2jeakgGUmqbJA=;
        b=SOacYYyqBg0qZnd0TNoifYk05Si+nVzJibtvZogmrYe8jRHW1KDZ0HbPVxuOdVsbA7
         Bj/5VzR1AxVgvkwiPlZTzITeSsvZPEW1cINLirTCmpb+lPaz8KhiQbmskAGf1K/Ugr12
         VFmHHDBmenJEh1RcN/fm+sCt8kG8g6w2D9Sgh7yzrVVJ2PC6YJNsNeE1q+UUYHo02VS+
         CGSmmEZ3RFJ5JDFG90tsLB5//fC5lG91q9T5Tv2bic1Op6ixsJJoLk0X+lxLIFF4BwAE
         RXni0TBMEOibCVvPj7d2/+U81vdXnkC4qNUIdLLnz5EG8l1239mb6gYuYxXiPQ3fa7rv
         b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VoxAVyfvGSyy1qH0WPeEcXvaJrXVn2jeakgGUmqbJA=;
        b=XpvMa6a0dj2xrKFJTGB5uyDv591s/puqBuNQX118Cee4WHdbUmAlTwQHr11aOfpfOo
         Aq5YW4t+lEqATuFwXqMI+Wt5GMj5cpw1m5HqK3Kczxk7hbuSbVA8jYz1JstcIBRJvGVs
         1mJyzQCKUSUq4Tu2PpclVzmOjMJc6KQ1mdOj1KONOy2JADE14m9COTc7GHk/uE1AOIee
         NXwQWl/HlMEGyN0EXVzljyJi50Aw1Im7+NA+jzx7YdsAI0mbQt7VHBFm6wKq5gm1HUvR
         fW6ThmFo8VkVw/wc8Z51X4JPecxwkPgITAWaTaRwvWal/CWS3ZwKzqwGwq+gCCfwFil/
         vU+w==
X-Gm-Message-State: AOAM531Ikn4UOML/hjNWKoyd3sKhodeBzm+W/PqNMYCszVcFMaT+gVwT
        zCLffqolh34ia1hAawRQ0Ac=
X-Google-Smtp-Source: ABdhPJxPxlB9lzML+Rw1tngAsIsL5C+U4G7n4d4Z+uaP+pgHQSnppIjLA+nUEcNfy7Gysn3ZCrb7Hw==
X-Received: by 2002:a17:90a:784c:: with SMTP id y12mr9713221pjl.16.1594469982956;
        Sat, 11 Jul 2020 05:19:42 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id o4sm8695668pjo.16.2020.07.11.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:19:42 -0700 (PDT)
Date:   Sat, 11 Jul 2020 20:19:33 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] perf ftrace: select function/function_graph
 tracer automatically
Message-ID: <20200711121933.sgsprjjibflddkgu@mail.google.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
 <20200710134322.15400-2-changbin.du@gmail.com>
 <CAM9d7cgZFrakd5n=ZekQNS2WSa9nrnmaU1FxiRHxVrUEviUD4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgZFrakd5n=ZekQNS2WSa9nrnmaU1FxiRHxVrUEviUD4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:14:05PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jul 10, 2020 at 10:43 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > The '-g/-G' options have already implied function_graph tracer should be
> > used instead of function tracer. So the extra option '--tracer' can be
> > killed.
> >
> > This patch changes the behavior as below:
> >   - By default, function tracer is used.
> >   - If '-g' or '-G' option is on, then function_graph tracer is used.
> >   - The perf configuration item 'ftrace.tracer' is marked as deprecated.
> >   - The option '--tracer' is marked as deprecated.
> >
> > Here are some examples.
> >
> > This will start tracing all functions using function tracer:
> >   $ sudo perf ftrace
> >
> > This will trace all functions using function graph tracer:
> >   $ sudo perf ftrace -G
> 
> If you removed the default value, this doesn't work, right?
>
yes, I forgot to update this commit message. Thanks.

> Thanks
> Namhyung
> 
> >
> > This will trace function vfs_read using function graph tracer:
> >   $ sudo perf ftrace -G vfs_read
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > ---
> > v3: remove default '*' for -G/-T.
> > ---
> >  tools/perf/Documentation/perf-config.txt |  5 -----
> >  tools/perf/Documentation/perf-ftrace.txt |  2 +-
> >  tools/perf/builtin-ftrace.c              | 15 ++++++++++-----
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> > index c7d3df5798e2..a25fee7de3b2 100644
> > --- a/tools/perf/Documentation/perf-config.txt
> > +++ b/tools/perf/Documentation/perf-config.txt
> > @@ -612,11 +612,6 @@ trace.*::
> >                 "libbeauty", the default, to use the same argument beautifiers used in the
> >                 strace-like sys_enter+sys_exit lines.
> >
> > -ftrace.*::
> > -       ftrace.tracer::
> > -               Can be used to select the default tracer. Possible values are
> > -               'function' and 'function_graph'.
> > -
> >  llvm.*::
> >         llvm.clang-path::
> >                 Path to clang. If omit, search it from $PATH.
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index b80c84307dc9..952e46669168 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -24,7 +24,7 @@ OPTIONS
> >
> >  -t::
> >  --tracer=::
> > -       Tracer to use: function_graph or function.
> > +       Tracer to use: function_graph or function. This option is deprecated.
> >
> >  -v::
> >  --verbose=::
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 2bfc1b0db536..5f53da87040d 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -27,7 +27,6 @@
> >  #include "util/cap.h"
> >  #include "util/config.h"
> >
> > -#define DEFAULT_TRACER  "function_graph"
> >
> >  struct perf_ftrace {
> >         struct evlist           *evlist;
> > @@ -419,6 +418,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
> >         if (strcmp(var, "ftrace.tracer"))
> >                 return -1;
> >
> > +       pr_warning("Configuration ftrace.tracer is deprecated\n");
> >         if (!strcmp(value, "function_graph") ||
> >             !strcmp(value, "function")) {
> >                 ftrace->tracer = value;
> > @@ -459,7 +459,7 @@ int cmd_ftrace(int argc, const char **argv)
> >  {
> >         int ret;
> >         struct perf_ftrace ftrace = {
> > -               .tracer = DEFAULT_TRACER,
> > +               .tracer = "function",
> >                 .target = { .uid = UINT_MAX, },
> >         };
> >         const char * const ftrace_usage[] = {
> > @@ -469,7 +469,7 @@ int cmd_ftrace(int argc, const char **argv)
> >         };
> >         const struct option ftrace_options[] = {
> >         OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> > -                  "tracer to use: function_graph(default) or function"),
> > +                  "tracer to use: function or function_graph (This option is deprecated)"),
> >         OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >                    "trace on existing process id"),
> >         OPT_INCR('v', "verbose", &verbose,
> > @@ -479,11 +479,13 @@ int cmd_ftrace(int argc, const char **argv)
> >         OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
> >                     "list of cpus to monitor"),
> >         OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> > -                    "trace given functions only", parse_filter_func),
> > +                    "trace given functions using function tracer",
> > +                    parse_filter_func),
> >         OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
> >                      "do not trace given functions", parse_filter_func),
> >         OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> > -                    "Set graph filter on given functions", parse_filter_func),
> > +                    "trace given functions using function_graph tracer",
> > +                    parse_filter_func),
> >         OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
> >                      "Set nograph filter on given functions", parse_filter_func),
> >         OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
> > @@ -505,6 +507,9 @@ int cmd_ftrace(int argc, const char **argv)
> >         if (!argc && target__none(&ftrace.target))
> >                 ftrace.target.system_wide = true;
> >
> > +       if (!list_empty(&ftrace.graph_funcs) || !list_empty(&ftrace.nograph_funcs))
> > +               ftrace.tracer = "function_graph";
> > +
> >         ret = target__validate(&ftrace.target);
> >         if (ret) {
> >                 char errbuf[512];
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
