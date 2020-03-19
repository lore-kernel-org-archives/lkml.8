Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29323C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AFF2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWbpJB7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCSCAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:00:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39935 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSCAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:00:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id r2so796681otn.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imF7ST2MLfxUreXaGENTzkNj4f/nZW7foh0Y9cYT5II=;
        b=AWbpJB7yskPqnyMVt/2INrUoBmCiE9QQmUJNQ5HmlLZf+VrMgdb+7MhMYLp69fSjxZ
         Aq05ZnGQr1YBsjjpAv0+efatsfSJIuXdIun5mVUNoDtoPik4BXavpFZrxPpr9J2g9dF2
         H8bN+wKhuXrg3XlaN02nEb8JTMKV+ss/UnaGSXv5Kc4/jzcvUDy9xn2uCbpQ2xAb1Y0I
         Cj0oPyH1BO1UdCN/9vHfMKrGMlctVQsW9iZGCXEeL3XDTAVqD0PbfZD4N9NyqrnJkzLC
         9jUhqecW9jZSntnRvwVuhDc3n6bgHtb5ZZTSIQSQ71GEM6gKWYMF4iAZTfJ8pGXuSP4s
         KThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imF7ST2MLfxUreXaGENTzkNj4f/nZW7foh0Y9cYT5II=;
        b=eD2hv2tH9+W6McAbHfpDxrvWnK0/6FvMQGnnpJpJRzxQ9Q8TJN2HKNYhLLKm0JHkgS
         LqlRY9vo5R7fZFWLqOfkGr+6Sv6v58zu0O6uWAUPfu2nlIzXj1TkGrvoidMe+qHXbukD
         xKEjsKdWFs/R0sF/E5zoJ01uIOf163q4fplLV9OywdtOn0KLm6EVEQ3kK/IYa/GSrds/
         SjjisIO4qGSiiJNMFNjrgeA+EqzteXOEPL4zPhj1wOi8tEikG+42GINlon28iPgvaxsd
         34KsQxeZCO08zPF67KDIi+1LNnWBNaVnXYaAJhpWKhlioTBOLix7qOGf97FRR1rslmgO
         nggQ==
X-Gm-Message-State: ANhLgQ3GYhvs09YNAynzC7wL754pRPd/DFdOY+805E5ofRp5IeVQ2QKR
        G7OFyJ9HnC2XAswv78jQuUw=
X-Google-Smtp-Source: ADFU+vswIHfUXvQfBu1NxP8p4+z8IJUMGHuTCJlToMmDF6UlG4GRrhcbHrElvXRNZyM1FrMupU+VtA==
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr509809oth.86.1584583205893;
        Wed, 18 Mar 2020 19:00:05 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q22sm331243oic.22.2020.03.18.19.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 19:00:05 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:00:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
Message-ID: <20200319020004.GB8292@ubuntu-m2-xlarge-x86>
References: <20200220051011.26113-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220051011.26113-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:10:12PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../kernel/trace/trace.c:9335:33: warning: array comparison always
> evaluates to true [-Wtautological-compare]
>         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
>                                        ^
> 1 warning generated.
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses. Using the address of operator silences the warning and
> does not change the runtime result of the check (tested with some print
> statements compiled in with clang + ld.lld and gcc + ld.bfd in QEMU).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/893
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-4-natechancellor@gmail.com/
> 
> * No longer a series because there is no prerequisite patch.
> * Use address-of operator instead of casting to unsigned long.
> 
> NOTE: The code generation does seem to change, unlike every other call
> site that I did this change to but the result of the check remains the
> same as noted in the commit message and I cannot really understand what
> has changed in the assembly. Please let me know if there is something
> catastrophically wrong.
> 
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c797a15a1fc7..78727dd9a6f5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
>  		goto out_free_buffer_mask;
>  
>  	/* Only allocate trace_printk buffers if a trace_printk exists */
> -	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> +	if (&__stop___trace_bprintk_fmt != &__start___trace_bprintk_fmt)
>  		/* Must be called before global_trace.buffer is allocated */
>  		trace_printk_init_buffers();
>  
> -- 
> 2.25.1
> 

Gentle ping for review/acceptance.

Cheers,
Nathan
