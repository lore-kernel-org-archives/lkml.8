Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED02C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F92077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QveHIXa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgFFOrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgFFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:47:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E3C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:47:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so3870450pjs.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=50yqHb4PNplMXBGZYcRRRB7EcbDjgp32miufY8ZFWsY=;
        b=QveHIXa8VdURrxPoOZBq9torY1Fe8GctLjoOCXtVGnBedyoMzfNHffMTIrAR2u2pV4
         w0S8JGtug6zEhGlkQNum3ALQmY9gh3s+3s7Ykijd+7jzEbX8a3yX2MlRLhlbly9Tyrt9
         307a46YfvIdqRTEyFK/b1gJuN+4o0IW6W+zEm/GKzD0GT45PwsLBKHB0nUEkig3WY7mq
         VBFVG/SD87Z7bI0B58wcC615X7L9NsvNuXuoe/cHCZkFfjz4BmJwyw8ybJ7R+Ktc9UXK
         SE7GgcfpswxT+Sp5QEtXcMBLOgCJQGcbEr1ceamInJacahJqUiQMp2u852WEMwlyqAHt
         1V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50yqHb4PNplMXBGZYcRRRB7EcbDjgp32miufY8ZFWsY=;
        b=BxRQs0l+5dN5CEuy0nUj/ZC/4okzsYpqPVD9Ah+KBiJ1oTDesjweY3CssJ41eBL3Z2
         3+78xA6EWwJJx8ZKI0y+uhkVOdLWY6/xiA78WbXkhvPV+6H9AAkibOQydFXEbCevtl5z
         aAIn8uxsKVVrtM91sKIxJMH4dMDU8AYeWgSin6/yDYrAYNduYpYJ9VpM0sk1DiGwbtxv
         g9+LDMIDpl52X+EVc/9vk/hparxCBxqUvjfSzCcjO3USpQz/8ZAz1D6yhUkF5X2HcFG2
         XnKHCObtJ3pKD+y2Iv9RKArTF7Nufaiu3y/vHDt6g6AHnl04J80J1et7OiY4i3SJtbyU
         zeuQ==
X-Gm-Message-State: AOAM533lJBCR+wDqZu0KmzshrbqkY81uCr7FPnpXkOrkgAjo5tDcGF64
        gl1Y5PjDOC7tr7JXf6IzlaI=
X-Google-Smtp-Source: ABdhPJzmZ0Mshbby7no5zZgW1+9jNn97zLDH9Ytqzo088e4sIUM3f+O8FpYxdXYF8imRDevXKjJ7Yw==
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr7937013pjr.114.1591454850406;
        Sat, 06 Jun 2020 07:47:30 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id s32sm2231157pjd.6.2020.06.06.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:47:29 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:47:20 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: add default value for opt 'call-graph'
Message-ID: <20200606144720.44brke7t3ej7ovho@mail.google.com>
References: <20200503040056.29683-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503040056.29683-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
Have you checked this one? thanks.

On Sun, May 03, 2020 at 04:00:56AM +0000, Changbin Du wrote:
> The documentation says the default value of call-graph.record_mode is 'fp'.
> But actually we never can omit value of call-graph parameter. This patch
> can fix this issue.
> 
> Meanwhile, this patch adds a short name '-g' for opt 'call-graph' since it's
> very useful.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 01d542007c8b..21a9656021a0 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4754,9 +4754,9 @@ int cmd_trace(int argc, const char **argv)
>  		     "Trace pagefaults", parse_pagefaults, "maj"),
>  	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
>  	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
> -	OPT_CALLBACK(0, "call-graph", &trace.opts,
> +	OPT_CALLBACK_DEFAULT('g', "call-graph", &trace.opts,
>  		     "record_mode[,record_size]", record_callchain_help,
> -		     &record_parse_callchain_opt),
> +		     &record_parse_callchain_opt, "fp"),
>  	OPT_BOOLEAN(0, "libtraceevent_print", &trace.libtraceevent_print,
>  		    "Use libtraceevent to print the tracepoint arguments."),
>  	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
> -- 
> 2.17.1
> 

-- 
Cheers,
Changbin Du
