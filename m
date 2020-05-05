Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECBDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A82073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvEnk/h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgEEMiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgEEMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:38:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:38:04 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c10so2039631qka.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/aTln0tkwuTbhfmuKqm31FCla82hb2dCRVj3WvO6HcE=;
        b=SvEnk/h/QDK5jZ/6WbWhu4xu9ItqBfRYWFT8NSahpr3YU8lN5AFKwsJUk8IjF6w409
         oAsStG3l0SmQDhVUez0Cj9QkMGJtTBkdVw1ZTDInT9sxQd8Rmmnrq2SiBcX42pUNO610
         rj9Olu8vBSRQcj/clQ0XTx26UrTikUQrpeNRDLOCDNuJMR6p8c2ffq5yrrgTgWdYvWgv
         Y1mxrb5k7ewwA2q4NX5HX5guW16g1JIje2gJYir3PY76ANpkIF4fggHEbeRsLbP2PbZV
         XxV/oilt6DkOniNcIInsH5SXNF2GSy+/YeNqObkHA2cyjxfmkjD1YbQj762Vil89BFXL
         BILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/aTln0tkwuTbhfmuKqm31FCla82hb2dCRVj3WvO6HcE=;
        b=hdxPhQlbyjzsjtZkKzRGYgyyXELfbcIgto14swRpQtryCrKWNCx45dj4erZStuIpdG
         jlWaJh9amwNTtRcTkyjG+LYfAcIZpEslqFzU2MMyJBqZj9AhH+zag0BA/HGMbgbjYMlX
         aDGDc6adnumY+8vdml7A4sBkc4Ta41H6uionw2U/BFnIBUq/EhdKoLKC9UWpdRBsR6dB
         BVjcnqpxY1EcWppX15Bc2pRTZB6tJHs8CSD01qYNmouVBMf742dgPtmlzzo6cn/DY4ib
         a4vsWW5bEWNY+iYtvtuGIShz1oBoEHU+Cvgni48hcQ8nPnwbvCiM63pckDFAdnLRGhhy
         Ht5w==
X-Gm-Message-State: AGi0PuYiT08qssqR7aPsl9qVHC8EEn0IWQfjoOgVP+QtBYAlwM0MPXrV
        BrjmMwcpc1ftsQ0Vi5SHptiE46tdLvM=
X-Google-Smtp-Source: APiQypL/0NNXUGoHLkEwwtzxNxUbj6MU94DrrF5z4KCKeNoGOKjeOh5ZAqRPQde1h98ll4LndYjKng==
X-Received: by 2002:a37:6851:: with SMTP id d78mr3118445qkc.262.1588682284032;
        Tue, 05 May 2020 05:38:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x22sm1544013qtr.57.2020.05.05.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 05:38:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BA99409A3; Tue,  5 May 2020 09:38:00 -0300 (-03)
Date:   Tue, 5 May 2020 09:38:00 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/3] Improvements for kallsyms__parse
Message-ID: <20200505123800.GT30487@kernel.org>
References: <20200501221315.54715-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501221315.54715-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 01, 2020 at 03:13:12PM -0700, Ian Rogers escreveu:
> kallsyms__parse is called 4 times during perf record startup. Add a
> benchmark to measure its performance. Transition it to using the api
> io.h buffered reading, improving performance by ~8% or saving ~5% from
> perf record start up time.
> 
> v2. Fix the err return value for success, error reported by
>     jolsa@redhat.com. Add clean-up for hex2u64.

Thanks, applied. Jiri, please let me know if I can stick your Acked-by
or, better, Reviewed-by there, Namhyung, others, please consider doing
the same :-)

- Arnaldo
 
> Ian Rogers (3):
>   perf bench: add kallsyms parsing
>   lib kallsyms: parse using io api
>   lib kallsyms: move hex2u64 out of header
> 
>  tools/lib/api/io.h                |  3 ++
>  tools/lib/symbol/kallsyms.c       | 86 ++++++++++++++-----------------
>  tools/lib/symbol/kallsyms.h       |  2 -
>  tools/perf/bench/Build            |  1 +
>  tools/perf/bench/bench.h          |  1 +
>  tools/perf/bench/kallsyms-parse.c | 75 +++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c        |  1 +
>  tools/perf/util/symbol.c          | 14 +++++
>  8 files changed, 133 insertions(+), 50 deletions(-)
>  create mode 100644 tools/perf/bench/kallsyms-parse.c
> 
> -- 
> 2.26.2.526.g744177e7f7-goog
> 

-- 

- Arnaldo
