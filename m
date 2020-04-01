Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C932080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgDAL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:27:46 -0400
Received: from foss.arm.com ([217.140.110.172]:49442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgDAL1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:27:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0995930E;
        Wed,  1 Apr 2020 04:27:44 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF783F68F;
        Wed,  1 Apr 2020 04:27:42 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:27:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Tuan Phan <tuanphan@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200401112739.GD17163@C02TD0UTHF1T.local>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
 <20200320105315.GA35932@C02TD0UTHF1T.local>
 <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
 <20200401095226.GA17163@C02TD0UTHF1T.local>
 <20200401102724.GA17575@willie-the-truck>
 <4d843ec7-ed74-4431-d8c7-d5aa6bd83c18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d843ec7-ed74-4431-d8c7-d5aa6bd83c18@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:12:23PM +0100, Robin Murphy wrote:
> On 2020-04-01 11:27 am, Will Deacon wrote:
> > On Wed, Apr 01, 2020 at 10:52:26AM +0100, Mark Rutland wrote:
> > > On Tue, Mar 31, 2020 at 03:14:59PM -0700, Tuan Phan wrote:
> > > > I looked at the SMMUv3 PMU driver and it also uses IRQF_SHARED. SMMUv3
> > > > PMU and DMC620 PMU are very much similar in which counters can be
> > > > accessed by any cores using memory map. Any special reasons
> > > > IRQF_SHARED works with SMMUv3 PMU driver?
> > > 
> > > No; I believe that is a bug in the SMMUv3 PMU driver. If the IRQ were
> > > shared, and another driver that held the IRQ changed the affinity,
> > > things would go very wrong.
> > 
> > I *think* the idea is that the SMMUv3 PMU driver manages multiple PMCG
> > devices, which may all share an irq line, rather than the irq line being
> > shared by some other driver that might change the affinity. So I suspect
> > dropping IRQF_SHARED will break things.
> 
> Each PMCG is conceptually a distinct PMU with its own interrupt - for
> instance, MMU-600 has one PMCG for its TCU and one for each TBU, each with a
> distinct interrupt output signal. Of course, integrators can and will mash
> them all together into a single SPI (particularly since they're all part of
> "the SMMU"), but that boils down to the same case as here.
> 
> This is going to continue to happen, so we could really do with figuring out
> a way to let MMIO system PMU drivers properly cope with shared interrupts in
> general :/

It does seem so, but I think we can only reasonably do that where it's
only being shared across instances of the same driver, rather than when
the IRQ is muxed across completely independent drivers. I'd like to
avoid that latter case if we can.

The driver would have to handle migration on a cross-instance basis.
e.g. all the contexts need to be migrated before the IRQ is, to avoid a
screaming IRQ on the target CPU, or the IRQ handler on the target racing
with migration from the source.

Is there a neat way to do that in a driver without using IRQF_SHARED, so
that we don't end up accidentally sharing with other drivers? We can
probably librify the code to handle this under drivers/pmu/.

Thanks,
Mark.
