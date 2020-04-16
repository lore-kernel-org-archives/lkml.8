Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EE7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D121927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7ARLeBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410632AbgDPPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442776AbgDPPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:50:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA337C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:50:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so21714537qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRruGjOqMYa0IrZR4+8JzDj9DjzXOMU0WS8KtXJYvIA=;
        b=t7ARLeBk0wSFWf7qbRF3xK464DEA5h6f4wnw6KtH0dqKybvG+sryMrK5cz4LuwfpzY
         SUyzj5W17vpMjz16iRe/fT1S73GoYf1mNSnc4Rs7ZrK2F3r+S3XkaVOGO6H0Nfvr8AsA
         ccBqShrVoa8Q7l/YUGwONx8eseT4FIqVkNbZa+iB1HCWyFfubHkJ+SoEUxKqcmHhGfWV
         AtCq+gaYPqpXwDVJhMxs/Ff0AGucdgT8SGDD76gMXbTB8wBc9KnJ/IomF7voxkgOTHSp
         eLbD1OowT1JQ2lxNMbZdHaHWrol3e7pYbSp/yr+zyDs2Cn5TyABd+XV5RZD/aQ6ge59y
         J9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRruGjOqMYa0IrZR4+8JzDj9DjzXOMU0WS8KtXJYvIA=;
        b=UB3dSwOFmQLs/0itLEn2bCan8j6X3WgagMsMMJ7JVJjskCsBGevPHkksCJ7HHYrJr+
         57LN6mS9VpGVU55fNt5LYspw2Ae2T1xVJaHd7D+puZxkKlos4GIggtMMtJLi6k3F9DBQ
         7j2EuOmuB9gT3LI41dfhIsz2JkpONY3unnEs3iOcfy0nTihWrdPZ0XLHYA07opGTFy6Y
         zJgR/CxxbhqAuco/Xt6YYN/0x4aiOkeOxCtv0FvjFKX+APLbgUW6ylf1EqsvUVR9DLU3
         0zIz9ngl4hGgjx0mMjGvBvR/ZWUi7jrh9FoUZ8jODYdXDQR5a8akvdiQpZOY2ONt+oIm
         Xn8w==
X-Gm-Message-State: AGi0PuYEJisVWXGICUpT0jsMz+as1f1k2Tpb74Pk2AtCo8GG28zWLavu
        q0R6r3ku21K4h+JQybUk7Fw=
X-Google-Smtp-Source: APiQypKEtfoNxiaWVLRyQt9NJ0qzg2Q0n8jdvGsyqynjjwvEE01Bx9XZK83hsUMl0bzc7xfxF24IpQ==
X-Received: by 2002:a05:620a:1232:: with SMTP id v18mr4928688qkj.429.1587052237885;
        Thu, 16 Apr 2020 08:50:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r18sm824644qtt.25.2020.04.16.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:50:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9099409A3; Thu, 16 Apr 2020 12:50:33 -0300 (-03)
Date:   Thu, 16 Apr 2020 12:50:33 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf stat: force error in fallback on :k events
Message-ID: <20200416155033.GD2650@kernel.org>
References: <20200414161550.225588-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161550.225588-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 14, 2020 at 09:15:50AM -0700, Ian Rogers escreveu:
> From: Stephane Eranian <eranian@google.com>
> 
> When it is not possible for a non-privilege perf command
> to monitor at the kernel level (:k), the fallback code forces
> a :u. That works if the event was previously monitoring both levels.
> But if the event was already constrained to kernel only, then it does
> not make sense to restrict it to user only.
> Given the code works by exclusion, a kernel only event would have:
> attr->exclude_user = 1
> The fallback code would add:
> attr->exclude_kernel = 1;
> 
> In the end the end would not monitor in either the user level or kernel
> level. In other words, it would count nothing.
> 
> An event programmed to monitor kernel only cannot be switched to user only
> without seriously warning the user.
> 
> This patch forces an error in this case to make it clear the request
> cannot really be satisfied.
> 
> Behavior with paranoid 1:
> $ sudo bash -c "echo 1 > /proc/sys/kernel/perf_event_paranoid"
> $ perf stat -e cycles:k sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>          1,520,413      cycles:k
> 
>        1.002361664 seconds time elapsed
> 
>        0.002480000 seconds user
>        0.000000000 seconds sys
> 
> Old behavior with paranoid 2:
> $ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
> $ perf stat -e cycles:k sleep 1
>  Performance counter stats for 'sleep 1':
> 
>                  0      cycles:ku
> 
>        1.002358127 seconds time elapsed
> 
>        0.002384000 seconds user
>        0.000000000 seconds sys
> 
> New behavior with paranoid 2:
> $ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
> $ perf stat -e cycles:k sleep 1
> Error:
> You may not have permission to collect stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).
> 
> The current value is 2:
> 
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN
>       Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN
> >= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN
> >= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN
> 
> To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> 
>         kernel.perf_event_paranoid = -1
> 
> v2 of this patch addresses the review feedback from jolsa@redhat.com.

Hey, thanks _a lot_ for providing the before/after output, this allows
me to review the code and then just go mechanically follow your steps to
reproduce the results, awesome, keep doing it that way.

And Jiri is right, one-liners are fantastic, this one came close enough
:-)

I did some reflowing of the commit text, check if you're curious when
this goes upstream, no original content changed, just added some spaces,
separator blank lines and moved the examples two spaces to the right.

Thanks,

- Arnaldo
 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d23db6755f51..b4e8bcb5ab05 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2446,6 +2446,10 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		char *new_name;
>  		const char *sep = ":";
>  
> +		/* If event has exclude user then don't exclude kernel. */
> +		if (evsel->core.attr.exclude_user)
> +			return false;
> +
>  		/* Is there already the separator in the name. */
>  		if (strchr(name, '/') ||
>  		    strchr(name, ':'))
> -- 
> 2.26.0.110.g2183baf09c-goog
> 

-- 

- Arnaldo
