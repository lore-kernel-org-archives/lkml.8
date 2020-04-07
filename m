Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDE62072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F8htgRGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgDGP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:58:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33235 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgDGP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:58:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c138so1653376pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R9/y2y6gn2TBTORGnx9cck+v00h9R2uXMo/O04FD5HA=;
        b=F8htgRGm1CMzCma9xbvHKrRO+AM4D+0wHNBAPKbzeh3LQCvPCZCUUXAfqRi5jKd5oD
         xzqNCqjH2krNw2h9ujTHdxgpqBh96iGcm3x/ApH9AUwU6G25sRhNncGLap6WZu1tWvZH
         55qenGKcfA4CKqFR2PEaaYHe8BMufENVxLBx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9/y2y6gn2TBTORGnx9cck+v00h9R2uXMo/O04FD5HA=;
        b=fbepzAPwJnpNMEc2betWy6PHDMD87WG9GraTrhzd64Ms7A1bc/dlinCGemr7FBF0t4
         +zCQfq4UcYSP8pbKHKaKuQcbRwGLtzV3lG7qkdxNUWz6owDPKisAIKWyeWFzv9DS8pPH
         F0aQO7zUbhbFbqJSPDryVqcczLCrlPxWCpDTqOj5Wn4EB26tRTF1RBEjT+MBbzobon8A
         2WiFNw5ptT6L1F+DMEksW9VfsW3UcWJ9/CBxYerz6M4dAU/jDs0yS2tn2sOMwXiQP1z4
         B1IM3nsCUY8jlJ7dOufgHLvDN/9eGmYB1eHLpEHtbcqGZgwHGsdRhix3CiAWRkmL6mRL
         kIFg==
X-Gm-Message-State: AGi0PubV650Iv836DWXmnizZndCNsvRY4qpkccei4aMq8nDkdhXArPIp
        CEm9DEgV6U0RlDNw6Vkeb21HCw==
X-Google-Smtp-Source: APiQypKP4MA4++iYJxvwc1ZhD9QiNn1B48cCrdnsUrWjnVs4jm3TEl4QrKEW0A30kDRvKDV2/odVRA==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr3167329pfi.95.1586275123363;
        Tue, 07 Apr 2020 08:58:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p22sm13768978pgn.73.2020.04.07.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 08:58:42 -0700 (PDT)
Date:   Tue, 7 Apr 2020 08:58:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] binfmt: Move install_exec_creds after setup_new_exec
 to match binfmt_elf
Message-ID: <202004070858.4644D9F529@keescook>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
 <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:31:25PM -0500, Eric W. Biederman wrote:
> 
> In 2016 Linus moved install_exec_creds immediately after
> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
> potential information leak.
> 
> Perform the same cleanup for the other binary formats.
> 
> Different binary formats doing the same things the same way makes exec
> easier to reason about and easier to maintain.
> 
> Putting install_exec_creds immediate after setup_new_exec makes many
> simplifications possible in the code.
> 
> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/ia32/ia32_aout.c | 3 +--
>  fs/binfmt_aout.c          | 2 +-
>  fs/binfmt_elf_fdpic.c     | 2 +-
>  fs/binfmt_flat.c          | 3 +--
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index 9bb71abd66bd..37b36a8ce5fa 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -140,6 +140,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
>  	set_personality_ia32(false);
>  
>  	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>  
>  	regs->cs = __USER32_CS;
>  	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
> @@ -156,8 +157,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
>  	if (retval < 0)
>  		return retval;
>  
> -	install_exec_creds(bprm);
> -
>  	if (N_MAGIC(ex) == OMAGIC) {
>  		unsigned long text_addr, map_size;
>  
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index 8e8346a81723..ace587b66904 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -162,6 +162,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>  	set_personality(PER_LINUX);
>  #endif
>  	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>  
>  	current->mm->end_code = ex.a_text +
>  		(current->mm->start_code = N_TXTADDR(ex));
> @@ -174,7 +175,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
>  	if (retval < 0)
>  		return retval;
>  
> -	install_exec_creds(bprm);
>  
>  	if (N_MAGIC(ex) == OMAGIC) {
>  		unsigned long text_addr, map_size;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..6c94c6d53d97 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -353,6 +353,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  		current->personality |= READ_IMPLIES_EXEC;
>  
>  	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>  
>  	set_binfmt(&elf_fdpic_format);
>  
> @@ -434,7 +435,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  	current->mm->start_stack = current->mm->start_brk + stack_size;
>  #endif
>  
> -	install_exec_creds(bprm);
>  	if (create_elf_fdpic_tables(bprm, current->mm,
>  				    &exec_params, &interp_params) < 0)
>  		goto error;
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 831a2b25ba79..1a1d1fcb893f 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>  		/* OK, This is the point of no return */
>  		set_personality(PER_LINUX_32BIT);
>  		setup_new_exec(bprm);
> +		install_exec_creds(bprm);
>  	}
>  
>  	/*
> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>  		}
>  	}
>  
> -	install_exec_creds(bprm);
> -
>  	set_binfmt(&flat_format);
>  
>  #ifdef CONFIG_MMU
> -- 
> 2.25.0
> 

-- 
Kees Cook
