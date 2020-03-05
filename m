Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C91421556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax2LpaR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEGKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:10:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEGKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:10:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id q23so4707130ljm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 22:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ro8am7a9jQLdIZetuCdvfxJqUN28W5E/77Aw6bQng0=;
        b=Ax2LpaR4Il8cA7nnnTi2xkhLuJJZ+SoN4TUH2Tfi5AwG714n+Nl0c/xh2wIX9lgNLn
         E3MzJdaxn+kuidsbAzchkhHh4zOKk24NGY288+XGqUwfmlBL4bJUlGRkb2NNyJHAGq0p
         d5AhWDAnvb6GQGCXdl8Fq4Y44qK4s3Ndp5zF+bnAAxVprG+MFqAi7CirTd1JCwSHuYty
         EsBv+KkGN/Bn0B+t313h9hVrFy7N1R/TuRqky9Z8UVGjYdOnj8bpc4gNkrL1eoWMgh9W
         gSml9tO80TFElM1MyZrCuSyqryHWbF67wqlNvexqkUtLXhtCiDKMv7QU/o9mS6YoxnTd
         XY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ro8am7a9jQLdIZetuCdvfxJqUN28W5E/77Aw6bQng0=;
        b=dLZoK5amYl2fXB2GPBN9Fkr9M+g6eHnkjWL/qFulLkCvsiVa33IDyo4M9rs6S6Kq2y
         fptxtA8gagMxFvLMNfRgO+z9lNWPxerVi+vesQdPreL42Sm3pASZCe/yEh8HJLWmIDw8
         GinRxmtKyDqq3wyTWEDzaektEFA7UzsLPLqdNckgYNH2Ddup3P506fNNqpt7zOrU7K+b
         1kQOPkXOy9Ovv3ua246v0flk4Mq3pnGs49DDKcqM0CeYWTD4/G2aKE4ToFN1x7RXy6V/
         WDvjL/n6e7TCe3C+UMT6MI75UTqugwoxxMdsOWVeZlxNM0HAtxRVTaubU88JPlSHMM+O
         TOwA==
X-Gm-Message-State: ANhLgQ1x3WvcnOsPFWXEHuG1J2qU/M+ll+puTEPsKRgufSfnzc+Xp30S
        2QLpvy97/7yHYcc4t8z02PmwS+HF4VZBkYCQFEI=
X-Google-Smtp-Source: ADFU+vvmtHpLJSceCa6BQ4gUhQzr7QeYuDpzeQXCFi6PZugxcnNoYEZLgevPiYpJyzv6zavLaKlixxU23E3Pna6Xn0o=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr4340445ljg.144.1583388622057;
 Wed, 04 Mar 2020 22:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20200304090633.420-1-adrian.hunter@intel.com> <20200304090633.420-4-adrian.hunter@intel.com>
 <20200305145852.5756764a9ffe5da10ae71c3e@kernel.org>
In-Reply-To: <20200305145852.5756764a9ffe5da10ae71c3e@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Mar 2020 22:10:10 -0800
Message-ID: <CAADnVQL1nDy4Fa5Y02r0Mg89nhRTf81ow5tCQxuyHeAztTvj8g@mail.gmail.com>
Subject: Re: [PATCH V4 03/13] kprobes: Add symbols for kprobe insn pages
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 10:01 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >       # perf probe __schedule
> >       Added new event:
> >         probe:__schedule     (on __schedule)
> >       # cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
> >       ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
> >       ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]
> >
> > Note: This patch adds "__builtin__kprobes" as a module name in
> > /proc/kallsyms for symbols for pages allocated for kprobes' purposes, even
> > though "__builtin__kprobes" is not a module.
>
> Looks good to me.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> BTW, would you also make a patch to change [bpf] to [__builtin__bpf]?

Please do not.
There is nothing 'builtin' about bpf.
