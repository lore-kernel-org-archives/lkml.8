Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC9C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A32467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgylNYI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA1AGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so13902096wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjVrjeD3QJ+6PJ6qKZcWEoHjMRPEf3uOEfUKJ8JnHLI=;
        b=jgylNYI7FFPqPl0yj8XLVgEzfctkkIK1IgEcYRwwP0urotQmY6b1+D0B4p5fz50qyk
         pqvqBZhIvuAPBLybcLTvgXwi8xJK5DqnIYila8oWZlL1mnJsgr8/6IrHpJwjq/CUTrtb
         rEsc6LloiI6vjH+s/ob2yHadqW7/XTvB5ZFQe6GrVz4DZk9Lj0QKlTXTo8Y8ZItdmvol
         VLh9PoXSR4AH8n9sj6MMSvs1W+E3xvYrsJbk349ogXmvotRZ2OqsvrHJ4Vfv1yVJ91qL
         GtP3GvOO/lw4RKyew/krYJZO1hPtz/JvOG82GcMrBHJA8ikNNHFWC6lq6aTgdh/6le4/
         4m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjVrjeD3QJ+6PJ6qKZcWEoHjMRPEf3uOEfUKJ8JnHLI=;
        b=VNRsGrfO18vOsGibmhyhdm/JZ3xqeOX+EmKXOabbu9PpRQq72vUQJZRlHSddw6Ct8b
         zvN+8P6D6+lNN3t47VFNH3zou1627TgooVI6xV/zO5FVRE4gjQflGUYGr4TmNTDTgcDb
         aciOhpJtsEBQ0relEI0g5ZYQ0CKBpjxfEV1VIR54KN23IyTlmEp37U17qqWefuWzaCso
         o/IOEO9gSdbsYkH50Qqo8QBUpUCtQC3ftEzGFtnvWfrnhHIGvn27QgVXXIzJuj9Yf+8p
         roHRYNBmTHChYRIydYIBMZeeitRV+M4gl7G4zqjW+KWRA878dwm5YT8OX2QTXSdBEQc3
         TiKQ==
X-Gm-Message-State: APjAAAX3Os2L2j3bayMDEMK6qOc+XEXvXAPi82oldwS16qciXWYFSOM1
        8sa+ILRsDy8QJ6L3RMKX5Wsc0gX4mpuYV0g/Cv58DQ==
X-Google-Smtp-Source: APXvYqwxaQhqrgUqe/+ObXlT0KOHI2eBR504o0ZIi+HYSd8zO7ktcKNPRVp+Yvr8uwipS/G4h6OW7T0ou+wEi8SHI58=
X-Received: by 2002:adf:f508:: with SMTP id q8mr25440974wro.334.1580169961494;
 Mon, 27 Jan 2020 16:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20200127210014.5207-1-tkjos@google.com> <CAJWu+orT-A5HVi97ccKwMvs9MvXWV0MZhsKcZDNS8r-gqRmcDA@mail.gmail.com>
 <CAHRSSEw67bY9V7un_t1oV2dsfE72BCAtOj_OH4wyQLpuEAjUfg@mail.gmail.com>
In-Reply-To: <CAHRSSEw67bY9V7un_t1oV2dsfE72BCAtOj_OH4wyQLpuEAjUfg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 27 Jan 2020 16:05:50 -0800
Message-ID: <CAJuCfpEYUsBt2iNixkOd9L0Wd4+0tNDquC3_fgRKtN63ZU=sjg@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Disallow ashmem memory from
 being remapped
To:     Todd Kjos <tkjos@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
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

On Mon, Jan 27, 2020 at 3:57 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> On Mon, Jan 27, 2020 at 2:30 PM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 1:00 PM 'Todd Kjos' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > When ashmem file is being mmapped the resulting vma->vm_file points to the
> > > backing shmem file with the generic fops that do not check ashmem
> > > permissions like fops of ashmem do. Fix that by disallowing mapping
> > > operation for backing shmem file.
> >
> > Looks good, but I think the commit message is confusing. I had to read
> > the code a couple times to understand what's going on since there are
> > no links to a PoC for the security issue, in the commit message. I
> > think a better message could have been:
> >
> >  When ashmem file is mmapped, the resulting vma->vm_file points to the
> >  backing shmem file with the generic fops that do not check ashmem
> >  permissions like fops of ashmem do. If an mremap is done on the ashmem
> >  region, then the permission checks will be skipped. Fix that by disallowing
> >  mapping operation on the backing shmem file.
>
> Sent v2 with the suggested change.

Sorry for the delay. The suggestion makes sense to me. Thanks!

>
> >
> > Or did I miss something?
> >
> > thanks!
> >
> > - Joel
> >
> >
> >
> > >
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable <stable@vger.kernel.org> # 4.4,4.9,4.14,4.18,5.4
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
> > > ---
> > >  drivers/staging/android/ashmem.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> > > index 74d497d39c5a..c6695354b123 100644
> > > --- a/drivers/staging/android/ashmem.c
> > > +++ b/drivers/staging/android/ashmem.c
> > > @@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
> > >                _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
> > >  }
> > >
> > > +static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
> > > +{
> > > +       /* do not allow to mmap ashmem backing shmem file directly */
> > > +       return -EPERM;
> > > +}
> > > +
> > > +static unsigned long
> > > +ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> > > +                               unsigned long len, unsigned long pgoff,
> > > +                               unsigned long flags)
> > > +{
> > > +       return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
> > > +}
> > > +
> > >  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> > >  {
> > > +       static struct file_operations vmfile_fops;
> > >         struct ashmem_area *asma = file->private_data;
> > >         int ret = 0;
> > >
> > > @@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> > >                 }
> > >                 vmfile->f_mode |= FMODE_LSEEK;
> > >                 asma->file = vmfile;
> > > +               /*
> > > +                * override mmap operation of the vmfile so that it can't be
> > > +                * remapped which would lead to creation of a new vma with no
> > > +                * asma permission checks. Have to override get_unmapped_area
> > > +                * as well to prevent VM_BUG_ON check for f_ops modification.
> > > +                */
> > > +               if (!vmfile_fops.mmap) {
> > > +                       vmfile_fops = *vmfile->f_op;
> > > +                       vmfile_fops.mmap = ashmem_vmfile_mmap;
> > > +                       vmfile_fops.get_unmapped_area =
> > > +                                       ashmem_vmfile_get_unmapped_area;
> > > +               }
> > > +               vmfile->f_op = &vmfile_fops;
> > >         }
> > >         get_file(asma->file);
> > >
> > > --
> > > 2.25.0.341.g760bfbb309-goog
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
