Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A93208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/c8CrRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgE0MI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbgE0MIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:08:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC9C08C5C3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:08:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so2794171wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hWeLOo4iOKd8skzEBNDJ5erer3toHQFODnEuIkowq34=;
        b=i/c8CrRfXVrFDfmfnb/stIgepvZwPUviGtgSB0+PTYcuYViu7eYvZQsiZ/t1fR/nKa
         ko1mQEdp9s2JNaMylgP1d1qkfZPib6fj86D9ZHCE3uDmU+/CRu15tlDMIsC7Eu/bXsjL
         t+RLvcM5Yuqlgv98c1WiMihM0Q8TrX0IPz6UYYtqVDImokN2g00uYmsFQT95xuDMUN/l
         OnOrbdQMQxd2sPhY3aQeIt9y5ngJw6bPkPu8SmJEN/VHmRdmJ1D/ptE/i0tecDxjunf+
         CpT2ACz4ZLcTwvRCCRm0znoYEo2FxuIIFixJJoq/WFY9MqKZYR/5pwbWXXXc17Oyl/ae
         +gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hWeLOo4iOKd8skzEBNDJ5erer3toHQFODnEuIkowq34=;
        b=bV56+62wL/n9RJyTGN7fEBYbqiHgu4azra5QINJQkb5v2VHlUNKQsw21A9T6jEE6m2
         HgBjgiToe+GDxzwmcN4FZVgttGXZdyVHCH3KS29s3ssj7wIKNOZKdvJcOudwLqLOtSft
         LSSVj23ZId8taylLyVJDihvxImQURqphnXKA3UwISJ71e32yk7ewHQuTKCIf04JKjVKF
         MmF0tJJLcM/USOOjXGoBi+N7URdnAwbj7e7tRf0NYeL5Q3N+FGtnyTdtnHr8kZG5uk6J
         R0tnhmxbfjOIrR4vmCXykEgtEHQkkhX877ExxFgiAtqXpPhOu6+KwtBXE2E5EjbpxHuo
         kt+A==
X-Gm-Message-State: AOAM532TfDUkxLc2pyUq+8Nxtk5bn+jDCHrBFg89+XOCfYYqylkVL4EG
        Y/lIjeCUPAhHRZuDZa28KYjq4QhwL+uACoEUAQlMLwQB
X-Google-Smtp-Source: ABdhPJwcWYJu24e914JbBvlLZf256LX0O8onz9YEamhO/FsqlHiPswIn0bpcVMhwfK4JI8JiL0Kol7UZsMi4diWq+wQ=
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr4171363wmt.165.1590581327799;
 Wed, 27 May 2020 05:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook> <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk> <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
 <20200513033349.GR23230@ZenIV.linux.org.uk> <20200524234535.GA23230@ZenIV.linux.org.uk>
 <20200526223817.GA3819674@ZenIV.linux.org.uk>
In-Reply-To: <20200526223817.GA3819674@ZenIV.linux.org.uk>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 27 May 2020 14:08:34 +0200
Message-ID: <CAG_fn=Xvhdjhd97ChesvXScGhCC-kVp0yxT-W5L9WzaF2_4UjA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 25, 2020 at 12:45:35AM +0100, Al Viro wrote:
> > On Wed, May 13, 2020 at 04:33:49AM +0100, Al Viro wrote:
> >
> > > FWIW, what I'm going to do is
> > >     * make all callers of copy_regset_to_user() pass 0 as pos
> > > (there are very few exceptions - one on arm64, three on sparc32
> > > and five on sparc64; I hadn't dealt with arm64 one yet, but all
> > > cases on sparc are handled)
> >
> > [snip]
> >
> > Any of that would be easy to backport, though.  Several questions
> > regaring XSAVE and friends:
> >
> > * do we ever run on XSAVE/XSAVES-capable hardware with XFEATURE_FP
> > turned off?
> >
> > * is it possible for x86 to have gaps between the state components
> > area as reported by CPUID 0x0d?  IOW, can area for feature 2
> > (XFEATURE_YMM) to start *not* at 0x200 and can area for N start
> > not right after the end of area for N-1 for some N > 2?
> >
> > I think I have an easy-to-backport solution, but I'm really confused
> > about XFEATURE_FP situation...
>
> Folks, could you test the following?
>
> copy_xstate_to_kernel(): don't leave parts of destination uninitialized
>
> copy the corresponding pieces of init_fpstate into the gaps instead.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Tested-by: Alexander Potapenko <glider@google.com>


> ---
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 32b153d38748..6a54e83d5589 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -957,18 +957,31 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatu=
res)
>         return true;
>  }
>
> -/*
> - * This is similar to user_regset_copyout(), but will not add offset to
> - * the source data pointer or increment pos, count, kbuf, and ubuf.
> - */
> -static inline void
> -__copy_xstate_to_kernel(void *kbuf, const void *data,
> -                       unsigned int offset, unsigned int size, unsigned =
int size_total)
> +static void fill_gap(unsigned to, void **kbuf, unsigned *pos, unsigned *=
count)
>  {
> -       if (offset < size_total) {
> -               unsigned int copy =3D min(size, size_total - offset);
> +       if (*pos < to) {
> +               unsigned size =3D to - *pos;
> +
> +               if (size > *count)
> +                       size =3D *count;
> +               memcpy(*kbuf, (void *)&init_fpstate.xsave + *pos, size);
> +               *kbuf +=3D size;
> +               *pos +=3D size;
> +               *count -=3D size;
> +       }
> +}
>
> -               memcpy(kbuf + offset, data, copy);
> +static void copy_part(unsigned offset, unsigned size, void *from,
> +                       void **kbuf, unsigned *pos, unsigned *count)
> +{
> +       fill_gap(offset, kbuf, pos, count);
> +       if (size > *count)
> +               size =3D *count;
> +       if (size) {
> +               memcpy(*kbuf, from, size);
> +               *kbuf +=3D size;
> +               *pos +=3D size;
> +               *count -=3D size;
>         }
>  }
>
> @@ -981,8 +994,9 @@ __copy_xstate_to_kernel(void *kbuf, const void *data,
>   */
>  int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigne=
d int offset_start, unsigned int size_total)
>  {
> -       unsigned int offset, size;
>         struct xstate_header header;
> +       const unsigned off_mxcsr =3D offsetof(struct fxregs_state, mxcsr)=
;
> +       unsigned count =3D size_total;
>         int i;
>
>         /*
> @@ -998,46 +1012,42 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs=
_state *xsave, unsigned int of
>         header.xfeatures =3D xsave->header.xfeatures;
>         header.xfeatures &=3D ~XFEATURE_MASK_SUPERVISOR;
>
> +       if (header.xfeatures & XFEATURE_MASK_FP)
> +               copy_part(0, off_mxcsr,
> +                         &xsave->i387, &kbuf, &offset_start, &count);
> +       if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
> +               copy_part(off_mxcsr, MXCSR_AND_FLAGS_SIZE,
> +                         &xsave->i387.mxcsr, &kbuf, &offset_start, &coun=
t);
> +       if (header.xfeatures & XFEATURE_MASK_FP)
> +               copy_part(offsetof(struct fxregs_state, st_space), 128,
> +                         &xsave->i387.st_space, &kbuf, &offset_start, &c=
ount);
> +       if (header.xfeatures & XFEATURE_MASK_SSE)
> +               copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
> +                         &xsave->i387.xmm_space, &kbuf, &offset_start, &=
count);
> +       /*
> +        * Fill xsave->i387.sw_reserved value for ptrace frame:
> +        */
> +       copy_part(offsetof(struct fxregs_state, sw_reserved), 48,
> +                 xstate_fx_sw_bytes, &kbuf, &offset_start, &count);
>         /*
>          * Copy xregs_state->header:
>          */
> -       offset =3D offsetof(struct xregs_state, header);
> -       size =3D sizeof(header);
> -
> -       __copy_xstate_to_kernel(kbuf, &header, offset, size, size_total);
> +       copy_part(offsetof(struct xregs_state, header), sizeof(header),
> +                 &header, &kbuf, &offset_start, &count);
>
> -       for (i =3D 0; i < XFEATURE_MAX; i++) {
> +       for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
>                 /*
>                  * Copy only in-use xstates:
>                  */
>                 if ((header.xfeatures >> i) & 1) {
>                         void *src =3D __raw_xsave_addr(xsave, i);
>
> -                       offset =3D xstate_offsets[i];
> -                       size =3D xstate_sizes[i];
> -
> -                       /* The next component has to fit fully into the o=
utput buffer: */
> -                       if (offset + size > size_total)
> -                               break;
> -
> -                       __copy_xstate_to_kernel(kbuf, src, offset, size, =
size_total);
> +                       copy_part(xstate_offsets[i], xstate_sizes[i],
> +                                 src, &kbuf, &offset_start, &count);
>                 }
>
>         }
> -
> -       if (xfeatures_mxcsr_quirk(header.xfeatures)) {
> -               offset =3D offsetof(struct fxregs_state, mxcsr);
> -               size =3D MXCSR_AND_FLAGS_SIZE;
> -               __copy_xstate_to_kernel(kbuf, &xsave->i387.mxcsr, offset,=
 size, size_total);
> -       }
> -
> -       /*
> -        * Fill xsave->i387.sw_reserved value for ptrace frame:
> -        */
> -       offset =3D offsetof(struct fxregs_state, sw_reserved);
> -       size =3D sizeof(xstate_fx_sw_bytes);
> -
> -       __copy_xstate_to_kernel(kbuf, xstate_fx_sw_bytes, offset, size, s=
ize_total);
> +       fill_gap(size_total, &kbuf, &offset_start, &count);
>
>         return 0;
>  }



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
