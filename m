Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9119920772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="kSAqmXOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgGALny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbgGALnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:43:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F393C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 04:43:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so23467393wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGlPMljjqotC+85g0kEBPRu7slUbnSWGj8wZ/K8FKjY=;
        b=kSAqmXOTOqUiSFwFnX7eJllNAj+iUoXPE2zUNK5qTJEOjBtfhzlo+jU/5e83J8jMkt
         EZRsAqX1MgW7dZoYtBiwaYDoluEIotBBvhiXoeWvUWH1ke95dM7H9AXQckTf5gzOPvi4
         +C0SA2cEkI3m9sJa7NTtNV4eavOA1FPsJ2v2VhBu40GUpeWZlYDnE8kBJv2SdNK3iXL2
         gnnsgn47kPlSMj/sc/EaL/aJXn3Iu3HLTbm6Y1CXkXsojMx58zglA2DGXaoqjw50zcE5
         nDTVyMks49kXc0ubvj5FIE1jAZd51urylpVMPWi20mRO5tW2oOwOHaXPag9NoJeMJ1Ph
         JE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGlPMljjqotC+85g0kEBPRu7slUbnSWGj8wZ/K8FKjY=;
        b=RRcpLusRK71MTPnxcOUmVJ+UxGxxTqnso4vBG7pnpQMqkTTLmxhtsVn9oUy4l0PjFG
         jPWGtcw29lCiunvE4PZ0fVpFehm/yNXUCN8ie+Zma9oKm+mm3X/0yOsLA+sI7dS3ZdxD
         XcieewmJMDbuG3hjDwoedBUwqestINylCKwz/Yy921ewtA/G+mQ6HOQGZKMIcF2+IiLs
         l91VMSkh42ONSJCtYkFrnNA1YtOFPrYrgK2jvXQgieVGmRtagfhToqzhpaZtub4VhgMS
         7uKcjZaJohFw5M17KgPeMZbkrrEheKWdEjfSvKB8di7niqzpx0C98FdsJg4SW0y0bP4M
         4QPw==
X-Gm-Message-State: AOAM530mIsLiybYyGjhJ9k2eNQwW9UC+6UHv73apE/+UrwkuCfcJuToC
        8bcDllun6RRA8WnePmDf3NHJaqro84z1kkuOvm5ORw==
X-Google-Smtp-Source: ABdhPJwV07nSGVd2VEMn9kQV8SXprQg0o2VU9cyV2ME+sB52xLcwY46OF28c+YuMOaoTv5u3NpP6ZjZ5SynzEPM8BYE=
X-Received: by 2002:adf:de12:: with SMTP id b18mr28393429wrm.390.1593603830985;
 Wed, 01 Jul 2020 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
 <CANXhq0p_HoD6npHmoxxYHohBsgihfe5S-0DG04xLpQ3VO1w7oQ@mail.gmail.com>
 <CAAhSdy0Ed8zQ5LVZva6p2TWqTOzrDRtL0JJkAdmpzWFhzJLUfg@mail.gmail.com>
 <CANXhq0o9BMe6G6kv-zO7OvLTfKsz-4XKsoZJe3nxvX9_6uunvw@mail.gmail.com>
 <CAAhSdy1fEge0AbKH6B72SwVHM-heN0QJPO0rQuCK5QhXq3uA0g@mail.gmail.com>
 <CANXhq0ojMx2c+OJ56YWiQG-6iHa0XvU=4qzdOvKL2_iUzwF20A@mail.gmail.com>
 <CAAhSdy1jC-hfWdSxVsaZ0Ri5AjgEQAV3YHMixqH9GW_a+VAg5w@mail.gmail.com>
 <CANXhq0rfQs_Q0q4sza0HaQOzrQoQosW4B0OduJ6T9ttMTWGZNA@mail.gmail.com>
 <CAAhSdy2D+r1oKegYJrH43akVAPJL8pvYymdSP+0x_Hk-XbtNHw@mail.gmail.com>
 <CAAhSdy02TpyfzTGWzdqFiyeQNTj-RLk61VJNy5pYVYukqvfvrg@mail.gmail.com>
 <358970eb7c126c77307cf1064963119935587607.camel@wdc.com> <CANXhq0o5GRBhTp_bx9+h6W8kYqiUAN1s5jDcWCdReAxhQYQsFw@mail.gmail.com>
In-Reply-To: <CANXhq0o5GRBhTp_bx9+h6W8kYqiUAN1s5jDcWCdReAxhQYQsFw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 Jul 2020 17:13:39 +0530
Message-ID: <CAAhSdy2QM4K7iqkY+Kd_kzUiTNsZbVpBxChXWRcST+N5TeHhGA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Zong Li <zong.li@sifive.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alankao@andestech.com" <alankao@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:44 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Jul 1, 2020 at 2:57 AM Atish Patra <Atish.Patra@wdc.com> wrote:
> >
> > On Tue, 2020-06-30 at 17:08 +0530, Anup Patel wrote:
> > > On Tue, Jun 30, 2020 at 3:48 PM Anup Patel <anup@brainfault.org>
> > > wrote:
> > > > On Tue, Jun 30, 2020 at 1:34 PM Zong Li <zong.li@sifive.com> wrote:
> > > > > On Tue, Jun 30, 2020 at 3:40 PM Anup Patel <anup@brainfault.org>
> > > > > wrote:
> > > > > > On Tue, Jun 30, 2020 at 12:07 PM Zong Li <zong.li@sifive.com>
> > > > > > wrote:
> > > > > > > On Mon, Jun 29, 2020 at 9:23 PM Anup Patel <
> > > > > > > anup@brainfault.org> wrote:
> > > > > > > > On Mon, Jun 29, 2020 at 6:23 PM Zong Li <zong.li@sifive.com
> > > > > > > > > wrote:
> > > > > > > > > On Mon, Jun 29, 2020 at 4:28 PM Anup Patel <
> > > > > > > > > anup@brainfault.org> wrote:
> > > > > > > > > > On Mon, Jun 29, 2020 at 11:22 AM Zong Li <
> > > > > > > > > > zong.li@sifive.com> wrote:
> > > > > > > > > > > On Mon, Jun 29, 2020 at 12:53 PM Anup Patel <
> > > > > > > > > > > anup@brainfault.org> wrote:
> > > > > > > > > > > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <
> > > > > > > > > > > > zong.li@sifive.com> wrote:
> > > > > > > > > > > > > This patch set adds raw event support on RISC-V.
> > > > > > > > > > > > > In addition, we
> > > > > > > > > > > > > introduce the DT mechanism to make our perf more
> > > > > > > > > > > > > generic and common.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Currently, we set the hardware events by writing
> > > > > > > > > > > > > the mhpmeventN CSRs, it
> > > > > > > > > > > > > would raise an illegal instruction exception and
> > > > > > > > > > > > > trap into m-mode to
> > > > > > > > > > > > > emulate event selector CSRs access. It doesn't
> > > > > > > > > > > > > make sense because we
> > > > > > > > > > > > > shouldn't write the m-mode CSRs in s-mode.
> > > > > > > > > > > > > Ideally, we should set event
> > > > > > > > > > > > > selector through standard SBI call or the shadow
> > > > > > > > > > > > > CSRs of s-mode. We have
> > > > > > > > > > > > > prepared a proposal of a new SBI extension,
> > > > > > > > > > > > > called "PMU SBI extension",
> > > > > > > > > > > > > but we also discussing the feasibility of
> > > > > > > > > > > > > accessing these PMU CSRs on
> > > > > > > > > > > > > s-mode at the same time, such as delegation
> > > > > > > > > > > > > mechanism, so I was
> > > > > > > > > > > > > wondering if we could use SBI calls first and
> > > > > > > > > > > > > make the PMU SBI extension
> > > > > > > > > > > > > as legacy when s-mode access mechanism is
> > > > > > > > > > > > > accepted by Foundation? or
> > > > > > > > > > > > > keep the current situation to see what would
> > > > > > > > > > > > > happen in the future.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This patch set also introduces the DT mechanism,
> > > > > > > > > > > > > we don't want to add too
> > > > > > > > > > > > > much platform-dependency code in perf like other
> > > > > > > > > > > > > architectures, so we
> > > > > > > > > > > > > put the mapping of generic hardware events to DT,
> > > > > > > > > > > > > then we can easy to
> > > > > > > > > > > > > transfer generic hardware events to vendor's own
> > > > > > > > > > > > > hardware events without
> > > > > > > > > > > > > any platfrom-dependency stuff in our perf.
> > > > > > > > > > > >
> > > > > > > > > > > > Please re-write this series to have RISC-V PMU
> > > > > > > > > > > > driver as a regular
> > > > > > > > > > > > platform driver as drivers/perf/riscv_pmu.c.
> > > > > > > > > > > >
> > > > > > > > > > > > The PMU related sources will have to be removed
> > > > > > > > > > > > from arch/riscv.
> > > > > > > > > > > >
> > > > > > > > > > > > Based on implementation of final
> > > > > > > > > > > > drivers/perf/riscv_pmu.c we will
> > > > > > > > > > > > come-up with drivers/perf/riscv_sbi_pmu.c driver
> > > > > > > > > > > > for SBI perf counters.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > There are some different ways to implement perf, and
> > > > > > > > > > > current
> > > > > > > > > > > implementation seems to be consensus when perf was
> > > > > > > > > > > introduced at the
> > > > > > > > > > > beginning [0][1]. I don't persist to which one, I
> > > > > > > > > > > could change the
> > > > > > > > > > > implementation as you mentioned if it is a new
> > > > > > > > > > > consensus one.
> > > > > > > > > > >
> > > > > > > > > > > [0]
> > > > > > > > > > > https://github.com/riscv/riscv-linux/pull/124#issuecomment-367563910
> > > > > > > > > >
> > > > > > > > > > I would not recommend taking the original RISC-V linux
> > > > > > > > > > fork as reference.
> > > > > > > > > >
> > > > > > > > > > Rather we should study how things are done on other
> > > > > > > > > > architectures.
> > > > > > > > > >
> > > > > > > > > > I really appreciate the attempt to make RISC-V PMU
> > > > > > > > > > driver depend on DT
> > > > > > > > > > but if we are going this route then we should maximize
> > > > > > > > > > the use of Linux
> > > > > > > > > > platform driver framework. In fact, whenever possible
> > > > > > > > > > we should integrate
> > > > > > > > > > RISC-V features as platform drivers under the drivers/
> > > > > > > > > > directory.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > OK, I would change the implementation to platform driver
> > > > > > > > > if there is no
> > > > > > > > > other voice.
> > > > > > > > >
> > > > > > > > > > I thought about SBI PMU counters as well. In future, we
> > > > > > > > > > can easily
> > > > > > > > > > expose SBI PMU counters as RAW events in the same RISC-
> > > > > > > > > > V PMU
> > > > > > > > > > driver. The sbi_probe_extension() can be used in RISC-V
> > > > > > > > > > PMU driver
> > > > > > > > > > to check for SBI PMU counters so no special provisions
> > > > > > > > > > needed in DT
> > > > > > > > > > for SBI PMU counters.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I thought about probing raw events by SBI extension too,
> > > > > > > > > I'm interested if you
> > > > > > > > > have more detail about this.
> > > > > > > > >
> > > > > > > > > It seems to me that it is a little bit hard to return all
> > > > > > > > > events
> > > > > > > > > through one SBI call,
> > > > > > > > > so I thought we could map the generic hardware events and
> > > > > > > > > maintain their own
> > > > > > > > > raw events by each platform in OpenSBI. But eventually, I
> > > > > > > > > thought the
> > > > > > > > > DT mechanism
> > > > > > > > > is more clear and easy than that. Let me know if you have
> > > > > > > > > any ideas about
> > > > > > > > > probe function. Thanks.
> > > > > > > >
> > > > > > > > We can design SBI calls such that no SBI call is required
> > > > > > > > to read
> > > > > > > > the perf counter.
> > > > > > > >
> > > > > > > > The sbi_probe_extension() will only be used to check
> > > > > > > > whether
> > > > > > > > underlying SBI implementation supports SBI PMU extension.
> > > > > > > >
> > > > > > > > As-per my initial thoughts, we can potentially have the
> > > > > > > > following SBI calls:
> > > > > > > >
> > > > > > > > 1. SBI_PMU_NUM_COUNTERS
> > > > > > > >     This call will return the number of SBI PMU counters
> > > > > > > > 2. SBI_PMU_COUNTER_DESCRIBE
> > > > > > > >    This call takes two parameters: 1) physical address 2)
> > > > > > > > counter index
> > > > > > > >     It will write the description of SBI PMU counter at
> > > > > > > > specified
> > > > > > > > physical address.
> > > > > > > >     The details of the SBI PMU counter will include name,
> > > > > > > > type, etc
> > > > > > >
> > > > > > > The main things are that we need to pass the information of
> > > > > > > raw events
> > > > > > > and the information of mapping of generic hardware events.
> > > > > > > Maybe
> > > > > > > this information could be passed by this SBI call.
> > > > > > >
> > > > > > > > 3. SBI_PMU_COUNTER_START
> > > > > > > >     This call takes two parameters: 1) physical address 2)
> > > > > > > > counter index
> > > > > > > >     It will inform SBI implementation to start counting
> > > > > > > > specified counter on the
> > > > > > > >     calling HART. The counter value will be written to the
> > > > > > > > specified physical
> > > > > > > >     address whenever it changes.
> > > > > > >
> > > > > > > I would prefer to read the counter directly on s-mode. Spec
> > > > > > > already defines the
> > > > > > > mechanism to allow that. But this way would still work if we
> > > > > > > couldn't
> > > > > > > read counters
> > > > > > > on s-mode.
> > > > > >
> > > > > > The SBI PMU counters have nothing to do with RISC-V PMU
> > > > > > counters because
> > > > > > these are counters provided by SBI implementation.
> > > > > >
> > > > > > All-in-all, we have three types of counters:
> > > > > > 1. PMU counters defined by RISC-V privilege spec. These are
> > > > > > TIME,
> > > > > > INSRET, and CYCLE CSRs.
> > > > > > 2. Implementation specific counters accessed via HPMCOUNTER
> > > > > > CSRs.
> > > > > > 3. SBI PMU counters for traps taken and processed by M-mode
> > > > > > runtime
> > > > > > firmware. Examples: number of misaligned load/store, number of
> > > > > > illegal
> > > > > > instructions, number of SBI RFENCE calls, number of SBI IPI
> > > > > > calls, etc.
> > > > > >
> > > > > > The DT based RISC-V PMU platform driver being discussed in this
> > > > > > email
> > > > > > thread only addresses points 1) and 2) above.
> > > > > >
> > > > >
> > > > > OK, sounds good, I misunderstood your ideas, I mixed the 2) and
> > > > > 3)
> > > > > and see them as the same thing. Many thanks for the clear
> > > > > explanation.
> > > >
> > > > Cool, we are on the same page till here.
> > > >
> > > > > > For point 3) above, we need to first define SBI PMU extension.
> > > > > > Once SBI
> > > > > > PMU extension is defined, we can have separate SBI PMU driver
> > > > > > in Linux
> > > > > > or extend RISC-V PMU driver to register additonal counters
> > > > > > based on
> > > > > > SBI PMU extension.
> > > > > >
> > > > > > I never suggested  to access RISC-V HPMCOUNTER CSRs via SBI
> > > > > > calls
> > > > > > so DT based RISC-V PMU platform driver (for 1) and 2) above) is
> > > > > > good
> > > > > > to have. The SBI PMU extension is a separate topic.
> > > > > >
> > > > > > > > 4. SBI_PMU_COUNTER_STOP
> > > > > > > >     This call takes one parameter: 1) counter index
> > > > > > > >     It will inform SBI implementation to stop counting
> > > > > > > > specified counters on
> > > > > > > >     the calling HART.
> > > > > > > >
> > > > > > > > The above calls are generic enough to support any number of
> > > > > > > > counters
> > > > > > > > and we don't need any SBI call to read the counter. We can
> > > > > > > > also assume
> > > > > > > > all counters to be of fixed 64bit width. In fact, even
> > > > > > > > Hypervisors can support
> > > > > > > > it's own SBI PMU counters with SBI PMU extension.
> > > > > > > >
> > > > > > > > We still need to think more about the above calls because
> > > > > > > > above SBI
> > > > > > > > calls are just initial ideas.
> > > > > > > >
> > > > > > >
> > > > > > > We also need a SBI call to set the event selector to specify
> > > > > > > which event
> > > > > > > is monitored.
> > > > > >
> > > > > > SBI_PMU_COUNTER_START will do that.
> > > > >
> > > > > I'm not sure whether this SBI call is only for SBI PMU counter
> > > > > and
> > > > > it's own events.
> > > > > For 2), it needs one SBI call to set the events, we just set the
> > > > > event selector
> > > > > by writing m-mode CSRs on s-mode now. If this SBI call could
> > > > > serve 2)
> > > > > and 3) both,
> > > > > we don't need another SBI call.
> > > >
> > > > Can you elaborate more ??
> > > >
> > > > Is the SBI call for 2) needed to enable/disable counters in
> > > > MCOUNTEREN CSR ?
> > > >
> > > > Currently, OpenSBI enables all counters by default but I see the
> > > > need
> > > > to enable/disable HPMCOUNTER on-demand from perf event start/stop.
> > > >
> > > > I hope we don't need any other implementation specific CSR to be
> > > > programmed
> > > > for enabling/disabling counters on SiFive Unleashed ??
> > > >
> > >
> > > Here's the next version of SBI PMU extension, which tries to address
> > > both
> > > 2) and 3). In other words, it covers all HPMCOUNTER CSRs and software
> > > counters of SBI implementation.
> > >
> > > To define SBI PMU extension, we first define counter_idx which is a
> > > unique
> > > number assigned to a counter:
> > > 1. counter_idx = 0 to 2 are for CYCLE, TIME, and INSTRET
> > > 2. counter_idx = 3 to 31 are for HPMCOUNTER
> > > 3. counter_idx = 32 or higher are for software counters counters
> > > provided by SBI implementation
> > >
> >
> > The number of HPMCOUNTER may increase in future. Right ?
> >
> > How about using a higher starting idx for software counters from SBI
> > impolementation ?
> >
>
> Sounds good to me.
>
> > > The counter_idx == 1 (i.e. TIME CSR) is always enabled when
> > > underlying
> > > HW implements it. Otherwise it is always disabled.
> > >
> > > Based on above definition of counter_idx definition, we can
> > > potentially have
> > > the following SBI calls:
> > >
> > > 1. SBI_PMU_NUM_HPMCOUNTER
> > >     This call will return the number of HPMCOUNTER CSRs
> > > 2. SBI_PMU_NUM_SOFTWARE
> > >     This call will return the number of software counters provided by
> > >     SBI implementation
> > > 3. SBI_PMU_COUNTER_DESCRIBE
> > >     This call takes two parameters: 1) counter_idx 2) physical
> > > address
> > >     It will write the description of SBI PMU counter at specified
> > > physical address.
> > >     The details of the SBI PMU counter will include name, type,
> > > width,
> > > events etc
> > > 4. SBI_PMU_COUNTER_SET_PHYS_ADDR
> > >     This call takes two parameters: 1) counter_idx 2) physical
> > > address
> > >     It will set the physical address where SBI implementation will
> > > write
> > >     the software counter. This SBI call is only for software counters
> > > (i.e.
> > >     counter_idx >= 32) so it will fail for other counters.
> > > 5. SBI_PMU_COUNTER_SELECT_EVENT
> > >     This call takes two parameters: 1) counter_idx 2) event number
> > >     It will select a particular HW event to monitor in a HPMCOUNTER
> > > CSR.
> > >     This SBI call is only for HPMCOUNTER CSRs (i.e 3 <= counter_idx
> > > <= 31)
> > > 6. SBI_PMU_COUNTER_START
> > >    This call takes one parameter: 1) counter_idx
> > >    It will inform SBI implementation to start/enable specified
> > > counter on the
> > >    calling HART. This SBI call will fail for counter_idx == 1 and
> > > counters
> > >    which are not present.
> > > 7. SBI_PMU_COUNTER_STOP
> > >     This call takes one parameter: 1) counter_idx
> > >     It will inform SBI implementation to stop/disable specified
> > > counters on
> > >     the calling HART. This SBI call will fail for counter_idx == 1
> > > and counters
> > >     which are not present.
> > >
> > > The above described SBI calls can be conveniently implemented in
> > > M-mode runtime firmware (OpenSBI) and various hypervisors (Xvisor,
> > > KVM, etc).
> > >
> > > We can have a single RISC-V PMU driver using above SBI calls which
> > > can be used natively in HS-mode and Guest/VM in VS-mode. Of course,
> > > we won't need any information to be passed in DT/ACPI for this driver
> > > and it can be under arch/riscv/kernel because without DT/ACPI it
> > > can't
> > > be a platform driver.
> >
> > We still need the information in DT for mapping generic hardware
> > events. No ?
>
> Yes, I think it does.
>

Here's v3 of SBI PMU extension which tries to cover CYCLE CSR, INSTRET CSR,
HPMCOUNTER CSRs and software counters of the SBI implementation.

To define SBI PMU extension, we first define counter_idx which is a unique
number assigned to a counter and event_idx which is an encoded number
representing event to be monitored.

The SBI PMU event_idx is 15bit number encoded as follows:
event_idx[14:12] = type
event_idx[11:0] = code

If event_idx.type == 0 then it is HARDWARE event and event_idx.code can
be one of the following:
enum sbi_pmu_hw_id {
    /*
     * Common hardware events, generalized by the kernel:
     */
    PERF_COUNT_HW_CPU_CYCLES        = 0,
    PERF_COUNT_HW_INSTRUCTIONS        = 1,
    PERF_COUNT_HW_CACHE_REFERENCES        = 2,
    PERF_COUNT_HW_CACHE_MISSES        = 3,
    PERF_COUNT_HW_BRANCH_INSTRUCTIONS    = 4,
    PERF_COUNT_HW_BRANCH_MISSES        = 5,
    PERF_COUNT_HW_BUS_CYCLES        = 6,
    PERF_COUNT_HW_STALLED_CYCLES_FRONTEND    = 7,
    PERF_COUNT_HW_STALLED_CYCLES_BACKEND    = 8,
    PERF_COUNT_HW_REF_CPU_CYCLES        = 9,

    PERF_COUNT_HW_MAX,            /* non-ABI */
};
(NOTE: Same as described in <linux_source>/include/uapi/linux/perf_event.h)

If event_idx.type == 1 then it is CACHE event and event_idx.code is encoded
as follows:
event_idx.code[11:4] = cache_id
event_idx.code[3:1] = op_id
event_idx.code[0:0] = result_id
enum sbi_pmu_hw_cache_id {
    PERF_COUNT_HW_CACHE_L1D            = 0,
    PERF_COUNT_HW_CACHE_L1I            = 1,
    PERF_COUNT_HW_CACHE_LL            = 2,
    PERF_COUNT_HW_CACHE_DTLB        = 3,
    PERF_COUNT_HW_CACHE_ITLB        = 4,
    PERF_COUNT_HW_CACHE_BPU            = 5,
    PERF_COUNT_HW_CACHE_NODE        = 6,

    PERF_COUNT_HW_CACHE_MAX,        /* non-ABI */
};
enum sbi_pmu_hw_cache_op_id {
    PERF_COUNT_HW_CACHE_OP_READ        = 0,
    PERF_COUNT_HW_CACHE_OP_WRITE        = 1,
    PERF_COUNT_HW_CACHE_OP_PREFETCH        = 2,

    PERF_COUNT_HW_CACHE_OP_MAX,        /* non-ABI */
};
enum sbi_pmu_hw_cache_op_result_id {
    PERF_COUNT_HW_CACHE_RESULT_ACCESS    = 0,
    PERF_COUNT_HW_CACHE_RESULT_MISS        = 1,

    PERF_COUNT_HW_CACHE_RESULT_MAX,        /* non-ABI */
};
(NOTE: Same as described in <linux_source>/include/uapi/linux/perf_event.h)

If event_idx.type == 2 then it is RAW event and event_idx.code is just
a RAW event number.

In future, more event_idx can be defined without breaking ABI compatibility
of SBI calls.

Based on above definition of counter_idx definition, we can potentially have
the following SBI calls:

1. SBI_PMU_NUM_COUNTERS
   This call will return the number of COUNTERs
2. SBI_PMU_COUNTER_DESCRIBE
   This call takes two parameters: 1) counter_idx 2) physical address of 4k page
   It will write the description of SBI PMU counter at specified physical
   address. The details of the SBI PMU counter written at specified physical
   address are as follows:
   1. Name (64 bytes)
   2. CSR_Offset (4 bytes)
      (E.g. CSR_Offset == 0x2 imply CSR 0xC02)
      (E.g. CSR_Offset == 0xffffffff means it is SBI implementation counter)
   3. CSR_Width (4 bytes)
      (Number of CSR bits implemented in HW)
   4. Event bitmap (2048 bytes) (i.e. 1-bit for each possible event_idx)
      (If bit corresponding to a event_idx is 1 then event_idx is supported
       by the counter)
   5. Any thing else ??
3. SBI_PMU_COUNTER_SET_PHYS_ADDR
   This call takes two parameters: 1) counter_idx 2) physical address
   It will set the physical address where SBI implementation will write
   the software counter. This SBI call is only for counters not mapped
   to any CSR (i.e. only for counters with CSR_Offset == 0xffffffff).
4. SBI_PMU_COUNTER_START
   This call takes two parameters: 1) counter_idx 2) event_idx
   It will inform SBI implementation to configure and start/enable specified
   counter on the calling HART to monitor specified event. This SBI call will
   fail for counters which are not present.
5. SBI_PMU_COUNTER_STOP
   This call takes one parameter: 1) counter_idx
   It will inform SBI implementation to stop/disable specified counters on the
   calling HART. This SBI call will fail for counters which are not present.

From above, the RISC-V PMU driver will use most of the SBI calls at boot time.
Only SBI_PMU_COUNTER_START to used once before using the counter. The reading
of counter is by reading CSR (for CSR_Offset != 0xffffffff) OR by reading
memory location (for CSR_Offset == 0xffffffff). The counter overflow handling
will have to be done in software by Linux kernel.

The information returned by SBI_PMU_NUM_COUNTERS and SBI_PMU_COUNTER_DESCRIBE
can be passed via DT/ACPI but it will be difficult to maintain because we
have hardware counters and SBI implementation counters both provided by SBI
PMU extension. The SBI implementation counters are specific to underlying
SBI implementation so we will have to keep counters/events described in
DT/ACPI in-sync with underlying SBI implementation.

Regards,
Anup
