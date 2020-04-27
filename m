Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DDC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6522320656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plaJ/5Ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD0SD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgD0SD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:03:26 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9EC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:03:26 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d197so5497967ybh.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7xjWm5IylgwfTRtFrUz8O1j0UbpEjTflZcxO3pCk9c=;
        b=plaJ/5Yept6LFQ2ntG72eyFTl6gPmPN4bYfc2VGwwT4WGmYz980KE1LpA3FHqHbW9V
         Xr1ZYwDOequ/ZsrEB6bXHgPkFNqR31kvxrEE4BB1lNAjmewI8j/iYbuCxbzwH8GqdEaR
         0DEuR1Mk4jHjIInVChBiQdZsWrtDhUaiO7eXYYz5LAcPsOAcJp5Pvzo2KImxk7VjxXCp
         JDJAxu058VxwYxo99jIaDdhpGnnJ2xAB2H95HztifLciNlqqNMZqCX30ENzHStMmEZhm
         /0AVPrkjXUOlTIg3WPcKh+Ig6EVdJ3HpHD9Ypr5wqdLyQyD/A/XNxCuIVLX1aDj3zUnV
         NkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7xjWm5IylgwfTRtFrUz8O1j0UbpEjTflZcxO3pCk9c=;
        b=HGmJkYo+MOObfATukzQOJZJrkoZLwFkhinh+3GaBuMJxSLzTo/3o6iE9/m9kmJOFdd
         h4x9b+7pxo4D/B/1sHJps2aYg4h/KkSh7NOn/6Bo6givmZyVLy3qqpdvQE6XAzUjJV4O
         gmxPPBNK1YYWX2Crhxr3H835onmelgkpCkO4isg6WOfwfcebdDfDNxd363lYlkFWDubT
         gs1IQkWPjsCREhf1er3khQhhngHdvc3XBV81SWgI/4LaXJpopavpzdIPj1K8hfgzhs/h
         2j8kcj87oc8p/vukKHKuJFFUBaiT+Rq1mWYrvyDjyu9Aj4ozZltDn0860V+1LP/D0k5G
         nBVg==
X-Gm-Message-State: AGi0PuYprcIc5Bc8wl5iTH4dAORK3tuSmTlRNlWOa5yyfQ5kKBppUjqq
        dQ/mk251z7gjLX9tv4XPci3KVt4Pn3HitjwyAminRw==
X-Google-Smtp-Source: APiQypLpp3QnfAbrAFuq0BISed/HUbyIPPKrnqIyZ8L27RT3EF1FqkTF2ZLS6HPdnCDyGPIOczYyf5VkQHiQ6QTN+Qw=
X-Received: by 2002:a25:4443:: with SMTP id r64mr37030346yba.41.1588010604891;
 Mon, 27 Apr 2020 11:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-7-irogers@google.com>
 <0cee674e-4084-07cb-1954-05dafc371648@linux.ibm.com>
In-Reply-To: <0cee674e-4084-07cb-1954-05dafc371648@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Apr 2020 11:03:13 -0700
Message-ID: <CAP-5=fUWtQBBNqyr=xhKUO+jHxq=04SrBYD2Yh6QiH55BvtEWw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf expr: parse numbers as doubles
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
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

On Mon, Apr 27, 2020 at 4:12 AM kajoljain <kjain@linux.ibm.com> wrote:
>
> On 4/23/20 3:34 AM, Ian Rogers wrote:
> > This is expected in expr.y and metrics use floating point values such as
> > x86 broadwell IFetch_Line_Utilization.
> >
> > Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.l | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > index 95bcf3629edf..0efda2ce2766 100644
> > --- a/tools/perf/util/expr.l
> > +++ b/tools/perf/util/expr.l
> > @@ -10,12 +10,12 @@
> >  char *expr_get_text(yyscan_t yyscanner);
> >  YYSTYPE *expr_get_lval(yyscan_t yyscanner);
> >
> > -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> > +static double __value(YYSTYPE *yylval, char *str, int token)
> >  {
> > -     u64 num;
> > +     double num;
> >
> >       errno = 0;
> > -     num = strtoull(str, NULL, base);
> > +     num = strtod(str, NULL);
> >       if (errno)
> >               return EXPR_ERROR;
> >
> > @@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
> >       return token;
> >  }
> >
> > -static int value(yyscan_t scanner, int base)
> > +static int value(yyscan_t scanner)
> >  {
> >       YYSTYPE *yylval = expr_get_lval(scanner);
> >       char *text = expr_get_text(scanner);
> >
> > -     return __value(yylval, text, base, NUMBER);
> > +     return __value(yylval, text, NUMBER);
> >  }
> >
> >  /*
> > @@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
> >  }
> >  %}
> >
> > -number               [0-9]+
> > +number               [0-9]*\.?[0-9]+
> >
>
> Hi Ian,
>     In this patch I saw the parsing of expression with '+number         [0-9]*\.?[0-9]+'
> Could you please explain why '?' is introduced here, so that I can be sure that this is
> not conflicting with my change to add '?'

Hi Kajol,
the '?' here is part of the regular expression. Basically it is saying
that a number is a possible set of integers possibly followed by a '.'
and then 1 or more integers. The expression comes from having seen
Intel's metrics are of the form '.1234' in some of their topdown
spreadsheets, so we need to be able to handle cases like '1.2', '123'
and '.1234'. Having looked at your patch I don't believe it
interferes.

> In this patch : https://lkml.org/lkml/2020/4/1/1427
> I have used '?' symbol as part of metric expression in order to replace '?' with runtime
> parameter.

Interesting, I'll follow up with comments on that e-mail.

Thanks!
Ian

> Thanks,
> Kajol Jain
>
>
> >  sch          [-,=]
> >  spec         \\{sch}
> > @@ -92,7 +92,7 @@ min         { return MIN; }
> >  if           { return IF; }
> >  else         { return ELSE; }
> >  #smt_on              { return SMT_ON; }
> > -{number}     { return value(yyscanner, 10); }
> > +{number}     { return value(yyscanner); }
> >  {symbol}     { return str(yyscanner, ID); }
> >  "|"          { return '|'; }
> >  "^"          { return '^'; }
> >
