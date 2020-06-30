Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD173206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5QTXRyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgF3Tro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgF3Trn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:47:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA37C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:47:43 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w17so17796114oie.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UKxlIJOTY2zx2nzmpDV6yMhwVzomovdk4iBLHXz+to=;
        b=b5QTXRyrtvJIel7TqOAPE7QxmKK0A0Kk/L9Y88ohrYuISTLLPdp5HH9fUHPSEDqcTq
         etgp/5shPJOkJzg9Azw7IAVltGons+60NY0zqsd3wibTXJCm7bDqpHR4MPEfSKZzdKFY
         RaVLrZFIUpykTrxj5+s/RbG50eBIV8k/bAMIsgo/F2IPeaMwuK8gvy97eT9jx28c4BLJ
         n+G1HzxZvlmPyqoBCikNS2FAk3hiUfcugrxlaT9FJD/xkpXz+luMfWgNw9gAEJLh0JfU
         sbJELKGA/NjGmfY/jqBwt2FR3nBPIvf0eHx8gW0vJwhwxCXQXRWsrnRGHLL8vwBPP+iw
         v1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UKxlIJOTY2zx2nzmpDV6yMhwVzomovdk4iBLHXz+to=;
        b=kR1DjWvSttyKzL8zjzufA598W0CI0/D9uknAvlv8FAQZEr2p6Fc1GVQPlLmfJNRuF4
         OkWdtnDGQsebAdfKfI1NzsPuc2zaEDF9lP/X3Oat78TZy/JQWtKHj1UN8vmbIpHKXKyO
         xi6TLBrv4oYc1QZp0uNYDne9jfidmOJagC36pPfGfJx7RgugaEqXBrwAxPYNla9QATsc
         xkPll+UXtr1A6OWAPi9k80MAUn2u5H87r9kqWyKeExmp3nYz7KPWZVFQmghy6hlSLKly
         oj7ORhqNAyScfhpZXer+HWvOaoeyFKEKE/oERZ+eieyM5AJIwPpvTKLCMSzW/+55142M
         R0ng==
X-Gm-Message-State: AOAM5318a2OgobRTZf1Qa7zJKOp8AQ/36+nm5MN2aeZiQeN1w2noOBB3
        Pkv0VRsOraaQH6BFaNZWSVXC7xriaDPp/pTy04E5Hg==
X-Google-Smtp-Source: ABdhPJzl9oZuNesnaQZ/teRrLRE7pNmT9CEUr1yOCRE9DkovB1JFdxUa5I7sAEWXrcc+60LRYFXJ6PfgRURsOozdFbY=
X-Received: by 2002:a05:6808:3ab:: with SMTP id n11mr12490827oie.121.1593546462237;
 Tue, 30 Jun 2020 12:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 30 Jun 2020 21:47:30 +0200
Message-ID: <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 at 19:39, Will Deacon <will@kernel.org> wrote:
>
> When building with LTO, there is an increased risk of the compiler
> converting an address dependency headed by a READ_ONCE() invocation
> into a control dependency and consequently allowing for harmful
> reordering by the CPU.
>
> Ensure that such transformations are harmless by overriding the generic
> READ_ONCE() definition with one that provides acquire semantics when
> building with LTO.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso/Makefile   |  2 +-
>  arch/arm64/kernel/vdso32/Makefile |  2 +-
>  3 files changed, 65 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/rwonce.h

This seems reasonable, given we can't realistically tell the compiler
about dependent loads. What (if any), is the performance impact? I
guess this also heavily depends on the actual silicon.

I do wonder, though, if there is some way to make the compiler do
something better for us. Clearly, implementing real
memory_order_consume hasn't worked out until today. But maybe the
compiler could promote dependent loads to acquires if it recognizes it
lost dependencies during optimizations. Just thinking out loud, it
probably still has some weird corner case that will break. ;-)

The other thing is that I'd be cautious blaming LTO, as I tried to
summarize here:
https://lore.kernel.org/kernel-hardening/20200630191931.GA884155@elver.google.com/

The main thing is that, yes, this might be something to be worried
about, but if we are worried about it, we need to be worried about it
in *all* builds (LTO or not). My guess is that's not acceptable. Would
it be better to just guard the promotion of READ_ONCE() to acquire
behind a config option like CONFIG_ACQUIRE_READ_DEPENDENCIES, and then
make LTO select that (or maybe leave it optional?). In future, for
very aggressive non-LTO compilers even, one may then also select that
if there is substantiated worry things do actually break.

Thanks,
-- Marco
