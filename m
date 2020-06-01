Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A098C20659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jknxIcNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgFAEJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAEJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:09:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8E5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:09:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so9922933wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDxsJqQtiN6qT4srwSvggU8FGCrRE9qkazQvrNm8wfM=;
        b=jknxIcNH2XQSSNADSiNUBSHeS3PF+O5g3LD87ZKg1H6TlAD0JXRYtW2TIbDZqzNFpl
         z6R9GNVtRO8obFFLI8YZNz9iQBPShTZdmMTBkeKi8wErxfL1rFeTK6rCGt7DhNGqYHWZ
         K8D4mxYOArJ+C6694FYqzOJ23r+YtXWb/ITfatn3AE/oPSaGqtPlAHUGdGfc8WB7jp9B
         Ba/+tIsl3cO4H33h1KG1vttcpU8w6Xu0oceZgFC9NIq7epa5eGptSZopF0bCf/ID31d+
         +EzNXTS8MKYwnqPTZyG4Vnv+mr/91XjcdDg05caxGY2oF4NkShgxazFeL12UCwMUtP45
         pzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDxsJqQtiN6qT4srwSvggU8FGCrRE9qkazQvrNm8wfM=;
        b=ZKnP36EBdlk2yAANwg01HuwxD8RlISqoyNc89+FGXL/ogxcmz0JSZi3ItPeJHt8sRB
         16f7gZiaTJ7mU6CWllkhpKd4JwnOoVyQ0ZfVaAABtBa/RifV5wYGUZ/rBZ2mmfSLIsUu
         HL2qSRLRtP71IR0ZjRpDK54QXTzp7PCejCoTAUrDwefvOStpLnuhPnFZpjpj7YY34wwz
         90pVcRZkmBaTnIrX2N0qQb14BYuijjokLMf8Y+mfifTxZPOKhbiP2cSS4nCu+Z6YPgPw
         A/flTb7l7GAWnvUj9C1jsg5WKMotYgBPSSsQCw98rqBt1uEcJTRdoI48ZbzXzL/f5Xiw
         +X8A==
X-Gm-Message-State: AOAM5307i36jDmXU9uxVj3O1YfV8SiCPqVhm+gJ/DOlIj8EV7CtGQH47
        k5HXz+5aNb+aPjiVAbA8KP0cHSjORL38O0aRO3nXTQAv5BU=
X-Google-Smtp-Source: ABdhPJwFi1WjShumSoZd1c/C4iYCIO++7+TAGxRepfLWm6PBEo326+hgrkZrJTnSo2VN3fBbDvZ+FLBOqWEusZ/sClo=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr8931300wme.152.1590984568220;
 Sun, 31 May 2020 21:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200530100725.265481-1-anup.patel@wdc.com> <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org> <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org> <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
 <e315f76b06b7b0935ebee867c04f364e@kernel.org>
In-Reply-To: <e315f76b06b7b0935ebee867c04f364e@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 Jun 2020 09:39:16 +0530
Message-ID: <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 4:23 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-05-31 11:06, Anup Patel wrote:
> > On Sun, May 31, 2020 at 3:03 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-05-31 06:36, Anup Patel wrote:
> >> > On Sat, May 30, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> [...]
> >>
> >> >> >       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> >> >>
> >> >> Why do you need to both disable the interrupt *and* change the
> >> >> priority
> >> >> threshold? It seems to be that one of them should be enough, but my
> >> >> kno9wledge of the PLIC is limited. In any case, this would deserve a
> >> >> comment.
> >> >
> >> > Okay, I will test and remove "disable the interrupt" part from
> >> > plic_dying_cpu().
> >>
> >> Be careful, as interrupt enabling/disabling is refcounted in order
> >> to allow nesting. If you only enable on CPU_ON and not disable
> >> on CPU_OFF, you will end-up with a depth that only increases,
> >> up to the point where you hit the roof (it will take a while though).
> >>
> >> I would keep the enable/disable as is, and drop the priority
> >> setting from the CPU_OFF path.
> >
> > The PLIC threshold is like GICv2 CPU interface enable/disable.
>
> Looking at the documentation[1], that's not really a correct analogy:
>
> - The PLIC is far removed from the CPU, and is more akin a GICv3
>    distributor. The INTC itself is more like a GICv3 redistributor,
>    as it deals with local interrupts only. I don't see anything
>    in the RISC-V architecture that actually behaves like a GIC
>    CPU interface (not necessarily a bad thing...).
>
> - The threshold register is not an ON/OFF, but a priority mask,
>    similar to the GIC PMR (except that the PMR lives in the CPU
>    interface and affects all interrupts targetting this CPU while
>    this only seem to affect PLIC interrupts and not the INTC interrupts).
>    You may be using it as an ON/OFF for now as you don't support
>    multiple priorities yet, but that's just a SW thing.

Yes, your analogy is correct.

BTW, PLIC does not handle MSI and does not have virtualization support
pass-through interrupts. We will most likely see a new RISC-V interrupt
controller spec for these capabilities.

Also, the PLIC spec is now owned by RISC-V foundation (not SiFive) so
we will have to rename the driver to "irq-riscv-plic" and will have a new
generic compatible string "riscv,plic-1.0.0". One of us (me or Palmer) will
send separate patches for this renaming. I hope you will be fine with this??
(Refer, https://github.com/riscv/riscv-plic-spec)

>
> > Based on your comment, we should only program the PLIC threshold
> > in CPU_ON and don't touch the PLIC threshold in CPU_OFF. Right??
>
> This seems like the correct thing to do.

Sure, I will update.

>
>          M.
>
> [1]
> https://sifive.cdn.prismic.io/sifive%2Fdc4980ff-17db-448b-b521-4c7ab26b7488_sifive+u54-mc+manual+v19.08.pdf
> --
> Jazz is not dead. It just smells funny...

Regards,
Anup
