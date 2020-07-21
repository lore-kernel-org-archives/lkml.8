Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E58320717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGUGwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:52:46 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35387 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUGwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:52:46 -0400
Received: by mail-yb1-f196.google.com with SMTP id f5so9556726ybq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oX2c45gXD89+TOpPTsbkrsdgAsnkvRsdX4GY6xWWaE=;
        b=eMlq2ukRpex8eJ1pDOwPlPxYBwBPVl5iA+gsq32NLbYIjOwbu4Pnm08fqIMNUrK7qz
         e4wkSKuEZUHLAiL6RCF6FVu7VbBUtigNpDdeDuaD+KaHV5KkGslIxknwrTmfxayfZoOT
         DgQiKm+9/YbndyZQDyQ1tKHnhXxI9NqWkdmHICJjYlRdj4YHK7DNyL8gbXljNc6hjtp/
         kc88s5eRniqQy5ZDhLZo7ZFqtgHkKun0iWRPmMePZd0UegbXzrQ9Di6phFIUc21Mtatn
         cJ9wDYg5tX0DK6OtnBi+/QOgos8EOxy7xRQh9OVB6vqTOvqqlLEnH70XXv2CBBrQKNMS
         M2IQ==
X-Gm-Message-State: AOAM5310KYr1d//9suDuzhjX7Brhw3x6ClsoG4T+YOtN7wYXVDA/a6jF
        AXytpGUB0mLYQuVJ+z/e9ODnLczZC/XWD1hSVKdNuQ==
X-Google-Smtp-Source: ABdhPJz5Or1fZOKRFi+qwSdKPGxc8tke4gXRClp9E9Bc/nNz52u2RoDmwD/CeIAFAY2fx8+A0cc6ZyGNP9e1yWa040w=
X-Received: by 2002:a25:2d6f:: with SMTP id s47mr37532124ybe.1.1595314364717;
 Mon, 20 Jul 2020 23:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <0d7d0c38-5b67-1793-47d7-b8a7714838ee@arm.com> <mhng-2f6b1241-9ab3-47a2-bc23-789d59a3fd8f@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-2f6b1241-9ab3-47a2-bc23-789d59a3fd8f@palmerdabbelt-glaptop1>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 21 Jul 2020 08:52:33 +0200
Message-ID: <CANBLGczm4+5=gMVYTNH_f4gcEggn4uPOOn13=-n82R6rFoJzhw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maochenxi@eswin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 06:04, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 14 Jul 2020 20:20:54 PDT (-0700), anshuman.khandual@arm.com wrote:
> >
> >
> > On 07/15/2020 02:56 AM, Emil Renner Berthing wrote:
> >> This allows the pgtable tests to be built.
> >>
> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> ---
> >>
> >> The tests seem to succeed both in Qemu and on the HiFive Unleashed
> >>
> >> Both with and without the recent additions in
> >> https://lore.kernel.org/linux-riscv/1594610587-4172-1-git-send-email-anshuman.khandual@arm.com/
> >
> > That's great, thanks for testing.
>
> Actually, looking at this I'm not sure it actually helps us any.  This changes
> the behavior of two functions.  Pulling out the relevant sections, I see:
>
> unsigned int __sw_hweight32(unsigned int w)
> {
> #ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
>         w -= (w >> 1) & 0x55555555;
>         w =  (w & 0x33333333) + ((w >> 2) & 0x33333333);
>         w =  (w + (w >> 4)) & 0x0f0f0f0f;
>         return (w * 0x01010101) >> 24;
> #else
>         unsigned int res = w - ((w >> 1) & 0x55555555);
>         res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
>         res = (res + (res >> 4)) & 0x0F0F0F0F;
>         res = res + (res >> 8);
>         return (res + (res >> 16)) & 0x000000FF;
> #endif
> }
>
> and
>
> unsigned long memchr_inv(unsigned long value64)
> {
> #if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && BITS_PER_LONG == 64
>         value64 *= 0x0101010101010101ULL;
> #elif defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER)
>         value64 *= 0x01010101;
>         value64 |= value64 << 32;
> #else
>         value64 |= value64 << 8;
>         value64 |= value64 << 16;
>         value64 |= value64 << 32;
> #endif
>         return value64;
> }
>
> GCC optimizer the multiplication out of the first one:
>
> __sw_hweight32:
>         li      a4,1431654400
>         srliw   a5,a0,1
>         addi    a4,a4,1365
>         and     a5,a5,a4
>         subw    a0,a0,a5
>         li      a5,858992640
>         srliw   a4,a0,2
>         addi    a5,a5,819
>         and     a0,a5,a0
>         and     a5,a5,a4
>         addw    a5,a0,a5
>         srliw   a0,a5,4
>         addw    a0,a0,a5
>         li      a5,252645376
>         addi    a5,a5,-241
>         and     a5,a5,a0
>         srliw   a0,a5,8
>         addw    a5,a0,a5
>         srliw   a0,a5,16
>         addw    a0,a0,a5
>         andi    a0,a0,0xff
>         ret
>
> __sw_hweight32:
>         li      a5,1431654400
>         srliw   a4,a0,1
>         addi    a5,a5,1365
>         and     a5,a5,a4
>         subw    a0,a0,a5
>         li      a5,858992640
>         srliw   a4,a0,2
>         addi    a5,a5,819
>         and     a0,a5,a0
>         and     a5,a5,a4
>         addw    a5,a0,a5
>         srliw   a0,a5,4
>         addw    a5,a0,a5
>         li      a0,252645376
>         addi    a0,a0,-241
>         and     a5,a0,a5
>         slliw   a0,a5,8
>         addw    a0,a0,a5
>         slliw   a5,a0,16
>         addw    a0,a0,a5
>         srliw   a0,a0,24
>         ret
>
> so that doesn't matter.  The second one is really a wash:
>
> memchr_inv:
>         ld      a5,.LC0
>         mul     a0,a0,a5
>         ret
> .rodata
> .LC0:
>         .dword  72340172838076673
>
> vs
>
> memchr_inv:
>         slli    a5,a0,8
>         or      a5,a5,a0
>         slli    a0,a5,16
>         or      a0,a0,a5
>         slli    a5,a0,32
>         or      a0,a5,a0
>         ret
>
> It's unlikely that load ends up relaxed, so it's going to be two instructions.
> That means we have 4 cycles to forward the load and multiply, for a cache hit.
> IIRC the multiplier on the existing hardware isn't that fast -- GCC lists it as
> imul as 10 cycles, but I remember it being more like 5 so that might just be an
> architecture-inaccurate tuning in the generic pipeline model.  This is out of
> the inner loop, so it's probably not all that important anyway.  The result
> isn't used for a while so on a bigger machine it's probably worth picking the
> smaller code path, but it seems like a very small thing to optimize for either
> way.
>
> I'm actually a bit surprised about this.  Do you have benchmarks that indicate
> ARCH_HAS_FAST_MULTIPLIER is actually faster?  Otherwise I guess I'm going to
> reject this, as it's really more
> ARCH_HAS_FAST_MULTIPLIER_AND_FAST_LARGE_CONSTANTS than just
> ARCH_HAS_FAST_MULTIPLIER.

Hi Palmer,

I think you meant this reply for
https://lore.kernel.org/linux-riscv/c5d82526-233a-15d5-90df-ca0c25a53639@eswin.com/T/#t

/Emil
