Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EC920772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593355954;
	bh=1A1LBF13tY4/QGYiqzjje0lY23s+iMcEMxhBw/Upx94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N3djhfzyexGzKhDP/NEKt9GS6T1+nrMJsKePViPoRwJ9MAzDrQWVbTo+psD6nzqIu
	 kfduOHTKL2TtjhiYDY5ey47fKz6UXQjimG5pliOIF+fsmuUVdK+1OLnY28Yw0aXvgW
	 JhffB9JgsaVzkUmz/yB8wjDeedFc7HWlkUyErXzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgF1Owd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgF1Owd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:52:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959D920771;
        Sun, 28 Jun 2020 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593355952;
        bh=1A1LBF13tY4/QGYiqzjje0lY23s+iMcEMxhBw/Upx94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NAQOE0iLfVVPbmiHJhNZeDkjlMGjFMmyGvHcSiHX3U6BiFyDySmTEdggHrg0r+1Rh
         BPpQhMrZE2V3Zo4q0MC1MrTBd9Zdc1Tu0P5UITmL5w/H0yyican7fyTRsKF7e1S0PV
         XtmNgigG+8kaWltXzltG2BnK8s23k2h/h6rgaTpQ=
Date:   Sun, 28 Jun 2020 23:52:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: Fixup compile error BUILD_BUG_ON failed
Message-Id: <20200628235226.dbbe2256ea6e846abfb63feb@kernel.org>
In-Reply-To: <CAJF2gTTCHMHp-+RoG8DoDhbJStzmOf5AK=Z3K26FUmd_hbgR=g@mail.gmail.com>
References: <1593274802-46332-1-git-send-email-guoren@kernel.org>
        <20200628115945.335b92c517cb8a8fa87be759@kernel.org>
        <CAJF2gTTCHMHp-+RoG8DoDhbJStzmOf5AK=Z3K26FUmd_hbgR=g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 14:12:07 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Sun, Jun 28, 2020 at 10:59 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sat, 27 Jun 2020 16:20:02 +0000
> > guoren@kernel.org wrote:
> >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Unfortunately, the current code couldn't be compiled, because
> > > BUILD_BUG_ON needs a static defined value, not a dynamic
> > > variable with a0 regs. Just use it inline as a solution.
> > >
> > >   CC      arch/riscv/kernel/patch.o
> > > In file included from ./include/linux/kernel.h:11,
> > >                  from ./include/linux/list.h:9,
> > >                  from ./include/linux/preempt.h:11,
> > >                  from ./include/linux/spinlock.h:51,
> > >                  from arch/riscv/kernel/patch.c:6:
> > > In function ‘fix_to_virt’,
> > >     inlined from ‘patch_map’ at arch/riscv/kernel/patch.c:37:17:
> > > ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_205’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
> > >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > >                                       ^
> > > ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
> > >     prefix ## suffix();    \
> > >     ^~~~~~
> > > ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
> > >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > >   ^~~~~~~~~~~~~~~~~~~
> > > ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
> > >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> > >                                      ^~~~~~~~~~~~~~~~~~
> > > ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
> > >   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> > >   ^~~~~~~~~~~~~~~~
> > > ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
> > >   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
> > >   ^~~~~~~~~~~~
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Zong Li <zong.li@sifive.com>
> > > ---
> > >  arch/riscv/kernel/patch.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > > index d4a64df..f8e84f2 100644
> > > --- a/arch/riscv/kernel/patch.c
> > > +++ b/arch/riscv/kernel/patch.c
> > > @@ -20,7 +20,7 @@ struct patch_insn {
> > >  };
> > >
> > >  #ifdef CONFIG_MMU
> > > -static void *patch_map(void *addr, int fixmap)
> > > +static inline void *patch_map(void *addr, int fixmap)
> >
> > Would we be better to use "__always_inline" as same as fix_to_virt?
> Ok
> 
> > And also, could you add a comment why we need to make it inline?
> I've mentioned in comment:
> > > BUILD_BUG_ON needs a static defined value, not a dynamic
> > > variable with a0 regs.
> 
> idx must be a const unsigned int or it will cause compile error with
> BUILD_BUG_ON.

Ah, sorry for the confusion. I meant the comment line in the code.
BTW, can we also use "const unsigned int" for the fixmap index so that
no one miss it anymore?

Thank you,

> 
> /*
>  * 'index to address' translation. If anyone tries to use the idx
>  * directly without translation, we catch the bug with a NULL-deference
>  * kernel oops. Illegal ranges of incoming indices are caught too.
>  */
> static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> {
>         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
>         return __fix_to_virt(idx);
> }
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/


-- 
Masami Hiramatsu <mhiramat@kernel.org>
