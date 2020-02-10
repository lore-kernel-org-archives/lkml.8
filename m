Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F03C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234820733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nb46eOhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBJSlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:41:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53712 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJSll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:41:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so135846pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+26oPPURci8wbc/keQwshEFpG87fhSfKC1I6X00Ei/g=;
        b=nb46eOhf0uPuVxDEnQQ+dlrG6ZI2ZouyYiBGEeZcFhP2SftY4CSzNODxjZNHIQSlZU
         8i18MaYxcYi9kjKt+cOH4khaS2dpGCvPZziGoNzxwAcyGOj/7kVfKJQ8Mfacn3T0kbdK
         BRBkMHXzePcBR/pzBT0i7H6qscwVpWANQQnjKW38w+c4LW0gq8oBmcxyqat2MlK3XtTB
         mzs40jDY+1uqgRfyOtMFCprNqypmMZbE8Cx2pNeKsYQnOXP5EcrA5LIb3AzGunoqBa04
         bEiyY+eDKSFFcVI9aUCjqUQLQk4dwSVyA9eZumEVeIfJCms1gQ+ljy8RtPApg0AMgoVN
         Secg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+26oPPURci8wbc/keQwshEFpG87fhSfKC1I6X00Ei/g=;
        b=fYbpfBPdYkalrQU9mQFg+fDI3lc93pmmCZapt4i7mQAyiqmRe938iO+M6C7cGodm1U
         vZ7I24wCm558yFrHIoKjvXfx4Fh1CygpWwII9u023lvoEiXCnwc7aCRIodHH+gVBmgYd
         FUOypsk8cInjadFUuY60ePW7hpt1aczwuPyavJznazbVC+uDZiJzykvcSNYKN3Bocd5/
         cftErgGTEsAViUPI4KL6JB9u83CTWIyZ2C1cUQV+xVKTiTSCpC0i51THBW2D2uiM1CYj
         6yOSeiNISCnKro4/QkbbCS5PnVFWYIYfejg1eOHx6DH6riXALXtyJw6yhyL++JgY3yTS
         XzVA==
X-Gm-Message-State: APjAAAV2+fhHWhAal7GpR6K5JSUIVE+rAKkqzmz++BbWJXbi0w4n40y3
        Q1yRrCZXzEQXidjAYyAP7Z3l7eFBS5H4VY9Uy51J1A==
X-Google-Smtp-Source: APXvYqx+Bi4Z5XLl5nC2IIbRR3gLrxNJoVDnPGzCuEIPY6OrPR1pC6+IcFhiYlhbBmf1UPlY6S57jAQeNQyXWhsDNGw=
X-Received: by 2002:a17:90a:98d:: with SMTP id 13mr487964pjo.102.1581360100932;
 Mon, 10 Feb 2020 10:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20200205005054.k72fuikf6rwrgfe4@google.com> <87pnemzoxa.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pnemzoxa.fsf@mpe.ellerman.id.au>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 10 Feb 2020 10:41:29 -0800
Message-ID: <CAFP8O3JPJvnQhAcF+DWQQGPNOj9vF-nLovzi5uSQ4zrUP1DvtQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as STV_PROTECTED
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 3:01 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> Fangrui Song <maskray@google.com> writes:
> > A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
> > preemptible symbol in a -shared link is not allowed.  GNU ld's powerpc
> > port is permissive and allows it [1], but lld will report an error afte=
r
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commi=
t/?id=3Dec0895f08f99515194e9fcfe1338becf6f759d38
> >
> > Make the symbol protected so that it is non-preemptible but still
> > exported.
>
> "preemptible" means something different to me, and I assume we're not
> using it to mean the same thing.
>
> Can you explain it using small words that a kernel developer can
> understand? :)
>
> cheers

The term used in the ELF specification is "preemptable". I heard from
Roland McGrathr that "preemptable" was a typo. The correct term is
"preemptible".
On a random article I found, it mentions that "preemptible" is used
more than "preemptable". So now I stick with "preemptible".

The word is overloaded and has a different meaning in the kernel, but
here we refer to within the ELF binary format context.

From http://www.sco.com/developers/gabi/latest/ch4.symtab.html
"The visibility of symbols with the STV_DEFAULT attribute is as
specified by the symbol's binding type. That is, global and weak
symbols are visible outside of their defining component (executable
file or shared object). Local symbols are hidden, as described below.
Global and weak symbols are also preemptable, that is, they may by
preempted by definitions of the same name in another component."

__kernel_datapage_offset is a STB_GLOBAL STV_DEFAULT symbol. In a
-shared link, it is considered preemptible. There are some methods
that make such symbols non-preemptible but none is used in this
context.

* -Bsymbolic
* -Bsymbolic-functions if STT_FUNC
* --dynamic-list is specified but the dynamic list does not name this symbo=
l
* A --version-script makes the symbol local

__kernel_datapage_offset is accessed via some mechanism similar to
dlsym, so it has to be exported.

Given all the above, I chose STV_PROTECTED, which is the simplest and
least intrusive approach.

> > [1]: https://sourceware.org/bugzilla/show_bug.cgi?id=3D25500
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/851
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> > ---
> >  arch/powerpc/kernel/vdso32/datapage.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kerne=
l/vdso32/datapage.S
> > index 217bb630f8f9..2831a8676365 100644
> > --- a/arch/powerpc/kernel/vdso32/datapage.S
> > +++ b/arch/powerpc/kernel/vdso32/datapage.S
> > @@ -13,7 +13,8 @@
> >  #include <asm/vdso_datapage.h>
> >
> >       .text
> > -     .global __kernel_datapage_offset;
> > +     .global __kernel_datapage_offset
> > +     .protected      __kernel_datapage_offset
> >  __kernel_datapage_offset:
> >       .long   0
> >
> > --
> > 2.25.0.341.g760bfbb309-goog



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
