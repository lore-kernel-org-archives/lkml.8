Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6612FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ADC2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrKSk27Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgCZUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:19:46 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38477 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgCZUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:19:43 -0400
Received: by mail-il1-f196.google.com with SMTP id m7so6690738ilg.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dOHIQM15C+8J2rrlogjSwV4spTK3lPNUtfX8p1nrXQ=;
        b=mrKSk27QeQHjOhXDQ67+/nvXEJW9w0/5zoTq0a3tKFUS5MEt0c8/8hyr9bA/lTtcZc
         usly1JHNxlla3H/Z/lx62QtQG/yuXx3E9yREvC7YE+KFdrZRa1w2X/3r8Wp0N5W+tQvQ
         vW9SIOWUhjdDUtyBWGLxhpykQPilXkcZCKd5TuKwpsvC8sgHDQLTfnQ1GOnbgxcj4ocl
         RbuuOeFwOi4nupN8mAU0KKNF8E996G+GZReVy6dbztLiHFcw6uj3QsnhfmPMgIIztihp
         EZ/PStOMq+tEGtwYXNLFa1+rqA070AZY6YalKjALb79Nz7mTMn/cKm+rYa3bGpLHMpqp
         KlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dOHIQM15C+8J2rrlogjSwV4spTK3lPNUtfX8p1nrXQ=;
        b=DvmWzT0SGvawJeS0pzZU8yNZuaxvkrRNW+iPn4ntokDNQUGFtBUwslXmfgnGQSDtOw
         xr1Zv1GEqZs0f0tv94dOlSoftQrOEAc+VrB6ZSEP9tjJQ79yNiw9wxS/ws8uD/LnlzSH
         Y8f55bwZYUn1jRPnSeUtjrfP36QHPZ5UxBMI/QRRIiRFIHtmVPmkIypxs7K4iVHOIROD
         a7nF37PVFo4glFAcjkrJY4t6sqWdKgcdow1/eSDbeDxqVpWAy1yQnX31Zol+7DpPD+ye
         WkXB3E7ecwFQTd30DUELzlLtGU3RWLT1Ail68WDbbebCQ/hPo/L2u3dVXjXp1etNratZ
         XSkw==
X-Gm-Message-State: ANhLgQ2XRZjDmJKdPesQWbH0cs0uvuFmX1ATqOSdrfemReyP9UfjPyRt
        UtFysDlT2dWu8Oftfmvo18XMjRK5gXkdZyPPjpHRYQ==
X-Google-Smtp-Source: ADFU+vv9DU+eeDcpOTiazVkWPCi0VWmR4L7HpVdNPP5erkX2ql7MUXAnFmpS/pDyT/XQQ+IAZqH1L7D77DQ/545HJzs=
X-Received: by 2002:a92:8384:: with SMTP id p4mr10939777ilk.16.1585253982337;
 Thu, 26 Mar 2020 13:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com> <20200326134011.c4dswiq2g7eln3qd@tomti.i.net-space.pl>
In-Reply-To: <20200326134011.c4dswiq2g7eln3qd@tomti.i.net-space.pl>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 26 Mar 2020 13:19:30 -0700
Message-ID: <CACdnJutT1F7YJ5KFkyuaZv=nj8GqC+mrnoAsHZfMP1ZRNUQg3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 6:40 AM Daniel Kiper <daniel.kiper@oracle.com> wrote:
> On Wed, Mar 25, 2020 at 01:29:03PM -0700, 'Matthew Garrett' via trenchboot-devel wrote:
> > On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> > <ross.philipson@oracle.com> wrote:
> > > To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
> > > built into the setup section of the compressed kernel to handle the
> > > specific state that the late launch process leaves the BSP. This is a
> > > lot like the EFI stub that is found in the same area. Also this stub
> > > must measure everything that is going to be used as early as possible.
> > > This stub code and subsequent code must also deal with the specific
> > > state that the late launch leaves the APs in.
> >
> > How does this integrate with the EFI entry point? That's the expected
>
> It does not. We do not want and need to tie secure launch with UEFI.

I agree that it shouldn't be required, but it should be possible. We
shouldn't add new entry points that don't integrate with the standard
way of booting the kernel.

> > What's calling ExitBootServices() in
>
> Currently it is a bootloader, the GRUB which I am working on... OK, this
> is not perfect but if we want to call ExitBootServices() from the kernel
> then we have to move all pre-launch code from the bootloader to the
> kernel. Not nice because then everybody who wants to implement secure
> launch in different kernel, hypervisor, etc. has to re-implement whole
> pre-launch code again.

We call ExitBootServices() in the EFI stub, so this is fine as long as
the EFI stub hands over control to the SL code. But yes, I think it's
a requirement that it be kernel-owned code calling ExitBootServices().

> > this flow, and does the secure launch have to occur after it? It'd be
>
> Yes, it does.

Ok. The firmware TPM interfaces are gone after ExitBootServices(), so
we're going to need an additional implementation.

> I think any post-launch code in the kernel should not call anything from
> the gap. And UEFI belongs to the gap. OK, we can potentially re-use UEFI
> TPM code in the pre-launch phase but I am not convinced that we should
> (I am looking at it right now). And this leads us to other question
> which pops up here and there. How to call UEFI runtime services, e.g. to
> modify UEFI variables, update firmware, etc., from MLE or even from the
> OS started from MLE? In my opinion it is not safe to call anything from
> the gap after secure launch. However, on the other hand we have to give
> an option to change the boot order or update the firmware. So, how to
> do that? I do not have an easy answer yet...

How does Windows manage this? Retaining access to EFI runtime services
is necessary, and the areas in the memory map marked as runtime
services code or data should be considered part of the TCB and
measured - they're very much not part of the gap.
