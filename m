Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6592C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13D20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN/a6tNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGJNgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGJNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:36:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56DC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:36:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so2561396pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hTSA/0krZvdeCyQcop6JdEMFdLGIH7H+rDDAyCz6QGM=;
        b=rN/a6tNU90T2FY14ui6NQyGj/cahER84wtPNp1gtH6Q7ljWqaRrXb/+ZCTGRkmzo9O
         Z7nEK4aO7zBY/vwEfbjf98S1Z8obnq4QJaK1ts14oPfs7EdUzm+eyBNqGH9FtjthTeBy
         27xP21CPj9bK05RfSKEPP0F1uLEKD4e23N+/W//GC4gTT+St1ga6w5cRQSFgAuCsULlT
         6mM80lY1OSgWMczVrmpcwpRQwf9zg8zYG5hK1nhg4Qp/6FtdgAk7x4W5Bje1VYyo8dxt
         b6mLxkpqy59lavBe/6logV4eNwYkSw0HUGV/1ozuW9J5W5kb50HH98sau5NX7byEbv2j
         7Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTSA/0krZvdeCyQcop6JdEMFdLGIH7H+rDDAyCz6QGM=;
        b=GRjyp+tyytiFdkU2idHy6V5MpBB0thEi8fz5mSPRGvVMS0iCvtjk1xDeSoeiOcHv+0
         Q6i3XEG4aEefZ4GyG8v/oa/glKLgVHnlNIZxRgvWDjawCsDubUrIj1UJOG0h34hQ2CsB
         YNNpyMJ1tZHqPZIY/X/FXCtTaxt/xoXtu41rXfnJh+5IbWIsMiiKJIhBVt/kRicRQo+8
         EJ7ZHTyBrsujE++/HleS56ZjH0JnQcmoDMm7dwkWXJq7eMyh35x6bty9Km9fiYKwgLxs
         6lRVR3evz5nzDj1Xc5opbfis6TDnH68fTxcGeghA0q39t5oybpijtitiV+ClHQBbPUfP
         myfA==
X-Gm-Message-State: AOAM530J6RaDL2aAui9FRcZemsxLi7x70qyrK9CoyGwvfnCb0C8dKoFX
        NbUfAoS1ugULqgpYMT0gVe8=
X-Google-Smtp-Source: ABdhPJzl/nX4gst99+I1lpA08dejvaG38mGP4x5ipKmzOhMiq/O91PIOUmbMopO7/t3Xff3t4SEQ8g==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr55866075pgq.36.1594388168369;
        Fri, 10 Jul 2020 06:36:08 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id n2sm5844714pgv.37.2020.07.10.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:36:07 -0700 (PDT)
Date:   Fri, 10 Jul 2020 21:35:58 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/17] perf: ftrace enhancement
Message-ID: <20200710133558.npuhovqs642zv6qh@mail.google.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
 <20200708173959.GD22437@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708173959.GD22437@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:39:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 09, 2020 at 12:45:48AM +0800, Changbin Du escreveu:
> > Here is a glance of all ftrace functions with this serias:
> > 
> > $ sudo perf ftrace -h
>  
> >  Usage: perf ftrace [<options>] [<command>]
> >     or: perf ftrace [<options>] -- <command> [<options>]
> > 
> >     -a, --all-cpus        system-wide collection from all CPUs
> >     -C, --cpu <cpu>       list of cpus to monitor
> >     -d, --delay <n>       ms to wait before starting tracing after program start
> >     -D, --graph-depth <n>
> >                           Max depth for function graph tracer (This option is deprecated)
> >     -F, --funcs           Show available functions to filter
> >     -G, --graph-funcs <func>
> >                           trace given functions using function_graph tracer
> >     -g, --nograph-funcs <func>
> >                           Set nograph filter on given functions
> >     -m, --buffer-size <size>
> >                           size of per cpu buffer
> >     -N, --notrace-funcs <func>
> >                           do not trace given functions
> >     -p, --pid <pid>       trace on existing process id
> >     -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
> >     -T, --trace-funcs <func>
> >                           trace given functions using function tracer
> >     -t, --tracer <tracer>
> >                           tracer to use: function or function_graph (This option is deprecated)
> >     -v, --verbose         be more verbose
> >         --func-opts <options>
> >                           function tracer options, available options: call-graph,irq-info
> >         --graph-opts <options>
> >                           graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
> >         --inherit         trace children processes
> > 
> > v3:
> >   o add --func-opts and --graph-opts to set tracer specific options.
> >   o support units as a suffix for option '-m/--buffer-size'.
> 
> Thanks for working on this! -d/--delay:
> 
> [acme@quaco perf]$ perf record -h delay
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -D, --delay <n>       ms to wait before starting measurement after program start
> 
> [acme@quaco perf]$
> 
> [acme@quaco perf]$ perf stat -h --delay
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -D, --delay <n>       ms to wait before starting measurement after program start
> 
> [acme@quaco perf]$
> 
> [acme@quaco perf]$ perf trace -h -D
> 
>  Usage: perf trace [<options>] [<command>]
>     or: perf trace [<options>] -- <command> [<options>]
>     or: perf trace record [<options>] [<command>]
>     or: perf trace record [<options>] -- <command> [<options>]
> 
>     -D, --delay <n>       ms to wait before starting measurement after program start
> 
> Perhaps we can move --graph-depth to --graph-opts and make -D/--delay be
> just like with 'perf record', 'perf stat' and 'perf trace'?
> 
> Will be super nice if one can go from:
> 
> 	perf stat --delay 100 workload
> 
> to see the default set of counters to:
> 
> 	perf ftrace --delay 100 workload
> 
> to get the ftrace output for that.
> 
> Ditto seeing the syscalls strace-like with:
> 
> 	perf trace --delay 100 workload
>
No problem. Now -D/--graph-depth is moved to --graph-opts.

> Regards,
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
