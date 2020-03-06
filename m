Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B250DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C1C2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYYuWZLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:54:22 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36839 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:54:22 -0500
Received: by mail-yw1-f66.google.com with SMTP id j71so3012456ywb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4k+80Q3nQjCWteUyAhZ6YcboJW9HYZRVDGVL+kSyi/k=;
        b=NYYuWZLsNuPaoJFvWxV1iHK0POM0eZCAjXZUdaWD1JjioAw57dddmMC4t52NAHvsw4
         MblsPian0TkfDhRcdwvYMKUMtizW2OXMiTfa3NdZNEnHVQaD7pQioly3gWIa93F5QolV
         IEHxYHxp98f14S6f9Rfr4mREwJ3VneZSKDhzguw/WjwY2hPd85fsNwMZhvqhbn9jzVGj
         JJmKWt7irULB+qlRliAPUNRzGitVXRaASU/QCY3KWg/nZ9eUP64bW1nA/YJPzWXFDd8O
         RI0mehRTXtEyvinjltr2KEYMt4cBF5Csu2rFHqWxcyGOQNIyJGHvt8AIAhM3HOFGFQ5L
         R8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4k+80Q3nQjCWteUyAhZ6YcboJW9HYZRVDGVL+kSyi/k=;
        b=PrkMJjVgotxeZkoWZAr+7m6UXNHJfkx+JbYCjZX75jqEKIjP54HJEbMqBOtMUpsdyF
         1V2YT5kH4pXbCFaRJLKG4bWQ5O5v8NMrDpiP3r5oYzsr9TqsTr+MX02+ODeQGHd+vdxY
         d//PhXxe5ueD2zgtu6C2Z1UZilAX4kx16lNpuGJdxxbSyv8eQyH+Jc+0Vct6gKluTeKW
         8oL6DufJ7RQp76VbAoz2m2NjI9uowKPZudENt/r2d40nfp9CqMO0/QqC1TLy/YO/BIGM
         xrjT5mzBNG1VOsBF/LnRjfd/DvKv7ns4uPH8soOmWJDfXUWMbSYewD2Ek54VrghA4pgJ
         eJnA==
X-Gm-Message-State: ANhLgQ2pYVDtVSsM2altWfK3ARJXrjU8MgbajuVFzq1fsu0IpleBPTfG
        LTeKUCP5Gyi2SUw1aHJx89fNecrCGamySFBmZCEtlA==
X-Google-Smtp-Source: ADFU+vveCrlRXxx62/mHZj6Fy+BNRyuQ9buItwmzP03xyrVo60C0Foz2j5JCM6zIPwo+rEzoyKPoCf9EuPADmoiZ16E=
X-Received: by 2002:a0d:ca8e:: with SMTP id m136mr5082180ywd.349.1583517260882;
 Fri, 06 Mar 2020 09:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com> <20200306071110.130202-3-irogers@google.com>
 <20200306113855.GA27494@kernel.org>
In-Reply-To: <20200306113855.GA27494@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 Mar 2020 09:54:09 -0800
Message-ID: <CAP-5=fUaFTR=CKaBiR1QTJ5VqS0xBNW8-YDp_junt6tLkzZdAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libperf: avoid redefining _GNU_SOURCE in test
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 3:38 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 05, 2020 at 11:11:09PM -0800, Ian Rogers escreveu:
> > _GNU_SOURCE needs to be globally defined to pick up features like
> > asprintf. Add a guard against redefinition in this test.
>
> Humm, so you're completely sure that the Makefiles that drive the build
> of this file don't set _GNU_SOURCE? I.e. some explanation in the cset
> log message about that would help in processing the patch,

The convention on _GNU_SOURCE isn't very clear. For our builds we set
_GNU_SOURCE globally hence needing this patch. This patch won't
interfere with a Makefile setting. Here is some of the inconsistency:

tools/perf: sets _GNU_SOURCE:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/perf/Makefile.config#n309

tools/lib/perf: doesn't set _GNU_SOURCE <-- I'm inconsistent in
setting _GNU_SOURCE when building files here
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/perf/Makefile

tools/lib/subcmd: sets _GNU_SOURCE
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/subcmd/Makefile#n43

Some #defines of _GNU_SOURCE are already guarded to avoid redefinition:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf/libbpf.c#n13

Some code explicitly undefines _GNU_SOURCE:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/str_error_r.c#n2

I don't think this patch hurts, I'm not sure it adds value. I think
there's a wider cleanup necessary here but I'm not sure what that
would look like.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/tests/test-evlist.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> > index 6d8ebe0c2504..5a5ff104b668 100644
> > --- a/tools/lib/perf/tests/test-evlist.c
> > +++ b/tools/lib/perf/tests/test-evlist.c
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#ifndef _GNU_SOURCE
> >  #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
> > +#endif
> >  #include <sched.h>
> >  #include <stdio.h>
> >  #include <stdarg.h>
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
> --
>
> - Arnaldo
