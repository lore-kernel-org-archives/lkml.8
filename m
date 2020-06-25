Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F70AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE942072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZms4slB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbgFYCAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389070AbgFYCAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:00:23 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B46C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:00:22 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id y3so750194vkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haPh2Xvd7Zt46zY+ZtekFR/RX9PHzoO9GWj53NuZJAg=;
        b=jZms4slBsFztIAOUylr/cALBwKqs7LOp4M06UnI3N6wUY7Wx89GY/oUw2v2mCerW3H
         5VYU6+xD6MkxP/svHFVvqxwXV4xDJvc8HlcmDkIAxQtelVzS5LZM2ZUi7vZIhQNrA7TI
         WC6isbl6OBTxZEPteEYdHTr5zwUnsKYinCBGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haPh2Xvd7Zt46zY+ZtekFR/RX9PHzoO9GWj53NuZJAg=;
        b=V7nqgzrZOGvwqA5sI1TCcKCIbZ9um1jPEKc/nm6OoaDnQZbNTHNs9Uv30KIa4I336N
         ePmfjzSN3K7UjFuFxgls3ButmhMMMSG8ldG8MpjZSYvlCEUxkIKgVKEpDm1La3juUxqf
         SjtJWptbMw8C/A/fxA15xojnz4h3jhpPoAqJZY6aiPjx0h0BgAZ2peHHdqzhN9bw3BJs
         XMOMRtSjwTk17EkjntdrG7UDv2D5cm0nqir43RqgBC3lzvIPDEhUNiHUSaG1r+E80Dtw
         s+c5AxXN0Oin1078naGuR1Z3t4LpvK2JEN3hx5c2Tzqbr30atMs1Rnt+WyngO+kRPPCq
         1Aiw==
X-Gm-Message-State: AOAM533VVsKwNcLCKP1E6qKLf1Nptasecp9MADhCLqrroVH8yoYXLaJS
        a55m+sA3i39HGU+AOeH02N/GQMdepHletWkoS/b43A==
X-Google-Smtp-Source: ABdhPJydWeOY40pKFEMO6Yr41VUFuo4Ro6+kbmxyCIJyVgV0ilXzBlgncKAJwc0X62UvnH7+TKymJSemHdSMrJtHhkg=
X-Received: by 2002:a1f:1e0b:: with SMTP id e11mr25308230vke.55.1593050420674;
 Wed, 24 Jun 2020 19:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200624084524.259560-1-drinkcat@chromium.org>
 <20200624120408.12c8fa0d@oasis.local.home> <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
In-Reply-To: <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 25 Jun 2020 10:00:09 +0800
Message-ID: <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 1:25 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 24, 2020 at 9:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 24 Jun 2020 16:45:24 +0800
> > Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > > trace_printk is only meant as a debugging tool, and should never be
> > > compiled into production code without source code changes, as
> > > indicated by the warning that shows up on boot if any trace_printk
> > > is called:
> > >  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> > >  **                                                      **
> > >  ** trace_printk() being used. Allocating extra memory.  **
> > >  **                                                      **
> > >  ** This means that this is a DEBUG kernel and it is     **
> > >  ** unsafe for production use.                           **
> > >
> > > If this option is set to n, the kernel will generate a build-time
> > > error if trace_printk is used.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > Interesting. Note, this will prevent modules with trace_printk from
> > being loaded as well.
>
> Nack.
> The message is bogus. It's used in production kernels.
> bpf_trace_printk() calls it.

Interesting. BTW, the same information (trace_printk is for debugging
only) is repeated all over the place, including where bpf_trace_printk
is documented:
https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L757
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/bpf.h#L706
https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace.c#L3157

Steven added that warning (2184db46e425c ("tracing: Print nasty banner
when trace_printk() is in use")), so maybe he can confirm if it's
still relevant.

Also, note that emitting the build error is behind a Kconfig option,
you don't have to select it if you don't want to (the default is =y
which allows trace_printk).

If the overhead is real, we (Chrome OS) would like to make sure
trace_printk does not slip into production kernels (we do want to
provide basic tracing support so we can't just remove CONFIG_TRACING
as a whole which would make trace_printk no-ops). I could also imagine
potential security issues if people print raw pointers/sensitive data
in trace_printk, assuming that the code is for debugging only.

Also, the fact that the kernel test robot already found a stray
trace_printk in drivers/usb/cdns3/gadget.c makes me think that this
change is working as intended ,-) (we're going to need to add a few
Kconfig deps though for other debugging options that intentionally use
trace_printk).
