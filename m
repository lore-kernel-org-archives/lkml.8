Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72212C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6732166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/vDifw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgEARjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729807AbgEARjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:39:55 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:39:54 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e16so3103739ybn.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNUBGa0a7zxAAnTw0opvF4jencC5GpbadnEhIi/WWSc=;
        b=n/vDifw0MAr2OMpJrIRf3dWQDUTaXe6C9sf9AQ6WteXpILhKtsvY0qz5UzyeH3RcTb
         KlHRi0DiUYic6nY2J30a4FXm2g9J20hu/9uSY5/viYPGUz3SNc82dZ0oQkiDT8cmuH6q
         3qfVTZJu3YUkQxjq/XzttzX9uhBmpO6zcIOE0Wt6xO+RtAPih6zI6aQCPllPh+B9vv+L
         WlrVQu71zB2O1JhQtLo1BOpmj8+WvXLYhCaRR3kDEai0uK+bmED8450rxLJIKAUk6A62
         JUrTEFIzj3wHjJ7HJU2x/YwzGHegojrLTQQtbrdgpq3fa9sfk23tvcFDjZh6QTezYOvN
         uCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNUBGa0a7zxAAnTw0opvF4jencC5GpbadnEhIi/WWSc=;
        b=pIblyohwF7EKHg/B3EwyxJjHyzdnJwqonKcJN5l5W9RG+LcXfOjinXI2TytApEGxJo
         87naJFkh8z1e2GP0n7Ox06dyRK3uoRwVarTDCM8tqWo/cFEJEUFpNZ4Zmu/jiwNWyPGt
         /7eLAxvef5j8f+lDC3sGXyYGsFN1/bETlX1fNCBRkch4OFOjLSv94hZnkNntFyLe5cx3
         IfOCbYmdKJtbH6/B9uAm7cJEGaAJDrROYrYfwv3FVdq0i9wNsO4IZmHYkHyHS+pNifKW
         U4MHuro9y8JMF6OYJkMkCmsP4jK075w//yOIXgxx0VjWrAWJKDm0scw0jf3I/Lr4oig3
         R4cA==
X-Gm-Message-State: AGi0PuY8aUMvtccuiQl6bRM78f3qqT8jFRsWwIPboqH/4PbbzIDF0+oo
        Ihnavoezn0jIUJbPKQpxxRzX/aYiIUXj+khTPT1A4w==
X-Google-Smtp-Source: APiQypLjRXtEUUO/+jeOasrYMULbKTyb4hU64R99kWPKqsw7zu+qeYOd9Jy5qIQ4jQ/ixzKZUGQ9Icv7S3FaZOv4xMs=
X-Received: by 2002:a25:3d86:: with SMTP id k128mr8305222yba.403.1588354793103;
 Fri, 01 May 2020 10:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com> <20200501103519.GB1789042@krava>
In-Reply-To: <20200501103519.GB1789042@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 May 2020 10:39:41 -0700
Message-ID: <CAP-5=fVAnY12rWttXZ4bcnS87g2KruE6EzrkBH_8GxWxAMFcuQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] perf metric fixes and test
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
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 3:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 30, 2020 at 12:51:32AM -0700, Ian Rogers wrote:
> > Add a test that all perf metrics (for your architecture) are parsable
> > with the simple expression parser. Attempt to parse all events in
> > metrics but only fail if the metric is for the current CPU. Fix bugs
> > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > around add PMU config term failures.
> >
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
> >   perf parse-events: expand add PMU error/verbose messages
> >   perf test: improve pmu event metric testing
>
> this does not apply on top of changes from Kajol Jain
> which are now in Arnaldo's perf/core.. could you please
> rebase?

Thanks! Done, v4 is here:
https://lore.kernel.org/lkml/20200501173333.227162-1-irogers@google.com/T/#m0637a37d54b694c508904790d4c6f9bc24332d0b

The power8/power9 fixes were acked-by IBM, would it be useful for
Intel to do the same for skylake/cascade lake? Should I drop those
patches to wait for updated ones from Jin Yao? The problem is that
without them the test will fail on Intel. It'd be really nice to get
the test landed.

Thanks,
Ian

> thanks,
> jirka
>
