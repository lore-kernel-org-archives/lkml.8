Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F912067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E/BIkeJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgF2Tc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733237AbgF2Tcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3ADC02A54B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:53:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t18so2554034otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpGY14F7o8tvnSzx9JOHKFiHnDFjBtM9leHhvp2Jk2Q=;
        b=E/BIkeJ3asC+kXjjStwJJA5dG4G+MZ4kz2qFEdYHNZxCWxWvSe4xDKIrHmimQqSfMo
         Cfeh5RGaPg+ctZ5yoMPEnn3B4dc7SG7+7bveYyqnKQVbmmUYpcl2PeDyT5DrEVRMWJI7
         73DMiaCu8DulBQWIv8b/PcnOmUzR5HqcSlRTUGD41ylmF2N7sh6sonFf8HS5eCAwJdI4
         8RkTlGnGuXGsR8OSqINbsbtbbqPjsEEEhYVZZ2ALVqrO7Tl4RBHXWL6XjWlcBT+yTv89
         yBU/zVKIkkoQYSoZrS9MzUD3C6847fY+dlJ7XnmEiE7E3uQfB6zPKMYHArgVrZr+yAhb
         NAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpGY14F7o8tvnSzx9JOHKFiHnDFjBtM9leHhvp2Jk2Q=;
        b=cLy/KqdQ8OM6tXG7r6HCQ9A+n6gp8SO9/kENvAkl/tvgvQWvmVasORz0pnrtquUV2n
         xm+9AaWpqH/OeQcGTogbqPACj6iKArDht4ze90/yy3KGZ1rNFW/mJofRlHWknmsJgQvJ
         UKmONSLe+wre4TgK0qWG/wexG2i6Wcl8sTfBP7QLQQT1khNr5DqkQU2ckbZYjcfCAs8M
         h6m4YpkJQAEB8Q3hBd0rl38842Y1l3swGundTHpce6PJj/ck3q22Fqmdod2ipeUM8EID
         Ch2IaUQaKtoI7vRBJ2zh1I4v3TACj/6xCQt/seHNLYd6klVxbB48Eba412UhiBWncg4u
         5X5A==
X-Gm-Message-State: AOAM533rfULEdGFjdPlpv/FMDA++tNI5o/DZkxfEe2aUPwXQL7Tni4kB
        jrPuPdyDthb+kEm5eaA1cwT6zrvCR2oJxR0h1dke4Q==
X-Google-Smtp-Source: ABdhPJzxh47hW31R4Qv+c9igVj09O3X547WPk3QRsuXCRHKkPqLxJ9Uxdd9MKLO4gkj3o9fTu9v2lHW9M7a92A3h5To=
X-Received: by 2002:a9d:186:: with SMTP id e6mr13462718ote.33.1593435195031;
 Mon, 29 Jun 2020 05:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
 <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com> <CAAhSdy0Ed8zQ5LVZva6p2TWqTOzrDRtL0JJkAdmpzWFhzJLUfg@mail.gmail.com>
In-Reply-To: <CAAhSdy0Ed8zQ5LVZva6p2TWqTOzrDRtL0JJkAdmpzWFhzJLUfg@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 29 Jun 2020 20:53:04 +0800
Message-ID: <CANXhq0o9BMe6G6kv-zO7OvLTfKsz-4XKsoZJe3nxvX9_6uunvw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Anup Patel <anup@brainfault.org>
Cc:     Alan Kao <alankao@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:28 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 29, 2020 at 11:22 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Mon, Jun 29, 2020 at 12:53 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > This patch set adds raw event support on RISC-V. In addition, we
> > > > introduce the DT mechanism to make our perf more generic and common.
> > > >
> > > > Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> > > > would raise an illegal instruction exception and trap into m-mode to
> > > > emulate event selector CSRs access. It doesn't make sense because we
> > > > shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> > > > selector through standard SBI call or the shadow CSRs of s-mode. We have
> > > > prepared a proposal of a new SBI extension, called "PMU SBI extension",
> > > > but we also discussing the feasibility of accessing these PMU CSRs on
> > > > s-mode at the same time, such as delegation mechanism, so I was
> > > > wondering if we could use SBI calls first and make the PMU SBI extension
> > > > as legacy when s-mode access mechanism is accepted by Foundation? or
> > > > keep the current situation to see what would happen in the future.
> > > >
> > > > This patch set also introduces the DT mechanism, we don't want to add too
> > > > much platform-dependency code in perf like other architectures, so we
> > > > put the mapping of generic hardware events to DT, then we can easy to
> > > > transfer generic hardware events to vendor's own hardware events without
> > > > any platfrom-dependency stuff in our perf.
> > >
> > > Please re-write this series to have RISC-V PMU driver as a regular
> > > platform driver as drivers/perf/riscv_pmu.c.
> > >
> > > The PMU related sources will have to be removed from arch/riscv.
> > >
> > > Based on implementation of final drivers/perf/riscv_pmu.c we will
> > > come-up with drivers/perf/riscv_sbi_pmu.c driver for SBI perf counters.
> > >
> >
> > There are some different ways to implement perf, and current
> > implementation seems to be consensus when perf was introduced at the
> > beginning [0][1]. I don't persist to which one, I could change the
> > implementation as you mentioned if it is a new consensus one.
> >
> > [0] https://github.com/riscv/riscv-linux/pull/124#issuecomment-367563910
>
> I would not recommend taking the original RISC-V linux fork as reference.
>
> Rather we should study how things are done on other architectures.
>
> I really appreciate the attempt to make RISC-V PMU driver depend on DT
> but if we are going this route then we should maximize the use of Linux
> platform driver framework. In fact, whenever possible we should integrate
> RISC-V features as platform drivers under the drivers/ directory.
>

OK, I would change the implementation to platform driver if there is no
other voice.

> I thought about SBI PMU counters as well. In future, we can easily
> expose SBI PMU counters as RAW events in the same RISC-V PMU
> driver. The sbi_probe_extension() can be used in RISC-V PMU driver
> to check for SBI PMU counters so no special provisions needed in DT
> for SBI PMU counters.
>

I thought about probing raw events by SBI extension too, I'm interested if you
have more detail about this.

It seems to me that it is a little bit hard to return all events
through one SBI call,
so I thought we could map the generic hardware events and maintain their own
raw events by each platform in OpenSBI. But eventually, I thought the
DT mechanism
is more clear and easy than that. Let me know if you have any ideas about
probe function. Thanks.

> Also, the RISC-V PMU driver can be implemented such that it will
> work for RV32, RV64, NoMMU RV32, and NoMMU RV64.
>
> Regards,
> Anup
>
> > [1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/f19TmCNP6yA
> >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > Zong Li (6):
> > > >   dt-bindings: riscv: Add YAML documentation for PMU
> > > >   riscv: dts: sifive: Add DT support for PMU
> > > >   riscv: add definition of hpmcounter CSRs
> > > >   riscv: perf: Add raw event support
> > > >   riscv: perf: introduce DT mechanism
> > > >   riscv: remove PMU menu of Kconfig
> > > >
> > > >  .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
> > > >  arch/riscv/Kconfig                            |  13 -
> > > >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
> > > >  arch/riscv/include/asm/csr.h                  |  58 +++
> > > >  arch/riscv/include/asm/perf_event.h           | 100 ++--
> > > >  arch/riscv/kernel/Makefile                    |   2 +-
> > > >  arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
> > > >  7 files changed, 471 insertions(+), 245 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > > >
> > > > --
> > > > 2.27.0
> > > >
