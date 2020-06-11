Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10453C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BE62083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFKOLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:11:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFKOLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E45301F1;
        Thu, 11 Jun 2020 07:11:11 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C0F3F6CF;
        Thu, 11 Jun 2020 07:11:08 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:11:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Wooyeon Kim <wooy88.kim@samsung.com>
Cc:     'Dave Martin' <Dave.Martin@arm.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Bhupesh Sharma' <bhsharma@redhat.com>,
        'Julien Grall' <julien.grall@arm.com>,
        'Vincenzo Frascino' <vincenzo.frascino@arm.com>,
        'Will Deacon' <will@kernel.org>, yhwan.joo@samsung.com,
        'Anisse Astier' <aastier@freebox.fr>,
        'Marc Zyngier' <maz@kernel.org>,
        'Allison Randal' <allison@lohutok.net>,
        'Sanghoon Lee' <shoon114.lee@samsung.com>,
        jihun.kim@samsung.com, 'Kees Cook' <keescook@chromium.org>,
        'Suzuki K Poulose' <suzuki.poulose@arm.com>,
        'Wooki Min' <wooki.min@samsung.com>,
        'Kristina Martsenko' <kristina.martsenko@arm.com>,
        'Jeongtae Park' <jtp.park@samsung.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        'Steve Capper' <steve.capper@arm.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, 'James Morse' <james.morse@arm.com>,
        'Sudeep Holla' <sudeep.holla@arm.com>, dh.han@samsung.com
Subject: Re: [PATCH] arm64: fpsimd: Added API to manage fpsimd state inside
 kernel
Message-ID: <20200611141101.GA31408@gaia>
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
 <20200605073052.23044-1-wooy88.kim@samsung.com>
 <20200605103705.GD85498@C02TD0UTHF1T.local>
 <20200608103340.GA31466@arm.com>
 <001401d63fd4$95646690$c02d33b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401d63fd4$95646690$c02d33b0$@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 06:42:12PM +0900, Wooyeon Kim wrote:
> I am in charge of camera driver development in Samsung S.LSI division.
> 
> In order to guarantee real time processing such as Camera 3A algorithm in
> current or ongoing projects, prebuilt binary is loaded and used in kernel
> space, rather than user space.

Thanks for the additional details.

If you do such intensive processing in an IRQ context you'd probably
introduce additional IRQ latency. Wouldn't offloading such work to a
real-time (user) thread help? In a non-preempt-rt kernel, I don't think
you can get much in terms of (soft) guarantees for IRQ latency anyway.

> Because the binary is built with other standard library which could use
> FPSIMD register, kernel API should keep the original FPSIMD state for other
> user tasks.

Can you not recompile those libraries not to use FP?

As Mark said, for a kernel API we require at least an in-kernel,
upstreamed, user of that functionality.

> In the case of the kernel_neon_begin / kernel_neon_end that you mentioned,
> there is a limitation that cannot be used in hardirq context.
> Also, if another kernel task switching occurs while kernel API is being
> used, fpsimd register corruption may occur.

kernel_neon_begin/end disable preemption, so you can't have a task
switch (you can have interrupts though but we don't allow FPSIMD in IRQ
context).

-- 
Catalin
