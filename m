Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8979DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5972E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1qtGcuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCLT7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:59:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35424 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:59:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so7795036wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ob+DDAJoCv1eNbpOzJsx/saHpEetRfJlb0KnNJ3G6Og=;
        b=X1qtGcuvtvqFLuJpd+LP+okeBAHhenV4fi3+E47XtLVTi50WomOHJaVXJwKPrIFDNz
         2cgvozUVrPAkfJ7GJYn2XZchKUpD4GXfk7rc2yCfXHtFbfM5ntfsjQjfwWnt6GkiWKPX
         DN6er1P1AU3isxcGno53R5S2vZ8pQgAQSPrk8emtJchUerRbWdHHszfgp6DeV03f++2Y
         eTMbqy3iqlNvvYRKL5hu+qAhApLzaCbPp8q8xLrSjYIJc3Puu8749dkNxIFhnI/TO1w+
         Px5ldX2pwZszdBWGLq1okMV/XR7fCGe6oaoq0UvtFaYL8U3JVT+YA3vLxWWVzCs9x3+l
         oU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ob+DDAJoCv1eNbpOzJsx/saHpEetRfJlb0KnNJ3G6Og=;
        b=iU64dwnw9wjIgmHoa+Cz/qJs+PA58BLY2Gx7ajb+lTtAuYsr/MFFngVSytBEAHYkwi
         vSj7Bq/1Li55Pf+Z3H0DDypL203M0W4r54sBkbQjqvw4xz2b8FHgDPI7bTE/8o6knPx3
         AZ2dCF8Z69qlIsHjrCVIm/QY+q0Zx7y6UNSygNxI2iQ3lF3WhtPVNvEGVlQ7sMwrM2Hd
         ok9iv3FmQUrgRAzfVf746u74DZBDKpinZAr94Y89a64J1GeRfeH1C5oT8AYt4BQzt8ff
         8FVfia/CWHob//BdECQydACMu8IOsZbOfBd23iHlgDT7UiWjZyXnRZUyn/5M0kp/dRkV
         ESEQ==
X-Gm-Message-State: ANhLgQ0YGjNpxrWRO3wd6GIRWZ659LWrAb1muwYFa+hHKGCpl/djdK8s
        DYDfMZcqf6RcdXaSqpx6EQVEV3+xMb0VaA3LwXWkEQ==
X-Google-Smtp-Source: ADFU+vtNzD+KVArkr1t+ZItRwBiWwgsZ175SQZjbBDipJcKcWr0rV2ntzewY7uSWxCh7efF2btQLS9IY5JEAkPzrMJg=
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr6032809wma.29.1584043180023;
 Thu, 12 Mar 2020 12:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312155920.50067-1-glider@google.com> <20200312164922.GC21120@lakrids.cambridge.arm.com>
In-Reply-To: <20200312164922.GC21120@lakrids.cambridge.arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Mar 2020 20:59:28 +0100
Message-ID: <CAG_fn=VfRW6Gi-a9WCMwoK1-Nc+i+NFLN3ZyhFAUzr-K3LeaZQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: define __alloc_zeroed_user_highpage
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 5:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Mar 12, 2020 at 04:59:20PM +0100, glider@google.com wrote:
> > When running the kernel with init_on_alloc=3D1, calling the default
> > implementation of __alloc_zeroed_user_highpage() from include/linux/hig=
hmem.h
> > leads to double-initialization of the allocated page (first by the page
> > allocator, then by clear_user_page().
> > Calling alloc_page_vma() with __GFP_ZERO, similarly to e.g. x86, seems
> > to be enough to ensure the user page is zeroed only once.
>
> Just to check, is there a functional ussue beyond the redundant zeroing,
> or is this jsut a performance issue?

This is just a performance issue that only manifests when running the
kernel with init_on_alloc=3D1.

> On architectures with real highmem, does GFP_HIGHUSER prevent the
> allocator from zeroing the page in this case, or is the architecture
> prevented from allocating from highmem?

I was hoping one of ARM maintainers can answer this question. My
understanding was that __GFP_ZERO should be sufficient, but there's
probably something I'm missing.



> Thanks,
> Mark.
>
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  arch/arm64/include/asm/page.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/pag=
e.h
> > index d39ddb258a049..75d6cd23a6790 100644
> > --- a/arch/arm64/include/asm/page.h
> > +++ b/arch/arm64/include/asm/page.h
> > @@ -21,6 +21,10 @@ extern void __cpu_copy_user_page(void *to, const voi=
d *from,
> >  extern void copy_page(void *to, const void *from);
> >  extern void clear_page(void *to);
> >
> > +#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
> > +     alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vad=
dr)
> > +#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
> > +
> >  #define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, va=
ddr)
> >  #define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from=
, vaddr)
> >
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
