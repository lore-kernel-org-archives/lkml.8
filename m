Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F42C2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C6020732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zv3t+mfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgC3Stg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:49:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51312 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Stg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:49:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so21135610wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ik9JoE1yePkVW5pMmW8sNiDPHUTcFN32pUnnOtmd2X8=;
        b=Zv3t+mfLAKwrtFlPXDlkRFJdfWkKdKBiP6oxIrn1G5XRV9GptwT8+6Lag7mLLRdVpg
         MF+qJjLwk9SjGSI+B43Ogf7Qh3oZen/QxCAup76xenOzvYfgO+pgi6FJYjDZRhvLn1/H
         quu1s+8IvShUGn8KiVxeU0qVnmlVVhfKaYfwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ik9JoE1yePkVW5pMmW8sNiDPHUTcFN32pUnnOtmd2X8=;
        b=BhSzW1ixanmqjmnF2gmozcGSL0AWmyoHiOoJjj4wOVi3FSFn8GVJQYwrBzuaOA1akE
         98zaaeUbJccC5OGVlQTX3y8Qww8z5h5LFzeOFrRFNNwARUtS7wFgmCaoRYsQMiPP1wH7
         zvXgLKBY2oV1Te9uQs+BLx9d4vHxEGsapPp3r3hfkAgxY6xtyVbsrZv8yujuYYz3xH9I
         CSlvEKg6k9z9wGLnDr3rGAXPCelXodWDSmZ2zOproOIKCHE5aSya6nK9pxPGLKyxmXXI
         oj6RMnwzghsEjdNpvyxw0bMQxvjZhzNM5LvPhyP0CK+YyR5BDSWCfYazgKXnb1FVHfIM
         qGxQ==
X-Gm-Message-State: ANhLgQ1gLYSpummKfrb8pthx5dN1GpNG2rXYQdZezMmiLBxXek2k1y8x
        6Lc4Q7poKmUNeEuro8AllVCeDw==
X-Google-Smtp-Source: ADFU+vupkbpxkRBF/jrJ9ZlFwutT/7Z3g9rubooBJWdjmh/ugoXzX8CRCRZ5ixDknBTQK+6eaM3OvQ==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr675797wmc.53.1585594173976;
        Mon, 30 Mar 2020 11:49:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id h26sm500703wmb.19.2020.03.30.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:49:33 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Mar 2020 20:49:32 +0200
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: linux-next: Tree for Mar 30 (bpf)
Message-ID: <20200330184932.GB180081@google.com>
References: <20200330204307.669bbb4d@canb.auug.org.au>
 <86f7031a-57c6-5d50-2788-ae0e06a7c138@infradead.org>
 <d5b4bd95-7ef9-58cb-1955-900e6edb2467@iogearbox.net>
 <CACYkzJ72Uy9mnenO04OJaKH=Bk4ZENKJb9yw6i+EhJUa+ygngQ@mail.gmail.com>
 <20200330180538.GA180081@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330180538.GA180081@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Mar 20:05, KP Singh wrote:
> On 30-Mar 19:54, KP Singh wrote:
> 
> So, it looks like bpf_tracing_func_proto is only defined when
> CONFIG_BPF_EVENTS is set:
> 
>         obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
> 
> We have a few options:
> 
> * Add a __weak symbol for bpf_tracing_func_proto which we have done in
>   the past for similar issues. This however, does not make much sense,
>   as CONFIG_BPF_LSM cannot really do much without its helpers.
> * Make CONFIG_BPF_LSM depend on CONFIG_BPF_EVENTS, this should solve
>   it, but not for this particular Kconfig that was generated. Randy,
>   I am assuming if we add the dependency, this particular Kconfig
>   won't be generated.
> 
> I am assuming this patch now needs to be sent for "bpf" and not
> "bpf-next" as the merge window has opened?

I am wrong, I will send the patch targeted for "bpf-next" and they
will be applied after merge window closes (and the -next tree opens).

Apologies for the confusion.

- KP

> 
> - KP
> 
> > Thanks for adding me Daniel, taking a look.
> > 
> > - KP
> > 
> > On Mon, Mar 30, 2020 at 7:25 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > [Cc KP, ptal]
> > >
> > > On 3/30/20 7:15 PM, Randy Dunlap wrote:
> > > > On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> > > >> Hi all,
> > > >>
> > > >> The merge window has opened, so please do not add any material for the
> > > >> next release into your linux-next included trees/branches until after
> > > >> the merge window closes.
> > > >>
> > > >> Changes since 20200327:
> > > >
> > > > (note: linux-next is based on linux 5.6-rc7)
> > > >
> > > >
> > > > on i386:
> > > >
> > > > ld: kernel/bpf/bpf_lsm.o:(.rodata+0x0): undefined reference to `bpf_tracing_func_proto'
> > > >
> > > >
> > > > Full randconfig file is attached.
> > > >
> > >
