Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204FEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB39721924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHcuIinD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgFRCHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgFRCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:07:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:07:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j189so3648544oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTuTZrROcjbKGbLzM26GRFZl+svxQ2ZPj7ijGP/cuPc=;
        b=NHcuIinDiRWKtzcYfjGb+7YQ2+kaT6KDrLW9ZNvz1U6p4Zv8xELeWUjD5kWKrQDrOB
         EI6EujdfQyX+G4Pp5z3V1uKb1ANZoE1LXWjfQ59bs048ZBbusafkWNgyN9Dyr7lSVVOJ
         LsAchUzeSHFRtyD3k9a0MrC+MKYpdtEqK1hh5BG63ZUPWST2TvhwK3Claoks+N6Pw7Tj
         mU7qHV3w66bAM5+zRlLfoCpFU+knYQ3oBSumnZesfWa+PWsrxK8iA63wellLhr8r9QTb
         MgqXKZoQhXu/eVlkkUTS27tjk/iTOUkXxRS0z9kKYqpV0avZyrV2YnMdKh3jSvq1ztjG
         FWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTuTZrROcjbKGbLzM26GRFZl+svxQ2ZPj7ijGP/cuPc=;
        b=ONPJKmtwxJBfYnrCx10nSprH8gBjEysEjo+H0GjzMrDZ0E/sYfeP3ShCPb0CkqpDbe
         Y+FwfTONL+iqqZRZpBN1n8KqWroJWRnnAJPOZgD1OZtQ26tqNGwraZnQHgyVGFmJHV1X
         M/W6eQ9H1XMpi3ugzE1Cvqdn0F/Ug624uz8ojVrQr2lzFsOZmoPfM8E/NQqqyRNGuTD5
         vNC0IrJ9SermmSVb/p1/JEJQ6KHYQipd5I2Ubo3FEghjIXS/Ey82bRuzQGbLxBHhFYew
         hQPuEgA0KqL2sQod7/cd/LpMpksQPwyb9CKsGWU3pHvaKqLyqh4/IsXwH7GlIEBsjBm7
         s+tw==
X-Gm-Message-State: AOAM531ZClLR36PlJBegzcFZlIqzcyXbehJRuRFefAb1O5xsP1OLLt2y
        HGyNQ6p0D4kbg+Mik7sjJlzkkPjKFuPiGQIJQ8J6Gg==
X-Google-Smtp-Source: ABdhPJyFTC31VZdaVVaBE9s8VmMDzvA/wIR4yseV1PD6iJ2gshZHqOSl+guplhqIbzvkfw7/CLg6IBiJt6/p79avbek=
X-Received: by 2002:aca:35d4:: with SMTP id c203mr1305469oia.30.1592446021379;
 Wed, 17 Jun 2020 19:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200605222257.44882-1-saravanak@google.com> <20200616213953.GA2561@willie-the-truck>
 <CAMj1kXGdpk390+b4VDzqGzUzgwZt7GjWT2p=HaZTBTqnjefKhQ@mail.gmail.com> <20200617140526.GA3747@willie-the-truck>
In-Reply-To: <20200617140526.GA3747@willie-the-truck>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Jun 2020 19:06:25 -0700
Message-ID: <CAGETcx_hF9-G5Xg+kQJdCyho3cE3pp=L8ESsUwSQC8je9QERmA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 7:05 AM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> On Wed, Jun 17, 2020 at 10:17:33AM +0200, Ard Biesheuvel wrote:
> > On Tue, 16 Jun 2020 at 23:40, Will Deacon <will@kernel.org> wrote:
> > > On Fri, Jun 05, 2020 at 03:22:57PM -0700, Saravana Kannan wrote:
> > > > This gives significant reduction in module load time for modules with
> > > > large number of relocations with no measurable impact on modules with a
> > > > small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> > > > enabled, the load time for one module went down from 268ms to 100ms.
> > > > Another module went down from 143ms to 83ms.
> > >
> > > Whilst I can see that's a significant relative saving, what proportion of
> > > actual boot time are we talking about here? It would be interesting to
> > > know if there are bigger potential savings elsewhere.
> > >
> >
> > Also, 'some module' vs 'some other module' doesn't really say
> > anything. Please explain which modules and their sizes.
>
> I suspect these are all out-of-tree modules, but yes, some metadata such as
> sizes, nr or relocs etc would be good to have in the commit message.
>
> > > > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > > > index 65b08a74aec6..bf5118b3b828 100644
> > > > --- a/arch/arm64/kernel/module-plts.c
> > > > +++ b/arch/arm64/kernel/module-plts.c
> > > > @@ -253,6 +253,36 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> > > >       return ret;
> > > >  }
> > > >
> > > > +static bool rela_needs_dedup(Elf64_Rela *rela)
> > > > +{
> > > > +     return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26
> > > > +            || ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > > > +}
> > >
> >
> > Would it help to check the section index here as well? Call/jump
> > instructions within a section are never sent through a PLT entry.
>
> (I tried hacking this in below)
>
> > > Does this handle A53 erratum 843419 correctly? I'm worried that we skip
> > > the ADRP PLTs there.
> > >
> >
> > ADRP PLTs cannot be deduplicated, as they incorporate a relative jump
> > back to the caller.
>
> Duh yes, thanks. We can't trash the link register here.
>
> > > > +/* Group the CALL26/JUMP26 relas toward the beginning of the array. */
> > > > +static int partition_dedup_relas(Elf64_Rela *rela, int numrels)
> > > > +{
> > > > +     int i = 0, j = numrels - 1;
> > > > +     Elf64_Rela t;
> > > > +
> > > > +     while (i < j) {
> > > > +             while (rela_needs_dedup(rela + i) && i < j)
> > > > +                     i++;
> > > > +             while (!rela_needs_dedup(rela + j) && i < j)
> > > > +                     j--;
> > > > +             if (i < j) {
> > > > +                     t = *(rela + j);
> > > > +                     *(rela + j) = *(rela + i);
> > > > +                     *(rela + i) = t;
> > > > +             }
> > > > +     }
> > >
> > > This is very hard to read and I think some of the 'i < j' comparisons are
> > > redundant. Would it make more sense to assign a temporary rather than
> > > post-inc/decrement and recheck?
> > >
> >
> > Agreed.
> >
> > Also, what's wrong with [] array indexing?
>
> Saravana, since our stylistic objections are reasonably vague, I tried
> to clean this up so you can get an idea of how I'd prefer it to look (can't
> speak for Ard). I haven't tried running this, but please feel free to adapt
> it. Replacement diff below.
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 65b08a74aec6..204290314054 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -253,6 +253,39 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
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
> @@ -290,7 +323,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>
>         for (i = 0; i < ehdr->e_shnum; i++) {
>                 Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
> -               int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
> +               int nents, numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
>                 Elf64_Shdr *dstsec = sechdrs + sechdrs[i].sh_info;
>
>                 if (sechdrs[i].sh_type != SHT_RELA)
> @@ -300,8 +333,14 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
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

Thanks Will & Ard. I'll incorporate your feedback and send a v2 within
a few days.

-Saravana
