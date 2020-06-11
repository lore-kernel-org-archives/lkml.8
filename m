Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4120747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MoyRJSIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgFKABE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgFKABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:01:03 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:01:03 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n123so2095666ybf.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heNNgHVBTiNbrhYraTF8IA3nfAYOGSiVIhsoXNXN2aI=;
        b=MoyRJSIJTBR+Gh83Nc0qCwYUWhPOku+NJyjYRBtljJ6HZhWEatdrJt2iS2m/nfcE9w
         CrIYi9uWV+ebgTRhmeqAqy7POj/PrPoNiXmiLFTbtiBQBkQiewN45+9AIF46nVyeNTeL
         gyCitziXzOvJsxf8mtcDDQukend9DkUWb/pqD7yA/kGpJO9Pl6Iuwkupt2G6no6WdGxg
         Xfrzgj2RjugVSeaDIZYWqMWsgK6JZwnZTT3OuVlfbRzcrCfY6YuIoZ+1YsciIVZhkcpK
         Mpx+Vt2BLcdOQVjAVxy0NdisTUWhn/ORatOG4UZqUyl3GQnXzOvjnrT+UGWNWQpYYBmx
         wCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heNNgHVBTiNbrhYraTF8IA3nfAYOGSiVIhsoXNXN2aI=;
        b=dYGPT5e5vnhuLVo3enSleIVcAr8UZlBLn+Az65uWNrH+S/m4hpqCdD89yTxYMznLQP
         tRiQBkS0fFZ6wwzM0CjUJ8YThT87UZL7loshkhEa0tQGoTwb1rBKmImrgqV98izJjgjV
         7+sjGkTe4kCPGDMHxfzoQjAGf0N8Rmu0BrP4Ytd0PsJqEHX3O5yPQwrmUFVdmTA9idFj
         dtSApjNPKQCZcpm7TeuqjHmgBP4Xm/SKImoJ46Z+TaoGJLWrySQ3l5t6wUCQuvnPg+WY
         80gsX4lJAnWPqDvbXarBtUgYbe7m61N9+XUvL2efcqMi14dw+a0d31YyNcEf4OKvbOUc
         bBow==
X-Gm-Message-State: AOAM531TfYjWMALVgC9lE9oQO8VSOLuiXokir6sJ/+WzaOayX52NK6Fq
        qFJEghA7Wn9bYAYfFSNXqo6S8kYPpsaZmwVrtR2gPQ==
X-Google-Smtp-Source: ABdhPJzdBMfDTMaDKbXEE3IfD48CKkAL3YI0YozgYGu2/zdZigggLyn7UHoOEWOhowb9h+uMjoQCjC5qcMbiVG64zDo=
X-Received: by 2002:a5b:ec1:: with SMTP id a1mr9512881ybs.41.1591833660790;
 Wed, 10 Jun 2020 17:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200610051717.170457-1-irogers@google.com> <20200610154129.GA1776102@krava>
 <20200610164304.GA29052@kernel.org>
In-Reply-To: <20200610164304.GA29052@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Jun 2020 17:00:49 -0700
Message-ID: <CAP-5=fV3_ieXtAvo0kmXRkU8i4R0sxxZvMxTXbuk8bUWPZKDmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf expr: Add d_ratio operation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 9:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 10, 2020 at 05:41:29PM +0200, Jiri Olsa escreveu:
> > On Tue, Jun 09, 2020 at 10:17:15PM -0700, Ian Rogers wrote:
> > > This simplifies computing ratios in json expressions.
> >
> > please put in the comment some usage example and add
> > a test for this to tests/expr.c
> >
> > same for the '<>' operators in the other patch
> >
> > I'll put documentation on this together with the rest to
> > stat man page with my other changes, so no need to document
> > this, but at least bit more details in changelog ;-)
>
> Removed those from my local branch, pushed what I have to tmp.perf/core

These should be addressed in v2:
https://lore.kernel.org/lkml/20200610235823.52557-1-irogers@google.com/T/#t

Thanks,
Ian

> - Arnaldo
>
> > thanks,
> > jirka
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/expr.l |  1 +
> > >  tools/perf/util/expr.y | 14 ++++++++++++--
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > > index f397bf8b1a48..298d86660a96 100644
> > > --- a/tools/perf/util/expr.l
> > > +++ b/tools/perf/util/expr.l
> > > @@ -100,6 +100,7 @@ symbol          ({spec}|{sym})+
> > >             }
> > >     }
> > >
> > > +d_ratio            { return D_RATIO; }
> > >  max                { return MAX; }
> > >  min                { return MIN; }
> > >  if         { return IF; }
> > > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > > index bf3e898e3055..fe145344bb39 100644
> > > --- a/tools/perf/util/expr.y
> > > +++ b/tools/perf/util/expr.y
> > > @@ -10,6 +10,14 @@
> > >  #include "smt.h"
> > >  #include <string.h>
> > >
> > > +static double d_ratio(double val0, double val1)
> > > +{
> > > +   if (val1 == 0) {
> > > +           return 0;
> > > +   }
> > > +   return  val0 / val1;
> > > +}
> > > +
> > >  %}
> > >
> > >  %define api.pure full
> > > @@ -28,7 +36,7 @@
> > >  %token <num> NUMBER
> > >  %token <str> ID
> > >  %destructor { free ($$); } <str>
> > > -%token MIN MAX IF ELSE SMT_ON
> > > +%token MIN MAX IF ELSE SMT_ON D_RATIO
> > >  %left MIN MAX IF
> > >  %left '|'
> > >  %left '^'
> > > @@ -64,7 +72,8 @@ other: ID
> > >  }
> > >  |
> > >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > > -
> > > +|
> > > +D_RATIO
> > >
> > >  all_expr: if_expr                  { *final_val = $1; }
> > >     ;
> > > @@ -105,6 +114,7 @@ expr:     NUMBER
> > >     | MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> > >     | MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
> > >     | SMT_ON                 { $$ = smt_on() > 0; }
> > > +   | D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
> > >     ;
> > >
> > >  %%
> > > --
> > > 2.27.0.278.ge193c7cf3a9-goog
> > >
> >
>
> --
>
> - Arnaldo
