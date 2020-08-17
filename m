Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65859C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421DC2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkCp5JQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHQXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgHQXgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:36:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A6C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:36:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 189so8222997pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOIHbT3JqC0FRpZDPNAbKveRqgfrDO50QrAvAKQ9atQ=;
        b=XkCp5JQQCy7S3tKdICI8JlFwMNGJP2JshQrY+MGHpbLqjPKDYXrgs3hZkvZU8vHWEI
         y2arku1NBKcCW//wsFphhQ9Dt2XS3tKLFoWRzFhxzdPPw7Lp0Ut843ctXeOb+UXnrwvj
         74GD5gFl0ASqVaCLPTP3cC7mIURSfPBNExQrSolEnKhlizeYIn4wr5B8FPK0JksNyRao
         SnuzHrOxfHuI0LSR2z/T06CKFBITsvVewZoDcy81cbfFASfidcQocDlWmrFIbFXXbFuC
         RaW4rfS3CD8m5XBL2wdTcbti7034hxRp21RyB0lOPbJSFwxSwvGkbuRYdkmglJfeWnc8
         0F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOIHbT3JqC0FRpZDPNAbKveRqgfrDO50QrAvAKQ9atQ=;
        b=JJ+VpmOhhvpnDG/lmsof5hHh63NoiuK4ayfgxaEgxe5pKbeE0N8GIyicdwIrGvqnBJ
         gPQH4eJqzB4M7beNPQyt5R41TTm2az2tGxn9WHyxGOB3InTxHrrfpbPy9ZEMB5v45bgN
         UkPuhs0y1gcfhYAA61TZyv4p5gfli9O/4oY7XqLykC1PJfyh4Ve9ewnwLvhcIfW9KTuR
         6eZDs9WO2qGQ4pCpp0j8u8QtdKrcZ0774XmXb1G3iVoU9Z5DGdQyvtD1ghTkIr0xhR1D
         gyZ+iEYyBT8UuBMcj8EU8K7guMGmiShl4U3DwVLuNud5BvQOO/dXQxpFPutFKnyuazDI
         4TAw==
X-Gm-Message-State: AOAM531vOEAPMjFSCdF22B/wanEDRVySi9IQZaPgLDxsDNpBVUtX+CvZ
        5zn9XbXlKEXcvXrcS8VHwhTzCokjvVYDblir7vlrNw==
X-Google-Smtp-Source: ABdhPJzTNYLRGAfC38gdAJvUvZlf02/zlic7+bE1C4fTT/ZvvVT7ez+raK4l3fC3WsNgH8Ar/pS3z/E0UZCPTCQQcoA=
X-Received: by 2002:a62:8303:: with SMTP id h3mr13220958pfe.169.1597707399867;
 Mon, 17 Aug 2020 16:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <20200817220212.338670-2-ndesaulniers@google.com> <82bbeff7-acc3-410c-9bca-3644b141dc1a@zytor.com>
In-Reply-To: <82bbeff7-acc3-410c-9bca-3644b141dc1a@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Aug 2020 16:36:28 -0700
Message-ID: <CAKwvOdma_n8D5iERGiSSMc7o2bc-rTZN_KhqPZ+rAOP2sGw5uA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Makefile: add -fno-builtin-stpcpy
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-08-17 15:02, Nick Desaulniers wrote:
> > LLVM implemented a recent "libcall optimization" that lowers calls to
> > `sprintf(dest, "%s", str)` where the return value is used to
> > `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> > in parsing format strings. This optimization was introduced into
> > clang-12. Because the kernel does not provide an implementation of
> > stpcpy, we observe linkage failures for almost all targets when building
> > with ToT clang.
> >
> > The interface is unsafe as it does not perform any bounds checking.
> > Disable this "libcall optimization" via `-fno-builtin-stpcpy`.
> >
> > Unlike
> > commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> > which cited failures with `-fno-builtin-*` flags being retained in LLVM
> > LTO, that bug seems to have been fixed by
> > https://reviews.llvm.org/D71193, so the above sha can now be reverted in
> > favor of `-fno-builtin-bcmp`.
> >
>
> stpcpy() and (to a lesser degree) mempcpy() are fairly useful routines
> in general. Perhaps we *should* provide them?

Sorry, I forgot to provide context of the previous thread, which is
worth a read.  To answer this question specifically (or at least for
stpcpy), the answer from the previous thread was (via Kees): "No;
please no more unbounded string.h routines":
https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/
-- 
Thanks,
~Nick Desaulniers
