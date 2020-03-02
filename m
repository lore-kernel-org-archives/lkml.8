Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28C0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7798024676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uga3wDMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCBSb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:31:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33859 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:31:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id g6so255950oiy.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5zc76Fdz+bJVXzSQGbzBzVXZNM5xUhVIZ7ZJyJk0S0=;
        b=Uga3wDMUkWwXE5tHNv2a97Zp6mCHgCe+1C1PTkbrKQrGI8tfVoqqyE26+m+VkLoJ01
         KXxSiHthuMwAeAk+rDcUV62fNAU+IvOj4Xfmiq5/+Wtu5IIxSxXAsrHquQOWyR4MflVx
         yZiYJ3zW8/CLEvontWYfzsmNfghJXgqEm2gHbnjPysUxalCops1zC/DNXUNs3d2AEBxH
         ZjYWh2TlFhsBLJKyFNo95Fu6ItoYeZyPLhBTKNHPUedndktiLNvn7ThHegA30BQDePW0
         eaQmnX1IITDRRwkEAiVzvCjRjOWSf0eBTrLez0iLFV/3biPe9ckSAUOQj/KfDzvmSZnY
         bnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5zc76Fdz+bJVXzSQGbzBzVXZNM5xUhVIZ7ZJyJk0S0=;
        b=X/NnxknbPFocYrjNwtoP6pV7Z/nhcLYc936ghdqUIAeBH+tTe81qLQLm2WQ68BDIwq
         YXPBiA2gzdVgOHuR2WjNnaT8bpPWneDlo6xtLgQ+It0hpNjIdlR84NZxaQXBGniAedfB
         6mvR2ef14snwt2+Ib/M2ju1Qu8K/JxO6u6JBBvDDQWeAudLMd7TS0NUGfcI3OXq2meKr
         Vzg542FMKN499KaAz/IeWVxPtslhKZsBFXvu2SHi60TJfUvolX81v+lAronU/J42oszb
         caWcUZC1vvO8Z856MtbuvRh4GE08HniLgG6t6pnQNo8TWy3MmYMso8pdT84i0Df0L5xJ
         MPTw==
X-Gm-Message-State: ANhLgQ2WErPXbbSQrpnBcopZajNRHUshG5Pv3ePZJq41IuS7RUTqoGMn
        o8MJ0cQGBdFWiKu/w+at5ECyzAha+TWDCLoBKQ85jA==
X-Google-Smtp-Source: ADFU+vvXaqJBInvF+5ETBIuxxC3EfWkUVVfy8dqWP0DZZSHrfPicWDuaN9bpcELzGK3h4ad0Mnn8rtSnbDnHdPuUITg=
X-Received: by 2002:aca:b187:: with SMTP id a129mr290744oif.175.1583173887129;
 Mon, 02 Mar 2020 10:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com> <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
In-Reply-To: <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Mar 2020 19:31:01 +0100
Message-ID: <CAG48ez3sPSFQjB7K64YiNYfemZ_W9cCcKQW34XAcLP_MkXUjCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Alexander Potapenko <glider@google.com>
Cc:     Joe Perches <joe@perches.com>, Todd Kjos <tkjos@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 7:17 PM Alexander Potapenko <glider@google.com> wrote:
> On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-03-02 at 14:25 +0100, Alexander Potapenko wrote:
> > > On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> > > > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > > > Certain copy_from_user() invocations in binder.c are known to
> > > > > unconditionally initialize locals before their first use, like e.g. in
> > > > > the following case:
> > > > []
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > []
> > > > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > > > >
> > > > >               case BC_TRANSACTION_SG:
> > > > >               case BC_REPLY_SG: {
> > > > > -                     struct binder_transaction_data_sg tr;
> > > > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > > > >
> > > > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> > > >
> > > > I fail to see any value in marking tr with __no_initialize
> > > > when it's immediately written to by copy_from_user.
> > >
> > > This is being done exactly because it's immediately written to by copy_to_user()
> > > Clang is currently unable to figure out that copy_to_user() initializes memory.
> > > So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
> > > the following code:
> > >
> > >   struct binder_transaction_data_sg tr;
> > >   memset(&tr, 0xAA, sizeof(tr));
> > >   if (copy_from_user(&tr, ptr, sizeof(tr))) {...}
> > >
> > > This unnecessarily slows the code down, so we add __no_initialize to
> > > prevent the compiler from emitting the redundant initialization.
> >
> > So?  CONFIG_INIT_STACK_ALL by design slows down code.
> Correct.
>
> > This marking would likely need to be done for nearly all
> > 3000+ copy_from_user entries.
> Unfortunately, yes. I was just hoping to do so for a handful of hot
> cases that we encounter, but in the long-term a compiler solution must
> supersede them.
>
> > Why not try to get something done on the compiler side
> > to mark the function itself rather than the uses?
> This is being worked on in the meantime as well (see
> http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
> Do you have any particular requisitions about how this should look on
> the source level?

Just thinking out loud: Should this be a function attribute, or should
it be a builtin - something like __builtin_assume_initialized(ptr,
len)? That would make it also work for macros, and it might simplify
the handling of inlining in the compiler. And you wouldn't need such a
complicated attribute that refers to function arguments by index and
such. The downside would be that it wouldn't work for non-inlined
functions without creating inline wrappers around them...
