Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8B22073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hgvgUU1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbgF2VDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgF2TMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:45 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F39C08EA4C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:52:27 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j11so10775931oiw.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpBY/PhrvExkev45/pQ1Qu7CoJvNzyMndE/eWx97fMU=;
        b=hgvgUU1Xfua78tVrTtp3zWeTyQpT5JpiZVg/D3zvcQmcA85R562BFrW1EQxwMRFFkm
         U7Ik0SNI2DDR3Wcw+CvpFIKXThF2md39C5sfSztd1q5AR8xHSCDqflRMs8B8PsyahB46
         dhHi4falOMMGreUT3tfUM85joxU+FozootxjvLjWDfiAffUNIBUX9p+xx5W+JqPyPlxo
         SUj5rxtji4C6BI9sN05D020VrJDrZa1KrxH34a5uwXlO6ti95r+vrfGF0KgmYkWIlbnE
         khmg5AbB9z4YCZjw30xLZUENQjja+NXmtDKHqGBT4ciEHbZZrL5TkTTCv1OH2k5E5yPP
         f+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpBY/PhrvExkev45/pQ1Qu7CoJvNzyMndE/eWx97fMU=;
        b=aHhXTB05WgLyh9fBuG1f3qXM+4LpmtiPZyGk/ZWdYy0GwXL77Os6YI10PQu6gQClbj
         eHx/Cy0Iv0rn2QoPo8wuw60jz2Ku7ZBuS0SQETh1mpMV6OTfCuXXZ0hido1ezYzIQ5My
         m7gQQy+HsfjkoLmxoTkxdQ0OqZ20KxPfsX5NB7mdvh4ZZW4BFwn0QiA2h8Rn5xnN1J9g
         XlwOhDbiS7gjsV4ydhKqrRAq+0HOwmPPGR0CMgjLh2kLo/QFnWxH0BvVDrlY1GSSxqqt
         xQtm9XbpQD0Pd8Y+MAktKui11Yp1PE0zn4inB2+YyQphfU2kbhK0DsHMhMkheQBacyOg
         Zcsg==
X-Gm-Message-State: AOAM530xN7ZZoXJffqxpRervwfklId67hS5IqhRfbtJnaoGE5RWI5vBM
        5HadC+fK0hSlKEp37EN6THTlGF4RVRQOBawsp1je8w==
X-Google-Smtp-Source: ABdhPJwTf94VErmAjkPpNTDsEVcqGB2LVv1W5/dNVrcWEhT6lWcsdaSCiTlXRXIqMBcHLL8+1//OEb+4eT3sY5Uz5SQ=
X-Received: by 2002:aca:1c05:: with SMTP id c5mr10429190oic.32.1593409946707;
 Sun, 28 Jun 2020 22:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 29 Jun 2020 13:52:15 +0800
Message-ID: <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Anup Patel <anup@brainfault.org>, alankao@andestech.com
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:53 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> >
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
>
> Please re-write this series to have RISC-V PMU driver as a regular
> platform driver as drivers/perf/riscv_pmu.c.
>
> The PMU related sources will have to be removed from arch/riscv.
>
> Based on implementation of final drivers/perf/riscv_pmu.c we will
> come-up with drivers/perf/riscv_sbi_pmu.c driver for SBI perf counters.
>

There are some different ways to implement perf, and current
implementation seems to be consensus when perf was introduced at the
beginning [0][1]. I don't persist to which one, I could change the
implementation as you mentioned if it is a new consensus one.

[0] https://github.com/riscv/riscv-linux/pull/124#issuecomment-367563910
[1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/f19TmCNP6yA

> Regards,
> Anup
>
> >
> > Zong Li (6):
> >   dt-bindings: riscv: Add YAML documentation for PMU
> >   riscv: dts: sifive: Add DT support for PMU
> >   riscv: add definition of hpmcounter CSRs
> >   riscv: perf: Add raw event support
> >   riscv: perf: introduce DT mechanism
> >   riscv: remove PMU menu of Kconfig
> >
> >  .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
> >  arch/riscv/Kconfig                            |  13 -
> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
> >  arch/riscv/include/asm/csr.h                  |  58 +++
> >  arch/riscv/include/asm/perf_event.h           | 100 ++--
> >  arch/riscv/kernel/Makefile                    |   2 +-
> >  arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
> >  7 files changed, 471 insertions(+), 245 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> >
> > --
> > 2.27.0
> >
