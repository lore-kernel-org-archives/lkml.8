Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C168C206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qgy/XtcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:25:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1226FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:25:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z5so4356578ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmgOIn7CLKu0/cluJFaG5idJvO1nymi+j4c/I4o6A5Y=;
        b=Qgy/XtcHoi9ZAcx9KfXpQh1hEMUZwd60c5Tc6HwImodikXHQ3WWjJddr3duPA+g0aJ
         IOm8S1DosmIyQDxFSiWLzeKIgkYBUuhMHCkWT0Bxb21CIz1zs+LmyTbV0XH+FPGEflMn
         i2NOLSwhV0pWln/dtffguH47aDwfE2Oa65KFVm7XT/cPVxp/Uv0qKK98Wva5QdhTlUYA
         SZRi6yhKIWkwWAbF5vEb2MIxNt9+J6hcwHvrbERPeLuaR4vRBenWMILZDxISaQ9EdxgH
         0966BZYXXprTJAgdtoPxbqoK1oDe0+mJv5OXr5X3SQTtN9mgWJbAPsCWpLAUYT/wALPf
         EsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmgOIn7CLKu0/cluJFaG5idJvO1nymi+j4c/I4o6A5Y=;
        b=FbAik8bdr789yJ+WvnwDmx1b/oWOQp3P3vQdK45+HYhM22zOcszSyB+fqZuGxqIoVh
         JkazUPub2OyIAOG03xEREgpex/woDkEdjJmj2uYtwazMlzeavU3TObSb/3fBIV2vTcAU
         pwAdgLxU62S8+GoEplcsNBq8FuxW034oai+dnOKZ9LqNnOrFg6g1X83YXrPClsTpoqDY
         FCbt72G0sJ9Dtj3DxXqjsLoFOM90Ssnn8Ply8ExIfVPZFYmtebIkDD0TYCKtyiGMBZc1
         +/eyksfa+Lc2URvx/wc8eiDhrfJMazyoTg3C8/2jAeGmyYyTSkgvCl9U4/CnIEcfQFzU
         Ve7g==
X-Gm-Message-State: AOAM533UUQJHV+CipzTO6R4TRjxSNceFXFlRerrmRgQEwGKYHBw6SYDt
        VVGMu7Q//R7hNNtMDvuF7MyPmKG1MpmxIecprJcR5Q==
X-Google-Smtp-Source: ABdhPJxKctA75G7J/qj6W53QptYi2MZiZGA/evgiJh+TTmSwgPpMWJZVUfO6u+1qqh8vaK8Uz54Ei0uURfXf108uvpU=
X-Received: by 2002:a17:906:ff54:: with SMTP id zo20mr4065711ejb.124.1589988353659;
 Wed, 20 May 2020 08:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <158992635164.403910.2616621400995359522.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158992635697.403910.6957168747147028694.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87d06z7x1a.fsf@mpe.ellerman.id.au>
In-Reply-To: <87d06z7x1a.fsf@mpe.ellerman.id.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 May 2020 08:25:42 -0700
Message-ID: <CAPcyv4igM-jK6OkPzd91ur_fNCaUxwbWTHhwWsWe-PJNjZdWGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 2:54 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Dan,
>
> Just a couple of minor things ...
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > In reaction to a proposal to introduce a memcpy_mcsafe_fast()
> > implementation Linus points out that memcpy_mcsafe() is poorly named
> > relative to communicating the scope of the interface. Specifically what
> > addresses are valid to pass as source, destination, and what faults /
> > exceptions are handled. Of particular concern is that even though x86
> > might be able to handle the semantics of copy_mc_to_user() with its
> > common copy_user_generic() implementation other archs likely need / want
> > an explicit path for this case:
> ...
>
> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> > index 0969285996cb..dcbbcbf3552c 100644
> > --- a/arch/powerpc/include/asm/uaccess.h
> > +++ b/arch/powerpc/include/asm/uaccess.h
> > @@ -348,6 +348,32 @@ do {                                                             \
> >  extern unsigned long __copy_tofrom_user(void __user *to,
> >               const void __user *from, unsigned long size);
> >
> > +#ifdef CONFIG_ARCH_HAS_COPY_MC
> > +extern unsigned long __must_check
>
> We try not to add extern in headers anymore.

Ok, I was doing the copy-pasta dance, but I'll remove this.

>
> > +copy_mc_generic(void *to, const void *from, unsigned long size);
> > +
> > +static inline unsigned long __must_check
> > +copy_mc_to_kernel(void *to, const void *from, unsigned long size)
> > +{
> > +     return copy_mc_generic(to, from, size);
> > +}
> > +#define copy_mc_to_kernel copy_mc_to_kernel
> > +
> > +static inline unsigned long __must_check
> > +copy_mc_to_user(void __user *to, const void *from, unsigned long n)
> > +{
> > +     if (likely(check_copy_size(from, n, true))) {
> > +             if (access_ok(to, n)) {
> > +                     allow_write_to_user(to, n);
> > +                     n = copy_mc_generic((void *)to, from, n);
> > +                     prevent_write_to_user(to, n);
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +#endif
>
> Otherwise that looks fine.

Cool.

>
> ...
>
> > diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
> > index 0917983a1c78..959817e7567c 100644
> > --- a/tools/testing/selftests/powerpc/copyloops/Makefile
> > +++ b/tools/testing/selftests/powerpc/copyloops/Makefile
> > @@ -45,9 +45,9 @@ $(OUTPUT)/memcpy_p7_t%:     memcpy_power7.S $(EXTRA_SOURCES)
> >               -D SELFTEST_CASE=$(subst memcpy_p7_t,,$(notdir $@)) \
> >               -o $@ $^
> >
> > -$(OUTPUT)/memcpy_mcsafe_64: memcpy_mcsafe_64.S $(EXTRA_SOURCES)
> > +$(OUTPUT)/copy_mc: copy_mc.S $(EXTRA_SOURCES)
> >       $(CC) $(CPPFLAGS) $(CFLAGS) \
> > -             -D COPY_LOOP=test_memcpy_mcsafe \
> > +             -D COPY_LOOP=test_copy_mc \

Ok.

>
> This needs a fixup:
>
> diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
> index 959817e7567c..b4eb5c4c6858 100644
> --- a/tools/testing/selftests/powerpc/copyloops/Makefile
> +++ b/tools/testing/selftests/powerpc/copyloops/Makefile
> @@ -47,7 +47,7 @@ $(OUTPUT)/memcpy_p7_t%:       memcpy_power7.S $(EXTRA_SOURCES)
>
>  $(OUTPUT)/copy_mc: copy_mc.S $(EXTRA_SOURCES)
>         $(CC) $(CPPFLAGS) $(CFLAGS) \
> -               -D COPY_LOOP=test_copy_mc \
> +               -D COPY_LOOP=test_copy_mc_generic \
>                 -o $@ $^
>
>  $(OUTPUT)/copyuser_64_exc_t%: copyuser_64.S exc_validate.c ../harness.c \
>
>
> >               -o $@ $^
> >
> >  $(OUTPUT)/copyuser_64_exc_t%: copyuser_64.S exc_validate.c ../harness.c \
> > diff --git a/tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S b/tools/testing/selftests/powerpc/copyloops/copy_mc.S
> > similarity index 100%
> > rename from tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S
> > rename to tools/testing/selftests/powerpc/copyloops/copy_mc.S
>
> This file is a symlink to the file in arch/powerpc/lib, so the name of
> the link needs updating, as well as the target.
>
> Also is there a reason you dropped the "_64"? It would make most sense
> to keep it I think, as then the file in selftests and the file in arch/
> have the same name.
>
> If you want to keep the copy_mc.S name it needs the diff below. Though
> as I said I think it would be better to use copy_mc_64.S.

copy_mc_64.S looks good to me.

Thanks Michael!
