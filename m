Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70643C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3838622596
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgGQaKPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgGNSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGNSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:20:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44931C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:20:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so15051511iln.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LBM8mZ5TU62dVovLrevNINwnFxRJdGHmD0tUrxeo9bA=;
        b=YgGQaKPEOmvcQOyPiDG6H54qBUMxmOa9APfc6QP93a9cVxaGD1EwsdbxcjmTF8LhyI
         Y872ffWWDPqAxdyYNiGeVwdvQC19MdpEZMBOX9eoS6mH9pZesXywgOrkhkS3KITmUk4W
         Z9dOj8YFJ9QV2lh4vXq2K8R0ZNSWkS8nGlRbrrzaH5SUnfOHAiB1qleAySu5Cy3oY4Uk
         5uxmPvlx6i9XYRAEsqOyGgZAgRSdIfl/jQf+XS5kpeGeXWSsEfO5aarZGprO+LmS3jFd
         S06ZrSUQVBdJW2VfAn3bOcqP/CoLJen36e0VN5Bw1BhsNzvu8oGa66t164DdvUOZzmNx
         aAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LBM8mZ5TU62dVovLrevNINwnFxRJdGHmD0tUrxeo9bA=;
        b=E/AP9aMd7S+6wSIXaZYDTWK8jiPatdKRPBmp9/tryUNIxWep8MRi4JsyjxfyJUUtpU
         2uxgHHhTH9HcCFGjFqLU6pWMHTuD9jKm5F7wzieblnr2l2KRo7tDvF+Vhpv4qTzDwb/M
         48tItXXICuHiEV2Mc1ZlQtYNWmoXbsjGCn4/fSPE73m5A+ugoeeSQ1lRx2p/q457z8vq
         jp9tgC49BTfo9zCGf04oiQ1U91fnEsacCqQyr0aT8Csf4IQx+uIFMHwgL+JAHGAxbmw3
         mYIZJ86Guk6FdOXL2l1bXtE5UlmyhkRjQFF/xYNrXJH+xnS5vbYlbhjIc3wVgGYh82g/
         WWoQ==
X-Gm-Message-State: AOAM5323zugQOSv8RdbRcI23L108Py9zJv15bt7FGv0eKgn0on4ha3zC
        VNEGb0kwr6u4ostELW7PtdYIxxUWQso4hLs7nmI=
X-Google-Smtp-Source: ABdhPJzMp8f1ZYsA+NPqsWgoz/btZaewhlW6Krb1Gw9Ul9uLTmz79yG70LVh7EN0MW9KtgDy81QQ0RVD+6O7dMHvmOQ=
X-Received: by 2002:a92:dc09:: with SMTP id t9mr6142976iln.226.1594750811549;
 Tue, 14 Jul 2020 11:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200714111103.14591-1-sedat.dilek@gmail.com> <CAKwvOdk3WSMhMxxaWfFeWYkR=xYgwrREckS+X5Yg5QeC48UVrg@mail.gmail.com>
In-Reply-To: <CAKwvOdk3WSMhMxxaWfFeWYkR=xYgwrREckS+X5Yg5QeC48UVrg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 20:19:59 +0200
Message-ID: <CA+icZUUBvSzbG9CXSzdtphotmFhG-5y5aXgDFwjwx7_QeE5hvg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Wei Liu <wei.liu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 7:46 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jul 14, 2020 at 4:11 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
> > ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a patch.
> >
> > With Jian's patch applied another issue raised up when CONFIG_HYPERV=m.
> >
> > It turned out that the conversion of vectors to IDTENTRY_SYSVEC in
> > case of CONFIG_HYPERV was incomplete and fails with a build error:
> >
> > <instantiation>:9:6: error: expected absolute expression
> >  .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
> >      ^
> > <instantiation>:1:1: note: while in macro instantiation
> > idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
> > ^
> > ./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
> > idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
> > ^
> > <instantiation>:9:6: error: expected absolute expression
> >  .if HYPERVISOR_STIMER0_VECTOR == 3
> >      ^
> > <instantiation>:1:1: note: while in macro instantiation
> > idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
> > ^
> > ./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
> > idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;
> >
> > I and Nathan double-checked the hyperv(isor) vectors:
> >
> > $ rg --no-heading "HYPERVISOR_REENLIGHTENMENT_VECTOR|HYPERVISOR_STIMER0_VECTOR"
> > $ rg --no-heading "HYPERV_REENLIGHTENMENT_VECTOR|HYPERV_STIMER0_VECTOR"
> >
> > Fix these typos in arch/x86/include/asm/idtentry.h:
> >
> > HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> > HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
> >
> > For more details see CBL issue #1088.
> >
> > With both fixes applied I was able to build/assemble with a snapshot
> > version of LLVM/Clang from Debian/experimental.
> >
> > NOTE: My patch is independent from Jian's patch and should be applied separately.
>
> Hi Sedat,
> Thanks for the patch!  Nice job finding the fix.
>
> I would like to see a v3 with the commit message trimmed a bit.  In
> particular, you mention that Jian's patch is unrelated.  In that case,
> please don't mention it in the commit message, drop the link to issue
> #1043, and drop the lore link.  I think if the commit was just simply:
>
> ```
> x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
>
> When assembling with Clang via `make LLVM_IAS=1`, we observe the
> following error:
> <instantiation>:9:6: error: expected absolute expression
> <rest of the diagnostic>
>
> This is caused by typos in arch/x86/include/asm/idtentry.h:
>
> HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
> ```
> Then the tags you have below minus the unrelated ones.
>
> >
> > Cc: Jian Cai <caij2003@gmail.com>
> > Cc: clang-built-linux@googlegroups.com
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> > Link: https://lore.kernel.org/patchwork/patch/1272115/
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1088
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
>
> Otherwise you can put some additional info here "below the fold."  It
> doesn't hurt to say "I also need Jian's patch to completely build with
> LLVM_IAS=1" but I don't think that should be in the message that gets
> committed per se.  Sorry to be a pedant about this.  With those
> changes, I'd be happy to sign off on the patch.
>

Yeah, that sounds like good compromise.

Without Jian's fix/patch we did not found the issue.
I wanted to respect this.

I will send out a v3 soonish.

- Sedat -

> > Changes v1->v2:
> > - Add Wei Liu's Reviewed-by
> > - Add note to clarify my patch is independent from Jian's patch
> > - Add link to latest version of Jian's patch
> >
> >  arch/x86/include/asm/idtentry.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> > index eeac6dc2adaa..d79541bfc36f 100644
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -626,8 +626,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,  sysvec_kvm_posted_intr_nested
> >
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,    sysvec_hyperv_callback);
> > -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,     sysvec_hyperv_reenlightenment);
> > -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,     sysvec_hyperv_stimer0);
> > +DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR, sysvec_hyperv_reenlightenment);
> > +DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR, sysvec_hyperv_stimer0);
> >  #endif
> >
> >  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> > --
>
> --
> Thanks,
> ~Nick Desaulniers
