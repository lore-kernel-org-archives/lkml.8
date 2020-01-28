Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDAC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C57522527
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EUj614/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA1AZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:25:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35847 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1AZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:25:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so4393116plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+BSVtOjuS68/b2v0f7OT648Jg3O+3AV7imEPIWfZyw=;
        b=EUj614/He5DI6FobTl5392ZqO7A6CzV7kdXT1PuB3EGx3J+GPDqLfqgd7QXlznNm4L
         y68b4WVm1dxVr+tnmypR/Z01rMwkubTzy9Vx1vFZQafxAHSbcHtK7iIENoEBTbXwULWv
         mkg8C12/yJRbY/G32Fwa4JEd4z8MXuoel0JtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+BSVtOjuS68/b2v0f7OT648Jg3O+3AV7imEPIWfZyw=;
        b=l22EHn/WlywK3KsKKFe7mJ4ixLcWeYBycWLbIvul/N1CLPwNlI6SIvGRqkESChl+D1
         FbCWPesXPWN1Or0krk11wbazDad8R7MaKjBCfXnStsRojeEGXSAjGx/HrQOErcw3t4Jb
         BjeXEaAqNJcGWnn+uHXNFWewlkYxybTg/sSnZbWrlMnoG2RsLToEyIqzkNx6HYPN9WIX
         vDjhTApJIBjHk9XjhSXVnkJqjQKpNP8UIBeJXkaSPd0RJIF9GkaP52degVxzZ9bqeTej
         KxeCqzf89b9CB6zeXbZwxPEW3n8ldDV6y6Dbvx5N846a2TD9bCjeSTmPWFn/kFM/cUUV
         0M1Q==
X-Gm-Message-State: APjAAAUKNo/ijRFGIT+eAIuIGcMOGQ+jwNDkPrOKHoDAyQd0nelHt54O
        l80CT/Fv914v32nSfUYjsS03vg==
X-Google-Smtp-Source: APXvYqxjSyhkagCwOGrSkkXQiY8CYWhpKHQ6EdsasKmr4x2185dIVpT5C1eC06D1ybeI/kMaN6i9Rw==
X-Received: by 2002:a17:902:7d8c:: with SMTP id a12mr19193277plm.47.1580171128071;
        Mon, 27 Jan 2020 16:25:28 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u20sm17009658pgf.29.2020.01.27.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:25:27 -0800 (PST)
Date:   Mon, 27 Jan 2020 19:25:26 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     surenb@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] staging: android: ashmem: Disallow ashmem memory from
 being remapped
Message-ID: <20200128002526.GC175575@google.com>
References: <20200127235616.48920-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127235616.48920-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:56:16PM -0800, Todd Kjos wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> When ashmem file is mmapped, the resulting vma->vm_file points to the
> backing shmem file with the generic fops that do not check ashmem
> permissions like fops of ashmem do. If an mremap is done on the ashmem
> region, then the permission checks will be skipped. Fix that by disallowing
> mapping operation on the backing shmem file.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable <stable@vger.kernel.org> # 4.4,4.9,4.14,4.18,5.4
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/staging/android/ashmem.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> v2: update commit message as suggested by joelaf@google.com.
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 74d497d39c5a..c6695354b123 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
>  	       _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
>  }
>  
> +static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	/* do not allow to mmap ashmem backing shmem file directly */
> +	return -EPERM;
> +}
> +
> +static unsigned long
> +ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> +				unsigned long len, unsigned long pgoff,
> +				unsigned long flags)
> +{
> +	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
> +}
> +
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> +	static struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> @@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  		}
>  		vmfile->f_mode |= FMODE_LSEEK;
>  		asma->file = vmfile;
> +		/*
> +		 * override mmap operation of the vmfile so that it can't be
> +		 * remapped which would lead to creation of a new vma with no
> +		 * asma permission checks. Have to override get_unmapped_area
> +		 * as well to prevent VM_BUG_ON check for f_ops modification.
> +		 */
> +		if (!vmfile_fops.mmap) {
> +			vmfile_fops = *vmfile->f_op;
> +			vmfile_fops.mmap = ashmem_vmfile_mmap;
> +			vmfile_fops.get_unmapped_area =
> +					ashmem_vmfile_get_unmapped_area;
> +		}
> +		vmfile->f_op = &vmfile_fops;
>  	}
>  	get_file(asma->file);
>  
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
