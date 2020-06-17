Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDB92080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zv03sXe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQVah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:30:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C4C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:30:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so4705247ljm.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNW7nFhEI6LZ3FAxGyejnyXZOUx5LRT59wBgGEUa2pY=;
        b=Zv03sXe7v0sm71NEVWABUiuV4WyfDQu+Vs148YdDBnqH+4dqnrH44dgt+Q3K/yoy/P
         JM1bmY3MokvZ5hruRGoUqhtE5gF80UDRsSTfFtfGGU0KFl8PSmak0Eb+XxDITH7uBk5E
         CmPR+kDoIBaq0vFyY9U/4AM9piSYRzTOM2BdoFT/6WM0V2UuPBVuPdd76gMUAfhqU7wx
         uLhxQ+Ozk2LfJlnLgUwEKxcGpemsvojHAXWhEexBUuwz7R0XuAyHedvdkWrnWe38nrdy
         vTUfjMr8mLl0KpytbOoVfW94I3Wy1ZDSZENvD8WoJ7tCYsXx0oMQTbC6d0PB/5+MiGN2
         ANcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNW7nFhEI6LZ3FAxGyejnyXZOUx5LRT59wBgGEUa2pY=;
        b=iM6cX5Y9llXcxDXYr4jCUra780Yj6I0dNPfqcio66vB05r4ZmI6WZQ8G7ub6671AXf
         iUP57ZtNLwrjHYEZJCsBOVk7lwRgVd5xiwm1VCD7GKE+XHzvHRxJlJsWIJ4cEGo+ac3W
         YAe8cQqbC1Hf0hv5cfsh1zHRKrz6k77u7pAo9czowZglvf8CzOoPaUYJjenipbSkiWu1
         BffS4/OrfMwgEt7NAFEl0pxu8J/GApRuGkrOfw/ZMA0AYH9suFzHi9EVf3gT+VJ3ipMo
         TVfBj9DxvigUBvTku5dcBQJZvwJ7nm8R8giEvtt1a5/f8e7VoySDyjtl1Bb9nQCk9hEx
         N20w==
X-Gm-Message-State: AOAM533ji6V+3bBAZ1Xk6Y8IRTMLdUoQoGN14KHb+6iu8EAo//xrjFmX
        UL0/S9llK0KyXKVmaQNkNxQZcltwITAhPqpl94UeXA==
X-Google-Smtp-Source: ABdhPJzakSe2kPNs0RHEHuWLZIpA5pDXEDizg3WJ/E4xujDLcUowT4+GDEOfZ9+AA0b1YMzCv0voiQly6qgNG2yriEo=
X-Received: by 2002:a2e:7f02:: with SMTP id a2mr590399ljd.138.1592429434462;
 Wed, 17 Jun 2020 14:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200617165616.52241bde@oasis.local.home>
In-Reply-To: <20200617165616.52241bde@oasis.local.home>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Jun 2020 23:30:07 +0200
Message-ID: <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Use linker magic instead of recasting ftrace_ops_list_func()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:56 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, all function casts need to be
> removed.
>
> This means that ftrace_ops_list_func() can no longer be defined as
> ftrace_ops_no_ops(). The reason for ftrace_ops_no_ops() is to use that when
> an architecture calls ftrace_ops_list_func() with only two parameters
> (called from assembly). And to make sure there's no C side-effects, those
> archs call ftrace_ops_no_ops() which only has two parameters, as
> ftrace_ops_list_func() has four parameters.
>
> Instead of a typecast, use vmlinux.lds.h to define ftrace_ops_list_func() to
> arch_ftrace_ops_list_func() that will define the proper set of parameters.
>
> Link: https://lore.kernel.org/r/20200614070154.6039-1-oscar.carter@gmx.com
[...]
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
[...]
> +                       ftrace_ops_list_func = arch_ftrace_ops_list_func;
>  #else
>  # ifdef CONFIG_FUNCTION_TRACER
>  #  define MCOUNT_REC() ftrace_stub_graph = ftrace_stub;
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
[...]
> +/* Defined by vmlinux.lds.h see the commment above arch_ftrace_ops_list_func for details */
> +void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> +                         struct ftrace_ops *op, struct pt_regs *regs);
[...]
> +void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
>  {

Well, it's not like the function cast itself is the part that's
problematic for CFI; the problematic part is when you actually make a
C function call (in particular an indirect one) where the destination
is compiled with a prototype that is different from the prototype used
at the call site. Doing this linker hackery isn't really any better
than shutting up the compiler warning by piling on enough casts or
whatever. (There should be some combination of casts that'll shut up
this warning, right?)

IIUC the real issue here is that ftrace_func_t is defined as a fixed
type, but actually has different types depending on the architecture?
If so, it might be cleaner to define ftrace_func_t differently
depending on architecture, or something like that?

And if that's not feasible, I think it would be better to at least
replace this linker trickery with straightforward
shut-up-the-compiler-casts - it'd be much easier to understand what's
actually going on that way.
