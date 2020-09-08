Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46183C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165C1207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwAuRwk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgIHTl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731871AbgIHTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:41:49 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F687C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:41:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q10so336519qvs.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/dG9jEncAs6+nkD7fnq9LTKRpUa08FrYgm5ZlkQNI8=;
        b=RwAuRwk7pxhQ71WROwODFBIcDmVLrtFl0k4TKuddGbNYLKtXCyJVW7iGhTVKCbMm8J
         ZHUR5yyIANSRQavZ51djg7RpwpL4jgTpTwtH9K7i6UkX+2sfPPQxRyMBGGMgHXiXhWOs
         Tsn+ij3jkLQjcJf5TUiY783q3O+DRSSdVVa8EjX4YywvBDDyRFi5F/VS7dXkmdlgkxv9
         ZgPujixkqYDZGYJYzDBnnbRC5WdqeK/GekVsDgV4ldCkmUwDsT2R+1uEwn35kUngW19G
         u4e6CmgzBddqfjG1MjBIrE1o0+Ww8ynFxNXEqXXijgXYWmbGOXi60+taUXszSgSqdrMq
         7+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/dG9jEncAs6+nkD7fnq9LTKRpUa08FrYgm5ZlkQNI8=;
        b=Z8jVYuD23p3bmIqn8Pxxh6Gi3a3vdSN/isow5I58k1hPdh7KuaxRJEDI6ydpQeOnrR
         Sh+dCGrBofuJCOQ2j7+3GvXLS5ZoopSLtgwCmHEH0owcSZ525KhPxoOn1D7s2Ns+8Nkh
         3riAL/L9HUEN3xkylAr8EVPutMTF6YOzauG+aKuAXaZYgBrT7X6RFf/VADRw8pcEWGak
         sIsZezVMG4nRrEEzALyEjpcHckl675RvoceQBXEPmA61ot5jzmq2pAcUG+CPJXOcKDpy
         eBx5V/VdWv6juNRI6oesRlII/lvnxegInL7pmO/yHoyWbQNkzzBooetlZLtV8Zax4xBi
         viHQ==
X-Gm-Message-State: AOAM530FiWpvan8l108pSQ3wsFjyc4kWh4QbzrBfqGH1Nv8wKvkdCZ9r
        5TLEE92a3hQzQt3AEF2WaO/luuCprmp2LhJJxM6txhbCtLfSUw==
X-Google-Smtp-Source: ABdhPJweWeyf717PpgPykMuyVWPBC3W6Y4joNnhd1reD3noCOLUGyDP8M6HMPX8xiAGrXbscRQKLaw5m96q5Wmvg+HI=
X-Received: by 2002:a05:6214:bcf:: with SMTP id ff15mr784046qvb.39.1599594108271;
 Tue, 08 Sep 2020 12:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia> <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
 <20200827121604.GL29264@gaia> <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
 <20200908153910.GK25591@gaia>
In-Reply-To: <20200908153910.GK25591@gaia>
From:   Derrick McKee <derrick.mckee@gmail.com>
Date:   Tue, 8 Sep 2020 15:41:37 -0400
Message-ID: <CAJoBWHy9=hJ-GCCYjUm2=HKOiHbue2cXO1TBNx0LsCQKAqO02A@mail.gmail.com>
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marco Elver <elver@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is the branch where the MTE patches currently are being applied
for-net/mte?  It looks like that's the place, but I want to confirm.

On Tue, Sep 8, 2020 at 11:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Sep 08, 2020 at 04:02:06PM +0200, Andrey Konovalov wrote:
> > On Thu, Aug 27, 2020 at 2:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Thu, Aug 27, 2020 at 11:56:49AM +0100, Vincenzo Frascino wrote:
> > > > On 8/27/20 11:38 AM, Catalin Marinas wrote:
> > > > > On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> > > > >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > > >> index 7717ea9bc2a7..cfac7d02f032 100644
> > > > >> --- a/arch/arm64/kernel/mte.c
> > > > >> +++ b/arch/arm64/kernel/mte.c
> > > > >> @@ -18,10 +18,14 @@
> > > > >>
> > > > >>  #include <asm/barrier.h>
> > > > >>  #include <asm/cpufeature.h>
> > > > >> +#include <asm/kasan.h>
> > > > >> +#include <asm/kprobes.h>
> > > > >>  #include <asm/mte.h>
> > > > >>  #include <asm/ptrace.h>
> > > > >>  #include <asm/sysreg.h>
> > > > >>
> > > > >> +u64 gcr_kernel_excl __read_mostly;
> > > > >
> > > > > Could we make this __ro_after_init?
> > > >
> > > > Yes, it makes sense, it should be updated only once through mte_init_tags().
> > > >
> > > > Something to consider though here is that this might not be the right approach
> > > > if in future we want to add stack tagging. In such a case we need to know the
> > > > kernel exclude mask before any C code is executed. Initializing the mask via
> > > > mte_init_tags() it is too late.
> > >
> > > It depends on how stack tagging ends up in the kernel, whether it uses
> > > ADDG/SUBG or not. If it's only IRG, I think it can cope with changing
> > > the GCR_EL1.Excl in the middle of a function.
> > >
> > > > I was thinking to add a compilation define instead of having gcr_kernel_excl in
> > > > place. This might not work if the kernel excl mask is meant to change during the
> > > > execution.
> > >
> > > A macro with the default value works for me. That's what it basically is
> > > currently, only that it ends up in a variable.
> >
> > Some thoughts on the topic: gcr_kernel_excl is currently initialized
> > in mte_init_tags() and depends on the max_tag value dynamically
> > provided to it, so it's not something that can be expressed with a
> > define. In the case of KASAN the max_tag value is static, but if we
> > rely on that we make core MTE code depend on KASAN, which doesn't seem
> > right from the design perspective.
>
> The design is debatable. If we want MTE to run on production devices, we
> either (1) optimise out some bits of KASAN (configurable) or (2) we
> decouple MTE and KASAN completely and add new callbacks in the core code
> (slab allocator etc.) specific to MTE.
>
> My first choice is (1), unless there is a strong technical argument why
> it is not possible.
>
> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Derrick McKee
Phone: (703) 957-9362
Email: derrick.mckee@gmail.com
