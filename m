Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A840C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7215F20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjobsTwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgFVXEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbgFVXEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:04:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C1C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:04:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so8250631plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SzgCWMDg2RKJ2NhPQUi7yzswSotPjadK1/0BdT/7pNM=;
        b=CjobsTwjEzfFB7mg3yto+C37iPxoADkBtXnwx5Zwh1qhWDXJI9D8xzTYannQoMeE59
         wYG8uphNg+tfYmpQDrje8+ZiMkr9C6zDHh05LXr1dxnbGcD7rcatVqb208oPrAX1xxqB
         rMhirMwPU0VMi65dec2Qn/HinSWsI/vcDRVsMIGJs+5yaNri6IK5LoQwvGPcoK+2WLMn
         sqYEhxjSdosxf/hM9s6W6CVJJi/xnF0Je9pZD+TXn6ArUzc0GmkZz3Hco2I6Im31YEfK
         tis4ESU+TFUPNnp/+ik9M+TOUIBnySvS0k8SDIEYVkUGO+TUFQ8DH2mreAVwZRufQBL7
         psPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SzgCWMDg2RKJ2NhPQUi7yzswSotPjadK1/0BdT/7pNM=;
        b=p9j3kbyzt/c+S7+j4LrAxC0Ths/sF8IBW2TwgV8j2NoDry6Qbp/NJSp5viaQ0aTypy
         HAee+od4553f0ZV80FB9wp3oir1ysH00tAZkysaQCPhkgc7fZhgvAFcEOKFqUSvDgPbg
         rmwO6EkWrgl56JXgpXj3iq4oTkAGn8rdutD13rK8plRpaNPCcG54BHUo4FypPKLLrQYs
         Pjg14RUoVhUVn0oyQhGQOJ2hHF2EAKOXIyulkB2RJNuv2otDaBYXsvgknUUX+vhUUHIK
         6lMvuBH3XPrN3KqJoOTRQnAkUYbAppQKgUfiQ5CU8NAVbArLrbGAfNGjdZzSi+jOxnUn
         anOw==
X-Gm-Message-State: AOAM5336BNcZVz3Vple+f6Vqebn/fWK+DXV3vztROMGMK+KtGrH8j1JC
        KrrK6miMzAb6kSMiXJ7AG4nrUShpV0sGzrIhJcBI0g==
X-Google-Smtp-Source: ABdhPJy9ExQlGK27NrlHcsj2o4KqK8zQSxV/IYN84Vo7oDdUJkzL59yBK014EWuci7pcT/EaZ13XpTPNDdTLyCE+wNI=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr21225140plm.179.1592867060019;
 Mon, 22 Jun 2020 16:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200617210613.95432-1-ndesaulniers@google.com> <20200617212705.tq2q6bi446gydymo@google.com>
In-Reply-To: <20200617212705.tq2q6bi446gydymo@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 16:04:07 -0700
Message-ID: <CAKwvOdniambW9_nVbDnd4A_+bdDdZMd2V1Q=Xw5EJYDGeh=eyQ@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of
 .text too
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 2:27 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
>
> On 2020-06-17, Nick Desaulniers wrote:
> >ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
> >be part of .text, as well as .text.unlikely and .text.unlikely.*.
>
> >ld.lld will produce .text.hot.*/.text.unlikely.* sections.
>
> Correction to this sentence. lld is not relevant here.
>
> -ffunction-sections combined with profile-guided optimization can
> produce .text.hot.* .text.unlikely.* sections.  Newer clang may produce
> .text.hot. .text.unlikely. (without suffix, but with a trailing dot)
> when -fno-unique-section-names is specified, as an optimization to make
> .strtab smaller.

Then why was the bug report reporting https://reviews.llvm.org/D79600
as the result of a bisection, if LLD is not relevant?  Was the
bisection wrong?

The upstream report wasn't initially public, for no good reason.  So I
didn't include it, but if we end up taking v1, this should have

Link: https://bugs.chromium.org/p/chromium/issues/detail?id=3D1084760

The kernel doesn't use -fno-unique-section-names; is that another flag
that's added by CrOS' compiler wrapper?
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/t=
hird_party/toolchain-utils/compiler_wrapper/config.go;l=3D110
Looks like no.  It doesn't use `-fno-unique-section-names` or
`-ffunction-sections`.


>
> We've already seen that GCC can place main in .text.startup without
> -ffunction-sections. There may be other non -ffunction-sections cases
> for .text.hot.* or .text.unlikely.*. So it is definitely a good idea to
> be more specific even if we don't care about -ffunction-sections for
> now.
>
> >Make sure to group these together.  Otherwise these orphan sections may
> >be placed outside of the the _stext/_etext boundaries.
> >
> >Cc: stable@vger.kernel.org
> >Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=
=3Dadd44f8d5c5c05e08b11e033127a744d61c26aee
> >Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=
=3D1de778ed23ce7492c523d5850c6c6dbb34152655
> >Link: https://reviews.llvm.org/D79600
> >Reported-by: Jian Cai <jiancai@google.com>
> >Debugged-by: Luis Lozano <llozano@google.com>
> >Suggested-by: F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google.com>
> >Tested-by: Luis Lozano <llozano@google.com>
> >Tested-by: Manoj Gupta <manojgupta@google.com>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >---
> > include/asm-generic/vmlinux.lds.h | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vml=
inux.lds.h
> >index d7c7c7f36c4a..fe5aaef169e3 100644
> >--- a/include/asm-generic/vmlinux.lds.h
> >+++ b/include/asm-generic/vmlinux.lds.h
> >@@ -560,7 +560,9 @@
> >  */
> > #define TEXT_TEXT                                                     \
> >               ALIGN_FUNCTION();                                       \
> >-              *(.text.hot TEXT_MAIN .text.fixup .text.unlikely)       \
> >+              *(.text.hot .text.hot.*)                                \
> >+              *(TEXT_MAIN .text.fixup)                                \
> >+              *(.text.unlikely .text.unlikely.*)                      \
> >               NOINSTR_TEXT                                            \
> >               *(.text..refcount)                                      \
> >               *(.ref.text)                                            \
> >--
> >2.27.0.290.gba653c62da-goog
> >



--
Thanks,
~Nick Desaulniers
