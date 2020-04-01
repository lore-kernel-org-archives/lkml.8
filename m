Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BF4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56EE20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgDAJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:52:37 -0400
Received: from foss.arm.com ([217.140.110.172]:47414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgDAJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:52:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDB611FB;
        Wed,  1 Apr 2020 02:52:35 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96DBF3F52E;
        Wed,  1 Apr 2020 02:52:34 -0700 (PDT)
Date:   Wed, 1 Apr 2020 10:52:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200401095226.GA17163@C02TD0UTHF1T.local>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
 <20200320105315.GA35932@C02TD0UTHF1T.local>
 <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:14:59PM -0700, Tuan Phan wrote:
> > On Mar 20, 2020, at 4:25 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Mar 19, 2020 at 12:03:43PM -0700, Tuan Phan wrote:
> >>> On Mar 19, 2020, at 8:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>> On Tue, Mar 17, 2020 at 05:29:38PM -0700, Tuan Phan wrote:
> >>>> +static int arm_dmc620_pmu_dev_init(struct arm_dmc620_pmu *dmc620_pmu)
> >>>> +{
> >>>> +	struct platform_device *pdev = dmc620_pmu->pdev;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = devm_request_irq(&pdev->dev, dmc620_pmu->irq,
> >>>> +				arm_dmc620_pmu_handle_irq,
> >>>> +				IRQF_SHARED,
> >>>> +				dev_name(&pdev->dev), dmc620_pmu);
> >>> 
> >>> This should have IRQF_NOBALANCING | IRQF_NO_THREAD. I don't think we
> >>> should have IRQF_SHARED.
> >> => I agree on having IRQF_NOBALANCING and IRQF_NO_THREAD. But
> >> IRQF_SHARED is needed. In our platform all DMC620s share same IRQs and
> >> any cpus can access the pmu registers.
> > 
> > Linux needs to ensure that the same instance is concistently accessed
> > from the same CPU, and needs to migrate the IRQ to handle that. Given we
> > do that on a per-instance basis, we cannot share the IRQ with another
> > instance.
> > 
> > Please feed back to you HW designers that muxing IRQs like this causes
> > significant problems for software.
> 
> I looked at the SMMUv3 PMU driver and it also uses IRQF_SHARED. SMMUv3
> PMU and DMC620 PMU are very much similar in which counters can be
> accessed by any cores using memory map. Any special reasons
> IRQF_SHARED works with SMMUv3 PMU driver?

No; I believe that is a bug in the SMMUv3 PMU driver. If the IRQ were
shared, and another driver that held the IRQ changed the affinity,
things would go very wrong.

Note that it's also missing IRQF_NOBALANCING, which is also necessary to
avoid such issues.

Thanks,
Mark.
