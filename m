Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A885C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2906620781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTw6NC1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLRj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgHLRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:39:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B7C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:39:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a79so1370969pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+nw0tzUCelBAby2tkOpTqz2VXzgt4Q4iLKx4BxN7dk=;
        b=aTw6NC1zqiue7pEcocQoxkus0jUNzxX+1+Pk27WWiD5wLyEtYoSJcRJPD3gC0lLKJZ
         Ft8GDVVf/oaVtyQUSFlhGxK3/dHVH+0TR/D2UpQGsVmwZUJdMOcMIyHQtbOqM6dBwQdD
         IRxQLQ9q0bmPqmSuWaW5FI2+6ZxsD1a3Reu42avCQPML9Y5BtyjCprJBjKr49zZDFD2r
         EEJOFh8lsi+pyr8gjdMXD1jdeRoF063fEvmNTOLV8xBKAlGhYOWHxnDbdbGvujpuL9ka
         mgLcZLyxbt7XU7T0X3ocNMCU7WCuiLOhzBSd2idGdOme4jGIrx03/xeUL4BLQuuTsPc1
         bRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+nw0tzUCelBAby2tkOpTqz2VXzgt4Q4iLKx4BxN7dk=;
        b=QZPz4oHsgsGGtkZ8n4Jc0uyDXBqJmeSNDz5LSfxd3YfmcWvSno+7gXgWi/L5/Rpetv
         i/4WAtj6qem72FgTFlMZSw5nkVOumSwuq7hBmsApm4Ss77GxApKXQEH2wKG6tewAUrqa
         uJvO3zO6VxDGugddSJPFSJsqrzBypMTdR8nq12O4dALOvYuNcNuhUaDfqwPJ+zIAK2Wz
         zEd3IQ/hQF2WCebEi68h/qRmNKDZZcUlRnMybNWxR75qLC1t+gX8r2l5MZwAXPC+Cygy
         82XOKo5XVlEVS4elL8b30Uub2GLc/BOjXshWDR45yb2t62kygTh1wD1eXAmYWZavynTo
         dRrQ==
X-Gm-Message-State: AOAM533jTKjNZKJcSkRmt9TrgwVjgtJo0DlZvxS4fCJYeVLNdpVSy6I1
        yNtwrQTk+TWbY6Ao2M19BnRSkMEivcgFaOEBiyp3LQ==
X-Google-Smtp-Source: ABdhPJw59+/d0Tp8l+mnAaeWltFhdcq83AFVNVn4foFtQb2tSca5FZLPrc/kTZpgroGmPzoBZQD0xOE5Bk/y+JtiSjE=
X-Received: by 2002:a62:8303:: with SMTP id h3mr586947pfe.169.1597253992588;
 Wed, 12 Aug 2020 10:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=ypa8xE-kaDa7XtzPsBH8=Xu_pZj2rnWaeawNs=3dDkw@mail.gmail.com>
 <20200811173655.1162093-1-nivedita@alum.mit.edu> <CAKwvOdnjLfQ0fWsrFYDJ2O+qFAfEFnTEEnW-aHrPha8G3_WTrg@mail.gmail.com>
 <20200811224436.GA1302731@rani.riverdale.lan> <CAKwvOdnvyVapAJBchivu8SxoQriKEu1bAimm8688EH=uq5YMqA@mail.gmail.com>
 <20200811234340.GA1318440@rani.riverdale.lan> <CAKwvOdn5gCjcAVHZ3jHU+q=mD5rmFAHpEyHyLf7ixtdaQ3Z-PQ@mail.gmail.com>
 <20200812004158.GA1447296@rani.riverdale.lan>
In-Reply-To: <20200812004158.GA1447296@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 10:39:41 -0700
Message-ID: <CAKwvOdnQu_6_NNtzFfxpjsxNzbj4JwENXntzMicOE6ZbUrBZqw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed: Disable relocation relaxation for
 non-pie link
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        e5ten.arch@gmail.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:42 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Aug 11, 2020 at 04:51:23PM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 11, 2020 at 4:43 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 04:04:40PM -0700, Nick Desaulniers wrote:
> > > > On Tue, Aug 11, 2020 at 3:44 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Tue, Aug 11, 2020 at 10:58:40AM -0700, Nick Desaulniers wrote:
> > > > > > > Cc: stable@vger.kernel.org # 4.19.x
> > > > > >
> > > > > > Thanks Arvind, good write up.  Just curious about this stable tag, how
> > > > > > come you picked 4.19?  I can see boot failures in our CI for x86+LLD
> > > > > > back to 4.9.  Can we amend that tag to use `# 4.9`? I'd be happy to
> > > > > > help submit backports should they fail to apply cleanly.
> > > > > > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/builds/179237488
> > > > > >
> > > > >
> > > > > 4.19 renamed LDFLAGS to KBUILD_LDFLAGS. For 4.4, 4.9 and 4.14 the patch
> > > > > needs to be modified, KBUILD_LDFLAGS -> LDFLAGS, so I figured we should
> > > > > submit backports separately. For 4.19 onwards, it should apply without
> > > > > changes I think.
> > > >
> > > > Cool, sounds good.  I'll keep an eye out for when stable goes to pick this up.
> > > >
> > > > tglx, Ingo, BP, can we pretty please get this in tip/urgent for
> > > > inclusion into 5.9?
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> > >
> > > Another alternative is to just do this unconditionally instead of even
> > > checking for the -pie flag. None of the GOTPCRELs are in the
> > > decompressor, so they shouldn't be performance-sensitive at all.
> > >
> > > It still wouldn't apply cleanly to all the stable versions, but
> > > backporting would be even simpler.
> > >
> > > What do you think?
> > >
> > > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > > index 3962f592633d..10c2ba59d192 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -43,6 +43,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign
> > >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> > >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > >  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> > > +KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
> >
> > We'd still want it for KBUILD_AFLAGS, too, just to be safe. Maybe a
>
> KBUILD_CFLAGS gets included into KBUILD_AFLAGS, so this already does
> that.

Ah, right, just below it in the diff.

>
> > one line comment to the effect of `# remove me once we can link as
> > -pie` would help us rip off this band-aid in the future?  It's more
> > obvious that the added hunk can be reverted once -pie linkage is
> > achieved with the current patch; either are fine by me.  Thanks!
> >
> > >
> > >  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> > >  GCOV_PROFILE := n
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
