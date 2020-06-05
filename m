Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA592075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFEKhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:37:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEKhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 574262B;
        Fri,  5 Jun 2020 03:37:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880453F52E;
        Fri,  5 Jun 2020 03:37:08 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:37:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wooyeon Kim <wooy88.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, hk92.kim@samsung.com,
        Wooki Min <wooki.min@samsung.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, yb.song@samsung.com,
        yj.yim@samsung.com, Julien Grall <julien.grall@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sanghoon Lee <shoon114.lee@samsung.com>,
        jinsoo37.kim@samsung.com, hyewon.ryu@samsung.com,
        yhwan.joo@samsung.com, Anisse Astier <aastier@freebox.fr>,
        Marc Zyngier <maz@kernel.org>, dongww.kim@samsung.com,
        linux-arm-kernel@lists.infradead.org, jihun.kim@samsung.com,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        junik.lee@samsung.com, sgun.bae@samsung.com,
        Jeongtae Park <jtp.park@samsung.com>, kgene.kim@samsung.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Steve Capper <steve.capper@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        hyeyeon5.shim@samsung.com, dh.han@samsung.com
Subject: Re: [PATCH] arm64: fpsimd: Added API to manage fpsimd state inside
 kernel
Message-ID: <20200605103705.GD85498@C02TD0UTHF1T.local>
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
 <20200605073052.23044-1-wooy88.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605073052.23044-1-wooy88.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wooyeon,

There are a *lot* of people Cc' here, many of whomo will find this
irrelevant. Please try to keep the Cc list constrained to a reasonable
number of interested parties.

On Fri, Jun 05, 2020 at 04:30:52PM +0900, Wooyeon Kim wrote:
> From: Wooki Min <wooki.min@samsung.com>
> 
>      This is an patch to use FPSIMD register in Kernel space.
>      It need to manage to use FPSIMD register without damaging it
>      of the user task.
>      Following items have been implemented and added.

Please introduce the problem you are trying to solve in more detail. We
already have kernel_neon_{begin,end}() for kernel-mode NEON; why is that
not sufficient for your needs? Please answer this before considering
other details.

What do you want to use this for?

> 
>      1. Using FPSIMD in ISR (in_interrupt)
> 	It can used __efi_fpsimd_begin/__efi_fpsimd_end
> 	which is already implemented.
> 	Save fpsimd state before entering ISR,
> 	and restore fpsimd state after ISR ends.
> 	For use in external kernel module,
> 	it is declared as EXPORT_SYMBOL.

This patch adds no in-tree modular users of this, so per the usual
conventions, NAK to EXPORT_SYMBOL().

Thanks,
Mark.
