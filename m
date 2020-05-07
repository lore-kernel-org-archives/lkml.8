Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DC720838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7BnZHmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEGQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgEGQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:00:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BEC05BD09;
        Thu,  7 May 2020 09:00:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p13so2879411qvt.12;
        Thu, 07 May 2020 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atcaUOaEs0tADTWkGUnU+frLVlv/+bjjbd986VwwiHA=;
        b=M7BnZHmUaVTTJ+fDIhonO4sRs4WRRR5ScFnI6D2iorOzSuFBUtDrky9WGvRkSr2Q8D
         tVYoowwartdWC5ppYv+aUBst1/UvgyTNeDgRBME74dyx1qOmA5qEeFmEr0ESlrUrDFGL
         mkOtlXiWtKGNr9cX5mL2p6vcMz0XYNxXCIY5uNe+QCGB3bNCABwMKMO+GisZ8Ds4kDk5
         MwOPfs7ZiXa0c9OI18zcYOennqeSIJBIxNGPtH8XX92UlvWwlH3IudrHuGP1yNCiLr4G
         hZ90QJjXEet8jkV12kb+/C3SYlBepITLUokR2JExUPku/CyeLcgrtYHaiMlPmFMe1Te/
         RdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atcaUOaEs0tADTWkGUnU+frLVlv/+bjjbd986VwwiHA=;
        b=h5rsguOyQjxz/jICeaHJXQ+iOy+jlc4KhsUTWCaG+1n265yWs9oMrhANbLBYZwKD48
         mtxwidkujUG8SV9pqL43d4O+zfLpjfuWJnmeS4CSdHNM7xL1ubGcILlEEdtdZKkfEQ1Z
         CpkPDpyybdaOW5eyciDltIk4CMZZotO2SXX4lwd3GCspCuQG70+rHNoeyS7lqdpj1kJ/
         nB+rtfSaLqE1L/58VUBKUvq7+n+ZTAmcWGGHgGaFltGBUe7d9fzjioF977zI+C/+gkD2
         pPP7HQsa0/x+vsMhH71iJJhNfjSongKSZoq2ge0XtDOCqwCfysFX0kfEpr4zTrGKOJho
         EuHQ==
X-Gm-Message-State: AGi0PuYkVwQTWD35rMmJyROoB2DPqGxvyk1huHn9PZ78ESiop80UbXOs
        g3iBWXGDrX/5ygGkk8LdNUA=
X-Google-Smtp-Source: APiQypKGrDypkvCufb2U5+cCmlK8gioGj9AyZHw7W/rLT1xetjjSxEcPrChTRvLqojtQGjqM4wtgSA==
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr13836133qvf.30.1588867210389;
        Thu, 07 May 2020 09:00:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b126sm4362557qkc.119.2020.05.07.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:00:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9834C40AFD; Thu,  7 May 2020 13:00:07 -0300 (-03)
Date:   Thu, 7 May 2020 13:00:07 -0300
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
Message-ID: <20200507160007.GC32641@kernel.org>
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

Ok sir, processing these now,

- Arnaldo

> and let's not block them with new versions for patches 11/12
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>


