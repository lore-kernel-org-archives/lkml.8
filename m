Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096FFC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC152075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BiT/yyVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgDGQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:03:51 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54820 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgDGQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:03:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so940422pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gP729yExvsKwcKrE86VBUvEUivRuAU1I4cifk756xg8=;
        b=BiT/yyVr1rSfof6VFqWXygsiJDCQsZIVl3d4oHMX1AlwZu2InJRMzINblucNVGW/ZH
         t+PA9lgM0DmQMakMUPj4R/C/CPo85Zx7iBKrQHz14noUlbYVtQ2CR0tcbxK52eUp/0by
         XbWcQl93c78Jk4nzonwajBC96ypn5aCIxRxEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gP729yExvsKwcKrE86VBUvEUivRuAU1I4cifk756xg8=;
        b=Iy8b9DD03rUMAlD1XyTl6vmxcNyzzXI7pXyzgGKpZkoORAM2qCZZlSVfvRCA+rnYoU
         PHn+7QJtb0TUyOsJF4BZ2yI4Y0IIWXA7zjDamcrcPQ/ZWn9ydhi7UBkU1nwC/P9XBfjz
         geOp+tf+8u4AoB8ILXeHHWf+Kt2rADpK2ORRfk0V69murrm5AgqLL/b3Q9k6ntPbQzZP
         5MD6Gc37bpW41HiLTsKVLl4Ah6BxYYaLO0nkb/PjN1hhCRq5LEhLPGB+bQf22lqFCWDG
         xYBZJVteS0lScvllWd6oxjxnDo/bJgTi3xHpg73pKUfqr0eD9XbQ2/wRcQMWO8c/Buna
         /lPw==
X-Gm-Message-State: AGi0Puae1hpHjGkfWthLgHbGQJUpmgSd7NCjeoYTjsKYI7Be9gSfp7hh
        oYeZGTNyBYP0zeEXpVrFwCv8cA==
X-Google-Smtp-Source: APiQypJ9peVI9az7UwkHqtzSEwC0pTS1l9u9mH/FppWKiEPX2XYXZdvNpEolk4nHDToGI2lLSlyaXQ==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr3051101plt.61.1586275428262;
        Tue, 07 Apr 2020 09:03:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nh14sm2014218pjb.17.2020.04.07.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:03:47 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:03:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/3] exec: Rename the flag called_exec_mmap
 point_of_no_return
Message-ID: <202004070903.CC08A70A@keescook>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
 <87d08k3wt4.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d08k3wt4.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:32:23PM -0500, Eric W. Biederman wrote:
> 
> Update the comments and make the code easier to understand by
> renaming this flag.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

I like it, yes!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/exec.c               | 12 ++++++------
>  include/linux/binfmts.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 28c87020da9b..a61987d6dc33 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1300,12 +1300,12 @@ int flush_old_exec(struct linux_binprm * bprm)
>  		goto out;
>  
>  	/*
> -	 * After setting bprm->called_exec_mmap (to mark that current is
> -	 * using the prepared mm now), we have nothing left of the original
> -	 * process. If anything from here on returns an error, the check
> -	 * in search_binary_handler() will SEGV current.
> +	 * With the new mm installed it is completely impossible to
> +	 * fail and return to the original process.  If anything from
> +	 * here on returns an error, the check in
> +	 * search_binary_handler() will SEGV current.
>  	 */
> -	bprm->called_exec_mmap = 1;
> +	bprm->point_of_no_return = true;
>  	bprm->mm = NULL;
>  
>  #ifdef CONFIG_POSIX_TIMERS
> @@ -1694,7 +1694,7 @@ int search_binary_handler(struct linux_binprm *bprm)
>  
>  		read_lock(&binfmt_lock);
>  		put_binfmt(fmt);
> -		if (retval < 0 && bprm->called_exec_mmap) {
> +		if (retval < 0 && bprm->point_of_no_return) {
>  			/* we got to flush_old_exec() and failed after it */
>  			read_unlock(&binfmt_lock);
>  			force_sigsegv(SIGSEGV);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 6f564b9ad882..8f479dad7931 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -46,10 +46,10 @@ struct linux_binprm {
>  		 */
>  		secureexec:1,
>  		/*
> -		 * Set by flush_old_exec, when exec_mmap has been called.
> -		 * This is past the point of no return.
> +		 * Set when errors can no longer be returned to the
> +		 * original userspace.
>  		 */
> -		called_exec_mmap:1;
> +		point_of_no_return:1;
>  #ifdef __alpha__
>  	unsigned int taso:1;
>  #endif
> -- 
> 2.25.0
> 

-- 
Kees Cook
