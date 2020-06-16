Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F344C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C7520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKp61PCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFPRRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgFPRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:17:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC9C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:17:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c8so22822287iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vHq52omWlog0YiKhxrpQ9eFFCo1rr88pNsfYob/7tk=;
        b=kKp61PCmH0YJN59e08g6UWRGA2qPc2SQu2edP+4uWaU5v7dgwA8n2GmMeiSkMb9ev9
         m7KYESJwHaOcgOrlwbtrLKEP8297fuw8T29I7zFhfjVku208u21q7zo92p0esqHZ9WB/
         Z9nyiM49patEAHIfL+EYVlJ3U/I7KCcPI/LTTN+xIK4zXU+8+tUMtCL9xRMehHuiavSN
         nwzKymid8grfAPP+tXu5wJSH55j5DSGeVvq7rH98XqaTl3TJ3yHO0wGGWObRWaEQRPbh
         aieg2VomUmwc1mBtmISvHA6uB8G9qcxiuitfXLNfqeLkZl7mDRvOUTrJ87Y0QhecJ6mV
         lKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vHq52omWlog0YiKhxrpQ9eFFCo1rr88pNsfYob/7tk=;
        b=QPbXAU8qyhYSuQnWvk1uvhOorKtosNPua+oPnGccx6HMawsHjSoRyQ9VHly3Azdi8s
         to6/BzmLMORvVlIcJoWpINzm+Nmxa4H6vV7/qRW1uYVEMT1W4UNx5gI9FXIUHjlMUbCV
         2bEgJiDdJe/y9Wyh+wiTK5x+P2j3Y23QnSLUZK022MWsMncuWKNAF459kiRhksYnq1Lv
         irzrdM7K1ECgIytta/X73hdgRcdrlzZQe+ijVjysudKh4UUpxyVJirUWJNLl6CfB0BIy
         LI38LziG8tvJxK8w9JsbeUC8sKyuQHnXk3iyWAQWucWmimnAUCaDVH3WM35ffdYCcGEP
         +fhg==
X-Gm-Message-State: AOAM531/0441pP9FXM2OH6mECynML5YausqxHbbEjLDMSXrI07DygKCk
        kDggQjCBgTGi6rWzzYr+gXvX5Pz/yu99ZF5qIXdQ+Wk=
X-Google-Smtp-Source: ABdhPJyif4kUv+iTsQe9xrQHAp5uKjBBJLgDKtVWMJdUjE3F6koyRxNVPEAu+D3aptg4+KCfe14VtIEhdmro3/813rI=
X-Received: by 2002:a02:896:: with SMTP id 144mr15829689jac.126.1592327860458;
 Tue, 16 Jun 2020 10:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200616142315.375918-1-brgerst@gmail.com> <20200616142315.375918-2-brgerst@gmail.com>
 <CALCETrXUjM9g2e5v7chFXWoadvUO_7cqhGvuFn2s7YVpyff__Q@mail.gmail.com>
In-Reply-To: <CALCETrXUjM9g2e5v7chFXWoadvUO_7cqhGvuFn2s7YVpyff__Q@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 16 Jun 2020 13:17:29 -0400
Message-ID: <CAMzpN2jA3rdfCA-UYGEtRPrYCChK1wzHfVUhbrHiqGL3iL4PBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/x32: Use __x64 prefix for X32 compat syscalls
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Jun 16, 2020 at 7:23 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > The ABI prefix for syscalls specifies the argument register mapping, so
> > there is no specific reason to continue using the __x32 prefix for the
> > compat syscalls.  This change will allow using native syscalls in the X32
> > specific portion of the syscall table.
>
> Okay, I realize that the x86 syscall machinery is held together by
> duct tape and a lot of luck, but:
>
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/entry/syscall_x32.c           |  8 +++-----
> >  arch/x86/include/asm/syscall_wrapper.h | 10 +++++-----
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> > index 3d8d70d3896c..f993e6254043 100644
> > --- a/arch/x86/entry/syscall_x32.c
> > +++ b/arch/x86/entry/syscall_x32.c
> > @@ -9,15 +9,13 @@
> >  #include <asm/syscall.h>
> >
> >  #define __SYSCALL_64(nr, sym)
> > +#define __SYSCALL_COMMON(nr, sym) __SYSCALL_X32(nr, sym)
> >
> > -#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
> > -#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> > +#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_64.h>
> >  #undef __SYSCALL_X32
> > -#undef __SYSCALL_COMMON
> >
> > -#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
> > -#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
> > +#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
> >
> >  asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
> >         /*
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> > index a84333adeef2..267fae9904ff 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> >   * __x64_sys_*()         - 64-bit native syscall
> >   * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
> >   * __ia32_compat_sys_*() - 32-bit compat syscall
>
> On a 64-bit kernel, an "ia32" compat syscall is __ia32_compat_sys_*, but...
>
> > - * __x32_compat_sys_*()  - 64-bit X32 compat syscall
> > + * __x64_compat_sys_*()  - 64-bit X32 compat syscall
>
> Now an x32 compat syscall is __x64_compat?  This seems nonsensical.

Again, think of it as how the registers are mapped, not which syscall
table it belongs to.  X32 and X64 are identical in that regard.

> I'm also a bit confused as to how this is even necessary for your
> other patch.

This came out of discussion on Cristoph's patch to combine compat
execve*() into the native version:
https://lore.kernel.org/lkml/20200615141239.GA12951@lst.de/

The bottom line is that marking a syscall as X32-only in the syscall
table forces an __x32 prefix even if it's not a "compat" syscall.
This causes a link failure.  This is just another quirk caused by how
X32 was designed.  The solution is to make the prefix consistent for
the whole table.  The other alternative is to use __x32 for all the
common syscalls.

The second patch isn't really necessary, but it makes more sense to
not have a compat syscall with no corresponding native version.

--
Brian Gerst
