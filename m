Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAD720826
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593475978;
	bh=Eun4NbTfii0sW6QvTru7wRSuIGDGkkNEhp0AOlaNHNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NIortZiqY6RixJZsr0nl0wRwcYReA10RDRYUaGavmxkwEC6ijrHzxiApeCGUOO9EZ
	 7Va/ZW7ypQCIYQ7Ftdlsxen1KeCNMFN16hZ33zJETLawzqRUevqarx7WOUCKgpKIn5
	 yZ9S4aGAqGVAKp4jZ4H4Me7isx1bCsx0Mx2NJgmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgF3AM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgF3AM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:12:56 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D524207E8;
        Tue, 30 Jun 2020 00:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593475975;
        bh=Eun4NbTfii0sW6QvTru7wRSuIGDGkkNEhp0AOlaNHNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Py1tgRPvgo9LIcjYU1cqG1eObUlUJhT6HW0GA2FfobvWok6kLb/+5KWVyDjsHyTSt
         zB7pyxrK37gPMIyrmt9QFrggg0sy2lBX5vDCK9CZzaaF6JQGmWiP+QIrjJ3p4GkYCl
         eJ/RDztRABDZpB1hepOGzJ/XSimfXWB8LI/pko/o=
Received: by mail-lj1-f172.google.com with SMTP id h22so13232700lji.9;
        Mon, 29 Jun 2020 17:12:55 -0700 (PDT)
X-Gm-Message-State: AOAM530tcDYHX8GbFfJ+XsMo1z4O5qRn0AHfi12neIzlzsnXsplBlYUT
        pYmCZbXjlwc+bzTmJBB19qyPuubY8zRD5iPLBH4=
X-Google-Smtp-Source: ABdhPJxjszLCB+6P/QOKJOqow+AAN21SNdoVF1M0w8qzY2jVobe7wqsxOnzyz9cWZ7vJYU0iobiOGI8eZIH6eqcyzyI=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr7382221ljd.79.1593475973227;
 Mon, 29 Jun 2020 17:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200629012524.c941a5f18aa7f312d325f714@kernel.org> <mhng-37e70bbc-2616-41e6-bc8a-f144ca647c97@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-37e70bbc-2616-41e6-bc8a-f144ca647c97@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Jun 2020 08:12:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ-LcZ_fxTCkHNBYqZn-C-QVeLp12FysaTjPe6PuTQYxg@mail.gmail.com>
Message-ID: <CAJF2gTQ-LcZ_fxTCkHNBYqZn-C-QVeLp12FysaTjPe6PuTQYxg@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: Fixup compile error BUILD_BUG_ON failed
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, linux-csky@vger.kernel.org,
        Zong Li <zong.li@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Jun 30, 2020 at 7:22 AM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Sun, 28 Jun 2020 09:25:24 PDT (-0700), mhiramat@kernel.org wrote:
> > On Sun, 28 Jun 2020 16:07:37 +0000
> > guoren@kernel.org wrote:
> >
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> Unfortunately, the current code couldn't be compiled:
> >>
> >>   CC      arch/riscv/kernel/patch.o
> >> In file included from ./include/linux/kernel.h:11,
> >>                  from ./include/linux/list.h:9,
> >>                  from ./include/linux/preempt.h:11,
> >>                  from ./include/linux/spinlock.h:51,
> >>                  from arch/riscv/kernel/patch.c:6:
> >> In function =E2=80=98fix_to_virt=E2=80=99,
> >>     inlined from =E2=80=98patch_map=E2=80=99 at arch/riscv/kernel/patc=
h.c:37:17:
> >> ./include/linux/compiler.h:392:38: error: call to =E2=80=98__compileti=
me_assert_205=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: =
idx >=3D __end_of_fixed_addresses
> >>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER=
__)
> >>                                       ^
> >> ./include/linux/compiler.h:373:4: note: in definition of macro =E2=80=
=98__compiletime_assert=E2=80=99
> >>     prefix ## suffix();    \
> >>     ^~~~~~
> >> ./include/linux/compiler.h:392:2: note: in expansion of macro =E2=80=
=98_compiletime_assert=E2=80=99
> >>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER=
__)
> >>   ^~~~~~~~~~~~~~~~~~~
> >> ./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=
=98compiletime_assert=E2=80=99
> >>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >>                                      ^~~~~~~~~~~~~~~~~~
> >> ./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON_MSG=E2=80=99
> >>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >>   ^~~~~~~~~~~~~~~~
> >> ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro =E2=
=80=98BUILD_BUG_ON=E2=80=99
> >>   BUILD_BUG_ON(idx >=3D __end_of_fixed_addresses);
> >>   ^~~~~~~~~~~~
> >>
> >> Because fix_to_virt(, idx) needs a const value, not a dynamic variable=
 of
> >> reg-a0 or BUILD_BUG_ON failed with "idx >=3D __end_of_fixed_addresses"=
.
> >
> > Looks good to me :)
> >
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> Is there a configuration that runs into this bug?  It's not showing up fo=
r me,
> and I generally try to add regressions to my test suite.
>
> > Thanks!

KPROBE, I'll send the patch soon.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
