Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE752074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591004043;
	bh=tEbGVazKhugocMY85YDdZyN7TPvYVvUeG93DMAI4G2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GHNsGl4kE6Wkl5NB2qPGUwuVBIAVBBtKtfut+rwUGfJYS1wOsg/Iu5aSuHrAORvok
	 MKYxzJ3gdD3iixrdz4GAw/hAupejvXdE9I3qHNiYXmCd1robb8vfuOliwh8B8X/vuT
	 F6KIp7jOnGP2VruI79Vh2jXJDd0A2UETX6qje5Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgFAJeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAJeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:34:01 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4331E2074B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591004040;
        bh=tEbGVazKhugocMY85YDdZyN7TPvYVvUeG93DMAI4G2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BAcp30K4oeTWD1PwvW9bJqRgTOiE1IAIUUYxog5BDxKFNySwCkcHavthS9/QN61oR
         812kGeybxu2624vYqhZsv36hssDTJxCe6xJP+NpfLNfZWfP3V/60GRyLUAEOMMONPu
         Clvm/yzR640V/ipSmVRItkq5P79V3ic9HtkaRv5o=
Received: by mail-lj1-f171.google.com with SMTP id m18so7279112ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:34:00 -0700 (PDT)
X-Gm-Message-State: AOAM532EHLXkuLRDXnBWPQRkrXmf/S9TdCDwjemcTXaNhFQ7KT7mFSZ6
        vPtaCK+rvno+hf3Fp7NDapO9xyE2TX32FjCp9pw=
X-Google-Smtp-Source: ABdhPJy/RpQxQ4SUjNcKSGoepTVkyVoG7hxOl1MPIaJ2Hi/xkPjglZZn9MuH5WDyh0dxK32pWYs4hRIYnguWm1R+4ME=
X-Received: by 2002:a2e:611a:: with SMTP id v26mr8847684ljb.265.1591004038570;
 Mon, 01 Jun 2020 02:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200530100725.265481-1-anup.patel@wdc.com> <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org> <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org> <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
 <e315f76b06b7b0935ebee867c04f364e@kernel.org> <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
In-Reply-To: <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:33:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSzQzEHofrhusXM6Yx69GzmptCGGe4xdDci4-Xj12MGBw@mail.gmail.com>
Message-ID: <CAJF2gTSzQzEHofrhusXM6Yx69GzmptCGGe4xdDci4-Xj12MGBw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
To:     Anup Patel <anup@brainfault.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Mon, Jun 1, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sun, May 31, 2020 at 4:23 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2020-05-31 11:06, Anup Patel wrote:
> > > On Sun, May 31, 2020 at 3:03 PM Marc Zyngier <maz@kernel.org> wrote:
> > >>
> > >> On 2020-05-31 06:36, Anup Patel wrote:
> > >> > On Sat, May 30, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
> > >>
> > >> [...]
> > >>
> > >> >> >       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> > >> >>
> > >> >> Why do you need to both disable the interrupt *and* change the
> > >> >> priority
> > >> >> threshold? It seems to be that one of them should be enough, but my
> > >> >> kno9wledge of the PLIC is limited. In any case, this would deserve a
> > >> >> comment.
> > >> >
> > >> > Okay, I will test and remove "disable the interrupt" part from
> > >> > plic_dying_cpu().
> > >>
> > >> Be careful, as interrupt enabling/disabling is refcounted in order
> > >> to allow nesting. If you only enable on CPU_ON and not disable
> > >> on CPU_OFF, you will end-up with a depth that only increases,
> > >> up to the point where you hit the roof (it will take a while though).
> > >>
> > >> I would keep the enable/disable as is, and drop the priority
> > >> setting from the CPU_OFF path.
> > >
> > > The PLIC threshold is like GICv2 CPU interface enable/disable.
> >
> > Looking at the documentation[1], that's not really a correct analogy:
> >
> > - The PLIC is far removed from the CPU, and is more akin a GICv3
> >    distributor. The INTC itself is more like a GICv3 redistributor,
> >    as it deals with local interrupts only. I don't see anything
> >    in the RISC-V architecture that actually behaves like a GIC
> >    CPU interface (not necessarily a bad thing...).
> >
> > - The threshold register is not an ON/OFF, but a priority mask,
> >    similar to the GIC PMR (except that the PMR lives in the CPU
> >    interface and affects all interrupts targetting this CPU while
> >    this only seem to affect PLIC interrupts and not the INTC interrupts).
> >    You may be using it as an ON/OFF for now as you don't support
> >    multiple priorities yet, but that's just a SW thing.
>
> Yes, your analogy is correct.
>
> BTW, PLIC does not handle MSI and does not have virtualization support
> pass-through interrupts. We will most likely see a new RISC-V interrupt
> controller spec for these capabilities.
>
> Also, the PLIC spec is now owned by RISC-V foundation (not SiFive) so
> we will have to rename the driver to "irq-riscv-plic" and will have a new
> generic compatible string "riscv,plic-1.0.0". One of us (me or Palmer) will
> send separate patches for this renaming. I hope you will be fine with this??
> (Refer, https://github.com/riscv/riscv-plic-spec)

That's great, we follow riscv-plic in hardware, but don't want to use
sifive string in dts.

Acked & Thx for the job.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
