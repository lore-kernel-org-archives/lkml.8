Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E79C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951FF20752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA5WUM7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgEKPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgEKPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:32:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DAFC061A0C;
        Mon, 11 May 2020 08:32:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so7482635qtt.1;
        Mon, 11 May 2020 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+gjGF9mp12XhJV3KRSM6BkPs9MzMOMU+7fWS7KbSk6c=;
        b=uA5WUM7JoakLBUMWtuNg0OEr6VtC2JiLQM5dGwv32Qcy266pLaqj6MKljT8xqidwoI
         xbBwQZifKF9FDhyA0a+IIpi6u188Vnr/DiWTXwB39kU0rJfQyykKE+aFexdGzSa17186
         B0pXJMndgJ27tQJVRmFy8fArFa8YSgoAypiiNT6FYE7i498VMYDEPrWoy8G7aROn0X6p
         tWoWEMqCnf5HmYc/wNK+WcV22LwPV27/H/gdI8KJeVKKImC+ptx8rFM/8AQ0jYApW0QW
         Ngq/yRDgGdG2DtUifvIrlvk3NcIBXNFOEmM2395fmhu447tANcEomjhAHCy4FfbOoR0V
         rN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gjGF9mp12XhJV3KRSM6BkPs9MzMOMU+7fWS7KbSk6c=;
        b=L5goYocNipRyiG5CrhO6hSn/RmE7izwFzgsASDSzYVDd5gL/rhFS74yJmg5uHW0/2r
         v1n+/5/gm1JLNt/GQ6Y8QnX04gr3Bex2ypmo7zsxc8YKFHhWZSTacFiEymwelOU0kglC
         6FR6eN0W7/pOJ6UNL2wwZRGTV3QnyMVjCcTMekdg9d5TDDgcRYuv/7VpRBfpZsAMPQIg
         uM+ljSS7WbITNn7izB5Ieh2oR3bEyDCNUogXS35SOU1qqWzRWYlGgBG5jR8dSq3naLdQ
         fawGokZmcu62yjfYYl2IAiWrA453Vr8qO6UD0zI7KTEquOTXllkPZtg5n4RfLWDBFIr+
         fgXw==
X-Gm-Message-State: AGi0Pub94g5TCGbwahWc2noC98gEJTYRhEQXk4AzQlnYHNegrXlGkagS
        Km9NwL+loaWF0H49a3vyAOM=
X-Google-Smtp-Source: APiQypLCU0hFC4OIriRQoICiofnBvYbZrP4NaUE4GjJpZWCNj1lltiBIHK4s2DKpbnrsIt9JbIpdyQ==
X-Received: by 2002:ac8:544e:: with SMTP id d14mr17602768qtq.283.1589211130365;
        Mon, 11 May 2020 08:32:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h12sm2473011qte.31.2020.05.11.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:32:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF0EB40AFD; Mon, 11 May 2020 12:32:07 -0300 (-03)
Date:   Mon, 11 May 2020 12:32:07 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 00/12] perf metric fixes and test
Message-ID: <20200511153207.GD28888@kernel.org>
References: <20200501173333.227162-1-irogers@google.com>
 <20200507084445.GA2447905@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507084445.GA2447905@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 10:44:45AM +0200, Jiri Olsa escreveu:
> On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> > Add a test that all perf metrics (for your architecture) are parsable
> > with the simple expression parser. Attempt to parse all events in
> > metrics but only fail if the metric is for the current CPU. Fix bugs
> > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > around add PMU config term failures.
> > 
> > v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> > v3 adds parse event testing of ids and improves debug messages for add
> >   PMU. These messages are paticular visible with 'perf test 10
> >   -vvv'. It moves the testing logic from tests/expr.c to
> >   tests/pmu-events.c as suggested by John Garry
> >   <john.garry@huawei.com>.  
> > v2 adds Fixes tags to commit messages for when broken metrics were
> >   first added. Adds a debug warning for division by zero in expr, and
> >   adds a workaround for id values in the expr test necessary for
> >   powerpc. It also fixes broken power8 and power9 metrics.
> > 
> > Ian Rogers (12):
> >   perf expr: unlimited escaped characters in a symbol
> >   perf metrics: fix parse errors in cascade lake metrics
> >   perf metrics: fix parse errors in skylake metrics
> >   perf expr: allow ',' to be an other token
> >   perf expr: increase max other
> >   perf expr: parse numbers as doubles
> >   perf expr: debug lex if debugging yacc
> >   perf metrics: fix parse errors in power8 metrics
> >   perf metrics: fix parse errors in power9 metrics
> >   perf expr: print a debug message for division by zero
> 
> heya,
> could we please get the 1st 10 patches in? they are important,
> and let's not block them with new versions for patches 11/12
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

The first ten patches are in, can we go with what Ian suggested for the
last two patches?

- Arnaldo
 
> thanks,
> jirka
> 
> >   perf parse-events: expand add PMU error/verbose messages
> >   perf test: improve pmu event metric testing
> > 
> >  tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
> >  .../arch/powerpc/power8/metrics.json          |   2 +-
> >  .../arch/powerpc/power9/metrics.json          |   2 +-
> >  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
> >  .../arch/x86/skylakex/skx-metrics.json        |   4 +-
> >  tools/perf/tests/builtin-test.c               |   5 +
> >  tools/perf/tests/expr.c                       |   1 +
> >  tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
> >  tools/perf/tests/pmu.c                        |   4 +-
> >  tools/perf/tests/tests.h                      |   2 +
> >  tools/perf/util/expr.c                        |   1 +
> >  tools/perf/util/expr.h                        |   2 +-
> >  tools/perf/util/expr.l                        |  16 +-
> >  tools/perf/util/expr.y                        |  16 +-
> >  tools/perf/util/parse-events.c                |  29 +++-
> >  tools/perf/util/pmu.c                         |  33 ++--
> >  tools/perf/util/pmu.h                         |   2 +-
> >  17 files changed, 262 insertions(+), 55 deletions(-)
> > 
> > -- 
> > 2.26.2.526.g744177e7f7-goog
> > 
> 

-- 

- Arnaldo
