Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4127BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B72920771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgGABSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:18:38 -0400
Received: from atcsqr.andestech.com ([60.248.187.195]:53180 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGABSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:18:37 -0400
X-Greylist: delayed 1586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 21:18:36 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 0610ijSs066933
        for <linux-kernel@vger.kernel.org>; Wed, 1 Jul 2020 08:44:45 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0610i76Y066903;
        Wed, 1 Jul 2020 08:44:07 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 1 Jul 2020
 08:51:29 +0800
Date:   Wed, 1 Jul 2020 08:51:29 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Zong Li <zong.li@sifive.com>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
Message-ID: <20200701005129.GA27962@andestech.com>
References: <cover.1593397455.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0610i76Y066903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:19:09AM +0800, Zong Li wrote:
> This patch set adds raw event support on RISC-V. In addition, we
> introduce the DT mechanism to make our perf more generic and common.
> 
> Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> would raise an illegal instruction exception and trap into m-mode to
> emulate event selector CSRs access. It doesn't make sense because we
> shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> selector through standard SBI call or the shadow CSRs of s-mode. We have
> prepared a proposal of a new SBI extension, called "PMU SBI extension",
> but we also discussing the feasibility of accessing these PMU CSRs on
> s-mode at the same time, such as delegation mechanism, so I was
> wondering if we could use SBI calls first and make the PMU SBI extension
> as legacy when s-mode access mechanism is accepted by Foundation? or
> keep the current situation to see what would happen in the future.
> 
> This patch set also introduces the DT mechanism, we don't want to add too
> much platform-dependency code in perf like other architectures, so we
> put the mapping of generic hardware events to DT, then we can easy to
> transfer generic hardware events to vendor's own hardware events without
> any platfrom-dependency stuff in our perf.
> 
> Zong Li (6):
>   dt-bindings: riscv: Add YAML documentation for PMU
>   riscv: dts: sifive: Add DT support for PMU
>   riscv: add definition of hpmcounter CSRs
>   riscv: perf: Add raw event support
>   riscv: perf: introduce DT mechanism
>   riscv: remove PMU menu of Kconfig
> 

DT-based PMU registration looks good to me. Together with Anup's feedback,
we can anticipate that the following items will be:

- rewrite RISC-V PMU to a platform driver
- propose SBI PMU extention
- fixes: RV32 counter access, namings, etc.

Yes, all are good directions towards better counting (`perf stat`) function.
But as the original author of RISC-V perf port, please allow me to address
the fundamental problems of RISC-V perf, again [0][1][2][3], that the sampling
(`perf record`) function never earned enough respect.  Counting gives you a
shallow view regarding an application, while sampling demystifies one for you.

The problems are three-fold
(1) Interrupt
Sampling in perf requires that a HPM raises an interrupt when it overflows.
Making RISC-V perf platform driver or not has nothing to do with this.  This
requires more discussions in TGs.
(2) S-mode access to PMU CSRs
This is also addressed in this patch set but to me, it is kind of like a
SBI-solves-them-all mindset to me.  Perf event is for performance monitoring
thus we should eliminate any possible overhead if we can.  Setting event masks
through SBI calls for counting maybe OK, but if we really take sampling and
interrupt handling into consideration, it is questionable if it is still a
viable way.
(3) Registers, registers, registers
There is just no enough CSR/function for perf sampling. The previous proposal
explains why [2].

Perf sampling is off-topic but somehow related, so I bring it up here just
for your information.

As this patch set goes v2, the PMU porting guide in [0] should be removed since
it contains no useful information anymore.

[0] Documentation/riscv/pmu.rst
[1] https://www.youtube.com/watch?v=Onvlcl4e2IU
[2] https://github.com/riscv/riscv-isa-manual/issues/402
    This proposal has been posted in Privileged Spec Task Group, in
https://lists.riscv.org/g/tech-privileged-archive/message/488?p=,,,20,0,0,0::Created,,Proposal,20,2,40,32306071
but never receive any feedback.
[3] https://lists.riscv.org/g/tech-unixplatformspec/message/84
    I intended to discuss [2] in the Unixplatform Spec Task Group at the
online meeting, but obviously people were too busy knowing who the new
RISC-V CTO is and what he has done to even follow the agenda.

