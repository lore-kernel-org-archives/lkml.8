Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628AB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uftKWEI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEKWyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgEKWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:54:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:54:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c18so10403084ile.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPqPt+LvpyhigCOhSWJiaFTaWdPgFw1mAm/F4h69auc=;
        b=uftKWEI+n9GZB7RWezlifiB8sDtRPtbEmmq8HWPjeWwJ/cRYg2pl5241xRCuo4BSo8
         YIt7mTpu+MNAxKxfMKwf0r6TzoEGEEnbPoaBNwHaqdxlo5SJT8ToQPemoR0rJKzVBak9
         EYGunad7teqx3hUoYD2jU8JiGxklWqYQyidGtANjKQGDeQH4tuTrjI1RHN0rN85y52tZ
         7/qRpGbRDFCotBApI6/NmVBtyvlKxAkIVbboat/cdWxDZk4URHiTOvmLYPtC2BE79xzq
         xxeinuSye7EkIV2qSaFvgnxdAg+wgP1/WufaWIeRM1foOzSfUHWd+I9AAjAsBESWOhHt
         Jbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPqPt+LvpyhigCOhSWJiaFTaWdPgFw1mAm/F4h69auc=;
        b=Z/agDtt3XTVzz77J3fVuU4bv/SWRGoy0P6gdmfS0KAe0pLgK32ShbApJy27ro4znOP
         QkXaC7eVf8bmu+IrDFwpx+E79FqthTd0H5RHCcFe/4Oe5CeBR46gxytlVgHTI+uJ/fy1
         fC+p0hWR3dfxEN+3L78/rbqtCn3AYehs3kEeKC7w1IwdKq/p4Lu8Evw+1OBTXR4orHL2
         Yytgpas2993ZyYjbqbvOhlwhM4+13b937DLQu13f0qL4OhbQiqqmi+9rFFHuV3RFgWxR
         hDFreUMr0td4TmwIHHSEKpgcm+c7iKGvb2q1Y9i1sDSTizhoWrWq5mGQWGIPk995aVmb
         iEgQ==
X-Gm-Message-State: AGi0PuarTGSSWvvTd6zhRb6pA/gdBRwxv3TRbImz9KnrsnOnba+FC/Nm
        /Tbr3sKfuSHJTL0z2jhHiJon0fCEoYW9YbTMXw==
X-Google-Smtp-Source: APiQypLLW4kSraX2xLdb7NEi1dpDxPOGfEEYBhEvfQrmvqmgM2Iz6CPpGFFnvqB7VN7uslkJKhSqvkvjyD9jGJb51NE=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr17283577ilh.191.1589237651050;
 Mon, 11 May 2020 15:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com>
 <CAKwvOdnxV_KwC-q73e3basJvo4-9FCGeMUOrZLj5xyt6Yyeh2A@mail.gmail.com> <CAMzpN2gTEwGh0U+L3_R6pC8Qmv1iY7bRTiTEXD86mF3u9Nnkqg@mail.gmail.com>
In-Reply-To: <CAMzpN2gTEwGh0U+L3_R6pC8Qmv1iY7bRTiTEXD86mF3u9Nnkqg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 11 May 2020 18:54:00 -0400
Message-ID: <CAMzpN2jcCM4m_HnJPc6kpVhnf588w6bPxYM_bCEd3OgbnvBvTg@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 3:34 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 2:46 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, May 11, 2020 at 11:09 AM Brian Gerst <brgerst@gmail.com> wrote:
> > > This looks like the same issue that we just discussed for bitops.h.
> > > Add the "b" operand size modifier to force it to use the 8-bit
> > > register names (and probably also needs the "w" modifier in the 16-bit
> > > case).
> >
> > While it does feel familiar, it is slightly different.
> > https://godbolt.org/z/Rme4Zg
> > That case was both compilers validating the inline asm, yet generating
> > assembly that the assembler would choke on.  This case is validation
> > in the front end failing.
>
> > long long ret;
> > switch (sizeof(ret)) {
> > case 1:
> >         asm ("movb $5, %0" : "=q" (ret));
> >         break;
> > case 8:;
> > }
>
> So if the issue here is that the output variable type is long long,
> what code is using a 64-bit percpu variable on a 32-bit kernel?  Can
> you give a specific file that fails to build with Clang?  If Clang is
> choking on it it may be silently miscompiling on GCC.

On further investigation, 64-bit percpu operations fall back to the
generic code on x86-32, so there is no problem with miscompiling here.

On a side note from looking at the preprocessed output of the percpu
macros: they generate a ton of extra dead code because the core macros
also have a switch on data size.  I will take a stab at cleaning that
up.

--
Brian Gerst
