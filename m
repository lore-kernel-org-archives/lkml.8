Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F107C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC832222A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfXORu70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgD2TQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:16:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6820C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:16:44 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f13so1861546ybk.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kphVjeMA1rwNix0FQwbQDGQWL5pMl/5phRSUzNUo3O0=;
        b=dfXORu70YQJbho+mXHv9fJvnNj0xQzukohO0Fn4BjosJuRaOzI1vh+Iy3e1s9djZWW
         tihXldc+Idx/WNSsyA/XmiocStmkHSnfjpu++RG+Mefm6q/8OSuMNoq65D2YKDcyWdt6
         svplUUT4YKkrRo9SCgbYb91I9GAO1cgRFsFcTcCgRKbc5p8krX4zeQlt166zfAdMO3xC
         Z6ZwqximNgA5E0huiZecIcqhcM1sFSeos4rdR6j66W7v4ZcJ/9f5TXuVz8z+kQCX+GgL
         2ug4saTD0q+Qh4e/GiygRgiWJ6yevlgE/RnvJf3OsYaG5EcXjJq/hi31W7l7IuJFEQ+S
         s6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kphVjeMA1rwNix0FQwbQDGQWL5pMl/5phRSUzNUo3O0=;
        b=e000zGUPDWEejVTEb1AMISdAGwHGXp1xCy6FQH91pD3FbsAFYVhJD5G+mOJkHcKjA/
         bX9n3oP1yczL6EekaeBUWWDzYjD6+6uPbuWFNBHpK8m6Guje4tMMSLGwhCw8z1WdAs35
         5vtprNY1L2gkZyC7RyoZNwRg6/Si4HZsBApi2xqMSvtL72DQH+emNeD66zPpHAxz/eOI
         oVvrgxLYKkp1s9HVi7wMuLfvLFoKEddl1/B/rGyPv83ett+CtaThyZKZPJxobTbcOSbR
         zfDeOZKeMGeoMONUmFT2prqItlKQtn5/yl6kwp6SGA94Bye991+w/2ui7/wlq8m1cn/x
         1RSA==
X-Gm-Message-State: AGi0PuZN3ddMsNWewm7GkEMwI3ND8DeJfjvoG8WdxInVA55l7zo8gKPi
        BQRXhchBOthGB0v8C6yPZowBfMhUt8nc/kFEuBEVlQ==
X-Google-Smtp-Source: APiQypIq6wVZD9HWBdlvoYPaAuctCcX+wQ28+n1WOQlMtuAAAEWMSYjcU7A8GKJc8f58RYOPL7oI6ESRppdvKnqyevo=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr56153499ybs.286.1588187803640;
 Wed, 29 Apr 2020 12:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com> <20200306071110.130202-4-irogers@google.com>
 <20200306114054.GB27494@kernel.org>
In-Reply-To: <20200306114054.GB27494@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Apr 2020 12:16:32 -0700
Message-ID: <CAP-5=fXrZKBC4ecv5tEOsaGX1TSbxV81ihOauz1Ff4Bd_HE4QA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
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

On Fri, Mar 6, 2020 at 3:40 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 05, 2020 at 11:11:10PM -0800, Ian Rogers escreveu:
> > Allow the CC compiler to accept a CFLAGS environment variable.
> > Make the architecture test directory agree with the code comment.
> > This doesn't change the code generated but makes it easier to integrate
> > running the shell script in build systems like bazel.
>
> Hendrik and Thomas, can you please take a look at this and provide a
> Reviewed-by tag?

Ping.

> Thanks,
>
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
> > @@ -57,7 +57,7 @@ process_arch()
> >       local arch="$1"
> >       local asm_errno=$(asm_errno_file "$arch")
> >
> > -     $gcc $include_path -E -dM -x c $asm_errno \
> > +     $gcc $CFLAGS $include_path -E -dM -x c $asm_errno \
> >               |grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
> >               |awk '{ print $2","$3; }' \
> >               |sort -t, -k2 -nu \
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
> > 2.25.1.481.gfbce0eb801-goog
> >
>
> --
>
> - Arnaldo
