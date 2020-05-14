Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C782065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXbcGZPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgENWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgENWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:41:40 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8714AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:41:39 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id s37so95133ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VP7VFrpLx9+7zavNiPF4upyf8a0jJr6Pd2wVgsM8FEU=;
        b=CXbcGZPRh61YqMS5n5nKa2yXWpw1FMvimDyryPuY+qg8BNN0pqXrfagDSgvy28KKOV
         7Hbnkh8tWoJYas/OJUDoJkzh/GipkESuIsFsB/hf1xT5/xsajMko0tT1qXi1UvtYerd1
         mBWbGD/ni7PpptTtrPwm6BQSKx7fxUm4+C98aRmbxjS4+qANciEh4d7M5jJn7Men447x
         azfOtzeWw1gPeIE4HP5tYqLIVh9Gty14TZfj+SRPPd5OtG9WVZ4EALxPbMOeEMP8wu6w
         BZXIxMmIITcQz7gDxHeO8e5ZUFpwO1KoTOyM1ZP/0tYFGU4xbB/+I5dsccDjPWx4e9o5
         QA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VP7VFrpLx9+7zavNiPF4upyf8a0jJr6Pd2wVgsM8FEU=;
        b=XpMK4XtbLdCXhX17NNTz2qUHXaa1fZevSGuCoV5F0zxJtaoQTjdpprrwDTQPNPSw5E
         ZEmqDWVpqjYfoZORwPbI7Idrcu8XuAAomK/BycG4ThDIhWj5VaEDBlM2cujBlMOjgxSs
         YyQxj6KjaWFRAJLga51+rsKCXZfjGe34lqtjc536KauyF1N5tIPfB2u+SJwmNs7m4mnv
         WlrNNpZ3DPDnosl0weO5xb0vea+8i5Y1B15+bEhy3rfIQba/s6qpMQIduxiRUtXIwhCS
         LThGBptwgNr7kWiw7wA34U2CChaUg/RsVV5J7cemm6HfdOcyo+uUCIc5A9JbW3QuoaHw
         xyQA==
X-Gm-Message-State: AOAM533tN9WYiqnWB6CQSyp9/7BHQtkYBSfVrw8GtG7rbEM/iQQ3NmRr
        dIczqI4R7WYfbzuGghXX1pEZw4wBPwAx1r/uuOAj+g==
X-Google-Smtp-Source: ABdhPJxMooBWdF5Rsgk3jORT1U07gQqPsMGpBPJeECF2zavMRjs2LQaZRhguXrsqFNYUm1+cJTvffdJKsPibqDZSvlA=
X-Received: by 2002:a25:5387:: with SMTP id h129mr840559ybb.47.1589496098451;
 Thu, 14 May 2020 15:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200427061520.24905-1-nick.gasson@arm.com> <20200427103505.GA1476763@krava>
 <85lflu7v4o.fsf@arm.com> <20200514132337.GM5583@kernel.org>
In-Reply-To: <20200514132337.GM5583@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 15:41:26 -0700
Message-ID: <CAP-5=fX-dV+VHaPMO2Sw0DFB72YtuSyc23X5S3EvxGxYhAT4kQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 6:23 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 14, 2020 at 04:56:07PM +0800, Nick Gasson escreveu:
> > On 04/27/20 18:35 pm, Jiri Olsa wrote:
> > >
> > > adding Stephane to the loop
>
> Stephane, Ian, can you guys please take a look at this one and provide a
> Reviewed-by or Acked-by?
>
> Thanks,
>
> - Arnaldo
>
>
> > > jirka
> > >
> > >>
> > >> These three patches fix a couple of issues I ran into while using the
> > >> jitdump JVMTI agent to profile the SPECjbb benchmark.
> > >>
> >
> > Hi, any feedback on these patches?
> >
> > Thanks,
> > Nick
>

Thanks Nick,

If you are looking at this code I believe there is a bug in that the
loop handling jvmtiCompiledMethodLoadInlineRecord is writing out the
entire line number table before a pc and not just the line number
table at the pc. This loop in do_get_line_numbers:

if (loc_tab[i].start_location < bci) {
tab[lines].pc = (unsigned long)pc;
tab[lines].line_number = loc_tab[i].line_number;
tab[lines].discrim = 0; /* not yet used */
tab[lines].methodID = m;
lines++;
} else {

It could possibly make sense if it were iterating over the inline data
in the jvmtiCompiledMethodLoadInlineRecord rather than the line number
table.
Fixing this is toward the end of a list of things I need to look at.

Thanks,
Ian

> > >>
> > >>
> > >> Nick Gasson (3):
> > >>   perf jvmti: Fix jitdump for methods without debug info
> > >>   perf jvmti: Do not report error when missing debug information
> > >>   perf jvmti: Fix demangling Java symbols
> > >>
> > >>  tools/perf/jvmti/libjvmti.c           | 24 +++++++--------
> > >>  tools/perf/tests/Build                |  1 +
> > >>  tools/perf/tests/builtin-test.c       |  4 +++
> > >>  tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
> > >>  tools/perf/tests/tests.h              |  1 +
> > >>  tools/perf/util/demangle-java.c       | 13 +++++----
> > >>  6 files changed, 66 insertions(+), 19 deletions(-)
> > >>  create mode 100644 tools/perf/tests/demangle-java-test.c
> > >>
> > >> --
> > >> 2.26.1
> > >>
> >
>
> --
>
> - Arnaldo
