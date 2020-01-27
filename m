Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87BC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755742173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdrZc7JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA0X5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:57:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42271 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA0X5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:57:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so12803569ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tgiIZ3Qy1g9mNO7VRbl57vkOmLmNl7iZKQGkzRYrdY=;
        b=kdrZc7JQdd3Ggq/Hn/zq9hgC+X0FhC/P5hlSrMkLTkSdpOcGrtCGVQf5XicHAnInu8
         P+1oMCYekCRgpwG/4iTw0rKaU6jwcINYhrFjqSyRP1eeAGz2vika79y/Gl4iZWvp/otp
         Bcrf+KF8odbP74f3I/t+wc85LJc9RX50rS3mqA5L7ag+xcZE5SVyHnWYTP7WBHgfBiy+
         LrXOaAET92DhkOI/p4miVRx5sue1RxAQjlN/dZtGN/pNjL52m7XhTm0tZQkMPw5kom6T
         INoNOjuO33HbCyNozU4S24NHyFGdMHaeRqXPesfXHxBg6kgsEUeaRrZX0xKmnU9O7atN
         aS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tgiIZ3Qy1g9mNO7VRbl57vkOmLmNl7iZKQGkzRYrdY=;
        b=Qeq0iM/axl5D5vQULvRoUtu4xjAZ8ybcfSX3o5mgFGBvFsKYYd815F+O+oMmmHywEH
         BOf3C088EkSiPXLUFo/MU+BuWyU/itXsLo0wS0FnZ15euAf1k5F2eK+XtCjlC3Ut6ESb
         uyV++mJZll4JfirA3dg/+9JPR4n+3EW2W3CkEZfJmylPHiAMxnpRDev2gXltYHaOM4mb
         ZpCF0im60kas77K5dY2+fgHYW3lqeZNirkEotdWG+B+9s2oXVsbjvSlEpzbIfFKhFkqi
         vUbD9O3N/KXqtUHpu9vvHL9psjwZUdx+VskfA+EuRNUMor5pfiIqvv+OV3pfJtNWBoyp
         YdrQ==
X-Gm-Message-State: APjAAAWT7n7i6zcAMF4WGEdz9oIN9yVlTLcvnisNgSUizMyqWigLwZqO
        DPPeFuWt9wAmFal41uAVoOk0R97k502X/lQWz9C61frLw+0=
X-Google-Smtp-Source: APXvYqxpYQubOtvkyRXFQ0ff36F9KwyoM8OjErnQTImtzrOLGjTqJl8scX7mGePq5NWrxrYKaq0IYVFgTtLsC2DDvjE=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr10876576ljj.206.1580169430817;
 Mon, 27 Jan 2020 15:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20200127210014.5207-1-tkjos@google.com> <CAJWu+orT-A5HVi97ccKwMvs9MvXWV0MZhsKcZDNS8r-gqRmcDA@mail.gmail.com>
In-Reply-To: <CAJWu+orT-A5HVi97ccKwMvs9MvXWV0MZhsKcZDNS8r-gqRmcDA@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 27 Jan 2020 15:56:59 -0800
Message-ID: <CAHRSSEw67bY9V7un_t1oV2dsfE72BCAtOj_OH4wyQLpuEAjUfg@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Disallow ashmem memory from
 being remapped
To:     Joel Fernandes <joelaf@google.com>
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

On Mon, Jan 27, 2020 at 2:30 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Mon, Jan 27, 2020 at 1:00 PM 'Todd Kjos' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > When ashmem file is being mmapped the resulting vma->vm_file points to the
> > backing shmem file with the generic fops that do not check ashmem
> > permissions like fops of ashmem do. Fix that by disallowing mapping
> > operation for backing shmem file.
>
> Looks good, but I think the commit message is confusing. I had to read
> the code a couple times to understand what's going on since there are
> no links to a PoC for the security issue, in the commit message. I
> think a better message could have been:
>
>  When ashmem file is mmapped, the resulting vma->vm_file points to the
>  backing shmem file with the generic fops that do not check ashmem
>  permissions like fops of ashmem do. If an mremap is done on the ashmem
>  region, then the permission checks will be skipped. Fix that by disallowing
>  mapping operation on the backing shmem file.

Sent v2 with the suggested change.

>
> Or did I miss something?
>
> thanks!
>
> - Joel
>
>
>
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable <stable@vger.kernel.org> # 4.4,4.9,4.14,4.18,5.4
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
> >  drivers/staging/android/ashmem.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> > index 74d497d39c5a..c6695354b123 100644
> > --- a/drivers/staging/android/ashmem.c
> > +++ b/drivers/staging/android/ashmem.c
> > @@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
> >                _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
> >  }
> >
> > +static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +       /* do not allow to mmap ashmem backing shmem file directly */
> > +       return -EPERM;
> > +}
> > +
> > +static unsigned long
> > +ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> > +                               unsigned long len, unsigned long pgoff,
> > +                               unsigned long flags)
> > +{
> > +       return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
> > +}
> > +
> >  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > +       static struct file_operations vmfile_fops;
> >         struct ashmem_area *asma = file->private_data;
> >         int ret = 0;
> >
> > @@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> >                 }
> >                 vmfile->f_mode |= FMODE_LSEEK;
> >                 asma->file = vmfile;
> > +               /*
> > +                * override mmap operation of the vmfile so that it can't be
> > +                * remapped which would lead to creation of a new vma with no
> > +                * asma permission checks. Have to override get_unmapped_area
> > +                * as well to prevent VM_BUG_ON check for f_ops modification.
> > +                */
> > +               if (!vmfile_fops.mmap) {
> > +                       vmfile_fops = *vmfile->f_op;
> > +                       vmfile_fops.mmap = ashmem_vmfile_mmap;
> > +                       vmfile_fops.get_unmapped_area =
> > +                                       ashmem_vmfile_get_unmapped_area;
> > +               }
> > +               vmfile->f_op = &vmfile_fops;
> >         }
> >         get_file(asma->file);
> >
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
