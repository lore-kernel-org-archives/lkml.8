Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB792C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C814D2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFHKeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:34:11 -0400
Received: from foss.arm.com ([217.140.110.172]:50944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgFHKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2E11FB;
        Mon,  8 Jun 2020 03:34:10 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0333F73D;
        Mon,  8 Jun 2020 03:34:05 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:34:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wooyeon Kim <wooy88.kim@samsung.com>, hk92.kim@samsung.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, yb.song@samsung.com,
        yj.yim@samsung.com, Julien Grall <julien.grall@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, jinsoo37.kim@samsung.com,
        hyewon.ryu@samsung.com, yhwan.joo@samsung.com,
        Anisse Astier <aastier@freebox.fr>,
        Marc Zyngier <maz@kernel.org>,
        Allison Randal <allison@lohutok.net>, dongww.kim@samsung.com,
        Sanghoon Lee <shoon114.lee@samsung.com>, jihun.kim@samsung.com,
        hyeyeon5.shim@samsung.com, Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Wooki Min <wooki.min@samsung.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        junik.lee@samsung.com, sgun.bae@samsung.com,
        Jeongtae Park <jtp.park@samsung.com>, kgene.kim@samsung.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, dh.han@samsung.com
Subject: Re: [PATCH] arm64: fpsimd: Added API to manage fpsimd state inside
 kernel
Message-ID: <20200608103340.GA31466@arm.com>
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
 <20200605073052.23044-1-wooy88.kim@samsung.com>
 <20200605103705.GD85498@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605103705.GD85498@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:37:05AM +0100, Mark Rutland wrote:
> Hi Wooyeon,
> 
> There are a *lot* of people Cc' here, many of whomo will find this
> irrelevant. Please try to keep the Cc list constrained to a reasonable
> number of interested parties.
> 
> On Fri, Jun 05, 2020 at 04:30:52PM +0900, Wooyeon Kim wrote:
> > From: Wooki Min <wooki.min@samsung.com>
> > 
> >      This is an patch to use FPSIMD register in Kernel space.
> >      It need to manage to use FPSIMD register without damaging it
> >      of the user task.
> >      Following items have been implemented and added.
> 
> Please introduce the problem you are trying to solve in more detail. We
> already have kernel_neon_{begin,end}() for kernel-mode NEON; why is that
> not sufficient for your needs? Please answer this before considering
> other details.
> 
> What do you want to use this for?
> 
> > 
> >      1. Using FPSIMD in ISR (in_interrupt)
> > 	It can used __efi_fpsimd_begin/__efi_fpsimd_end
> > 	which is already implemented.
> > 	Save fpsimd state before entering ISR,
> > 	and restore fpsimd state after ISR ends.
> > 	For use in external kernel module,
> > 	it is declared as EXPORT_SYMBOL.
> 
> This patch adds no in-tree modular users of this, so per the usual
> conventions, NAK to EXPORT_SYMBOL().

Ack, this looks supicious.  Can you explain why your usecase _requires_
FPSIMD in hardirq context?

For now, these functions are strictly for EFI use only and should never
be used by modules.

Cheers
---Dave
