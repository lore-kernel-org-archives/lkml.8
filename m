Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E8A21556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599509818;
	bh=ubxD/ScZybxsf+4VI1wzau0NAHEUpkIO+E2cbdGy744=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q7Nu5OcYijpJIOBzYpNFPTxfBwII4naYsr5/sKruTJ1oF4wGRLdMeDeNyaftUD7zW
	 lEwnvam2dMk9h/1tTVs4r+1aISLI456mYvwBl+RTYjhx4Ul6WqOMqxwK+8a/pPnrev
	 xMs3IudASDNNEg8bOT82vaQgN56EqT2WVMozw20o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgIGUQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:16:56 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A408F21556
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599509815;
        bh=ubxD/ScZybxsf+4VI1wzau0NAHEUpkIO+E2cbdGy744=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ELq2FWPAEkfexsb8R6febqziegl5swmnbyXXebMq9rYC0lH8WDw5C25y6ODOXIKi
         4HG/IxLLzmgVtieHUojDwPZ4pRLcD/YipRSz2wK4hzLMoW5j1qOtnWNhcVFpnvf6Bz
         K6411hafJiA4ThnSRiVyuRP5Na1RizsYlH6tgxw0=
Received: by mail-wm1-f46.google.com with SMTP id s13so15303029wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 13:16:55 -0700 (PDT)
X-Gm-Message-State: AOAM530nrStgRhHB3BA/ztufpdQNVrznmlgCIcebmY4oxfVzTAo75sP4
        txEkMSc+i1SeS1pnz+5hEFmEhejhRS+rgR2gLVnGPw==
X-Google-Smtp-Source: ABdhPJx2UM8BpaqRya476Nk2hXqdSVo1PrGufD+/Hv2y1VRUdv845YTPApnm22hs01w52l6iVs6puAuGrt3TpeIPecU=
X-Received: by 2002:a05:600c:2183:: with SMTP id e3mr980639wme.49.1599509814240;
 Mon, 07 Sep 2020 13:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200906212130.GA28456@zn.tnic>
In-Reply-To: <20200906212130.GA28456@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 7 Sep 2020 13:16:43 -0700
X-Gmail-Original-Message-ID: <CALCETrV4YN6t3Wqh+u4K=dQkj5RFQ0UbPj3nXXn2iHO+eZm4vA@mail.gmail.com>
Message-ID: <CALCETrV4YN6t3Wqh+u4K=dQkj5RFQ0UbPj3nXXn2iHO+eZm4vA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 2:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> Ingo and I talked about this thing this morning and tglx has had it on
> his to-fix list too so here's a first attempt at it.
>
> Below is just a brain dump of what we talked about so let's start with
> it and see where it would take us.
>
> Thx.
>
> ---
>
> From: Borislav Petkov <bp@suse.de>
>
> ... without any exception handling and tracing.
>
> If an exception needs to be handled while reading an MSR - which is in
> most of the cases caused by a #GP on a non-existent MSR - then this
> is most likely the incarnation of a BIOS or a hardware bug. Such bug
> violates the architectural guarantee that MSR banks are present with all
> MSRs belonging to them.
>
> The proper fix belongs in the hardware/firmware - not in the kernel.
>
> Handling exceptions while in #MC and while an NMI is being handled would
> cause the nasty NMI nesting issue because of the shortcoming of IRET
> of reenabling NMIs when executed. And the machine is in an #MC context
> already so <Deity> be at its side.
>
> Tracing MSR accesses while in #MC is another no-no due to tracing being
> inherently a bad idea in atomic context:
>
>   vmlinux.o: warning: objtool: do_machine_check()+0x4a: call to mce_rdmsrl() leaves .noinstr.text section
>
> so remove all that "additional" functionality from mce_rdmsrl() and
> concentrate on solely reading the MSRs.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0ba24dfffdb2..14ebdf3e22f3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -376,7 +376,7 @@ static int msr_to_offset(u32 msr)
>  /* MSR access wrappers used for error injection */
>  static u64 mce_rdmsrl(u32 msr)
>  {
> -       u64 v;
> +       DECLARE_ARGS(val, low, high);
>
>         if (__this_cpu_read(injectm.finished)) {
>                 int offset = msr_to_offset(msr);
> @@ -386,17 +386,13 @@ static u64 mce_rdmsrl(u32 msr)
>                 return *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
>         }
>
> -       if (rdmsrl_safe(msr, &v)) {
> -               WARN_ONCE(1, "mce: Unable to read MSR 0x%x!\n", msr);
> -               /*
> -                * Return zero in case the access faulted. This should
> -                * not happen normally but can happen if the CPU does
> -                * something weird, or if the code is buggy.
> -                */
> -               v = 0;
> -       }
> +       /*
> +        * RDMSR on MCA MSRs should not fault. If they do, this is very much an
> +        * architectural violation and needs to be reported to hw vendor.
> +        */
> +       asm volatile("rdmsr" : EAX_EDX_RET(val, low, high) : "c" (msr));

I don't like this.  Plain rdmsrl() will at least print a nice error if it fails.

Perhaps we should add a read_msr_panic() variant that panics on
failure?  Or, if there is just this one case, then we can use
rdmsrl_safe() and print a nice error and panic on failure.
