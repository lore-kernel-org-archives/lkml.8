Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1825220747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFKMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:47:13 -0400
Received: from foss.arm.com ([217.140.110.172]:51880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgFKMrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:47:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16721FB;
        Thu, 11 Jun 2020 05:47:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.13.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168F73F66F;
        Thu, 11 Jun 2020 05:47:06 -0700 (PDT)
Date:   Thu, 11 Jun 2020 13:47:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     ??? <wooy88.kim@samsung.com>
Cc:     'Dave Martin' <Dave.Martin@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
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
Message-ID: <20200611124704.GC53118@C02TD0UTHF1T.local>
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
 <20200605073052.23044-1-wooy88.kim@samsung.com>
 <20200605103705.GD85498@C02TD0UTHF1T.local>
 <20200608103340.GA31466@arm.com>
 <000001d63fd1$23430d80$69c92880$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d63fd1$23430d80$69c92880$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 06:17:32PM +0900, ??? wrote:
> > On Fri, Jun 05, 2020 at 11:37:05AM +0100, Mark Rutland wrote:
> > > Please introduce the problem you are trying to solve in more detail.
> > > We already have kernel_neon_{begin,end}() for kernel-mode NEON; why is
> > > that not sufficient for your needs? Please answer this before
> > > considering other details.
> > >
> > > What do you want to use this for?
> 
> > Ack, this looks supicious.  Can you explain why your usecase _requires_
> > FPSIMD in hardirq context?
> > 
> > For now, these functions are strictly for EFI use only and should never be
> > used by modules.
> 
> I am in charge of camera driver development in Samsung S.LSI division.
> 
> In order to guarantee real time processing
> such as Camera 3A algorithm in current or ongoing projects,
> prebuilt binary is loaded and used in kernel space, rather than user space.
> Because the binary is built with other standard library which could use
> FPSIMD register,
> kernel API should keep the original FPSIMD state for other user tasks.
> It is mostly used for internal kernel operation including hardirq context.
> (ex> hardIRQ context, kernel API called by user, kernel task)

That sounds incredibly dodgy to me, both from a correctness perspective
and a licensing perspective. Upstream doesn't support out-of-tree
modules, nor does upstream support binary blobs within the kernel, so
the above cannot justify this change to the kernel.

If you wish to do such processing within the kernel, I think you'll need
to post a more complete in-tree solution for inclusion in mainline.
However, I suspect that it will be difficult to justify NEON in hardirq
context given preempt rt and friends.

Thanks,
Mark.
