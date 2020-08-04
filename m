Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0B220738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgHDLiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:38:55 -0400
Received: from foss.arm.com ([217.140.110.172]:43024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbgHDLiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:38:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D089030E;
        Tue,  4 Aug 2020 04:38:54 -0700 (PDT)
Received: from bogus (unknown [10.37.12.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDA833F6CF;
        Tue,  4 Aug 2020 04:38:52 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:38:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Liu <jason.hui.liu@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Message-ID: <20200804113850.GB15199@bogus>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:58:47AM +0100, Marc Zyngier wrote:
> On 2020-08-04 09:56, Jason Liu wrote:
> > No need to do the irq_chip->irq_mask() if it already masked.
> > BTW, unconditionally do the irq_chip->irq_mask() will also bring issues
> > when the irq_chip in the runtime PM suspend. Accessing registers of the
> > irq_chip will bring in the exceptions. For example on the i.MX:
> > 
> > root@imx8qmmek:~# echo c > /proc/sysrq-trigger
> > [  177.796182] sysrq: Trigger a crash
> > [  177.799596] Kernel panic - not syncing: sysrq triggered crash
> > [  177.875616] SMP: stopping secondary CPUs
> > [  177.891936] Internal error: synchronous external abort: 96000210
> > [#1] PREEMPT SMP
> > [  177.899429] Modules linked in: crct10dif_ce mxc_jpeg_encdec
> > [  177.905018] CPU: 1 PID: 944 Comm: sh Kdump: loaded Not tainted
> > [  177.913457] Hardware name: Freescale i.MX8QM MEK (DT)
> > [  177.918517] pstate: a0000085 (NzCv daIf -PAN -UAO)
> > [  177.923318] pc : imx_irqsteer_irq_mask+0x50/0x80
> > [  177.927944] lr : imx_irqsteer_irq_mask+0x38/0x80
> > [  177.932561] sp : ffff800011fe3a50
> > [  177.935880] x29: ffff800011fe3a50 x28: ffff0008f7708e00
> > [  177.941196] x27: 0000000000000000 x26: 0000000000000000
> > [  177.946513] x25: ffff800011a30c80 x24: 0000000000000000
> > [  177.951830] x23: ffff800011fe3af8 x22: ffff0008f24469d4
> > [  177.957147] x21: ffff0008f2446880 x20: ffff0008f25f5658
> > [  177.962463] x19: ffff800012611004 x18: 0000000000000001
> > [  177.967780] x17: 0000000000000000 x16: 0000000000000000
> > [  177.973097] x15: ffff0008f7709270 x14: 0000000060000085
> > [  177.978414] x13: ffff800010177570 x12: ffff800011fe3ab0
> > [  177.983730] x11: ffff80001017749c x10: 0000000000000040
> > [  177.989047] x9 : ffff8000119f1c80 x8 : ffff8000119f1c78
> > [  177.994364] x7 : ffff0008f46bedf8 x6 : 0000000000000000
> > [  177.999681] x5 : ffff0008f46beda0 x4 : 0000000000000000
> > [  178.004997] x3 : ffff0008f24469d4 x2 : ffff800012611000
> > [  178.010314] x1 : 0000000000000080 x0 : 0000000000000080
> > [  178.015630] Call trace:
> > [  178.018077]  imx_irqsteer_irq_mask+0x50/0x80
> > [  178.022352]  machine_crash_shutdown+0xa8/0x100
> > [  178.026802]  __crash_kexec+0x6c/0x118
> > [  178.030464]  panic+0x19c/0x324
> > [  178.033524]  sysrq_handle_reboot+0x0/0x20
> > [  178.037537]  __handle_sysrq+0x88/0x180
> > [  178.041290]  write_sysrq_trigger+0x8c/0xb0
> > [  178.045389]  proc_reg_write+0x78/0xb0
> > [  178.049055]  __vfs_write+0x18/0x40
> > [  178.052461]  vfs_write+0xdc/0x1c8
> > [  178.055779]  ksys_write+0x68/0xf0
> > [  178.059098]  __arm64_sys_write+0x18/0x20
> > [  178.063027]  el0_svc_common.constprop.0+0x68/0x160
> > [  178.067821]  el0_svc_handler+0x20/0x80
> > [  178.071573]  el0_svc+0x8/0xc
> > [  178.074463] Code: 93407e73 91001273 aa0003e1 8b130053 (b9400260)
> > [  178.080567] ---[ end trace 652333f6c6d6b05d ]---
> > 
> > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > Cc: <stable@vger.kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Sasha Levin <sashal@kernel.org>
> > ---
> >  arch/arm64/kernel/machine_kexec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec.c
> > b/arch/arm64/kernel/machine_kexec.c
> > index a0b144cfaea7..8ab263c733bf 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -236,7 +236,7 @@ static void machine_kexec_mask_interrupts(void)
> >  		    chip->irq_eoi)
> >  			chip->irq_eoi(&desc->irq_data);
> > 
> > -		if (chip->irq_mask)
> > +		if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
> >  			chip->irq_mask(&desc->irq_data);
> > 
> >  		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
>
> This is pretty dodgy. irq_mask() should be an idempotent action
> (masking twice must not be harmful).
>

That was my understanding too, but was not totally against adding
it here.

> Even more, it really isn't obvious to me how this can work at all,
> as even if the interrupt isn't masked, the irqsteer could well be
> suspended.
>

Indeed, the runtime PM ops in that driver looks dodgy. Any calls to
mask_irq from drivers or anywhere with irqchip suspended with just
blows up the system.

> So as is, this change is just papering over a much deeper issue
> in your driver.
>

Thanks for confirming

--
Regards,
Sudeep
