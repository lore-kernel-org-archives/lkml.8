Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A622BED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHXuMrr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHXQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgHXQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:34:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4669C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:34:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v16so4494872plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJRzEKxQslNUvlgLwatGfusZhkWsuQ/eLz0nCOLU88U=;
        b=WHXuMrr+DrJsG5ydYqMywzOTNF0xboE3NYuEaGBrglNd4z3mFnPcURJW1XjqONdE02
         jEd3johpV7asGvtVa+ez8MfBRQ87rUHVp7CmI3ahiaW8mamMuaI8qLNBlRmHIN8qIRqs
         TFjcjDUxevJ7NY3H2b9PAQBUOWcIP8vFY1z/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJRzEKxQslNUvlgLwatGfusZhkWsuQ/eLz0nCOLU88U=;
        b=F4XGw/wvFcNJhEyvv1BQ6HMYKe+VwjfEqvfVk6QskcE/29QbR5uHDKUeUcR/4da7Zz
         UTLaLHeEQ7AYuL92LdrPrky9Zma8JqzNEd+7RQwZ8A2YybNI94G9CEz56VJ0E+ctXL9O
         GANNsNCQOCfQe62sj97X7XXkp/sXuTFe+xh+IfYjO1F/Kdl09+rGfhj6rgXpYHkZ3t0g
         8e5P+Ao9KyAnmSH/FQJJVZsy9PI2p2AVq0k1eSZ10K0kz59SLAggSnAPNPH/KdkweRUe
         r0njrFvfb1FhP14fkF6toJ/MHf8vLhmVyCLwToDrbc/7/wAWO+nRLNZ2G3/TvJv7qF8i
         0zhg==
X-Gm-Message-State: AOAM533xTfXr0A1BC6Z9idTNBmggO/AzJXtGEhq2JIYVVpoMi5zRpG9Q
        mtq115Y3IAoct6hpWVP1vuZ2Avf5cpTpbg==
X-Google-Smtp-Source: ABdhPJyworV0/Dr0sI3KHDP2uuvn/VCt9Dk9wQf/9i50LZ8rfttmW34/1Rr/04C4VJQlwHUH/o6Tlg==
X-Received: by 2002:a17:902:9a93:: with SMTP id w19mr4173622plp.297.1598286869071;
        Mon, 24 Aug 2020 09:34:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm12747047pfg.153.2020.08.24.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:34:28 -0700 (PDT)
Date:   Mon, 24 Aug 2020 09:34:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Use current_pt_regs()
Message-ID: <202008240929.8DDED2B90@keescook>
References: <20200824125921.488311-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824125921.488311-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:59:21PM +0300, Denis Efremov wrote:
> Modify seccomp_do_user_notification(), __seccomp_filter(),
> __secure_computing() to use current_pt_regs().

This looks okay. It seems some architectures have a separate
define for current_pt_regs(), though it's overlapped directly with
task_pt_regs(). I'm curious what the benefit of the change is?

-Kees

> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  kernel/seccomp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3ee59ce0a323..dc4eaa1d6002 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -910,7 +910,7 @@ static int seccomp_do_user_notification(int this_syscall,
>  	if (flags & SECCOMP_USER_NOTIF_FLAG_CONTINUE)
>  		return 0;
>  
> -	syscall_set_return_value(current, task_pt_regs(current),
> +	syscall_set_return_value(current, current_pt_regs(),
>  				 err, ret);
>  	return -1;
>  }
> @@ -943,13 +943,13 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  		/* Set low-order bits as an errno, capped at MAX_ERRNO. */
>  		if (data > MAX_ERRNO)
>  			data = MAX_ERRNO;
> -		syscall_set_return_value(current, task_pt_regs(current),
> +		syscall_set_return_value(current, current_pt_regs(),
>  					 -data, 0);
>  		goto skip;
>  
>  	case SECCOMP_RET_TRAP:
>  		/* Show the handler the original registers. */
> -		syscall_rollback(current, task_pt_regs(current));
> +		syscall_rollback(current, current_pt_regs());
>  		/* Let the filter pass back 16 bits of data. */
>  		seccomp_send_sigsys(this_syscall, data);
>  		goto skip;
> @@ -962,7 +962,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  		/* ENOSYS these calls if there is no tracer attached. */
>  		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
>  			syscall_set_return_value(current,
> -						 task_pt_regs(current),
> +						 current_pt_regs(),
>  						 -ENOSYS, 0);
>  			goto skip;
>  		}
> @@ -982,7 +982,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  		if (fatal_signal_pending(current))
>  			goto skip;
>  		/* Check if the tracer forced the syscall to be skipped. */
> -		this_syscall = syscall_get_nr(current, task_pt_regs(current));
> +		this_syscall = syscall_get_nr(current, current_pt_regs());
>  		if (this_syscall < 0)
>  			goto skip;
>  
> @@ -1025,7 +1025,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  			kernel_siginfo_t info;
>  
>  			/* Show the original registers in the dump. */
> -			syscall_rollback(current, task_pt_regs(current));
> +			syscall_rollback(current, current_pt_regs());
>  			/* Trigger a manual coredump since do_exit skips it. */
>  			seccomp_init_siginfo(&info, this_syscall, data);
>  			do_coredump(&info);
> @@ -1060,7 +1060,7 @@ int __secure_computing(const struct seccomp_data *sd)
>  		return 0;
>  
>  	this_syscall = sd ? sd->nr :
> -		syscall_get_nr(current, task_pt_regs(current));
> +		syscall_get_nr(current, current_pt_regs());
>  
>  	switch (mode) {
>  	case SECCOMP_MODE_STRICT:
> -- 
> 2.26.2
> 

-- 
Kees Cook
