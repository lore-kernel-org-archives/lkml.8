Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67049C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2662065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594277751;
	bh=0qnpvvOZ2ouMPWabm2r0fZNRG344s4R3ra9at+9Szr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gDnmOy2q+pnxQ9ahb36kbpgYhj5WsUDgim3+8L/2dvdmr4NB6RFeynjhuSh380K2q
	 HZ1Q88xZTrNncQXQspbIAm0evE1dVvs29Dz1TO+9b7Ma9kg/LfIYX66dtAoJ47HcCa
	 9qoA8bJZD9G0YycjEz1wMEDH0opUl9EjENHjNvUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIGzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgGIGzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:55:48 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED172065D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594277747;
        bh=0qnpvvOZ2ouMPWabm2r0fZNRG344s4R3ra9at+9Szr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BJ/s2ur1C0tGBHUScgrUPTUDAedxmw1oV9wtOfbUB/oDtFRYPEGvBBjWBt41aSI7
         niuJtyLcD4TPlc74Rr8vHUtgkSP7mNH1k7tSjrabgkUfat5SUVj1cfc8SKcM+wVnpk
         idhHXaWZuGfYv5yWJbyKVK6cMenGhMXovW+39H0Q=
Received: by mail-ot1-f51.google.com with SMTP id e90so1003349ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:55:47 -0700 (PDT)
X-Gm-Message-State: AOAM533feXPQJ9kcUo6+3XLlNK+Fgf7+dkAL/lOw4xSSUc7HohdIvviJ
        ePbC664EpnDzJch8GAHJoiUnun/Pg2gHNjxQs/w=
X-Google-Smtp-Source: ABdhPJx7BX00j0I/RdFxi452b9LxUoul9y9tcHXUMYbwEUodWJY43CuHz8AlSXVbR30IoBYp8sU9PpMfs1ubvARRRJQ=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr11940861otr.90.1594277746780;
 Wed, 08 Jul 2020 23:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <HKAPR02MB42915BECBD71F5ABA0890533E0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
In-Reply-To: <HKAPR02MB42915BECBD71F5ABA0890533E0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Jul 2020 09:55:35 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFPUPEtgMJPVj-ZANpPSgkcCxuOmhJR-sTV-JK3F4_cVg@mail.gmail.com>
Message-ID: <CAMj1kXFPUPEtgMJPVj-ZANpPSgkcCxuOmhJR-sTV-JK3F4_cVg@mail.gmail.com>
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

On Thu, 9 Jul 2020 at 09:50, =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@oppo=
.com> wrote:
>
> On Wed, 8 Jul 2020 at 13:03, =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@op=
po.com> wrote:
> >>
> >>
> >> On Tue, Jul 07, 2020 at 07:46:08AM -0400, Peng Hao wrote:
> >> >> If plt_max_entries is 0, a warning is triggered.
> >> >> WARNING: CPU: 200 PID: 3000 at arch/arm64/kernel/module-plts.c:97 m=
odule_emit_plt_entry+0xa4/0x150
> >> >
> >> > Which kernel are you seeing this with? There is a PLT-related change=
 in
> >> > for-next/core, and I'd like to rule if out if possible.
> >> >
> >> 5.6.0-rc3+
> >> >> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> >> >> ---
> >> >>  arch/arm64/kernel/module-plts.c | 3 ++-
> >> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/mo=
dule-plts.c
> >> >> index 65b08a74aec6..1868c9ac13f2 100644
> >> >> --- a/arch/arm64/kernel/module-plts.c
> >> >> +++ b/arch/arm64/kernel/module-plts.c
> >> >> @@ -79,7 +79,8 @@ u64 module_emit_plt_entry(struct module *mod, Elf=
64_Shdr *sechdrs,
> >> >>      int i =3D pltsec->plt_num_entries;
> >> >>      int j =3D i - 1;
> >> >>      u64 val =3D sym->st_value + rela->r_addend;
> >> >> -
> >> >> +    if (pltsec->plt_max_entries =3D=3D 0)
> >> >> +            return 0;
> >> >
> >> >Hmm, but if there aren't any PLTs then how do we end up here?
> >> >
> >> We also returned 0 when warning was triggered.
> >
> >That doesn't really answer the question.
> >
> >Apparently, you are hitting a R_AARCH64_JUMP26 or R_AARCH64_CALL26
> >relocation that operates on a b or bl instruction that is more than
> >128 megabytes away from its target.
> >
> My understanding is that a module that calls functions that are not part =
of the module will use PLT.
> Plt_max_entries =3D0 May occur if a module does not depend on other modul=
e functions.
>

A PLT slot is allocated for each b or bl instruction that refers to a
symbol that lives in a different section, either of the same module
(e.g., bl in .init calling into .text), of another module, or of the
core kernel.

I don't see how you end up with plt_max_entries in this case, though.
Are you sure you have CONFIG_RANDOMIZE_BASE enabled?

> >In module_frob_arch_sections(), we count all such relocations that
> >point to other sections, and allocate a PLT slot for each (and update
> >plt_max_entries) accordingly. So this means that the relocation in
> >question was disregarded, and this could happen for only two reasons:
> >- the branch instruction and its target are both in the same section,
> >in which case this section is *really* large,
> >- CONFIG_RANDOMIZE_BASE is disabled, but you are still ending up in a
> >situation where the modules are really far away from the core kernel
> >or from other modules.
> >
> >Do you have a lot of [large] modules loaded when this happens?
> I don=E2=80=99t think I have [large] modules.  I'll trace which module ca=
used this warning.

Yes please.
