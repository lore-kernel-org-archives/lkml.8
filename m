Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC64320704
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rRjNif88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGAEN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGAEN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:13:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:13:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so21715772wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhCFefXnj42102IUFh5vdFULLeKzARe5QK+Z4GHoVso=;
        b=rRjNif88bvgzqVKiigdFBaPnttMzPCxsE1uQAb93irufRThKsInIurg98D93Yu4S2Y
         vj11rhLAXDzMMfZyU/oIVwiy9VZTlzkOd3684cMPD+kKY97G+3lSoVYntWgpYoMeQMHE
         XRhSNWAoJbQdzdzJG4isNtnUolKeQHcvgrhCE7YMsAewYioaeNdMvQQwJ3syR7Fc8whv
         fGJ26hGHcT7F4Xf77ose0lWMxXmw7wZN90hvNigV0cDkZOJl4Dhzz5mFq3tKwH+qbE8l
         rGVWCp6llLUQbl86V0QZRFsFIQHaqZQ+G9yoGdNXS3MDUMVGzB+OdyayCCRex5XFNVdp
         ugoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhCFefXnj42102IUFh5vdFULLeKzARe5QK+Z4GHoVso=;
        b=A/DoeeWO56t0NX52K2LegiiPRSlh4jsON3e4ivgq6U+ww3o/ioZNlGaAoWpJKR0v+w
         qxa8bUcdp5kFKVgzR+aKijCjxaG71kFL46DikhLBdvlmBvcCbiajvj8xeWKUr+BaIuwe
         4XZWLJi5dyCOVnsoo9snO6XLV27TqldxYvjBRfOKlsjc+5c6SbOp2oRr7Mj7uUrnTvEy
         XVwCmPrm12s4pdGqETvdK91yi95JTv3Ky9CXHFj7Lz63oXMgbZyTkDcdoqjStPzqOsAh
         mwGeAsNm8ZzymmWE73xxp6dtwUMUlp1BksISDKGFxKxhusDaok/CIrVTPGfMdl8mwiQv
         Bb9w==
X-Gm-Message-State: AOAM533CAjRllw0c9JPxkCfSyd/linDGCPaYfQF9UxfruHsAyGpNb/2X
        +NYmVCYcKKHKrXbdPU9MlsvyJaUHPTZK4OUF6d1aDw==
X-Google-Smtp-Source: ABdhPJwFNGdYaQ9XNNvE1wh2L1ahkF62/f0VrjEK7JJXpfb4Xcfz8jIeYPvYObc+7VFoBSs0XfwH9liF3cDUXWpFZQc=
X-Received: by 2002:a1c:8117:: with SMTP id c23mr23493964wmd.157.1593576804638;
 Tue, 30 Jun 2020 21:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <20200701005129.GA27962@andestech.com>
In-Reply-To: <20200701005129.GA27962@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 Jul 2020 09:43:12 +0530
Message-ID: <CAAhSdy19utzjqK8RX7SM85Rb0h8m63-KS-tuUnprzBGJ4=4bgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Alan Kao <alankao@andestech.com>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:48 AM Alan Kao <alankao@andestech.com> wrote:
>
> On Mon, Jun 29, 2020 at 11:19:09AM +0800, Zong Li wrote:
> > This patch set adds raw event support on RISC-V. In addition, we
> > introduce the DT mechanism to make our perf more generic and common.
> >
> > Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> > would raise an illegal instruction exception and trap into m-mode to
> > emulate event selector CSRs access. It doesn't make sense because we
> > shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> > selector through standard SBI call or the shadow CSRs of s-mode. We have
> > prepared a proposal of a new SBI extension, called "PMU SBI extension",
> > but we also discussing the feasibility of accessing these PMU CSRs on
> > s-mode at the same time, such as delegation mechanism, so I was
> > wondering if we could use SBI calls first and make the PMU SBI extension
> > as legacy when s-mode access mechanism is accepted by Foundation? or
> > keep the current situation to see what would happen in the future.
> >
> > This patch set also introduces the DT mechanism, we don't want to add too
> > much platform-dependency code in perf like other architectures, so we
> > put the mapping of generic hardware events to DT, then we can easy to
> > transfer generic hardware events to vendor's own hardware events without
> > any platfrom-dependency stuff in our perf.
> >
> > Zong Li (6):
> >   dt-bindings: riscv: Add YAML documentation for PMU
> >   riscv: dts: sifive: Add DT support for PMU
> >   riscv: add definition of hpmcounter CSRs
> >   riscv: perf: Add raw event support
> >   riscv: perf: introduce DT mechanism
> >   riscv: remove PMU menu of Kconfig
> >
>
> DT-based PMU registration looks good to me. Together with Anup's feedback,
> we can anticipate that the following items will be:
>
> - rewrite RISC-V PMU to a platform driver
> - propose SBI PMU extention
> - fixes: RV32 counter access, namings, etc.
>
> Yes, all are good directions towards better counting (`perf stat`) function.
> But as the original author of RISC-V perf port, please allow me to address
> the fundamental problems of RISC-V perf, again [0][1][2][3], that the sampling
> (`perf record`) function never earned enough respect.  Counting gives you a
> shallow view regarding an application, while sampling demystifies one for you.
>
> The problems are three-fold
> (1) Interrupt
> Sampling in perf requires that a HPM raises an interrupt when it overflows.
> Making RISC-V perf platform driver or not has nothing to do with this.  This
> requires more discussions in TGs.
> (2) S-mode access to PMU CSRs
> This is also addressed in this patch set but to me, it is kind of like a
> SBI-solves-them-all mindset to me.  Perf event is for performance monitoring
> thus we should eliminate any possible overhead if we can.  Setting event masks
> through SBI calls for counting maybe OK, but if we really take sampling and
> interrupt handling into consideration, it is questionable if it is still a
> viable way.

Yes, we should certainly not have any SBI call for reading the PMU counter.
The S-mode software should always have direct access to the actual counter
value (i.e. CSR for HW counters and memory location for SBI specific counters).

The SBI calls that we have been discussing here only deal with describing
counters and configuring it.

> (3) Registers, registers, registers
> There is just no enough CSR/function for perf sampling. The previous proposal
> explains why [2].
>
> Perf sampling is off-topic but somehow related, so I bring it up here just
> for your information.

I agree with 1) and 2) limitations mentioned above. We certainly need a
RISC-V PMU extension in RISC-V privilege spec. Maybe you can propose
creating a working-group for this ??

My worry is that defining RISC-V PMU extension will take time and meanwhile
more HW will show-up this year and next year which will have the same set of
basic HPMCOUNTER CSRs. We are trying to brainstorm the best thing we can
do when we have just HPMCOUNTER CSRs accessible to S-mode. The SBI
PMU extension discussed here only tries to complement existing HPMCOUNTER
CSRs so that SOC designers can at least provide implementation specific CSRs
for configuring HW counters. The SBI PMU extension won't be able to solve the
counter overflow detection so we will have to depend on software techniques to
detect overflow.

>
> As this patch set goes v2, the PMU porting guide in [0] should be removed since
> it contains no useful information anymore.

I agree. This guide should be either updated or removed.

>
> [0] Documentation/riscv/pmu.rst
> [1] https://www.youtube.com/watch?v=Onvlcl4e2IU
> [2] https://github.com/riscv/riscv-isa-manual/issues/402
>     This proposal has been posted in Privileged Spec Task Group, in
> https://lists.riscv.org/g/tech-privileged-archive/message/488?p=,,,20,0,0,0::Created,,Proposal,20,2,40,32306071
> but never receive any feedback.
> [3] https://lists.riscv.org/g/tech-unixplatformspec/message/84
>     I intended to discuss [2] in the Unixplatform Spec Task Group at the
> online meeting, but obviously people were too busy knowing who the new
> RISC-V CTO is and what he has done to even follow the agenda.
>

Regards,
Anup
