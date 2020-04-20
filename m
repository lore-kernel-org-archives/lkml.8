Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C857C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B0820575
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587415600;
	bh=X3BjbPsb978yPTzpi4aAOOJ+sJjZ6cuIqQuH9zBeKU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jTgmkWEgNgHZbybE3SmaSibL1E4jhPa4ME9kMlHSMmBsEVDaHlWxk7h6AYeSUmo6V
	 hp0aOJS7A3vhqCDj2WLUU7Ds4kUUXC9Crlp9IRgpKizCCu2C2Z75gXfbAJ4cCrutzX
	 XkXaqi3+TfXYMcinqumPPCtcfhChzIHZQWzmlW8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDTUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgDTUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:46:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:46:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so9238061lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlaaVbm8PuebFJl/q63Tt+vA9aaeM21+f84Se7YPrVk=;
        b=IeyZiD2b5ww4LcmgBhjJAIyDJH/nL1yFN68MXiPJ5Rxcul6oFhjIyBWGxbK06/bW34
         3s7lJfT9DTUdt4FDYgflOIqw5NeAOwgt0vX4JgYIi4os7Dw7D9EOJbsrdiluBqX2dEfL
         KnnfIX9RrBlu8lC5HNlW/lH1/EQZTSFFinSss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlaaVbm8PuebFJl/q63Tt+vA9aaeM21+f84Se7YPrVk=;
        b=rvg23n/oFWK3Cq+DDxjmBO0DFDCcUSPwT7eb6/FIpyLtEUPJCUOmWso+jQBWqM5d42
         FzgsxnNafgHL/t4vSsi24lNoLEtxry+O5/6sH4nui175e6Uh6QYxP9Do0xhYNcEtkLzg
         3iSpEqpCgYG2Av7Ytt/+MbhtI0Bc2/E3De8LHjhzJy6PMwWsIoyFT7rsuF+duJUZnsTW
         p8Y51tzpsRan8KgEWBpEIc4euLbVWl5vG0ql5+fXyvY5oh/oa2+HjqjrISbcuJBb0kGK
         2CiM+4tFjT8oF5589IA3nJXnJ8QUVsyTq2txAZm6W2wtufk7ob4sg3NsjXU74E/GusOr
         IOEA==
X-Gm-Message-State: AGi0PuYPOKzjVdolNKZthzS+2EXsvgiBaLhZEJ7V8VN2F1QpOmp0xcFe
        TWZtkNEXgjYNfITyVMxDc+TSJSUJmU8=
X-Google-Smtp-Source: APiQypIQQFYyAx9nxqh41pu8SYT6Bk/XNcDoFp9ohJZTRSYqm3776i/WZ4N9IFOEA1XLX8wny2ArQg==
X-Received: by 2002:a19:7706:: with SMTP id s6mr11608262lfc.31.1587415595971;
        Mon, 20 Apr 2020 13:46:35 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p8sm362362ljn.93.2020.04.20.13.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:46:35 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id j3so11549038ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:46:34 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr878197ljg.204.1587415594444;
 Mon, 20 Apr 2020 13:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com> <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
In-Reply-To: <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 13:46:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
Message-ID: <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> ...but also some kind of barrier semantic, right? Because there are
> systems that want some guarantees when they can commit or otherwise
> shoot the machine if they can not.

The optimal model would likely be a new instruction that could be done
in user space and test for it, possibly without any exception at all
(because the thing that checks for errors is also presumably the only
thing that can decide how to recover - so raising an exception doesn't
necessarily help).

Together with a way for the kernel to save/restore the exception state
on task switch (presumably in the xsave area) so that the error state
of one process doesn't affect another one. Bonus points if it's all
per-security level, so that a pure user-level error report doesn't
poison the kernel state and vice versa.

That is _very_ similar to how FPU exceptions work right now. User
space can literally do an operation that creates an error on one CPU,
get re-scheduled to another one, and take the actual signal and read
the exception state on that other CPU.

(Of course, the "not even take an exception" part is different).

An alternate very simple model that doesn't require any new
instructions and no new architecturally visible state (except of
course the actual error data) would be to just be raising a *maskable*
trap (with the Intel definition of trap vs exception: a trap happens
_after_ the instruction).

The trap could be on the next instruction if people really want to be
that precise, but I don't think it even matters. If it's delayed until
the next serializing instruction, that would probably be just fine
too.

But the important thing is that it

 (a) is a trap, not an exception - so the instruction has been done,
and you don't need to try to emulate it or anything to continue.

 (b) is maskable, so that the trap handler can decide to just mask it
and return (and set a separate flag to then handle it later)

With domain transfers either being barriers, or masking it (so NMI and
external interrupts would presumably mask it for latency reasons)?

I dunno. Wild handwaving. But much better than that crazy
unrecoverable machine check model.

                   Linus
