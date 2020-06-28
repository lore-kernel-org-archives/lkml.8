Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F27C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501C20702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593324744;
	bh=MaEKsg6egy9Wkdm/kWLie4m5P0W1BsCSneDgGcQBAgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H9x5/eeiu7T+4By1Evbu91pkM9dqeceSJEoOra34s8iSnD0JU8uhCpqUzXDODw2a5
	 7c3g1NPvlWl9n7b5GeJtSAJZZ87H6uuvfZVcinMA4NiefiXAGEE5s1s4/pvGXKFwsm
	 YHHrbJfwceVIpieLP9h0bNmGAbdI02c4OSQ3IJcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgF1GMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgF1GMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:12:21 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA68212CC;
        Sun, 28 Jun 2020 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593324741;
        bh=MaEKsg6egy9Wkdm/kWLie4m5P0W1BsCSneDgGcQBAgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2pCwUgIshw5Jtg7FSTHrUAsO6kRgUWtBjQnrG4PHqZuG209tR0M/HEl7lJy/l3bZn
         b6mh9um0+gZZzDvvMxA4eYO//saa3RTb4+A25vpywXFvYVqR8kPYzdNykzu9swHTQO
         gAdy5TY3BWaypBMHp8CoRz+uA68e5rSHkljZb0R8=
Received: by mail-lj1-f172.google.com with SMTP id h22so7258124lji.9;
        Sat, 27 Jun 2020 23:12:20 -0700 (PDT)
X-Gm-Message-State: AOAM5326eutAI0+DU9/rI++ZPbN2fZA+gIksqTst3roZmGAZ8Q+TdMS5
        nYQUdktYzxPsRlVKlZqqZl0I1a7jr7pbfp/OxMQ=
X-Google-Smtp-Source: ABdhPJwOLXYcVriN4WTovhjiJ8y+DUyBj9KfGoziRBbU0PTHaerO/enEPu+Wtu+nCnBa4bct3gK+/AmZ+XdmTiuWaZ4=
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr5541912ljq.265.1593324739220;
 Sat, 27 Jun 2020 23:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <1593274802-46332-1-git-send-email-guoren@kernel.org> <20200628115945.335b92c517cb8a8fa87be759@kernel.org>
In-Reply-To: <20200628115945.335b92c517cb8a8fa87be759@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 28 Jun 2020 14:12:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTCHMHp-+RoG8DoDhbJStzmOf5AK=Z3K26FUmd_hbgR=g@mail.gmail.com>
Message-ID: <CAJF2gTTCHMHp-+RoG8DoDhbJStzmOf5AK=Z3K26FUmd_hbgR=g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup compile error BUILD_BUG_ON failed
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 10:59 AM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> On Sat, 27 Jun 2020 16:20:02 +0000
> guoren@kernel.org wrote:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Unfortunately, the current code couldn't be compiled, because
> > BUILD_BUG_ON needs a static defined value, not a dynamic
> > variable with a0 regs. Just use it inline as a solution.
> >
> >   CC      arch/riscv/kernel/patch.o
> > In file included from ./include/linux/kernel.h:11,
> >                  from ./include/linux/list.h:9,
> >                  from ./include/linux/preempt.h:11,
> >                  from ./include/linux/spinlock.h:51,
> >                  from arch/riscv/kernel/patch.c:6:
> > In function =E2=80=98fix_to_virt=E2=80=99,
> >     inlined from =E2=80=98patch_map=E2=80=99 at arch/riscv/kernel/patch=
.c:37:17:
> > ./include/linux/compiler.h:392:38: error: call to =E2=80=98__compiletim=
e_assert_205=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: i=
dx >=3D __end_of_fixed_addresses
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
> >                                       ^
> > ./include/linux/compiler.h:373:4: note: in definition of macro =E2=80=
=98__compiletime_assert=E2=80=99
> >     prefix ## suffix();    \
> >     ^~~~~~
> > ./include/linux/compiler.h:392:2: note: in expansion of macro =E2=80=98=
_compiletime_assert=E2=80=99
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
> >   ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=
=98compiletime_assert=E2=80=99
> >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                      ^~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98=
BUILD_BUG_ON_MSG=E2=80=99
> >   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >   ^~~~~~~~~~~~~~~~
> > ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON=E2=80=99
> >   BUILD_BUG_ON(idx >=3D __end_of_fixed_addresses);
> >   ^~~~~~~~~~~~
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/patch.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index d4a64df..f8e84f2 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -20,7 +20,7 @@ struct patch_insn {
> >  };
> >
> >  #ifdef CONFIG_MMU
> > -static void *patch_map(void *addr, int fixmap)
> > +static inline void *patch_map(void *addr, int fixmap)
>
> Would we be better to use "__always_inline" as same as fix_to_virt?
Ok

> And also, could you add a comment why we need to make it inline?
I've mentioned in comment:
> > BUILD_BUG_ON needs a static defined value, not a dynamic
> > variable with a0 regs.

idx must be a const unsigned int or it will cause compile error with
BUILD_BUG_ON.

/*
 * 'index to address' translation. If anyone tries to use the idx
 * directly without translation, we catch the bug with a NULL-deference
 * kernel oops. Illegal ranges of incoming indices are caught too.
 */
static __always_inline unsigned long fix_to_virt(const unsigned int idx)
{
        BUILD_BUG_ON(idx >=3D __end_of_fixed_addresses);
        return __fix_to_virt(idx);
}

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
