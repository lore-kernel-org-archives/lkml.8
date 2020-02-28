Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF96C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5341924677
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMqw5Svf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB1T4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:56:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45286 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1T4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:56:30 -0500
Received: by mail-io1-f68.google.com with SMTP id w9so4728924iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgCIie4drkANtWai9mcgLOk3bexsmo1iuE+8Ui86s3g=;
        b=AMqw5SvfNAW3vkAcLHa2yE9iK6Xsx9B5zvr6fjdAllvxtNz0HyX1vbD/D7fZk0n/Dc
         R2/RxWXko3mnxIPuz/rRjVoQ6Jm9ZoArQxAFiNvQuV5pRKZUEswHQz6NJGCJ4I35AZBs
         TPhGT9DqQ790AsRPLXHbzuAqNR4t59ffYPbWeQDNiFEtMd7lt/gYtcoi7OVgyQyuDzqY
         jHFvtvvrqLRyZH+HQScPk4SgyQmsrpEsVhX3aD3cCKnhobGWxTKEGNqcdU0UwoUn8IFh
         UeC3fbXga7Ref+zKSY/HjFUlPk9q4oP+hpV+SAzhpTIOlaZCwfyCwr6pDEjVndo98noY
         qMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgCIie4drkANtWai9mcgLOk3bexsmo1iuE+8Ui86s3g=;
        b=b7L+gd9pn68QpnoaH9EI/BdoOVDUYgZqfzUD1lH8VKoiDl/Af4Ofeb3JTA3TAK0Yy1
         kfNCGW+FexIp9yxnJ2u4dHn+oDMgEVlfMbhKNwdy0TMvzKnrt/JcwcV0xQ3DlGpgLBI+
         E1WNS+66JoxpgCR96hvkxdNv40FZoWj4EINYu4c36VHRRCffnmOoFfhSgCU1A0QAqRmm
         cog86BSULkom7mUGj4CUwroCmN1lYz74DSGfR+RVVvUNnvA4dPFuu1o5hijan169+X4I
         TKuGcSyez6SQVOnhnCvs/EKh4F4BiobNBPPLWhGYH+CQe+Y6dop7Jp2EEuMdFOAGjkZ7
         w3Lg==
X-Gm-Message-State: APjAAAVmsI4W0y5YHhn8mACzXz1YgQd53goZ19D++d5UaChiNuUXjQaR
        sUtmKPY43rxLDE7IAimM/jfSd8TEk2tol3bbRx8x0+4=
X-Google-Smtp-Source: APXvYqz6pAfwWrjdFRSm05Wa2Bz3boVakGcxnsE3j1hOQDYhfizzVg21WgM1d2ZWPh6xNZp7mopQO99USRHUBTJ+4pI=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr4806587jac.126.1582919788059;
 Fri, 28 Feb 2020 11:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-6-brgerst@gmail.com>
 <CALCETrXyYd=pqThrXQgbz5cqQTr8SKHZey4FGq5aV2_=CS4p9Q@mail.gmail.com>
In-Reply-To: <CALCETrXyYd=pqThrXQgbz5cqQTr8SKHZey4FGq5aV2_=CS4p9Q@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 28 Feb 2020 14:56:17 -0500
Message-ID: <CAMzpN2gCETE3O7K7ORxTsOB5KNcX669yVskG==UpJ2ersGFt7Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] x86: Move 32-bit compat syscalls to common location
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:47 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Move the 32-bit wrappers for syscalls that take 64-bit arguments (loff_t)
> > to a common location so that native 32-bit can use them in preparation for
> > enabling pt_regs-based syscalls.
>
> Can you clarify the purpose?  Even having read the series up to this
> point, I have no idea what this has to do with pt_regs.
>
> I think some renaming is in order.  Consider:
>
> >
> > -COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
> > -                      unsigned long, offset_low, unsigned long, offset_high)
>
> It used to be at least a little bit clear what was going on.  There's
> this compat-only mess that changes arguments for ftruncate64.  But
> now:
>
> > +SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
> > +               unsigned long, offset_low, unsigned long, offset_high)
> >  {
> >         return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
> >  }
>
> What is this "x86" ftruncate64 thing?
>
> Maybe call it ia32_ftructate?  Or at least do something to indicate
> that this is for a specific ABI.

Previously, these syscalls relied on the fact that the 64-bit loff_t
was passed in through two consecutive stack slots.  This doesn't work
when switching to using pt_regs, where we need to reassemble the
64-bit arg from two 32-bit args.  These wrapper functions were already
in use for the compat versions of these syscalls, because the 64-bit
kernel does use pt_regs for the 32-bit compat syscalls.  In order to
enable pt_regs syscalls for 32-bit native the same wrappers are
needed.

These wrappers exists for other architectures as well.  It would be
nice to combine them into a more generic version.

>
> > diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> > index 9649b5ad2ca2..d5520e92f89d 100644
> > --- a/arch/x86/um/sys_call_table_32.c
> > +++ b/arch/x86/um/sys_call_table_32.c
> > @@ -26,6 +26,16 @@
> >
> >  #define old_mmap sys_old_mmap
> >
> > +#define sys_x86_pread sys_pread64
> > +#define sys_x86_pwrite sys_pwrite64
> > +#define sys_x86_truncate64 sys_truncate64
> > +#define sys_x86_ftruncate64 sys_ftruncate64
> > +#define sys_x86_readahead sys_readahead
> > +#define sys_x86_fadvise64 sys_fadvise64
> > +#define sys_x86_fadvise64_64 sys_fadvise64_64
> > +#define sys_x86_sync_file_range sys_sync_file_range
> > +#define sys_x86_fallocate sys_fallocate
>
> Can this not be killed by changing the table itself instead of adding
> a bunch of defines?

Ultimately I want to get UML using pt_regs syscalls too, and this
would go away along with the hacks in syscalltbl.sh.

--
Brian Gerst
