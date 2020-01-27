Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5CC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368B324681
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXYubqq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgA0Wav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:30:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42867 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA0Wav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:30:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so11382037qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xn6Inxb6zuojs0iU7vTmsWoRmbZmQqG7zN5KkIu1iw=;
        b=RXYubqq5Vbt9/Yqh8rRc3gW77GBTJ9ktqMwX5BzBMFzzOT2bfEFFer+ZATdml4q/L8
         yeUOXdIXzpuY6tZZqtw3VnhfsjSheZCS0/Gla/Xdu7BNRdS4IpGlq4doJ5Bkrzt4xX6A
         szH+cb+WI7yNz8moAdV/Kr2o5h5MW7f9s8NyngUeHka78W+CdMlAM41W/l19UsOM96tl
         XdWQ0NvsVIuflJlp87Lsp8b5jFxwqtmUOaizejZb+TkDnH1G1uVVvhWbqDycJoI1H35g
         WyAdOfAKKVRFvXixsNa5QQkHdeIC085SjF1Ebd1YCifclqVFWwV3CSQkl/gYtzNQtvlJ
         ll/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xn6Inxb6zuojs0iU7vTmsWoRmbZmQqG7zN5KkIu1iw=;
        b=e+0yDySEpNdwoQhDhoftAn1noIt+2MupII4uJo6Kds42+hikxpbvcOExZ/FtMoJHut
         xDMPXqlPwGW0tQ8bU83q5VX72OEGtQNJ064mRR5I7S2GvSaF1ewBT1wm3ahJgx+8i0Ka
         aQuTCsK2zdOKX0UA3O6CQ17uXMKrFcV9D5kx6bPDppVoHfhitykmh/hzxmukA3VM5enw
         nlqSG0FCzWOtmyqzfSWa+IYUKLdJIudrKdjWB2PN9NBp3b5PJHNvNvNPW6OEZ6L0GFTl
         W0505XYizXjkRL6+iBN7qKlwKvSEn6KOzU0U/0wIOXqcMo8uObPjUSIw/BuC1g0kzb7/
         iCqw==
X-Gm-Message-State: APjAAAVtbRKUCF0/8jX1KszJ8JI43ZLfhnHXdLdHCU0GgJk5wvwmI4m1
        8MqNGZVYExTGteNtXzkQNp14GiqDc0CDRfpKydm7YA==
X-Google-Smtp-Source: APXvYqxCSQrirUnN+FZ82T0KdKjdeTod7OErds5KLF8UmezscEdKL2MJ9VbnHcnHl/RVaw2STHVzvy/g3A5rXPztxxQ=
X-Received: by 2002:a37:6794:: with SMTP id b142mr19240197qkc.216.1580164248519;
 Mon, 27 Jan 2020 14:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20200127210014.5207-1-tkjos@google.com>
In-Reply-To: <20200127210014.5207-1-tkjos@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 27 Jan 2020 14:30:36 -0800
Message-ID: <CAJWu+orT-A5HVi97ccKwMvs9MvXWV0MZhsKcZDNS8r-gqRmcDA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Disallow ashmem memory from
 being remapped
To:     Todd Kjos <tkjos@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jann Horn <jannh@google.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 1:00 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Suren Baghdasaryan <surenb@google.com>
>
> When ashmem file is being mmapped the resulting vma->vm_file points to the
> backing shmem file with the generic fops that do not check ashmem
> permissions like fops of ashmem do. Fix that by disallowing mapping
> operation for backing shmem file.

Looks good, but I think the commit message is confusing. I had to read
the code a couple times to understand what's going on since there are
no links to a PoC for the security issue, in the commit message. I
think a better message could have been:

 When ashmem file is mmapped, the resulting vma->vm_file points to the
 backing shmem file with the generic fops that do not check ashmem
 permissions like fops of ashmem do. If an mremap is done on the ashmem
 region, then the permission checks will be skipped. Fix that by disallowing
 mapping operation on the backing shmem file.

Or did I miss something?

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
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 74d497d39c5a..c6695354b123 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
>                _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
>  }
>
> +static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       /* do not allow to mmap ashmem backing shmem file directly */
> +       return -EPERM;
> +}
> +
> +static unsigned long
> +ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> +                               unsigned long len, unsigned long pgoff,
> +                               unsigned long flags)
> +{
> +       return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
> +}
> +
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> +       static struct file_operations vmfile_fops;
>         struct ashmem_area *asma = file->private_data;
>         int ret = 0;
>
> @@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>                 }
>                 vmfile->f_mode |= FMODE_LSEEK;
>                 asma->file = vmfile;
> +               /*
> +                * override mmap operation of the vmfile so that it can't be
> +                * remapped which would lead to creation of a new vma with no
> +                * asma permission checks. Have to override get_unmapped_area
> +                * as well to prevent VM_BUG_ON check for f_ops modification.
> +                */
> +               if (!vmfile_fops.mmap) {
> +                       vmfile_fops = *vmfile->f_op;
> +                       vmfile_fops.mmap = ashmem_vmfile_mmap;
> +                       vmfile_fops.get_unmapped_area =
> +                                       ashmem_vmfile_get_unmapped_area;
> +               }
> +               vmfile->f_op = &vmfile_fops;
>         }
>         get_file(asma->file);
>
> --
> 2.25.0.341.g760bfbb309-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
