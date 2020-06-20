Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A774C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3323102
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZN2T7/JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgFTDOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbgFTDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:14:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57740C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:14:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so5332291pfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxEmF09WoseIxP9Y3Uuc9kFSYRG1TlJlmbCTGKI9lsM=;
        b=ZN2T7/JFLmDO2z2VqtuTRneyEd81ySh+CNB207RiG+HiHo1Pm9LVrpBN3CK/yC3X/3
         uUJJtMJ2egHuHDNqrFuoTAtQf+zObtaa/8C8quuuZFpRLeyL+UFe4RK97pxafRMAnGEr
         36VL+zUT3i8FmRbW8t+7Lh1PrnZGv8ZajT6A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxEmF09WoseIxP9Y3Uuc9kFSYRG1TlJlmbCTGKI9lsM=;
        b=GFsCp8oYwe4PY7MBfq97OZZfqCzTAIWELB1kyN0r/1AuXghrM5KVJRuIlzZHkOFxlw
         aYgs7/g/4ZNf+m6XSvFVrdGnLDUuhNPz/Q3iGfb9X8PoxiuAJvulR1Pxa0YbYL5Xgq2P
         x7QyiTDh46hejL0kjP9J6P6PXmbNT0rJ6vpYrocsu6D+rqeZhU0EI76GEwAC4s9hS/4j
         ZUItu6bJtULa7xo4X9JszGwA9MtsKEWGTXB71CVOJwZuEe5Ng749sUxfA7BAllsVMwA1
         VVvE4DbfNXEl/NP3fGo3Hmd0vVdaLxuKvzLQSpzY7rclFb/XjWiBAjmy/W/EtYXNWouc
         4bRQ==
X-Gm-Message-State: AOAM533sZetoufQVDk1k95nFiIK38vuLJ86J2L3a79Qpaqidn5Rom1pc
        OQgwkh2k0ftYE/CDAL8gTMVRhLxkIXg=
X-Google-Smtp-Source: ABdhPJyMCJh40CWKlqEEw2lqNmH5tHb6m4VUOOna9wPFIuuJgq/28v5o8PV4xax85TfHCtDFn7HGzQ==
X-Received: by 2002:a63:5d55:: with SMTP id o21mr5221073pgm.58.1592622841842;
        Fri, 19 Jun 2020 20:14:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm6283132pjr.39.2020.06.19.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:14:00 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:13:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
Message-ID: <202006192008.337CB5212E@keescook>
References: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:34:16AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
> Gitweb:        https://git.kernel.org/tip/bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 10 Jun 2020 12:14:09 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 10 Jun 2020 12:30:19 +02:00
> 
> sched: Fix RANDSTRUCT build fail
> 
> As a temporary build fix, the proper cleanup needs more work.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Fixes: a148866489fb ("sched: Replace rq::wake_list")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hi, can this please get sent to Linus before -rc2? With a148866489fb in
-rc1, all the CI with the GCC plugins installed have been failing their
all*config builds. This entered -next 9 days ago (and fixed the -next
builds), but Linus's tree is still failing:

https://kernelci.org/build/mainline/branch/master/kernel/v5.8-rc1-226-g4333a9b0b67b/
...
https://kernelci.org/build/mainline/branch/master/kernel/v5.8-rc1/

Thanks!

-Kees

> ---
>  include/linux/sched.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 57a5ce9..59caeb9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -653,8 +653,10 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
> +	struct {
> +		struct llist_node		wake_entry;
> +		unsigned int			wake_entry_type;
> +	};
>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */

-- 
Kees Cook
