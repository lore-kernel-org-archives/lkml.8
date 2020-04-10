Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35B720732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9o4HrWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJU3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:29:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40534 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:29:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so1001920plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HODoK6E8L/CuOaFGCg2iAC1rPoU/icSNRuY7o7sO8Ws=;
        b=m9o4HrWYGaPjCrKKUVeHWee1Rn5fs9FN8wu6WoU+bDI6noVqb5hinEVQokCBtuQJfT
         fLUO9wsv1VCMDI85blYzteeMqCT3bnQlg7kLwecAI+coZAI0xGeYB+rFd43a65241FI8
         E9vNhsauJMCTPS6vDrZki02VIpPoRwqpUc+7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HODoK6E8L/CuOaFGCg2iAC1rPoU/icSNRuY7o7sO8Ws=;
        b=IRlkCMAGiGbeXepNRqHHYf6dfiWsYRTmKPnFD2i3rOi3Tq4eqcsv5VZccw9JX2GykJ
         E/a9EzlD/S/r2OIS7UeRLZncHT1TSHC0BvxOs+5Muv8gd8ZbdOG6ZgMv8dwzt1DIiosr
         HYg37v6EvN8EueXhhlto1MAGs6AUNrcNLh8dxlZIkNWTl+qQ4b0p3qwEbfS1oal4VbOo
         9Vy5FMytXT1CPbZDGlPWFRPZNQz+BqYepga/YUl6EkIL5YA5DZd9cfEaa2DjCefGpBre
         vcLIWo5jB7mymInP0OHnHxsLOYOgr/9AIAmR4nYgrGiwdRqL0wbFHucSaJqw1sKxNc8g
         reaw==
X-Gm-Message-State: AGi0PubL2fkSu4XZ8Rr+wdWZXPJjm8g/gGPl/yc9BAKRQUKqsSg/hih2
        b2g27OOtb82i8ZmsEnagixlmFA==
X-Google-Smtp-Source: APiQypKD8wYXfs/7EzdxX7L5G4cmdiNC+Ks7MIPw8kTtJLh6/UJnCEZ3fylDcudFSFjvfjyqm97q8A==
X-Received: by 2002:a17:902:bd45:: with SMTP id b5mr6008293plx.185.1586550545406;
        Fri, 10 Apr 2020 13:29:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm2240496pga.3.2020.04.10.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:29:04 -0700 (PDT)
Date:   Fri, 10 Apr 2020 13:29:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, wad@chromium.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/seccomp: allow clock_nanosleep instead of
 nanosleep
Message-ID: <202004101328.075568852D@keescook>
References: <20200408235753.8566-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408235753.8566-1-cascardo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:57:53PM -0300, Thadeu Lima de Souza Cascardo wrote:
> glibc 2.31 calls clock_nanosleep when its nanosleep function is used. So
> the restart_syscall fails after that. In order to deal with it, we trace
> clock_nanosleep and nanosleep. Then we check for either.
> 
> This works just fine on systems with both glibc 2.30 and glibc 2.31,
> whereas it failed before on a system with glibc 2.31.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Actually, sorry, this should go via Shuah's tree. :) Shuah, do you have
anything going Linus's way already for -rc2?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 89fb3e0b552e..c0aa46ce14f6 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2803,12 +2803,13 @@ TEST(syscall_restart)
>  			 offsetof(struct seccomp_data, nr)),
>  
>  #ifdef __NR_sigreturn
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 6, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 7, 0),
>  #endif
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 5, 0),
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 4, 0),
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 3, 0),
> -		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_nanosleep, 4, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 6, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 5, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 4, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_nanosleep, 5, 0),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_clock_nanosleep, 4, 0),
>  		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_restart_syscall, 4, 0),
>  
>  		/* Allow __NR_write for easy logging. */
> @@ -2895,7 +2896,8 @@ TEST(syscall_restart)
>  	ASSERT_EQ(PTRACE_EVENT_SECCOMP, (status >> 16));
>  	ASSERT_EQ(0, ptrace(PTRACE_GETEVENTMSG, child_pid, NULL, &msg));
>  	ASSERT_EQ(0x100, msg);
> -	EXPECT_EQ(__NR_nanosleep, get_syscall(_metadata, child_pid));
> +	ret = get_syscall(_metadata, child_pid);
> +	EXPECT_TRUE(ret == __NR_nanosleep || ret == __NR_clock_nanosleep);
>  
>  	/* Might as well check siginfo for sanity while we're here. */
>  	ASSERT_EQ(0, ptrace(PTRACE_GETSIGINFO, child_pid, NULL, &info));
> -- 
> 2.20.1
> 

-- 
Kees Cook
