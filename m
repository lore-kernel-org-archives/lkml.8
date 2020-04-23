Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57329C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FDA206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5C1V4io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDWOYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726591AbgDWOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:24:09 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440DC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:24:09 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n188so3238276ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On7uMVKUj/oaJJmzywZSm4qsJXQIiJn8ZPz+oC8CTSE=;
        b=Q5C1V4ioZfi/+MM9yv6Cv+SHFjYnL3VOcPKr1mZvDos2T8v85hmBSffk983k5JwUNp
         ANH21Hh0gwip6XnY++G5HwcFbasNi1n6OdSzCpkenzz1a6owgSmSe8cxdphujeM2vykV
         Pal5Y/9qt0e52WqVq4sQ8UuxOpsNp+SC8Scy2O6zAn+RiQS0iuwx9KlxJa3+kLt+kGqR
         3G8BXu2X6ProAyhn5Uu3T+pMoJdnPcs9mHiH3FupB/jAS5BZbXAdokizLf0MtkbcYtpz
         u6j8RLg8FbjhQrcMQlQ2/fGDeiM4yuEEkuPTabRH076SXZC0lsDYhnoJgx9i+oPliUqE
         9n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On7uMVKUj/oaJJmzywZSm4qsJXQIiJn8ZPz+oC8CTSE=;
        b=MDS5wLADcX0XC+SVX5/Rd74Jo9xnh5B+xhOuLWruQQ5jjh73/HQvkr85R+ITxNy47D
         pUhqRGZ9IPRZx0FvSpI59UPZGVMFleZSzkyDBEErZ28DEdb3cZ2f3P0VyD/4YQrZZNaP
         0rPvMWT2r9Wa81w1Jvd54F7QkPfYMWhbjs+O4Tj6wzz0kR+SUkQ5h5+rFWJpLdu1i0Zx
         WrfVeDMWyt642+DRTamqTwSFEuS7axO7NU/IUAFheon9fyOS8fgEEneUdvHtZqOtTqr+
         PT7jGeMgd/3W0dJpVUj8/c40JqvXKZqXocm+PuRzNHmThc/RQk9zowinRE0LH/RSQNwa
         GifQ==
X-Gm-Message-State: AGi0PuZAzDHwv3IIEsrrDnLvoFExn2AHPoj9KeIRGZh+oLJGIpFA1Sx8
        oXF3oCp9CHb4406dwAne6X30vjWBDmtbZpS8t4SVsA==
X-Google-Smtp-Source: APiQypJ41R/4vXDGGlNAKSVrq8gFAp0tInuFgn6gp4Sq2IdCJtYis2Fi6ZRQAnuu7tLtrEsv7n4DdcLtIPwKiX3eVVs=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr7227599ybc.47.1587651848118;
 Thu, 23 Apr 2020 07:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-6-irogers@google.com>
 <20200423112915.GH1136647@krava>
In-Reply-To: <20200423112915.GH1136647@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 07:23:56 -0700
Message-ID: <CAP-5=fU7=FvpRr+PMsc_xebiETBgbNcv7U2jX3pJT87X7LAdtQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] perf expr: increase max other
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

On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 03:04:24PM -0700, Ian Rogers wrote:
> > Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
> > need more space.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 0938ad166ece..4938bfc608b7 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -2,7 +2,7 @@
> >  #ifndef PARSE_CTX_H
> >  #define PARSE_CTX_H 1
> >
> > -#define EXPR_MAX_OTHER 20
> > +#define EXPR_MAX_OTHER 64
> >  #define MAX_PARSE_ID EXPR_MAX_OTHER
> >
> >  struct expr_parse_id {
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
> ok, and we should probably start to think about what Andi suggested
> in here: https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/

Agreed, a hash table would make sense. This was the smallest value
that would let the test on x86 pass.

Thanks,
Ian

> jirka
>
