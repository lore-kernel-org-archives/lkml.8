Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6554207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592381869;
	bh=KANy5N1nWIV9H/SGf8fjZ+c9xEq4cZlQFQzFMCjvnMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P4dJGhJmEz1ZXsG2um8ML9Mu9Cgw85+tPQmF1sE04du4iskOHdNw8wfTb7N5c4Wp8
	 dMwxC1X+XX6IpBfj2sidU6o7TDhVnpfZuIRgYWBzasP2jcZaWT2oScQFMnVHXNAkR+
	 bSkxhv8GHShQi9XPcFeLztM2aO1TLxxdiO0K9LP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:17:46 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F0221527
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592381865;
        bh=KANy5N1nWIV9H/SGf8fjZ+c9xEq4cZlQFQzFMCjvnMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=waQ3Tx6ZTdvKhLbHknQfL1HtgLTXTO3eIAaH5dODytLIObM/owJCYZZvAoMoMNV1G
         XYx2Vrlg8He8CwgMK7dMwf99xBQZf9QEKl23oj/rPCCJu97WetqHPKkFa8nQIgN+tq
         egjwDOjbwlGfMUyS3IFDiuDzmHTO2AuO7+UEya18=
Received: by mail-ot1-f44.google.com with SMTP id n5so965859otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:17:45 -0700 (PDT)
X-Gm-Message-State: AOAM533I1aI9Moy1lK90RVKC1AgThr4XAs9j5BdHHwMIyHFpDb4hepcr
        lu8LR4FFhvirJHXnvSBR6YRsVz25fgCV/XmY9+M=
X-Google-Smtp-Source: ABdhPJwgXq8YvwTYJNdrMbAD7Em1ZZ0MMgjSrSc60NfxtftYJvAcJRt8u1TiCduwrAkt/AZOKqNJWgD64uP1F+9SZrU=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr5613374oth.90.1592381865028;
 Wed, 17 Jun 2020 01:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200605222257.44882-1-saravanak@google.com> <20200616213953.GA2561@willie-the-truck>
In-Reply-To: <20200616213953.GA2561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 10:17:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGdpk390+b4VDzqGzUzgwZt7GjWT2p=HaZTBTqnjefKhQ@mail.gmail.com>
Message-ID: <CAMj1kXGdpk390+b4VDzqGzUzgwZt7GjWT2p=HaZTBTqnjefKhQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Will Deacon <will@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 23:40, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jun 05, 2020 at 03:22:57PM -0700, Saravana Kannan wrote:
> > When loading a module, module_frob_arch_sections() tries to figure out
> > the number of PLTs that'll be needed to handle all the RELAs. While
> > doing this, it tries to dedupe PLT allocations for multiple
> > R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> > R_AARCH64_JUMP26 relocations too.
> >
> > To make checks for duplicates easier/faster, it sorts the relocation
> > list by type, symbol and addend. That way, to check for a duplicate
> > relocation, it just needs to compare with the previous entry.
> >
> > However, sorting the entire relocation array is unnecessary and
> > expensive (O(n log n)) because there are a lot of other relocation types
> > that don't need deduping or can't be deduped.
> >
> > So this commit partitions the array into entries that need deduping and
> > those that don't. And then sorts just the part that needs deduping. And
> > when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
> > because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
> > if it's disabled.
> >
> > This gives significant reduction in module load time for modules with
> > large number of relocations with no measurable impact on modules with a
> > small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> > enabled, the load time for one module went down from 268ms to 100ms.
> > Another module went down from 143ms to 83ms.
>
> Whilst I can see that's a significant relative saving, what proportion of
> actual boot time are we talking about here? It would be interesting to
> know if there are bigger potential savings elsewhere.
>

Also, 'some module' vs 'some other module' doesn't really say
anything. Please explain which modules and their sizes.

> > This commit also disables the sorting if CONFIG_RANDOMIZE_BASE is
> > disabled because it looks like PLTs are not allocated for
> > R_AARCH64_CALL26 and R_AARCH64_JUMP26 if it's disabled.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  arch/arm64/kernel/module-plts.c | 37 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 65b08a74aec6..bf5118b3b828 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -253,6 +253,36 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> >       return ret;
> >  }
> >
> > +static bool rela_needs_dedup(Elf64_Rela *rela)
> > +{
> > +     return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26
> > +            || ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > +}
>

Would it help to check the section index here as well? Call/jump
instructions within a section are never sent through a PLT entry.

> Does this handle A53 erratum 843419 correctly? I'm worried that we skip
> the ADRP PLTs there.
>

ADRP PLTs cannot be deduplicated, as they incorporate a relative jump
back to the caller.

> > +
> > +/* Group the CALL26/JUMP26 relas toward the beginning of the array. */
> > +static int partition_dedup_relas(Elf64_Rela *rela, int numrels)
> > +{
> > +     int i = 0, j = numrels - 1;
> > +     Elf64_Rela t;
> > +
> > +     while (i < j) {
> > +             while (rela_needs_dedup(rela + i) && i < j)
> > +                     i++;
> > +             while (!rela_needs_dedup(rela + j) && i < j)
> > +                     j--;
> > +             if (i < j) {
> > +                     t = *(rela + j);
> > +                     *(rela + j) = *(rela + i);
> > +                     *(rela + i) = t;
> > +             }
> > +     }
>
> This is very hard to read and I think some of the 'i < j' comparisons are
> redundant. Would it make more sense to assign a temporary rather than
> post-inc/decrement and recheck?
>

Agreed.

Also, what's wrong with [] array indexing?
