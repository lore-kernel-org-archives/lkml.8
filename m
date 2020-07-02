Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E472073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593703802;
	bh=ibiaSjCpDSZZJylu3ozkYv+WYHYMgOffizACy47r7gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cXEAIJPLIv619V5/OHGGjEhsS0ekuNMQXiZBs4AovLdpnn74wexz+lIBB9euYjEXF
	 vyyneSOR8fIkDny0BANmqBKRm5YLZasq8w7KyQhx7xy98iT5KIv9BRj1MobmuxITQ0
	 g3lO95V3oj7O3tbCQ8VWW4WeuzHNQG42eGcCP0Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgGBPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGBPaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:30:00 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29307208B6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593703799;
        bh=ibiaSjCpDSZZJylu3ozkYv+WYHYMgOffizACy47r7gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZRg/pu+ABrs/KdKFGTQj9nrQTR9DK6Qv8G8XTx+FZY0lq1ipd5OL0WqIVrTlloB5l
         S7XNYxTfUSooMJ/IQ5c7OOCpw/WAA51zskW2OY+1AaFjljVnQob5h3ELB8H1UAicqN
         h6AVubuBVod20bnOu+lyZMCy4nU0YOyOIykGzciU=
Received: by mail-wr1-f46.google.com with SMTP id z15so17750125wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:29:59 -0700 (PDT)
X-Gm-Message-State: AOAM533D13ZqkK8TDaQRqbSkBDvfadJ/GItHLU1HRipsBMzI8jVu2zGe
        6omZq3sH2gmIsR5XhyLczHjOfkryOxTBu3cKFLU4Sw==
X-Google-Smtp-Source: ABdhPJzvh1jSZwTR0P/Tfnn8c8bQElkLW3f4MnXmGL8GLh44z97J+WTcfcbc/psDObtgUEhnYIYqv7s0HYDlAeLcKBE=
X-Received: by 2002:a5d:630d:: with SMTP id i13mr32495482wru.208.1593703797718;
 Thu, 02 Jul 2020 08:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200623011803.91232-1-saravanak@google.com>
In-Reply-To: <20200623011803.91232-1-saravanak@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Jul 2020 17:29:46 +0200
X-Gmail-Original-Message-ID: <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
Message-ID: <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Saravana Kannan <saravanak@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 03:27, Saravana Kannan <saravanak@google.com> wrote:
>
> When loading a module, module_frob_arch_sections() tries to figure out
> the number of PLTs that'll be needed to handle all the RELAs. While
> doing this, it tries to dedupe PLT allocations for multiple
> R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> R_AARCH64_JUMP26 relocations.
>
> To make checks for duplicates easier/faster, it sorts the relocation
> list by type, symbol and addend. That way, to check for a duplicate
> relocation, it just needs to compare with the previous entry.
>
> However, sorting the entire relocation array is unnecessary and
> expensive (O(n log n)) because there are a lot of other relocation types
> that don't need deduping or can't be deduped.
>
> So this commit partitions the array into entries that need deduping and
> those that don't. And then sorts just the part that needs deduping. And
> when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
> because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
> if it's disabled.
>
> This gives significant reduction in module load time for modules with
> large number of relocations with no measurable impact on modules with a
> small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> enabled, these were the results for a few downstream modules:
>
> Module          Size (MB)
> wlan            14
> video codec     3.8
> drm             1.8
> IPA             2.5
> audio           1.2
> gpu             1.8
>
> Without this patch:
> Module          Number of entries sorted        Module load time (ms)
> wlan            243739                          283
> video codec     74029                           138
> drm             53837                           67
> IPA             42800                           90
> audio           21326                           27
> gpu             20967                           32
>
> Total time to load all these module: 637 ms
>
> With this patch:
> Module          Number of entries sorted        Module load time (ms)
> wlan            22454                           61
> video codec     10150                           47
> drm             13014                           40
> IPA             8097                            63
> audio           4606                            16
> gpu             6527                            20
>
> Total time to load all these modules: 247
>
> Time saved during boot for just these 6 modules: 390 ms
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[I am no longer at Linaro so please don't use my @linaro.org address]

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1 -> v2:
> - Provided more details in the commit text
> - Pulled in Will's comments on the coding style
> - Pulled in Ard's suggestion about skipping jumps with the same section
>   index (parts of Will's suggested code)
>
>  arch/arm64/kernel/module-plts.c | 46 ++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 65b08a74aec6..0ce3a28e3347 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -253,6 +253,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>         return ret;
>  }
>
> +static bool branch_rela_needs_plt(Elf64_Sym *syms, Elf64_Rela *rela,
> +                                 Elf64_Word dstidx)
> +{
> +
> +       Elf64_Sym *s = syms + ELF64_R_SYM(rela->r_info);
> +
> +       if (s->st_shndx == dstidx)
> +               return false;
> +
> +       return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26 ||
> +              ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> +}
> +
> +/* Group branch PLT relas at the front end of the array. */
> +static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
> +                                     int numrels, Elf64_Word dstidx)
> +{
> +       int i = 0, j = numrels - 1;
> +
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               return 0;
> +
> +       while (i < j) {
> +               if (branch_rela_needs_plt(syms, &rela[i], dstidx))
> +                       i++;
> +               else if (branch_rela_needs_plt(syms, &rela[j], dstidx))
> +                       swap(rela[i], rela[j]);

Nit: would be slightly better to put

  swap(rela[i++], rela[j]);

here so the next iteration of the loop will not call
branch_rela_needs_plt() on rela[i] redundantly. But the current code
is also correct.





> +               else
> +                       j--;
> +       }
> +
> +       return i;
> +}
> +
>  int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                               char *secstrings, struct module *mod)
>  {
> @@ -290,7 +324,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>
>         for (i = 0; i < ehdr->e_shnum; i++) {
>                 Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
> -               int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
> +               int nents, numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
>                 Elf64_Shdr *dstsec = sechdrs + sechdrs[i].sh_info;
>
>                 if (sechdrs[i].sh_type != SHT_RELA)
> @@ -300,8 +334,14 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                 if (!(dstsec->sh_flags & SHF_EXECINSTR))
>                         continue;
>
> -               /* sort by type, symbol index and addend */
> -               sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
> +               /*
> +                * sort branch relocations requiring a PLT by type, symbol index
> +                * and addend
> +                */
> +               nents = partition_branch_plt_relas(syms, rels, numrels,
> +                                                  sechdrs[i].sh_info);
> +               if (nents)
> +                       sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
>
>                 if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
>                         core_plts += count_plts(syms, rels, numrels,
> --
> 2.27.0.111.gc72c7da667-goog
>
