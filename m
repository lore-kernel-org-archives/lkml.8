Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC8C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E1C2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hB9smXzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgDWORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgDWORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:17:03 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A40C08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:17:01 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n2so3222586ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szKC5AyyO/nv9mt5G8EkIB1SiSXnSxQWMmKce6rgbNI=;
        b=hB9smXzY+TwdW7kV4j0CS0LksvVLfqAhBliy6uwLpZlA+1utOs0B7RQOIM9JM8xgWD
         mcIxIQaruz+mraZx8KdGe1lJiPBszEeFywlJe2DrUYvkUh/tdJhy1xy/kjW4jB/f6IRa
         p4AOe99rdHj039Wej6hyQ87fuGtXlpgfXMg3GAYK/W4jb4VAwriR8j2wzVZZONqAeB8O
         dhxL7w0EEbs1/2PmTHUAS3SPU/Nz1pW+7D1qWgYQg8Bz45jxFm+KpnbNhgy6+vom5may
         0DYRQ8t34ecm9fxQm+fJfqFCsFMef5z8V1fGBDzzqQufuLjTlU2HGdSpbniQHhQVbz1f
         z7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szKC5AyyO/nv9mt5G8EkIB1SiSXnSxQWMmKce6rgbNI=;
        b=HG4nBDzDhIp2VIZNlFQHDHhwXwu0mVp4MkFKbR+3Nt1lrq+i9guhW5Ad8TsVEQiTGx
         Dq/KXaV+2FBQwJCLEPQNvtNgixHj5Bz9bBCutep1ayMD5H0XkigBYSb5vkBmfrf15Nf0
         dksZxYfeZ9Ipqloxygd6WQODJF/GzHmowm3ZUjKXnnu1V5Q5NgS4RMaxrXslxTElCGTg
         8Bqdcy0TxrtfRlfONdiUr+3PSsyTz0dUQts56v8VeXVkNayuXwa1XMxetIBu68B1a8DO
         syp0FV7LYdBzewloUIYiNLCmvIegWaDhG0gEQqRfqQNpwrT3KYY9ts1eZZu+KJIbZQOD
         oIyw==
X-Gm-Message-State: AGi0PuaXM0FoESoj6qRbyOXwvxmJW1jSFDRUg0iXvkgzt20QsKS1Fcx8
        nyGCUymSVQb+9Nz9gZqoVk0GIiAu6FWzSyvHgZuANw==
X-Google-Smtp-Source: APiQypL1mpsvkaxTyf78PVhsGL1wAyjmOZ2KqplwjwnUqJT908FEL0Eiwtd0qa0ukwWY7kag2iMBt1XMSd1vYL4aIxM=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr7177724ybs.286.1587651420491;
 Thu, 23 Apr 2020 07:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-11-irogers@google.com>
 <20200423112837.GE1136647@krava>
In-Reply-To: <20200423112837.GE1136647@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 07:16:48 -0700
Message-ID: <CAP-5=fVp7qJWqLfLQKeRmhnucWj2dYQ4K8RSAuiJ5TLd_PqXog@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] perf expr: print a debug message for division by zero
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:28 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 03:04:29PM -0700, Ian Rogers wrote:
> > If an expression yields 0 and is then divided-by/modulus-by then the
> > parsing aborts. Add a debug error message to better enable debugging
> > when this happens.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.y | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 54260094b947..21e82a1e11a2 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -103,8 +103,18 @@ expr:      NUMBER
> >       | expr '+' expr         { $$ = $1 + $3; }
> >       | expr '-' expr         { $$ = $1 - $3; }
> >       | expr '*' expr         { $$ = $1 * $3; }
> > -     | expr '/' expr         { if ($3 == 0) YYABORT; $$ = $1 / $3; }
> > -     | expr '%' expr         { if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
> > +     | expr '/' expr         { if ($3 == 0) {
> > +                                     pr_debug("division by zero\n");
> > +                                     YYABORT;
> > +                               }
> > +                               $$ = $1 / $3;
> > +                             }
> > +     | expr '%' expr         { if ((long)$3 == 0) {
>
> is that (long) cast necessary? it's missing for the '/' case

Andi Kleen could say for sure :-) From my observation, the values are
typically doubles and definitely need to be in the divide case. There
is also code handling them as longs such as |, &, ^:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/perf/util/expr.y#n100
There's an experiment to see if all of the long handling code could be
removed. This change isn't modifying the existing behavior.

Thanks,
Ian

> jirka
>
> > +                                     pr_debug("division by zero\n");
> > +                                     YYABORT;
> > +                               }
> > +                               $$ = (long)$1 % (long)$3;
> > +                             }
> >       | '-' expr %prec NEG    { $$ = -$2; }
> >       | '(' if_expr ')'       { $$ = $2; }
> >       | MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
