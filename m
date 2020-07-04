Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C49DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B53120826
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npG02l03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGDAsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDAsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:48:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB366C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 17:48:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x83so20213209oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyrkdM+/4kywlo/uW0HgnDi0aBA7X4V+SafC1NVgeP8=;
        b=npG02l03/lduMydpCZdBq/DY0eZ2nVHuPlPCmEzlyUDEHaNaWOtlLyAwZBWaHEBXNj
         Y1Ge+jYO5m1ipN3xB0eOvNZZCyfg8LiSb3lkEShgopcDyFHapyeOA5O3db+lNbTNaYqj
         HCNoWVQobB7ppqkpDtvMTyygDf9Hq/Seaaq9rJ5iE/xkeC4zX9SUfmczUa4cVSsWqCeU
         eac+npmASPQIvpPY63XfszQYj1YA7oyt9p7qve3poM4luMZ9MiK6/wK55M5uvDaeXCT8
         kCcPLhZ2Ar2IPOoVW+NLlEbleqZEXPJq02xQuxlRYUDxvQE0DNXQGhy/hEer59NCfDL9
         kP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyrkdM+/4kywlo/uW0HgnDi0aBA7X4V+SafC1NVgeP8=;
        b=BXMfS2/BBPe5xCnYTg/wMvN57OPaIBYAS9Q/aLQKM2o5lhbw848msMaoLi38qPsLFl
         lWemWE8eu+DQzXJKN4CkVb1lMH8AqhmdjjuQ5XDv+saRstXnJ4k9uYQrBz/VOL2TZN4l
         d/nZc6jRGbAMF3haDFMTfYOf65BTmKSv1+6omAhxruQyXCRlnnE6TjMx8Y09FmH3AJkH
         T3KvvYyHRAQVAUOfZk5pN+8GhyaF4wfv4SsK1Juq/lD/yyfeLPG88x1MEQchtjrhzhfg
         Sq4cpYXsu9eu3xcJCmGYB/CYXOUxcK+lUSl83jpgbK+rRyySIpNu1C9C4rIwgedBS4xl
         1gmA==
X-Gm-Message-State: AOAM531Ke7WeyvrLqZ+DXyX5TeVmCpHRINlci/9WxoXb8sWYVNph1yIy
        A2UgXrKIV2+H7IS1qUndIsVfYwNtKQX+tubggqRzvw==
X-Google-Smtp-Source: ABdhPJxtI0XuLnlxXZZheRMrj1zS5lfhIukPHeF36zADB7w8iimLB88dn2rs2U2+709eQuhvCr6+R6iIusJDlm8/wPU=
X-Received: by 2002:a05:6808:3d8:: with SMTP id o24mr15366288oie.69.1593823680002;
 Fri, 03 Jul 2020 17:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200623011803.91232-1-saravanak@google.com> <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Jul 2020 17:47:24 -0700
Message-ID: <CAGETcx9SBOQOL+xKq_-d2egG8+jMNjPMH37tVNBxgkWBGLWhvA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Thu, Jul 2, 2020 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 23 Jun 2020 at 03:27, Saravana Kannan <saravanak@google.com> wrote:
> >
> > When loading a module, module_frob_arch_sections() tries to figure out
> > the number of PLTs that'll be needed to handle all the RELAs. While
> > doing this, it tries to dedupe PLT allocations for multiple
> > R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> > R_AARCH64_JUMP26 relocations.
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
> > enabled, these were the results for a few downstream modules:
> >
> > Module          Size (MB)
> > wlan            14
> > video codec     3.8
> > drm             1.8
> > IPA             2.5
> > audio           1.2
> > gpu             1.8
> >
> > Without this patch:
> > Module          Number of entries sorted        Module load time (ms)
> > wlan            243739                          283
> > video codec     74029                           138
> > drm             53837                           67
> > IPA             42800                           90
> > audio           21326                           27
> > gpu             20967                           32
> >
> > Total time to load all these module: 637 ms
> >
> > With this patch:
> > Module          Number of entries sorted        Module load time (ms)
> > wlan            22454                           61
> > video codec     10150                           47
> > drm             13014                           40
> > IPA             8097                            63
> > audio           4606                            16
> > gpu             6527                            20
> >
> > Total time to load all these modules: 247
> >
> > Time saved during boot for just these 6 modules: 390 ms
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> [I am no longer at Linaro so please don't use my @linaro.org address]

Hmm... I'm pretty sure I got this using the get_maintainers script.
Maybe update the MAINTAINERS file if you haven't already (I didn't
check)?

But if I ever manually add in your email, I'll keep this in mind.

> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1 -> v2:
> > - Provided more details in the commit text
> > - Pulled in Will's comments on the coding style
> > - Pulled in Ard's suggestion about skipping jumps with the same section
> >   index (parts of Will's suggested code)
> >
> >  arch/arm64/kernel/module-plts.c | 46 ++++++++++++++++++++++++++++++---
> >  1 file changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 65b08a74aec6..0ce3a28e3347 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -253,6 +253,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> >         return ret;
> >  }
> >
> > +static bool branch_rela_needs_plt(Elf64_Sym *syms, Elf64_Rela *rela,
> > +                                 Elf64_Word dstidx)
> > +{
> > +
> > +       Elf64_Sym *s = syms + ELF64_R_SYM(rela->r_info);
> > +
> > +       if (s->st_shndx == dstidx)
> > +               return false;
> > +
> > +       return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26 ||
> > +              ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > +}
> > +
> > +/* Group branch PLT relas at the front end of the array. */
> > +static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
> > +                                     int numrels, Elf64_Word dstidx)
> > +{
> > +       int i = 0, j = numrels - 1;
> > +
> > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > +               return 0;
> > +
> > +       while (i < j) {
> > +               if (branch_rela_needs_plt(syms, &rela[i], dstidx))
> > +                       i++;
> > +               else if (branch_rela_needs_plt(syms, &rela[j], dstidx))
> > +                       swap(rela[i], rela[j]);
>
> Nit: would be slightly better to put
>
>   swap(rela[i++], rela[j]);
>
> here so the next iteration of the loop will not call
> branch_rela_needs_plt() on rela[i] redundantly. But the current code
> is also correct.

Oh yeah, I noticed that unnecessary repeat of branch_rela_needs_plt()
on rela[i] when j had to be decremented, but forgot to handle it after
I was done with all the testing.

But I did compare it to the code I had written in v1 that didn't have
this extra check for rela[i]. I couldn't find any measurable
difference in the module load time. Maybe 1ms for the worst case
module, but that could have been just run to run variation.

Anyway, maybe send this as another patch since Catalin has already
picked this mine?

Thanks,
Saravana
