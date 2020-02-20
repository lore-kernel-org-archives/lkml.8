Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88818C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F61206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCDh9AP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgBTOG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:06:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34095 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:06:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so4814917wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0F1N3hYW8XPNj9N+S4lYxuaShUHuL9nYAipAxCIxV0=;
        b=lCDh9AP38v1XCfFwz0C+1p9iDiQBHd6gcRFBu+7yWtc8nR306339+u4SIty39ttOSw
         KL+DnTDIXBQd3MjiakCsGw/EmAOj3Ds4Tve3GvZaJLXyDZZnoT80T+88TlH7JpQr5Gxq
         aS6+gjE6ltXo+BnK6ryzUr5JqsDYZLRB4QoMDTc3wtpmfPqbbjzcIgWJJ6LHHtXuc++3
         ZgQ/ZnbAMKbm3u+aBQnj2vRV1RMkNaCjbUrlE4kR+F0AlAUEKNEOsBwOpo2c1OSSIQiP
         Z/r8HyXzOdFKz68yB9RN+BYVwVggk6OhbHnbpZQpjQMHisvjAKND22ZwR7P0Zs+oOHlZ
         7omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0F1N3hYW8XPNj9N+S4lYxuaShUHuL9nYAipAxCIxV0=;
        b=ty8uJGFifitD8V17EVOauktCY2NaLY08JGd1AxLaNZYfs8gwVKCQG55pb/aLHw0Y1b
         GJCAXYzxnKlgI2kUMFG/I3V0sG7Eqwa2DYnKtmLi0CVRGQ7+voUjFyTnYxKAiLrHi0YM
         O8S8W3GPayJQg8HDyfQfuABfUZ2lkpoKQ37oIdciHxLl7lOrYwvrxBAiIj03cEe9PaZf
         jdJPFAidgYRnuOR0XFTM7iXrhFfP8d18KfU5SgYeOwzYA4BU/7uZSA8I6N7TE2xnwoRN
         8H/4DJGiymAg/fQzXA1ohzLVDHka8gWkk/W1no4Loo3MitGOif8fBH4rzSusKWGQjFNJ
         CODw==
X-Gm-Message-State: APjAAAUKY25CoLbNz6Pq/wP/8Y5E4a1arV4fE+J6ofgXQUkjQfcwlSvI
        +HYhNrVLAdWnMHLTWcCz/kVjBQ==
X-Google-Smtp-Source: APXvYqyFzUzkzzWprBxCZ2Rh6rcejpx7I7pfLYPR0QigPJpd9+RwX86jKPuqI5aHWgWd2H6b1JS8KQ==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr40697146wru.233.1582207613733;
        Thu, 20 Feb 2020 06:06:53 -0800 (PST)
Received: from holly.lan (89-145-231-170.xdsl.murphx.net. [89.145.231.170])
        by smtp.gmail.com with ESMTPSA id w1sm4664917wmc.11.2020.02.20.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:06:53 -0800 (PST)
Date:   Thu, 20 Feb 2020 14:06:50 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     minyard@acm.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220140650.tryvv3ishkxduujk@holly.lan>
References: <20200219152403.3495-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219152403.3495-1-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> I was working on a single-step bug on kgdb on an ARM64 system, and I saw
> this scenario:
> 
> * A single step is setup to return to el1
> * The ERET return to el1
> * An interrupt is pending and runs before the instruction
> * As soon as PSTATE.D (the debug disable bit) is cleared, the single
>     step happens in that location, not where it should have.
> 
> This appears to be due to PSTATE.SS not being cleared when the exception
> happens.  Per section D.2.12.5 of the ARMv8 reference manual, that
> appears to be incorrect, it says "As part of exception entry, the PE
> does all of the following: ...  Sets PSTATE.SS to 0."
> 
> However, I appear to not be the first person who has noticed this.  In
> the el0-only portion of the kernel_entry macro in entry.S, I found the
> following comment: "Ensure MDSCR_EL1.SS is clear, since we can unmask
> debug exceptions when scheduling."  Exactly the same scenario, except
> coming from a userland single step, not a kernel one.
> 
> As I was studying this, though, I realized that the following scenario
> had an issue:
> 
> * Kernel enables MDSCR.SS, MDSCR.KDE, MDSCR.MDE (unnecessary), and
>   PSTATE.SS to enable a single step in el1, for kgdb or kprobes,
>   on the current CPU's MDSCR register and the process' PSTATE.SS
>   register.
> * Kernel returns from the exception with ERET.
> * An interrupt or page fault happens on the instruction, causing the
>   instruction to not be run, but the exception handler runs.
> * The exception causes the task to migrate to a new core.
> * The return from the exception runs on a different processor now,
>   where the MDSCR values are not set up for a single step.
> * The single step fails to happen.
> 
> This is bad for kgdb, of course, but it seems really bad for kprobes if
> this happens.
> 
> To fix both these problems, rework the handling of single steps to clear
> things out upon entry to the kernel from el1, and then to set up single
> step when returning to el1, and not do the setup in debug-monitors.c.
> This means that single stepping does not use
> enable/disable_debug_monitors(); it is no longer necessary to track
> those flags for single stepping.  This is much like single stepping is
> handled for el0.  A new flag is added in pt_regs to enable single
> stepping from el1.  Unfortunately, the old value of PSTATE.SS cannot be
> used for this because of the hardware bug mentioned earlier.
> 
> As part of this, there is an interaction between single stepping and the
> other users of debug monitors with the MDSCR.KDE bit.  That bit has to
> be set for both hardware breakpoints at el1 and single stepping at el1.
> A new variable was created to store the cpu-wide value of MDSCR.KDE; the
> single stepping code makes sure not to clear that bit on kernel entry if
> it's set in the per-cpu variable.
> 
> After fixing this and doing some more testing, I ran into another issue:
> 
> * Kernel enables the pt_regs single step
> * Kernel returns from the exception with ERET.
> * An interrupt or page fault happens on the instruction, causing the
>   instruction to not be run, but the exception handler runs.
> * The exception handling hits a breakpoint and stops.
> * The user continues from the breakpoint, so the kernel is no longer
>   expecting a single step.
> * On the return from the first exception, the single step flag in
>   pt_regs is still set, so a single step trap happens.
> * The kernel keels over from an unexpected single step.
> 
> There's no easy way to find the pt_regs that has the single step flag
> set.  So a thread info flag was added so that the single step could be
> disabled in this case.  Both that flag and the flag in pt_regs must be
> set to enable a single step.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

I've pointed the kgdbtest suite at this patch (and run one of the
historically unstable test cases an extra 100 times just in case).

kgdbtest hasn't got great coverage, runs the code in qemu and some
of the strongest tests are still marked XFAIL on arm64 (for reasons
unrelated to stepping).

So the best I can say based on the above is that the test suite does not
observe any regression (but equally no improvement). Nevertheless FWIW:


Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
