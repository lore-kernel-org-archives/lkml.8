Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC30C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A91220776
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro/13rop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDYBrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:47:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F8C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 18:47:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so9631595qtv.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 18:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=epmQdF3K+/5UFEAqHIAqosz9RuvSXw7j3oErS4DM4VQ=;
        b=Ro/13ropbfUNMMDS0NGJvViiX+3yITYXYlIx/FZkE3byg7LpANFLjNMf3pwvTdtJoV
         Ue0/Hlwr856KhHy7RzRPkno7zZavbxM84gfW1jXw1lTGLZiHhnShwslKfMcwPfzu7Tyt
         iiRZLSKDQRYICb240fdmDprWC9iEfsF5jlQTay0+tU0t2GOlMT0Nl3LVO7qkkP8c4G2X
         E29OIhFUpRFtg0I1oFKvHLkcbKm6MfhMvoCGEINkRz6hNo7rb0QvLhB8InzdI4E7sCzk
         zkLe99EB5X7SvNEu3JN1d3Ab3x3KMgt9FrhY+mJz11rzCUBjtS1ZzACqqaq3SsMGkFTt
         FWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=epmQdF3K+/5UFEAqHIAqosz9RuvSXw7j3oErS4DM4VQ=;
        b=K6apvFMXFnZmepM+IvmBwheZGXregL9SSZiee9nnxvi0mXptJMwIkMVRgYRyz/owVb
         qaXXqnZM+4p+N0j/P0kGfZk/L79+hk+RxxG41XHXDkT70uhzUOWxfsQKTrc7NBolXXk0
         zsb49xWFsfU15TOaWLqAaduNgsiw3bJTnwI9AOKAWjErEL9sjCFtupaLQTUd62UEcf2x
         HRhE4q2724JCTzTXzxybtt5FXn48wYB9zc0JVQDSNx33SWEFCxhpg+tkcTI40lj/Nmg6
         KYn8n4ZoaToUmRDVYrfUzpaPHSqtndm0mz9PALSoSNwl3qSjRuoUMHPJauijJpdWCoJ9
         T0LQ==
X-Gm-Message-State: AGi0Pub8MpFn7YG03731LQO68ALOzEY/bD0KQj/aWClc/Cte0khsD3yK
        XmargDx68fV/Umvg/Xk6h7k=
X-Google-Smtp-Source: APiQypLZeZI1JDN88NzyRhdRyOcwHbKtxqnL1/ZWGLRWk4Oqb/7UD1c4g/5jHez07G799b9TTpLylA==
X-Received: by 2002:ac8:6799:: with SMTP id b25mr12574813qtp.54.1587779220263;
        Fri, 24 Apr 2020 18:47:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z26sm5022351qkg.39.2020.04.24.18.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 18:46:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 24 Apr 2020 21:46:57 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425014657.GA2191784@rani.riverdale.lan>
References: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423161126.GD26021@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:12:24PM +0200, Borislav Petkov wrote:
> Ok,
> 
> I have tried to summarize our odyssey so far and here's what I came up
> with. Just built latest gcc from the git repo and it seems to work.
> 
> Next I need to come up with a slick way of testing the compiler...
> 
> Thx.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> ... or the odyssey of trying to disable the stack protector for the
> function which generates the stack canary value.
> 
> The whole story started with Sergei reporting a boot crash with a kernel
> built with gcc-10:
> 
>   Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
>   Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
>   Call Trace:
>     dump_stack
>     panic
>     ? start_secondary
>     __stack_chk_fail
>     start_secondary
>     secondary_startup_64
>   -—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary
> 
> This happens because gcc-10 tail-call optimizes the last function call
> in start_secondary() - cpu_startup_entry() - and thus emits a stack
> canary check which fails because the canary value changes after the
> boot_init_stack_canary() call.
> 
> To fix that, the initial attempt was to mark the one function which
> generates the stack canary with:
> 
>   __attribute__((optimize("-fno-stack-protector"))) ... start_secondary(void *unused)
> 
> however, using the optimize attribute doesn't work cumulatively
> as the attribute does not add to but rather replaces previously
> supplied optimization options - roughly all -fxxx options.
> 
> The key one among them being -fno-omit-frame-pointer and thus leading to
> not present frame pointer - frame pointer which the kernel needs.
> 
> The next attempt to prevent compilers from tail-call optimizing
> the last function call cpu_startup_entry(), shy of carving out
> start_secondary() into a separate compilation unit and building it with
> -fno-stack-protector, is this one.
> 
> The current solution is short and sweet, and reportedly, is supported by
> both compilers so let's see how far we'll get this time.
> 
> Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
> ---
>  arch/x86/kernel/smpboot.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3b9bf8c7e29d..e9f44727fccd 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -266,6 +266,14 @@ static void notrace start_secondary(void *unused)
>  
>  	wmb();
>  	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> +
> +	/*
> +	 * Prevent tail call to cpu_startup_entry() because the stack protector
> +	 * guard has been changed a couple of functions up, in
> +	 * boot_init_stack_canary() and must not be checked before tail calling
> +	 * another function.
> +	 */
> +	asm ("");
>  }
>  
>  /**
> -- 
> 2.21.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

The comment above boot_init_stack_canary's definition should be updated
to note that it needs to be called from a function that, in addition to
not returning, either has stackprotector disabled or avoids ending in a
tail call.

There are also other calls that likely need to be fixed as well -- in
init/main.c, arch/x86/xen/smp_pv.c, and there is a powerpc version of
start_secondary in arch/powerpc/kernel/smp.c which may also be affected.

Thanks.
