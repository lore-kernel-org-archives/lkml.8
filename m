Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC31B206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="tF+QglDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390151AbgF2VBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgF2TM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949DBC008740
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:28:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so14508622wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhEnhfJli6ncCAHeEoV+qwFqYEF14Keo1BCmMzJ2sq4=;
        b=tF+QglDtRAjOHWBI/3gKzqBKloDVbRGAKLYcxV1LbyTdKUE+5nig4RbBh0fONEI8x4
         Y7r9tJXD7LxxnB22VEYyPJVLXiwq9xcsDbkKC+VcdfaTrInqIgrvbKlMBqjzShgvhR7l
         LSZDy4CppWY/0hqO+Si0dlwNOiRL2voiE/CuXyvxbpCnwnXwOQXy01j2jT8sxSud3jGG
         8jz/NcnJpe04JGW7XHfyleMRRjW7Fs0hgUsIDbqxJCq1+CdGHUREetAnZfWR3W9tur5C
         nOSn9jX7Z2mDI4dT8QZJpkvkTIo6Fx19ai+TVh6jmZ1LE5wgxJVTwdUGESI5khXeCw1G
         jW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhEnhfJli6ncCAHeEoV+qwFqYEF14Keo1BCmMzJ2sq4=;
        b=Kpb0+6QnwbTD+rkZdwnW0BKZpqtlT5KwgKP+KwFORuXL3uQVhMsoJW+DLj6KqNuaxB
         e3RQfa7wc94NePd0vBhDTWpPnEG6pFUDAkYOtmlyDapgr8XJLMWfK0YOLrKNxehhoMc+
         T6g/4OegPDFV99DF1e8ex/zX4sTcVcDUeNDqLITsjRE115tjatYvV/HHU8FRqWR40+q1
         Gt9092TktMjTvKFiON9B8GLAWXwuJhO3QV/k6ljeV1E/YAr1eo0OxKlFe27K+5zs1LnM
         51e9afcAiGB6/RKO6Bx2903xad5UCXwYlodNXvknOEHGPU+G9DttCG/E6/Jnh0TMAR6N
         ltKw==
X-Gm-Message-State: AOAM533xGirqO5RMhSnvTPdommUvscfIr+dc5yf8yfY9jKTXlz5PUDuT
        ixYG9CVAWETHKJqVKDwBlK6063i4NGmt3+4FnimIRg==
X-Google-Smtp-Source: ABdhPJzhxZXUqBgnQ1HG5bYWm22c4NWgWogtnDllPgrVAfM1+RuGad+1r2gECEyARZuQzWa2/NHIF5M79bJ57DUtFFY=
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr15292236wmq.3.1593419285032;
 Mon, 29 Jun 2020 01:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
 <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com>
In-Reply-To: <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 13:57:53 +0530
Message-ID: <CAAhSdy0Ed8zQ5LVZva6p2TWqTOzrDRtL0JJkAdmpzWFhzJLUfg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Zong Li <zong.li@sifive.com>
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

On Mon, Jun 29, 2020 at 11:22 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 29, 2020 at 12:53 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > This patch set adds raw event support on RISC-V. In addition, we
> > > introduce the DT mechanism to make our perf more generic and common.
> > >
> > > Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> > > would raise an illegal instruction exception and trap into m-mode to
> > > emulate event selector CSRs access. It doesn't make sense because we
> > > shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> > > selector through standard SBI call or the shadow CSRs of s-mode. We have
> > > prepared a proposal of a new SBI extension, called "PMU SBI extension",
> > > but we also discussing the feasibility of accessing these PMU CSRs on
> > > s-mode at the same time, such as delegation mechanism, so I was
> > > wondering if we could use SBI calls first and make the PMU SBI extension
> > > as legacy when s-mode access mechanism is accepted by Foundation? or
> > > keep the current situation to see what would happen in the future.
> > >
> > > This patch set also introduces the DT mechanism, we don't want to add too
> > > much platform-dependency code in perf like other architectures, so we
> > > put the mapping of generic hardware events to DT, then we can easy to
> > > transfer generic hardware events to vendor's own hardware events without
> > > any platfrom-dependency stuff in our perf.
> >
> > Please re-write this series to have RISC-V PMU driver as a regular
> > platform driver as drivers/perf/riscv_pmu.c.
> >
> > The PMU related sources will have to be removed from arch/riscv.
> >
> > Based on implementation of final drivers/perf/riscv_pmu.c we will
> > come-up with drivers/perf/riscv_sbi_pmu.c driver for SBI perf counters.
> >
>
> There are some different ways to implement perf, and current
> implementation seems to be consensus when perf was introduced at the
> beginning [0][1]. I don't persist to which one, I could change the
> implementation as you mentioned if it is a new consensus one.
>
> [0] https://github.com/riscv/riscv-linux/pull/124#issuecomment-367563910

I would not recommend taking the original RISC-V linux fork as reference.

Rather we should study how things are done on other architectures.

I really appreciate the attempt to make RISC-V PMU driver depend on DT
but if we are going this route then we should maximize the use of Linux
platform driver framework. In fact, whenever possible we should integrate
RISC-V features as platform drivers under the drivers/ directory.

I thought about SBI PMU counters as well. In future, we can easily
expose SBI PMU counters as RAW events in the same RISC-V PMU
driver. The sbi_probe_extension() can be used in RISC-V PMU driver
to check for SBI PMU counters so no special provisions needed in DT
for SBI PMU counters.

Also, the RISC-V PMU driver can be implemented such that it will
work for RV32, RV64, NoMMU RV32, and NoMMU RV64.

Regards,
Anup

> [1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/f19TmCNP6yA
>
> > Regards,
> > Anup
> >
> > >
> > > Zong Li (6):
> > >   dt-bindings: riscv: Add YAML documentation for PMU
> > >   riscv: dts: sifive: Add DT support for PMU
> > >   riscv: add definition of hpmcounter CSRs
> > >   riscv: perf: Add raw event support
> > >   riscv: perf: introduce DT mechanism
> > >   riscv: remove PMU menu of Kconfig
> > >
> > >  .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
> > >  arch/riscv/Kconfig                            |  13 -
> > >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
> > >  arch/riscv/include/asm/csr.h                  |  58 +++
> > >  arch/riscv/include/asm/perf_event.h           | 100 ++--
> > >  arch/riscv/kernel/Makefile                    |   2 +-
> > >  arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
> > >  7 files changed, 471 insertions(+), 245 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > >
> > > --
> > > 2.27.0
> > >
