Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB112C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB21020774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLTy+RRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHKXEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHKXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:04:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58968C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:04:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so41726pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jIVnC/ThBVmdAOVNCKzkgYvpkZs/3SaWOETF+/bDBw=;
        b=rLTy+RROVIXKYHzRZBfjIkWOti+ozBxFxi1Y8dQbExBZaxXRu+MHpQylvMEgpB9YZk
         8/Dxr4NCf7tnPzgiQd1HgYSPD4gTj+Wsm4gWGJzWRwEYiaMZuUyekuXE/Tx6gX7ctGC2
         +bbLBDKDcwiruY43RjcxqxAj+jnjQJQtgCY6jLXyngqEQ1JphgIj+MRK/9U/GC1B4TIX
         WpxLutHmu+HJcryDgWQzTr4ScFIpWrv7SilLHJm/NGRBsm3+QgZeAzr0o0T9suc/Zuwh
         WQdc3YsohEnPfTVoVyGG7EsWSptfc1Vi+f9xbYbg2B1IGZFeoBkAMUtWIJaz0p/MwI+9
         JX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jIVnC/ThBVmdAOVNCKzkgYvpkZs/3SaWOETF+/bDBw=;
        b=L+PWotYuwWI7MgRZSgBoowk4z9K+aa24TEGmd25hvQujyEshhjQR+UXBKg612sqZ5J
         7AlNABlWwp0QsYqrUdajE823w2Drb+5i5tg7cfJ7x1To+ZXziSF8AyJDTKTyhzDDMAIL
         l4ybuVCGVkmhpGqPQnBdEbvSWoiyBDj8mcw9Af3hNfXMgw2W7op7d8w9lMfIJ6ixdz1E
         djyiWjW32cNF3f3wPe6QFPjtIopHaT7Ou/uPgnopXCAdVk0NpwuV2sz36f+GNiBITkSP
         3CGTrTAYm6DWZhLeHorrip1U/FZGFhxxOO/x3yYrmUD5Uie7SyNYYVd6pC0T3ajPRXr4
         SiCA==
X-Gm-Message-State: AOAM532aQD3VRT1zkzkV6OnTX4rsvs5u5kBDU2bO4ei0w+6JzNl+51yA
        ep/MUWqUBDsqyLVe+xB4iKYyJmOicB+TwEmjmsbZAw==
X-Google-Smtp-Source: ABdhPJygigo4EqPc+yqir+aRi30bS1mpvV1cF5plaBFBJoaeqBve89TpMGWKhtsUTAscu1yjyEjJDFo7iN0qttT88XU=
X-Received: by 2002:a62:8081:: with SMTP id j123mr8666722pfd.80.1597187092283;
 Tue, 11 Aug 2020 16:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=ypa8xE-kaDa7XtzPsBH8=Xu_pZj2rnWaeawNs=3dDkw@mail.gmail.com>
 <20200811173655.1162093-1-nivedita@alum.mit.edu> <CAKwvOdnjLfQ0fWsrFYDJ2O+qFAfEFnTEEnW-aHrPha8G3_WTrg@mail.gmail.com>
 <20200811224436.GA1302731@rani.riverdale.lan>
In-Reply-To: <20200811224436.GA1302731@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Aug 2020 16:04:40 -0700
Message-ID: <CAKwvOdnvyVapAJBchivu8SxoQriKEu1bAimm8688EH=uq5YMqA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed: Disable relocation relaxation for
 non-pie link
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Fangrui Song <maskray@google.com>,
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

On Tue, Aug 11, 2020 at 3:44 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Aug 11, 2020 at 10:58:40AM -0700, Nick Desaulniers wrote:
> > > Cc: stable@vger.kernel.org # 4.19.x
> >
> > Thanks Arvind, good write up.  Just curious about this stable tag, how
> > come you picked 4.19?  I can see boot failures in our CI for x86+LLD
> > back to 4.9.  Can we amend that tag to use `# 4.9`? I'd be happy to
> > help submit backports should they fail to apply cleanly.
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/builds/179237488
> >
>
> 4.19 renamed LDFLAGS to KBUILD_LDFLAGS. For 4.4, 4.9 and 4.14 the patch
> needs to be modified, KBUILD_LDFLAGS -> LDFLAGS, so I figured we should
> submit backports separately. For 4.19 onwards, it should apply without
> changes I think.

Cool, sounds good.  I'll keep an eye out for when stable goes to pick this up.

tglx, Ingo, BP, can we pretty please get this in tip/urgent for
inclusion into 5.9?
-- 
Thanks,
~Nick Desaulniers
