Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6362DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F3720657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9fnzSs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgENRzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgENRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:55:03 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA621C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:55:01 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so1971002ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bqd0enkhMSxrfL/Adcye9oJBjo0l5uHXN5shg57c40Q=;
        b=F9fnzSs25Igfl0QV3polvMoP/mjq0cibxyISTPDDG60KqRjcudk+iygVw/pMmJA1Df
         H7cqJ7BIZz61FBdRCXZkrbsUr33+Z1mHHlejnzs4hz1ViXuoFpfVWrthA829Se6kGhOk
         aWGDKcNHRbfBmnXEpahkWPktevBMOdB3RGoxPlDGk8rsgFhApK5ajWAH94k7H1t03BY1
         wnTsh+pATo/tW0LFYwCJ2Up7M4IlOkurt2hAZPjab3fxiML1b7+T9p3QMIyzLAurFJux
         AqZTwwn97vjR/haLkfwzldKZTAOa9ur90f3SDEo3RSAG7hwYNRnB5UEQ7T7Uwaix2p5c
         UKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bqd0enkhMSxrfL/Adcye9oJBjo0l5uHXN5shg57c40Q=;
        b=jqKXnOhW0FsFj+vQwv147XoEJqCMZiVllZToHgwSimZj66U0vwSrUPQlaSKRy6oaeE
         PR10NwG/JfUOXLsMsWy8qdb/i24jWfNz5e9NBl32T1dyd3xTUlTD4Hed7qtVU6EfVOBn
         DobwN1tFnC5wXfZ9aW6MAPjvsnNrF0if6673La2jgvVKoasbBzpudcbENBebIYF6j6Fq
         ky2yOPXSIQpEncIaDwU8FuAFyGOPMK8mUF01fPmch+s/h8MMiIU3vVzozfBuY8CpufVB
         YVAzi86v5zcDgGDFzrBauTVHAK82SWAH6s6b6/qBHVdApp+6KagHxyfD+jEIFoHTDV3z
         k68A==
X-Gm-Message-State: AOAM530Y9yp2lKxn3mQ/r7tOPKq4nnBXVXsvAJfFmtWruY946tkL4mmw
        Xn5i66YojjyP7MBOA7al85O/1fOHHJTTFI2PIEkaOw==
X-Google-Smtp-Source: ABdhPJxGNWHXZNvqlyumtWXkLaf15V37wf/nGmXq8e/yBOtYkmcQWkrDo0RM0gQNHfQtWAZH+nvoHBy8Tzu7zdbNZX8=
X-Received: by 2002:a25:3182:: with SMTP id x124mr7777499ybx.324.1589478900332;
 Thu, 14 May 2020 10:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com> <20200306071110.130202-4-irogers@google.com>
 <20200514150447.GA29968@kernel.org>
In-Reply-To: <20200514150447.GA29968@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 10:54:49 -0700
Message-ID: <CAP-5=fU+RYa3GF_xfjCPFGRKi5-zNuY7bm+9wqAnrAo2NqJ+oQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
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

On Thu, May 14, 2020 at 8:04 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 05, 2020 at 11:11:10PM -0800, Ian Rogers escreveu:
> > Allow the CC compiler to accept a CFLAGS environment variable.
> > Make the architecture test directory agree with the code comment.
> > This doesn't change the code generated but makes it easier to integrate
> > running the shell script in build systems like bazel.
>
> I've looked at this and split this part in a separate patch, and applied
> it locally, please take a look, now looking at the other bit of the
> patch.


This bit looks good. The CFLAGS change is something I need to deal
with a directory layout change in our build system.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/trace/beauty/arch_errno_names.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> > index 22c9fc900c84..9f9ea45cddc4 100755
> > --- a/tools/perf/trace/beauty/arch_errno_names.sh
> > +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> > @@ -91,7 +91,7 @@ EoHEADER
> >  # in tools/perf/arch
> >  archlist=""
> >  for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> > -     test -d arch/$arch && archlist="$archlist $arch"
> > +     test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
> >  done
> >
> >  for arch in x86 $archlist generic; do
> > --
> commit 1b59e3b7bfc6183d3dc9f119e1875f9607d29d96
> Author: Ian Rogers <irogers@google.com>
> Date:   Thu Mar 5 23:11:10 2020 -0800
>
>     perf trace: Fix the selection for architectures to generate the errno name tables
>
>     Make the architecture test directory agree with the code comment.
>
>     Committer notes:
>
>     This was split from a larger patch.
>
>     The code was assuming the developer always worked from tools/perf/, so make sure we
>     do the test -d having $toolsdir/perf/arch/$arch, to match the intent expressed in the comment,
>     just above that loop.
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Alexios Zavras <alexios.zavras@intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Cc: Igor Lubashev <ilubashe@akamai.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Stephane Eranian <eranian@google.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Wei Li <liwei391@huawei.com>
>     Link: http://lore.kernel.org/lkml/20200306071110.130202-4-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index 22c9fc900c84..f8c44a85650b 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -91,7 +91,7 @@ EoHEADER
>  # in tools/perf/arch
>  archlist=""
>  for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> -       test -d arch/$arch && archlist="$archlist $arch"
> +       test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
>  done
>
>  for arch in x86 $archlist generic; do
