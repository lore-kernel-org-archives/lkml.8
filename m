Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8DE217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTKb1GkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGNAQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGNAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:16:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BDFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:16:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so6780670pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cDAVMiAV9Cf2sMWMCcN1ErVnmUCkKb59fUbYq+8rtyg=;
        b=eTKb1GkAhSQsJaOrZAoKTPiCrHpSdAdM/ujzzqP/yT1BAdpe49gHv4/LXShcE0Kkqv
         V2wHXdoiptBRUlGNpdWRA8baRPnJz2z5xo6Aick4R59c72qrU1f+SHVaqFkKpfWKRyvc
         CUe19gqaNV9466MwwX6l7vQDvSVPNkyu/LtRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDAVMiAV9Cf2sMWMCcN1ErVnmUCkKb59fUbYq+8rtyg=;
        b=DX7W2kfDqJibSyxxZiEsJ3m1HUG2ooTO95d+2o07hcQsNvySQu3hd9BqarqLMZ1NIs
         1VtEt3SId+Ux1ShBMQiYZlqlR9Z1Tkm83k4zmcmhn3SNOcf+P8fhoHg+/dKTW4gabksB
         uR6VtOavVZi7NQSntNYWaSQuie2Sd0wNvf/svRzL8RioOPwLZUkY/EReKl6GKjZQoxqr
         Nrp6ne4y2B/U/HguWy0KgM2e3OxwUfrd6zpo3EpqfQFBy8MqiCYHm+gTo6v9bv+heHMC
         PIx1bHa91QUdbrAIQPSVo33E7ziUDwQtsxPPP3IjPSw+4u9yefkDcK7kS7rNeMQYevCs
         ey7w==
X-Gm-Message-State: AOAM532XZ/rmWxDq8bXLKeUYUHMbVYTQ3NSrqR9J3A9v0qq9W4Fy9GVa
        4CuqBZwNHdGJo9DCkK5LXTLDiQ==
X-Google-Smtp-Source: ABdhPJwCmF2RTsgXJuYWMD+fnjEGodzv9ddQ3n6eDmcaxz1YZK3kEzwEHt2mMSc/49VmgiiaPKDDAg==
X-Received: by 2002:a63:e045:: with SMTP id n5mr1408753pgj.274.1594685765748;
        Mon, 13 Jul 2020 17:16:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s68sm625948pjb.38.2020.07.13.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:16:04 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        willy@infradead.org, luto@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gofmanp@gmail.com, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v3 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202007131715.5598282C@keescook>
References: <20200712044516.2347844-1-krisman@collabora.com>
 <20200712044516.2347844-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712044516.2347844-2-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 12:45:15AM -0400, Gabriel Krisman Bertazi wrote:
> Introduce a mechanism to quickly disable/enable syscall handling for a
> specific process and redirect to userspace via SIGSYS.  This is useful
> for processes with parts that require syscall redirection and parts that
> don't, but who need to perform this boundary crossing really fast,
> without paying the cost of a system call to reconfigure syscall handling
> on each boundary transition.  This is particularly important for Windows
> games running over Wine.
> 
> The proposed interface looks like this:
> 
>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start_addr>, <end_addr>, [selector])
> 
> The range [<start_addr>,<end_addr>] is a part of the process memory map
> that is allowed to by-pass the redirection code and dispatch syscalls
> directly, such that in fast paths a process doesn't need to disable the
> trap nor the kernel has to check the selector.  This is essential to
> return from SIGSYS to a blocked area without triggering another SIGSYS
> from rt_sigreturn.
> 
> selector is an optional pointer to a char-sized userspace memory region
> that has a key switch for the mechanism. This key switch is set to
> either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
> redirection without calling the kernel.
> 
> The feature is meant to be set per-thread and it is disabled on
> fork/clone/execv.
> 
> Internally, this doesn't add overhead to the syscall hot path, and it
> requires very little per-architecture support.  I avoided using seccomp,
> even though it duplicates some functionality, due to previous feedback
> that maybe it shouldn't mix with seccomp since it is not a security
> mechanism.  And obviously, this should never be considered a security
> mechanism, since any part of the program can by-pass it by using the
> syscall dispatcher.
> 
> For the sysinfo benchmark, which measures the overhead added to
> executing a native syscall that doesn't require interception, the
> overhead using only the direct dispatcher region to issue syscalls is
> pretty much irrelevant.  The overhead of using the selector goes around
> 40ns for a native (unredirected) syscall in my system, and it is (as
> expected) dominated by the supervisor-mode user-address access.  In
> fact, with SMAP off, the overhead is consistently less than 5ns on my
> test box.
> 
> Right now, it is only supported by x86_64 and x86, but it should be
> easily enabled for other architectures.
> 
> An example code using this interface can be found at:
>   https://gitlab.collabora.com/krisman/syscall-disable-personality
> 
> Changes since v2:
>   (Matthew Wilcox suggestions)
>   - Drop __user on non-ptr type.
>   - Move #define closer to similar defs
>   - Allow a memory region that can dispatch directly
>   (Kees Cook suggestions)
>   - Improve kconfig summary line
>   - Move flag cleanup on execve to begin_new_exec
>   - Hint branch predictor in the syscall path
>   (Me)
>   - Convert selector to char
> 
> Changes since RFC:
>   (Kees Cook suggestions)
>   - Don't mention personality while explaining the feature
>   - Use syscall_get_nr
>   - Remove header guard on several places
>   - Convert WARN_ON to WARN_ON_ONCE
>   - Explicit check for state values
>   - Rename to syscall user dispatcher
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Paul Gofman <gofmanp@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

I think this looks great. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

Any other folks able to look through it?

-- 
Kees Cook
