Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7320672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594210812;
	bh=HHc2Ezng0IQrmBx/mRY0UyImVZU/ECrgQzrZ0kvkusw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i/UsL3+65gLwLcBvqPmrzfgIuVcygekElr2u62YpWfsQ6pTn9GmL+VTl8Xg5TgoXd
	 QnmPxzcr+1eDYlNXFSUvypOm/h0ZZ8rzmSBuYWVYb7f/8ufUBGJ+CTKtHUxB8IQaMi
	 fPSzt3w5DX5o4pn8rJOfOUiB18RcosZgWOQHdVUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgGHMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgGHMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:20:10 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1945A20739
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594210810;
        bh=HHc2Ezng0IQrmBx/mRY0UyImVZU/ECrgQzrZ0kvkusw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ouHC65Qf6oGeZDFUQaogvKORY/uhSXljwcU/VdOvJIa4O0lqgUIZG9Xx47EpHDGGM
         B6YA7iYs6UVA1fYnVozB4LVF+1udfQzxKwoTj7bs5FubrM1f6zaj8lY1W6TiOcRjH1
         XaywCic+p1Ev/kEbcZz+CSaYVFKyYPgIoD0GHiys=
Received: by mail-oi1-f176.google.com with SMTP id l63so36197862oih.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:20:10 -0700 (PDT)
X-Gm-Message-State: AOAM533RxVf5+C1mLeqgDiDZNbW296kYlLeDFDzgzlHJujrZpqfDAFdN
        RZCd4Y2gABencDOslzjjt6t/xqPqNiB2w7mpiQY=
X-Google-Smtp-Source: ABdhPJzL2xtvgsVAhujqBSofPxebxLpUAT5D6hMJni/D0vkeLk/bzlZXhqWfW7ycXRQxtEFRTtuZvQR5KlrKzc7eeoI=
X-Received: by 2002:aca:f257:: with SMTP id q84mr7167150oih.174.1594210809486;
 Wed, 08 Jul 2020 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <HKAPR02MB4291B970192A023778445B1BE0670@HKAPR02MB4291.apcprd02.prod.outlook.com>
In-Reply-To: <HKAPR02MB4291B970192A023778445B1BE0670@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Jul 2020 15:19:58 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFoXMv4MEmkpj_Ft3kA+6zm3rEL4UtRgAvEDad+rTS7cQ@mail.gmail.com>
Message-ID: <CAMj1kXFoXMv4MEmkpj_Ft3kA+6zm3rEL4UtRgAvEDad+rTS7cQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     Will Deacon <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 13:03, =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@oppo=
.com> wrote:
>
>
> On Tue, Jul 07, 2020 at 07:46:08AM -0400, Peng Hao wrote:
> >> If plt_max_entries is 0, a warning is triggered.
> >> WARNING: CPU: 200 PID: 3000 at arch/arm64/kernel/module-plts.c:97 modu=
le_emit_plt_entry+0xa4/0x150
> >
> > Which kernel are you seeing this with? There is a PLT-related change in
> > for-next/core, and I'd like to rule if out if possible.
> >
> 5.6.0-rc3+
> >> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> >> ---
> >>  arch/arm64/kernel/module-plts.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/modul=
e-plts.c
> >> index 65b08a74aec6..1868c9ac13f2 100644
> >> --- a/arch/arm64/kernel/module-plts.c
> >> +++ b/arch/arm64/kernel/module-plts.c
> >> @@ -79,7 +79,8 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_=
Shdr *sechdrs,
> >>      int i =3D pltsec->plt_num_entries;
> >>      int j =3D i - 1;
> >>      u64 val =3D sym->st_value + rela->r_addend;
> >> -
> >> +    if (pltsec->plt_max_entries =3D=3D 0)
> >> +            return 0;
> >
> >Hmm, but if there aren't any PLTs then how do we end up here?
> >
> We also returned 0 when warning was triggered.

That doesn't really answer the question.

Apparently, you are hitting a R_AARCH64_JUMP26 or R_AARCH64_CALL26
relocation that operates on a b or bl instruction that is more than
128 megabytes away from its target.

In module_frob_arch_sections(), we count all such relocations that
point to other sections, and allocate a PLT slot for each (and update
plt_max_entries) accordingly. So this means that the relocation in
question was disregarded, and this could happen for only two reasons:
- the branch instruction and its target are both in the same section,
in which case this section is *really* large,
- CONFIG_RANDOMIZE_BASE is disabled, but you are still ending up in a
situation where the modules are really far away from the core kernel
or from other modules.

Do you have a lot of [large] modules loaded when this happens?
