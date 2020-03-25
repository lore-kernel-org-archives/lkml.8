Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D9E2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jvkg5nCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCYVf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:35:59 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43312 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgCYVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:35:59 -0400
Received: by mail-yb1-f194.google.com with SMTP id o70so2048382ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM5tF24jxTWZD1wcuGGjp7ru29LzT/mQ5FW1gUutUcg=;
        b=Jvkg5nCBH7SaM73Ih/ExS64TqRps5KxwLAt5AkSNFbQ2NaFsbupv6ZGsL4OFXjHFQp
         zyOwTFAKLAVXhybap93Tqb5KTYsVXJ4B6jE76fXf1VLfLxv1MAYQ0N7X8NV1D6BaFVyO
         N/dUkhL9rIabj4iJk3Ltc3fnpLiu6NX6Yi2DfseSoW44F8xbzcJsI5qtGdAJEYvmOEGh
         Z/+G076l+5TTBNscJQ4WHEhkPNwRpfPgQerHBxDsMveMJ4gW79oWU2ea38I59pSPklOP
         glGfRnd5zX2Ix2xa9MMBoNFZdWLUscsAaCXtSx4Cvno7pVrGk8o85IUGonRtbxsPVJMj
         4YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM5tF24jxTWZD1wcuGGjp7ru29LzT/mQ5FW1gUutUcg=;
        b=Q6itPr5/75pQPceZr0WSDMah4xH1ak6OBl2RTrwXwslVxHOH0KiiNf32uEnyCwg7lV
         q5rpWzt20708vesyyfjv1+W4siDvazpYyaAz4SBujX5BTcCxjf5I1KBuAZITjET4lQPZ
         IHKpTic8gUbArVVL8bnt3bS9BQ1+jP8NWtS9Mrc991G3YyTxswha+p7d6BsAVuB12Z81
         IjommDkJKCWTi2tNOZTWr4Bov523RaI9eHHVYl+8ZVrX8UzNBQ57efPN3kYtQeVER5Q5
         UxC3uhxGLEMVBfsjWgcjgLMWLufaqfr/nyeA+T1ilGWXWJU1RCju8NMOs3VbqpI20bdi
         390A==
X-Gm-Message-State: ANhLgQ2yyxlmdJImPSM35wdSXjqg1biVMgKB6crHZ7p54ixMJM/qlxUj
        IOZ76yg1La0HNnKo1r7qH8qbIyH2BTZZa3NFBJau9Q==
X-Google-Smtp-Source: ADFU+vuqVso8c9jgap1aIZDGTidCgKYfx270CJryNHCPFX7CUmVG0fGeNNOqJwIZBgKz8DT8Qjc3y2UFprHn6+s2FiE=
X-Received: by 2002:a25:aaa4:: with SMTP id t33mr9126430ybi.324.1585172156837;
 Wed, 25 Mar 2020 14:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200325164022.41385-1-irogers@google.com> <20200325192539.GH14102@kernel.org>
In-Reply-To: <20200325192539.GH14102@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Mar 2020 14:35:45 -0700
Message-ID: <CAP-5=fV9LVmaeSsXaD_oA=SZHjY=nhXi-RgJFe0EXzWzBdjsOQ@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: add defensive null check
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:25 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Mar 25, 2020 at 09:40:22AM -0700, Ian Rogers escreveu:
> > Terms may have a null config in which case a strcmp will segv. This can
> > be reproduced with:
> >   perf stat -e '*/event=?,nr/' sleep 1
> > Add a null check to avoid this. This was caught by LLVM's libfuzzer.
>
> Adding the NULL check doesn't hurt, I guess, but I coudln't repro it:
>
>   [root@seventh ~]# perf stat -e '*/event=?,nr/' sleep 1
>   WARNING: multiple event parsing errors
>   event syntax error: '*/event=?,nr/'
>                       \___ 'nr' is not usable in 'perf stat'
>
>   Initial error:
>   event syntax error: '*/event=?,nr/'
>                        \___ Cannot find PMU `*'. Missing kernel support?
>   Run 'perf list' for a list of valid events
>
>    Usage: perf stat [<options>] [<command>]
>
>       -e, --event <event>   event selector. use 'perf list' to list available events
>   [root@seventh ~]#
>
> Does this take place only when libfuzzer is being used?

Good catch! I was driving the repro through the fuzzer and getting the
stack trace below and had assumed this would repro on the command
line. I'm now wondering why it won't reproduce :-) I suspect this
issue can come up in other scenarios so as you say the null check
won't hurt, but the commit message is incorrect.

#0  __interceptor_strcmp ()
    at llvm/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:448
#1  0x0000555557345eb2 in pmu_resolve_param_term (term=0x607000081190,
head_terms=0x602000007cb0,
    value=0x7ffff4cc0320) at tools/perf/util/pmu.c:994
#2  0x00005555573389a4 in pmu_config_term (formats=0x6080000012c8,
attr=0x7ffff4dd4e20,
    term=0x607000081190, head_terms=0x602000007cb0, zero=false,
err=0x7ffff4c90020)
    at tools/perf/util/pmu.c:1117
#3  0x0000555557337b4e in perf_pmu__config_terms
(formats=0x6080000012c8, attr=0x7ffff4dd4e20,
    head_terms=0x602000007cb0, zero=false, err=0x7ffff4c90020)
    at tools/perf/util/pmu.c:1154
#4  0x0000555557338f7e in perf_pmu__config (pmu=0x6080000012a0,
attr=0x7ffff4dd4e20,
    head_terms=0x602000007cb0, err=0x7ffff4c90020)
    at tools/perf/util/pmu.c:1174
#5  0x0000555557314027 in parse_events_add_pmu
(parse_state=0x7ffff4c900a0, list=0x602000007e10,
    name=0x602000001910 "uncore_cha_1", head_config=0x602000007cb0,
auto_merge_stats=true,
    use_alias=false) at tools/perf/util/parse-events.c:1485
#6  0x0000555556d257f9 in parse_events_parse
(_parse_state=0x7ffff4c900a0, scanner=0x611000000cc0)
    at tools/perf/util/parse-events.y:318
#7  0x000055555731c573 in parse_events__scanner (str=0x7ffff4d85c40
"*/event=?,nr/",
    parse_state=0x7ffff4c900a0, start_token=258)
    at tools/perf/util/parse-events.c:2026
#8  0x000055555731cbc3 in parse_events (evlist=0x61e000000080,
str=0x7ffff4d85c40 "*/event=?,nr/",
    err=0x7ffff4c90020) at tools/perf/util/parse-events.c:2066

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 616fbda7c3fc..ef6a63f3d386 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -984,12 +984,11 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
> >       struct parse_events_term *t;
> >
> >       list_for_each_entry(t, head_terms, list) {
> > -             if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
> > -                     if (!strcmp(t->config, term->config)) {
> > -                             t->used = true;
> > -                             *value = t->val.num;
> > -                             return 0;
> > -                     }
> > +             if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM &&
> > +                 t->config && !strcmp(t->config, term->config)) {
> > +                     t->used = true;
> > +                     *value = t->val.num;
> > +                     return 0;
> >               }
> >       }
> >
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
> --
>
> - Arnaldo
