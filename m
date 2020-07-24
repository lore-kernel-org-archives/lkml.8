Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7066C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B172063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3INFemW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGXO2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:28:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbgGXO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595600922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lr9Etkm6DVlQmv048YXafbStcrgAPMR6c7hyfkG2ij0=;
        b=C3INFemWKk2e6c9GjRET+ATPA+SAJN9ZCpj/FkkciEdAyhD2WpJS8TCBBKrhyo8ElYHk37
        NmLILzFNb/k/o5NWqyiNAYUrYkVPeu/f2Ielh5K0vWTMDSiM9a/AmeC4biToLIF/qcKzxH
        sJ+ZQCq/NY8Jm+lIu/gI6LRxxBs84Us=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-SJdX5Q78MByn91oFCi0PJg-1; Fri, 24 Jul 2020 10:28:40 -0400
X-MC-Unique: SJdX5Q78MByn91oFCi0PJg-1
Received: by mail-wm1-f72.google.com with SMTP id z74so3728266wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lr9Etkm6DVlQmv048YXafbStcrgAPMR6c7hyfkG2ij0=;
        b=PUZNZEibZJ9p54pD2WwK4foWoZQc9hNm7HpqOOi0knzBJNBmARjimAmVjzDn6UzjuV
         BsL3oraLQeHCIOGAXz0oMOn+FKFVKlAgIONn4GCq2YF2oF++cHFy10hJlX+FT0vMD82a
         R7KHd/l74OAKqAOAIpXtPKATMuOafzYgouzDOCHgwjQCzr2P38Y4LsqXov5OEmZZWZcY
         rG6cVZV1xRkYtRuSwxYrd/U77m8zxrqK/A/SOdxHqAW5raaInfVBLBJW5WcZRSMDbetj
         OcYr+5/iwIxyGUNSDgKTZFJgOoUqY76b/EjhDdWQNEhx15Nvwuz1qbE6oY+aXTd4ws/5
         +kJA==
X-Gm-Message-State: AOAM532QD69MPq4VHV+nYDT2bxQaSOxhjfc5ZbIogBSEsJhbQNKw0Sfo
        O2keDZ+0tJKARtU+83HKy6zWGbgLRsqwuP068YcSH4os53Z8NNtUdq5JxjwdQLln7Y+RGnLpgBZ
        IF7TGZGugSPxoWXgloyxhhVeX
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr8538459wmk.127.1595600919601;
        Fri, 24 Jul 2020 07:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweAkCz6jqUgTCRtSnT+jtnvvd3TNnF9cP6oGan7bA1hezLM0XnPAmCXLixXMnOCHom0XLicQ==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr8538440wmk.127.1595600919291;
        Fri, 24 Jul 2020 07:28:39 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id t2sm7354008wmb.28.2020.07.24.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:28:37 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:28:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20200724100153-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-2-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-2-dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:31PM -0700, Daniel Colascione wrote:
> userfaultfd handles page faults from both user and kernel code.  Add a
> new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
> resulting userfaultfd object refuse to handle faults from kernel mode,
> treating these faults as if SIGBUS were always raised, causing the
> kernel code to fail with EFAULT.
> 
> A future patch adds a knob allowing administrators to give some
> processes the ability to create userfaultfd file objects only if they
> pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> will exploit userfaultfd's ability to delay kernel page faults to open
> timing windows for future exploits.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

Something to add here is that there is separate work on selinux to
support limiting specific userspace programs to only this type of
userfaultfd.

I also think Kees' comment about documenting what is the threat being solved
including some links to external sources still applies.

Finally, a question:

Is there any way at all to increase security without breaking
the assumption that copy_from_user is the same as userspace read?


As an example of a drastical approach that might solve some issues, how
about allocating some special memory and setting some VMA flag, then
limiting copy from/to user to just this subset of virtual addresses?
We can then do things like pin these pages in RAM, forbid
madvise/userfaultfd for these addresses, etc.

Affected userspace then needs to use a kind of a bounce buffer for any
calls into kernel.  This needs much more support from userspace and adds
much more overhead, but on the flip side, affects more ways userspace
can slow down the kernel.

Was this discussed in the past? Links would be appreciated.


> ---
>  fs/userfaultfd.c                 | 7 ++++++-
>  include/uapi/linux/userfaultfd.h | 9 +++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e39fdec8a0b0..21378abe8f7b 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -418,6 +418,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
> +	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> +	    ctx->flags & UFFD_USER_MODE_ONLY)
> +		goto out;
>  
>  	/*
>  	 * If it's already released don't get it. This avoids to loop
> @@ -2003,6 +2006,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  
>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	static const int uffd_flags = UFFD_USER_MODE_ONLY;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
>  
> @@ -2012,10 +2016,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	BUG_ON(!current->mm);
>  
>  	/* Check the UFFD_* constants for consistency.  */
> +	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
>  	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
>  	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
>  
> -	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> +	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
>  		return -EINVAL;
>  
>  	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index e7e98bde221f..5f2d88212f7c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -257,4 +257,13 @@ struct uffdio_writeprotect {
>  	__u64 mode;
>  };
>  
> +/*
> + * Flags for the userfaultfd(2) system call itself.
> + */
> +
> +/*
> + * Create a userfaultfd that can handle page faults only in user mode.
> + */
> +#define UFFD_USER_MODE_ONLY 1
> +
>  #endif /* _LINUX_USERFAULTFD_H */
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

