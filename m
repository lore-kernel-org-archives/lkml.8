Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB24C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923D02137B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599026488;
	bh=79RQWc+rAjR/zPT+t2YrwQwDfZcXIS1a2cC0FjA+zm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V3ZJBId1UIiD9uj7n0Yx4hYtCFvoPWlVZ78GvSk+xnkkRCWCkuhiinoXg5uUQBS8O
	 PoAgPRowj7IuCV+DwiGMbGGUhnrQ08V7kWs02uMMOFKuZ3Q3llkEJ/OaQVf1b7Vwx2
	 TVL2Rai7QYoI+/lp/fkRPS8lwYh3+EEorRnYaEws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBGBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgIBGBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:01:24 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3B120826
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599026483;
        bh=79RQWc+rAjR/zPT+t2YrwQwDfZcXIS1a2cC0FjA+zm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0mJewO06FLLu6tz+5iMkyWavvof5GE9lwceqazC0c2Re6E5rjbGy0Q54X3pB0+hVu
         8vkttidRc/1caq/h5lK8ddHANwVVYyVJ0IC6IN3qrHsGluqFMBipK1LMuCYSQiQnql
         nei3urpn7N6UuDpL/SGJncIYfBUif3QSy7+LOxbk=
Received: by mail-ot1-f42.google.com with SMTP id a2so2442834otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:01:23 -0700 (PDT)
X-Gm-Message-State: AOAM533f0fcmQ5goeX4PigAfdVvhIGliUY4VU+mSMf3z4fxbRJ3q6IHw
        i5gcZpyv27ovPv/MuD/gMePjZ2fo0k9rcYiQhac=
X-Google-Smtp-Source: ABdhPJxI7NzITXZbau4MEOMnupCV16YsuYj2tomemgemDpXbs30lar6hFgxrTWHYBWFR15q7KVRJUN9cSpok8RYdcW8=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr3915641oto.90.1599026483179;
 Tue, 01 Sep 2020 23:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200901160016.3646-1-jeyu@kernel.org>
In-Reply-To: <20200901160016.3646-1-jeyu@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Sep 2020 09:01:12 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHUNqqXp8mdgR9r6phsmGbcxOjTRwjH2ua6yHU_KANB7g@mail.gmail.com>
Message-ID: <CAMj1kXHUNqqXp8mdgR9r6phsmGbcxOjTRwjH2ua6yHU_KANB7g@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 19:00, Jessica Yu <jeyu@kernel.org> wrote:
>
> In the arm64 module linker script, the section .text.ftrace_trampoline
> is specified unconditionally regardless of whether CONFIG_DYNAMIC_FTRACE
> is enabled (this is simply due to the limitation that module linker
> scripts are not preprocessed like the vmlinux one).
>
> Normally, for .plt and .text.ftrace_trampoline, the section flags
> present in the module binary wouldn't matter since module_frob_arch_sections()
> would assign them manually anyway. However, the arm64 module loader only
> sets the section flags for .text.ftrace_trampoline when CONFIG_DYNAMIC_FTRACE=y.
> That's only become problematic recently due to a recent change in
> binutils-2.35, where the .text.ftrace_trampoline section (along with the
> .plt section) is now marked writable and executable (WAX).
>
> We no longer allow writable and executable sections to be loaded due to
> commit 5c3a7db0c7ec ("module: Harden STRICT_MODULE_RWX"), so this is
> causing all modules linked with binutils-2.35 to be rejected under arm64.
> Drop the IS_ENABLED(CONFIG_DYNAMIC_FTRACE) check in module_frob_arch_sections()
> so that the section flags for .text.ftrace_trampoline get properly set to
> SHF_EXECINSTR|SHF_ALLOC, without SHF_WRITE.
>
> Link: http://lore.kernel.org/r/20200831094651.GA16385@linux-8ccs
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/module-plts.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 0ce3a28e3347..2e224435c024 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                         mod->arch.core.plt_shndx = i;
>                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
>                         mod->arch.init.plt_shndx = i;
> -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> -                        !strcmp(secstrings + sechdrs[i].sh_name,
> +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
>                                  ".text.ftrace_trampoline"))
>                         tramp = sechdrs + i;
>                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
> --
> 2.16.4
>
