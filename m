Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65856C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382F82082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6K/4wTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGPtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:49:21 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43992C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 08:49:21 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb4so2866652qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8kAewJXxDLwMR0UJmYRXjLb2uTZfuJY1YrWM0JTXTDk=;
        b=b6K/4wTpmMeS5oky1ZJB2oeTq8hdSDybegicfWlRRwsRPkvJgt2I1FZh2rDXpqrvVL
         +0LpzQcGG147XM+dkW7WnPkD/L48+euP0yFHlOIcKZldBdRLsYx407W86GDpmi3dToz2
         IHcov5sZFLWy7TzTBzKTjOY4/nxHDnD6oKJtS1eaeHhLWald4TG3ANgHDuZNr1/ZKeRD
         Zfh2cJ1RLsTliw0czP51oExyZ2iGFV6ZIBQl5QUagPxS/L2tzg9ErzyBHww7hOcyZi71
         2rgZxrAiukK1uKwNvGM8JMqpBA05tjFjku+k6V8b8BYvzF0tjLw0GKI/nxe6AFARBJxt
         j19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8kAewJXxDLwMR0UJmYRXjLb2uTZfuJY1YrWM0JTXTDk=;
        b=ZBIDQfNCsQOP+LWH6RnM3Z/hzH4QTFOPSflRd5if8s5NjDTF0MGqEOOiPOo5hxzXz3
         bSxVDKbkrmFiJXmV8B4TOZJ/Eg5lzo6HH4sKd4EB7YvJaXdQv4ca+hiIk3vC3Ehzc65R
         +Vkil4hstsccNWlBx/hTFLzKqRNcI0LO+iKgXTf3E6G42Jh/zn/TJg6Fb4WJn6Pr4iqa
         3g905WEHwBneErxtRT4H94d+t/p5IXeWGkRheRduwU/rJq0kPRMEF5MSZdkMHWzvr2pw
         OjxpMbacZGCClcIXPJg5EYorZ9fBbLW/kAPyu8rheVsMceUQfGS3wEsUm5DE3/YgiChL
         dnfg==
X-Gm-Message-State: AGi0PuYt1M5fTtfdrIvmNjRoBnnsTqG9tqq8c9b6TEMNzyc/O8ZOKaVa
        oc+Rt7f4vu2Yl3BV+Civl0E=
X-Google-Smtp-Source: APiQypI5ex7AgGYLReKXjDYLwoXAwXBptOjcvzT/oWMweBj0cMpAju3wyuauXY6NDtOFy26bgbUmvA==
X-Received: by 2002:ad4:4744:: with SMTP id c4mr14289638qvx.203.1588866560342;
        Thu, 07 May 2020 08:49:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a27sm4822421qtb.26.2020.05.07.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 08:49:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BCB740AFD; Thu,  7 May 2020 12:49:17 -0300 (-03)
Date:   Thu, 7 May 2020 12:49:17 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: Re: [PATCH 0/5] perf tools: Pipe fixes
Message-ID: <20200507154917.GB32641@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507095024.2789147-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:50:19AM +0200, Jiri Olsa escreveu:
> hi,
> sending changes that allows callchain detection in pipe mode,
> fixing followign use case:
> 
>   # perf record --no-buffering --call-graph dwarf -e sdt_rtld:init_start -a -o - | perf --no-pager script -i -
> 
> plus change that allows to read pipe data from file:
> 
>   # perf record -o - sleep 1 > /tmp/perf.pipe.data
>   # perf report -i /tmp/perf.pipe.data
> 
> plus unrelated build fix.
> 
> Also reachable in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/pipe

Thanks a lot, all tested, great improvements for pipe mode!

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (5):
>       perf tools: Do not display extra info when there is nothing to build
>       perf tools: Do not seek in pipe fd during tracing data processing
>       perf session: Try to read pipe data from file
>       perf tools: Setup callchain properly in pipe mode
>       perf script: Enable IP fields for callchains
> 
>  tools/perf/Makefile.perf    |  8 +++++---
>  tools/perf/builtin-report.c | 33 ++++++++++++++++++++++-----------
>  tools/perf/builtin-script.c | 23 +++++++++++++++++++----
>  tools/perf/util/callchain.c | 14 ++++++++++++++
>  tools/perf/util/callchain.h |  1 +
>  tools/perf/util/header.c    | 34 ++++++++++++++++++++++++++--------
>  tools/perf/util/session.c   |  9 +++++++--
>  7 files changed, 94 insertions(+), 28 deletions(-)
> 

-- 

- Arnaldo
