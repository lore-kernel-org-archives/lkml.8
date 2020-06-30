Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B843206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jIF/JUnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgF3HkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgF3HkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:40:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA919C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:40:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so18560812wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0E7T7/hC3pMT1apZCUquidu9k+qGD6WVEvdwPrh18dI=;
        b=jIF/JUnbT8+0lPwj+9VJZ2c5YLoHz/NmnwVgJ2KyI1C4YjwWsikuGbzo0U5lCwZWpf
         bzTq6rwp4GteEkzXdqACRkszVSyUWay71T3Mg1ZXudev71JJW090FlSnEMT6JegYsO9a
         Ek3sX6/A1tV2yQ5DMCYHO8uhNehpf1+kGN0vJ4rmVQftK+PVdE1VLzOlIPynDJSNx+3U
         yXOKCGFcejVenugQ8N5mMKq1eR3U+ZcjKrOe0EKZi0vr7xzUZ6mx8kO4Qgbl4ATdX0/G
         bLc2UmT6XGmK2YMKfTt0EE3jOaL+LK1nhQS11r0Fjn2v3JXKmyGjXadC/3N4RcTZiB1J
         7MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0E7T7/hC3pMT1apZCUquidu9k+qGD6WVEvdwPrh18dI=;
        b=Od2Y6c3l0kSMpnS+q+JpeXqT07GulL/YZIQu6H4xgy5L2KFe++AvKqTDRqPYcVnqn3
         U1Fz4XHVvw5ioD7oLNLaNIcGICRWF1XuRSgVjgiEbT02dI+JoMmYMaAmIWykeXS4NsDa
         qPk07oXyOEDPZOQm+SkcFVJ1n+ZA2U732jvyCThqd1ne7SL9syGp56s990jg30T+V+D5
         KTqpKDj4MBKqmrUyxNc7irDD+mh7iJ2xeTPfQqtNUy7CAVKHDtBMSHTgIKw17aT0s//x
         J+l8WOVa9Qp7nxTRrSGfytLjtcP8fOqdR7H5fnaqoHVM0I46TycrScBjjpZRtbsVJ+Jy
         tznw==
X-Gm-Message-State: AOAM5328WJ4XBrvIIhqcbg3UgRbXwyesX2Te+lf2MDGU0d63gluoJCly
        BuGIBolhhsxO44JW1o5v1Ao10UvRZzINvXt7nE+KuA==
X-Google-Smtp-Source: ABdhPJyHgvESp+VYzBIKtLN7sgUvBhCyeZycJiorNoA8JXkzh1KfDBx6t9cS3l1UuPXe/2Vdbw8CrbdLvsKT2TXR6yU=
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr21917228wml.185.1593502811448;
 Tue, 30 Jun 2020 00:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
 <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com>
 <CAAhSdy0Ed8zQ5LVZva6p2TWqTOzrDRtL0JJkAdmpzWFhzJLUfg@mail.gmail.com>
 <CANXhq0o9BMe6G6kv-zO7OvLTfKsz-4XKsoZJe3nxvX9_6uunvw@mail.gmail.com>
 <CAAhSdy1fEge0AbKH6B72SwVHM-heN0QJPO0rQuCK5QhXq3uA0g@mail.gmail.com> <CANXhq0ojMx2c+OJ56YWiQG-6iHa0XvU=4qzdOvKL2_iUzwF20A@mail.gmail.com>
In-Reply-To: <CANXhq0ojMx2c+OJ56YWiQG-6iHa0XvU=4qzdOvKL2_iUzwF20A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jun 2020 13:09:59 +0530
Message-ID: <CAAhSdy1jC-hfWdSxVsaZ0Ri5AjgEQAV3YHMixqH9GW_a+VAg5w@mail.gmail.com>
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

On Tue, Jun 30, 2020 at 12:07 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 29, 2020 at 9:23 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 6:23 PM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 4:28 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Mon, Jun 29, 2020 at 11:22 AM Zong Li <zong.li@sifive.com> wrote:
> > > > >
> > > > > On Mon, Jun 29, 2020 at 12:53 PM Anup Patel <anup@brainfault.org> wrote:
> > > > > >
> > > > > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > > > > > >
> > > > > > > This patch set adds raw event support on RISC-V. In addition, we
> > > > > > > introduce the DT mechanism to make our perf more generic and common.
> > > > > > >
> > > > > > > Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> > > > > > > would raise an illegal instruction exception and trap into m-mode to
> > > > > > > emulate event selector CSRs access. It doesn't make sense because we
> > > > > > > shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> > > > > > > selector through standard SBI call or the shadow CSRs of s-mode. We have
> > > > > > > prepared a proposal of a new SBI extension, called "PMU SBI extension",
> > > > > > > but we also discussing the feasibility of accessing these PMU CSRs on
> > > > > > > s-mode at the same time, such as delegation mechanism, so I was
> > > > > > > wondering if we could use SBI calls first and make the PMU SBI extension
> > > > > > > as legacy when s-mode access mechanism is accepted by Foundation? or
> > > > > > > keep the current situation to see what would happen in the future.
> > > > > > >
> > > > > > > This patch set also introduces the DT mechanism, we don't want to add too
> > > > > > > much platform-dependency code in perf like other architectures, so we
> > > > > > > put the mapping of generic hardware events to DT, then we can easy to
> > > > > > > transfer generic hardware events to vendor's own hardware events without
> > > > > > > any platfrom-dependency stuff in our perf.
> > > > > >
> > > > > > Please re-write this series to have RISC-V PMU driver as a regular
> > > > > > platform driver as drivers/perf/riscv_pmu.c.
> > > > > >
> > > > > > The PMU related sources will have to be removed from arch/riscv.
> > > > > >
> > > > > > Based on implementation of final drivers/perf/riscv_pmu.c we will
> > > > > > come-up with drivers/perf/riscv_sbi_pmu.c driver for SBI perf counters.
> > > > > >
> > > > >
> > > > > There are some different ways to implement perf, and current
> > > > > implementation seems to be consensus when perf was introduced at the
> > > > > beginning [0][1]. I don't persist to which one, I could change the
> > > > > implementation as you mentioned if it is a new consensus one.
> > > > >
> > > > > [0] https://github.com/riscv/riscv-linux/pull/124#issuecomment-367563910
> > > >
> > > > I would not recommend taking the original RISC-V linux fork as reference.
> > > >
> > > > Rather we should study how things are done on other architectures.
> > > >
> > > > I really appreciate the attempt to make RISC-V PMU driver depend on DT
> > > > but if we are going this route then we should maximize the use of Linux
> > > > platform driver framework. In fact, whenever possible we should integrate
> > > > RISC-V features as platform drivers under the drivers/ directory.
> > > >
> > >
> > > OK, I would change the implementation to platform driver if there is no
> > > other voice.
> > >
> > > > I thought about SBI PMU counters as well. In future, we can easily
> > > > expose SBI PMU counters as RAW events in the same RISC-V PMU
> > > > driver. The sbi_probe_extension() can be used in RISC-V PMU driver
> > > > to check for SBI PMU counters so no special provisions needed in DT
> > > > for SBI PMU counters.
> > > >
> > >
> > > I thought about probing raw events by SBI extension too, I'm interested if you
> > > have more detail about this.
> > >
> > > It seems to me that it is a little bit hard to return all events
> > > through one SBI call,
> > > so I thought we could map the generic hardware events and maintain their own
> > > raw events by each platform in OpenSBI. But eventually, I thought the
> > > DT mechanism
> > > is more clear and easy than that. Let me know if you have any ideas about
> > > probe function. Thanks.
> >
> > We can design SBI calls such that no SBI call is required to read
> > the perf counter.
> >
> > The sbi_probe_extension() will only be used to check whether
> > underlying SBI implementation supports SBI PMU extension.
> >
> > As-per my initial thoughts, we can potentially have the following SBI calls:
> >
> > 1. SBI_PMU_NUM_COUNTERS
> >     This call will return the number of SBI PMU counters
> > 2. SBI_PMU_COUNTER_DESCRIBE
> >    This call takes two parameters: 1) physical address 2) counter index
> >     It will write the description of SBI PMU counter at specified
> > physical address.
> >     The details of the SBI PMU counter will include name, type, etc
>
> The main things are that we need to pass the information of raw events
> and the information of mapping of generic hardware events. Maybe
> this information could be passed by this SBI call.
>
> > 3. SBI_PMU_COUNTER_START
> >     This call takes two parameters: 1) physical address 2) counter index
> >     It will inform SBI implementation to start counting specified counter on the
> >     calling HART. The counter value will be written to the specified physical
> >     address whenever it changes.
>
> I would prefer to read the counter directly on s-mode. Spec already defines the
> mechanism to allow that. But this way would still work if we couldn't
> read counters
> on s-mode.

The SBI PMU counters have nothing to do with RISC-V PMU counters because
these are counters provided by SBI implementation.

All-in-all, we have three types of counters:
1. PMU counters defined by RISC-V privilege spec. These are TIME,
INSRET, and CYCLE CSRs.
2. Implementation specific counters accessed via HPMCOUNTER CSRs.
3. SBI PMU counters for traps taken and processed by M-mode runtime
firmware. Examples: number of misaligned load/store, number of illegal
instructions, number of SBI RFENCE calls, number of SBI IPI calls, etc.

The DT based RISC-V PMU platform driver being discussed in this email
thread only addresses points 1) and 2) above.

For point 3) above, we need to first define SBI PMU extension. Once SBI
PMU extension is defined, we can have separate SBI PMU driver in Linux
or extend RISC-V PMU driver to register additonal counters based on
SBI PMU extension.

I never suggested  to access RISC-V HPMCOUNTER CSRs via SBI calls
so DT based RISC-V PMU platform driver (for 1) and 2) above) is good
to have. The SBI PMU extension is a separate topic.

>
> > 4. SBI_PMU_COUNTER_STOP
> >     This call takes one parameter: 1) counter index
> >     It will inform SBI implementation to stop counting specified counters on
> >     the calling HART.
> >
> > The above calls are generic enough to support any number of counters
> > and we don't need any SBI call to read the counter. We can also assume
> > all counters to be of fixed 64bit width. In fact, even Hypervisors can support
> > it's own SBI PMU counters with SBI PMU extension.
> >
> > We still need to think more about the above calls because above SBI
> > calls are just initial ideas.
> >
>
> We also need a SBI call to set the event selector to specify which event
> is monitored.

SBI_PMU_COUNTER_START will do that.

>
> > Maybe you can refine the above ideas and send a proposal to the
> > UnixPlatformSpec mailing list ??
> >
>
> Ok, let us talk about the details in that.

Regards,
Anup

>
>
> > Regards,
> > Anup
> >
> > >
> > > > Also, the RISC-V PMU driver can be implemented such that it will
> > > > work for RV32, RV64, NoMMU RV32, and NoMMU RV64.
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > > [1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/f19TmCNP6yA
> > > > >
> > > > > > Regards,
> > > > > > Anup
> > > > > >
> > > > > > >
> > > > > > > Zong Li (6):
> > > > > > >   dt-bindings: riscv: Add YAML documentation for PMU
> > > > > > >   riscv: dts: sifive: Add DT support for PMU
> > > > > > >   riscv: add definition of hpmcounter CSRs
> > > > > > >   riscv: perf: Add raw event support
> > > > > > >   riscv: perf: introduce DT mechanism
> > > > > > >   riscv: remove PMU menu of Kconfig
> > > > > > >
> > > > > > >  .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
> > > > > > >  arch/riscv/Kconfig                            |  13 -
> > > > > > >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
> > > > > > >  arch/riscv/include/asm/csr.h                  |  58 +++
> > > > > > >  arch/riscv/include/asm/perf_event.h           | 100 ++--
> > > > > > >  arch/riscv/kernel/Makefile                    |   2 +-
> > > > > > >  arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
> > > > > > >  7 files changed, 471 insertions(+), 245 deletions(-)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > > >
> > > > > > > --
> > > > > > > 2.27.0
> > > > > > >
