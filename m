Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C5C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93BF2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsRiZ1dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDGQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:02:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45676 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgDGQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:02:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so1918493pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCeukKbud7C3clm1zbpVpVwgv+8wge+9QzRvJl6XRts=;
        b=YsRiZ1dEtXgjSAtNUNsyT8zEGLIAz3phRF7UE6EXjeNzS9J0E3WHCS/cxlySz3B1hB
         beXyhRyr5Vk8avGeXgB4i2pOGSJo2Op9/bw15THjx0x8D6P3f8qLao8/5qGSocrLL2dK
         6gWtCI6r6N0mXiPIrVCBTw1mAwiBEjLBqdRH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCeukKbud7C3clm1zbpVpVwgv+8wge+9QzRvJl6XRts=;
        b=IjqAq33b1XvvvgAotjr60zHJbocxv3hsL3DG9o7q+Aw56zziPVdOmLNoEW8by7AXpH
         AJwqmPaTdB9LZdUcn3lma3RR6eqWcfQGmCsYFNXtyUD/M282F3z7+tNWmL5PpXMeJfnG
         ih63mb979TF4h2jGUx7966ld9BEb9ZqLGXqBcEuPswMwYgE2vLiZSJYk97VazF14h/UK
         g3wG3yii7lj0m7uqfhpuuJ1XPagyawNPgxbdBLXNITsEdl7e6fWv1rQYxLrbGPhZERYW
         7p2kTKvW6SxigriQ8LkvOfLNPARCfxVTaB5/VooH2XGzCAijZsAztZ5R8hHsCvOxEzoy
         b+Cg==
X-Gm-Message-State: AGi0PuZx5YCE9+96CC9vxGJGWLqLXpdOnS92vvRrqTFCsOeuVNR2frOf
        BgxKvgwl19GOIlXZab4nA8sAfA==
X-Google-Smtp-Source: APiQypKzSZVZEZ9v0JoDGhqqEMHpb9k4/uqGwRPfOc9GLFgVM/iX2dNtzE9KGS6y1ZlSJjwUxLaYSA==
X-Received: by 2002:aa7:94a5:: with SMTP id a5mr3266386pfl.67.1586275354262;
        Tue, 07 Apr 2020 09:02:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z63sm13623706pgd.12.2020.04.07.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:02:33 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:02:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] exec: Make unlocking exec_update_mutex explict
Message-ID: <202004070902.5D36F15E@keescook>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
 <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:31:52PM -0500, Eric W. Biederman wrote:
> 
> With install_exec_creds updated to follow immediately after
> setup_new_exec, the failure of unshare_sighand is the only
> code path where exec_update_mutex is held but not explicitly
> unlocked.
> 
> Update that code path to explicitly unlock exec_update_mutex.
> 
> Remove the unlocking of exec_update_mutex from free_bprm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/exec.c               | 6 +++---
>  include/linux/binfmts.h | 3 +--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d55710a36056..28c87020da9b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1318,7 +1318,7 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	 */
>  	retval = unshare_sighand(me);
>  	if (retval)
> -		goto out;
> +		goto out_unlock;
>  
>  	set_fs(USER_DS);
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
> @@ -1335,6 +1335,8 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	do_close_on_exec(me->files);
>  	return 0;
>  
> +out_unlock:
> +	mutex_unlock(&me->signal->exec_update_mutex);
>  out:
>  	return retval;
>  }
> @@ -1451,8 +1453,6 @@ static void free_bprm(struct linux_binprm *bprm)
>  {
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
> -		if (bprm->called_exec_mmap)
> -			mutex_unlock(&current->signal->exec_update_mutex);
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);
>  	}
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index a345d9fed3d8..6f564b9ad882 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -47,8 +47,7 @@ struct linux_binprm {
>  		secureexec:1,
>  		/*
>  		 * Set by flush_old_exec, when exec_mmap has been called.
> -		 * This is past the point of no return, when the
> -		 * exec_update_mutex has been taken.
> +		 * This is past the point of no return.
>  		 */
>  		called_exec_mmap:1;
>  #ifdef __alpha__
> -- 
> 2.25.0
> 

-- 
Kees Cook
