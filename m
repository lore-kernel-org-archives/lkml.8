Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53678C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1C520787
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594947401;
	bh=pEhESIlESWcKno48xKe9K6wm4dDF0vvRIdiOTygrQQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NsG4Rc3lq5atlar6R8nlepKk45yyDDJ2IzFZNgmLQ2T0P1vuuhIf/Scp3/Oqcs7kS
	 DfgCYVoVCbC7g8bF1Druonzu/xwPoVXCYKxbYWFrcO+CVbAsmlgGb8IR3Qq6OnxUx3
	 uwK+Cg2Lc/57FiHXBVEOMI/Yjm0GhGDCyLJyQs3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGQA4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgGQA4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:56:37 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36AAD21702;
        Fri, 17 Jul 2020 00:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594947396;
        bh=pEhESIlESWcKno48xKe9K6wm4dDF0vvRIdiOTygrQQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hAC5gbg+vbX6IMObCwbD7sMX/uMjILjTT/ZU/DmNO6kbARvycIsZYqsTIvol4eNlb
         mxbhGT53Oi9j04Gt188M9Jq5h22DH+S4r4CdU2ifbrSB1KdaE2IqYK0DvuNujIBfFG
         7uKRuAdcsipZbLS5onSm2hMdwWobako/YsT+/4vc=
Received: by mail-lj1-f181.google.com with SMTP id s9so10572910ljm.11;
        Thu, 16 Jul 2020 17:56:36 -0700 (PDT)
X-Gm-Message-State: AOAM531AY6er1eicol2pTjbug/X0Ya5tQ8fiYzYXmNUzROhG8WQOUttT
        jGT1td7FADOQ7cIKR/fS47bHv8D0+2Mzd7rXuog=
X-Google-Smtp-Source: ABdhPJyzSSGChfDIEzsqvKW2PGKUYAGiI4uO0UdY6s5+DlYBPkgmhTRxWi6fOyM4nvfkyyTLRYOPiyd1ZsP5ldwPEcg=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr3362276ljj.441.1594947394493;
 Thu, 16 Jul 2020 17:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <1594613013-13059-1-git-send-email-guoren@kernel.org> <20200714083715.GE4516@willie-the-truck>
In-Reply-To: <20200714083715.GE4516@willie-the-truck>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 17 Jul 2020 08:56:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
Message-ID: <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, Jim found a GCC security leak in arm64, and would you want to
have a look at it?
-------
I notice in the epilogue I get
    ld a4, 8(sp)
    ld a5, 100(t6)
    xor a5, a4, a5
    bne a5,zero,.L4
This looks like a security leak that the canary value is left in a4.
The i386 implementation operates directly on memory without loading
into registers.  The rs6000 implementation is careful to load 0 into
the other register in the stack_protector_test code after the xor.  I
think this is a bug in the aarch64 code that it isn't clearing the
other register.  And I think it is a bug in your code too.  If we
don't need to clear the canary from the two registers, then you should
eliminate the xor and just use "bne a5,a4,.L4".  But I think the way
you have it is right, you just need to clear the a4 register after the
xor.
--------
[1] https://gcc.gnu.org/pipermail/gcc-patches/2020-July/549910.html

On Tue, Jul 14, 2020 at 4:37 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 04:03:33AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > TSK_STACK_CANARY only used in arm64/Makefile with
> > CONFIG_STACKPROTECTOR_PER_TASK wrap. So use the same policy in
> > asm-offset.c.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-developed-by: Kees Cook <keescook@chromium.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/asm-offsets.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 0577e21..37d5d3d 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -39,7 +39,7 @@ int main(void)
> >    DEFINE(TSK_TI_SCS_SP,              offsetof(struct task_struct, thread_info.scs_sp));
> >  #endif
> >    DEFINE(TSK_STACK,          offsetof(struct task_struct, stack));
> > -#ifdef CONFIG_STACKPROTECTOR
> > +#ifdef CONFIG_STACKPROTECTOR_PER_TASK
> >    DEFINE(TSK_STACK_CANARY,   offsetof(struct task_struct, stack_canary));
> >  #endif
>
> I don't think this really makese much sense. The 'stack_canary' field in
> 'struct task_struct' is defined as:
>
> #ifdef CONFIG_STACKPROTECTOR
>         /* Canary value for the -fstack-protector GCC feature: */
>         unsigned long                   stack_canary;
> #endif
>
> so I think it makes sense to follow that in asm-offsets.c
>
> Does the current code actually cause a problem?
>
> Will



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
