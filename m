Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5945C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D4120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597130869;
	bh=Yp7tTxScjJcN9TlGZyF+AMlYhqZOQMFfSV9sDQelnCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yH4lKhphpfgDduv8evI193lwoO4ZKlOUAWzZrU+eolpCzuYEzBIfrtOP4SS5UXBtR
	 ZDB0Os0AHzWlJoYr1mvFjqtOHxZHLFriN8uNsYzAQAo12AWEtWSm0N2rVLhcyEZh9z
	 f/SJQ2VO3p9e+nEzA1UtyJdtxqH6V/bueKmrtY5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHKH1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:27:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39785 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgHKH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:27:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id a5so10487821wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQmYeMRo/8i/fFefwKmsFbqOCjEq2XgZj6c7soBcqwQ=;
        b=ESWneI1h3BLstCM9p9Gw7eOyhtUADfn6HhGAza6I6o8g9nbIKNizUkNQd9r5kW5Rog
         Q+6lYgWqmwM73tpu+BNtBISqDBSqbZ56Gav6xR8EIyL5qyL0weI5kEzSBFzTGxPpy4s/
         LHWqG31b0HXk++czP3mPRe5nOPbCnL+yf+wAImX+ndpMJLcszj/RF5eHL3JQ9wAeN+SR
         1V35G3kXp4nPEEkD1EnzRwjniYfruqlh0KX3Y88ab2k5GJHqRkpdMcnnKEUwoJpN2knW
         GyhZgJQzCueAEQ0XS8zGYulrZgbydOZ+PQGsbdsmFQpylha23zKc5hUaetAZ5Zk8mF4J
         vOrQ==
X-Gm-Message-State: AOAM532BVXN/kBfoypn2Nr+z0LGvdjC9idqymeYbCk88Ko2XCnKusHJx
        zplAh9oaYAIdhwxk1STkpvce7XSWijxGg8iGZEo=
X-Google-Smtp-Source: ABdhPJwj0HUJHofr640Lcf0w9XJUTXq0v1iHW/wZNXIqdsfD12QrIoyD/JWDh07LoAnRzABJyaU10aB6teAMhxbjk4g=
X-Received: by 2002:adf:ab55:: with SMTP id r21mr26903503wrc.332.1597130866854;
 Tue, 11 Aug 2020 00:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597004831.git.agordeev@linux.ibm.com> <d949f5f48e17fc816f3beecf8479f1b2480345e4.1597004831.git.agordeev@linux.ibm.com>
In-Reply-To: <d949f5f48e17fc816f3beecf8479f1b2480345e4.1597004831.git.agordeev@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Aug 2020 16:27:35 +0900
Message-ID: <CAM9d7cijhLpaZWEn6=Gd-DQ08P0V0uEvFqzg_vD5kcNjPO9gBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf bench numa: fix number of processes in
 "2x3-convergence" test
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 3:22 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/bench/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 23e224e..90639c9 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -1754,7 +1754,7 @@ static int run_bench_numa(const char *name, const char **argv)
>     { " 1x3-convergence,", "mem",  "-p",  "1", "-t",  "3", "-P",  "512", OPT_CONV },
>     { " 1x4-convergence,", "mem",  "-p",  "1", "-t",  "4", "-P",  "512", OPT_CONV },
>     { " 1x6-convergence,", "mem",  "-p",  "1", "-t",  "6", "-P", "1020", OPT_CONV },
> -   { " 2x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
> +   { " 2x3-convergence,", "mem",  "-p",  "2", "-t",  "3", "-P", "1020", OPT_CONV },
>     { " 3x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
>     { " 4x4-convergence,", "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_CONV },
>     { " 4x4-convergence-NOTHP,",
> --
> 1.8.3.1
>
