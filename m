Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0001C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945CF20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QtYUniZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgDWTki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:40:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248DDC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:40:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so3384132pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TE9RqET8gb6yd/mF6jLNfjNMqySu661hmaTZlbyjNjA=;
        b=QtYUniZ49hKbdV3hvFwNdJ5y4uUsyzf+RyUgL6JP8MQQ5LSjf0xRb+d71f9Zq4KbCK
         pZNSXqaNnGVlbOiZoMsh/w6fH6AlFnQQ90BU9M8LmqPc60dIkjizrfNCgk82T57IU//k
         /gnqC9/8aIbdVB4pus9FUd7zsjgdpyfUzRrzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TE9RqET8gb6yd/mF6jLNfjNMqySu661hmaTZlbyjNjA=;
        b=rM3KvgV9xiNsLfSCVr2Osk7i2ELZiemQEHCladseMQYtnPtK2PHcbLViqRcVMilO+k
         7eOVFoUG95/TeIWf5Hgmva0qbiP+DkyZMaBUHK/zgBGyu64FbFlzKsE1O7+1xGJOvr9g
         kW4B/t7SAZtZSsiJuTyFC0ELdX3eHE6gD7RKJFL2hfJqYV3DiI0U70JZhCcFilMAIeXF
         h13BlgTJx+JX0QlCijy614/nmaZ5QxkWNmY/y3xizPjCh+4aoveYDwWJcTcDna3aGUo4
         q2g2ot9war2cLZ1mPSjT9N8Qlx/Z+CsNKCdrLr5c6DMioBSO+FYFh4p5B2AojKWbHJ3+
         g1sA==
X-Gm-Message-State: AGi0PuYzhyEehVA3G5YHkzfHEqNe9mDVpC1r7ct+y6u5AOjzVfC+TWsy
        kRh8Ttxud93bmIer8zRfHI1r1g==
X-Google-Smtp-Source: APiQypK82TyZHWItbaUkL7MXha+tLDNF63U5KaSJlzWZ627EjgQrfx4lwhsS1uwrZiz9P8cNRedCrA==
X-Received: by 2002:a62:7912:: with SMTP id u18mr5057190pfc.239.1587670837622;
        Thu, 23 Apr 2020 12:40:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7sm2885473pga.15.2020.04.23.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:40:36 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:40:35 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <202004231237.AB249F90@keescook>
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

Reviewed-by: Kees Cook <keescook@chromium.org>

I'm glad to have the gcc bug opened for the function attribute; thanks
Nick! I needed that for the syscall entry code, but instead went with
a compilation-unit down-grade[1]. I'd much prefer the attribute. :)

-Kees

[1] https://lore.kernel.org/lkml/20200406231606.37619-5-keescook@chromium.org/

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

-- 
Kees Cook
