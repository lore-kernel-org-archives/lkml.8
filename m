Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFACBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0725206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594895465;
	bh=I4dTQBrnodALq8P0qz+UQRJ3T5gEQmUi6IPIDUy1meg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VtMLA70sPbCjbx2xdretNUmndg6JsUoacqjKr/Het4JbjDmdw14dITcFWF++IzfEo
	 koEwEKRg5u4ulnEHH/kgJUh2NvQyzX0kalazZRYIm9kvDdjAuTbT1GsWG7J0AHqbOc
	 /yPMDpLzyUic+uY5H1zaYoLqAtFdh/cpKHWOpAcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGPKbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgGPKbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:31:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82AD2065D;
        Thu, 16 Jul 2020 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594895463;
        bh=I4dTQBrnodALq8P0qz+UQRJ3T5gEQmUi6IPIDUy1meg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQRv2fEJmtV5M30Lx6P6L4E4+ujyB+W6Fz5SJmIfLSeDES1/5LXrpnhZMqfZLSFf6
         VPTI+clOYCJGtXMFgi9J56Mb/qwXD3h5qWbwOCvxJx0WgpvLzOuAz2tBERfUAcjHJ1
         JYLwHHbIO5FDxFwOC64JE/PjLsyaG9VOKyK9Su2k=
Date:   Thu, 16 Jul 2020 11:30:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Qi Liu <liuqi115@huawei.com>, mark.rutland@arm.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        wang.wanghaifeng@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
Message-ID: <20200716103058.GE7036@willie-the-truck>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
 <20200716094144.GC6771@willie-the-truck>
 <a0f3d0c2-6a08-16a5-f7e9-42ac1d96ea11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f3d0c2-6a08-16a5-f7e9-42ac1d96ea11@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:26:25AM +0100, Robin Murphy wrote:
> On 2020-07-16 10:41, Will Deacon wrote:
> > On Thu, Jul 16, 2020 at 05:19:25PM +0800, Qi Liu wrote:
> > > Kernel panic will also happen when users try to unbind PMU drivers with
> > > device. This unbind issue could be solved by another patch latter.
> > > 
> > >   drivers/perf/arm_smmuv3_pmu.c                 | 1 +
> > >   drivers/perf/fsl_imx8_ddr_perf.c              | 1 +
> > >   drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 1 +
> > >   drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 1 +
> > >   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 1 +
> > >   5 files changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> > > index 48e28ef..90caba56 100644
> > > --- a/drivers/perf/arm_smmuv3_pmu.c
> > > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > > @@ -742,6 +742,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> > >   	platform_set_drvdata(pdev, smmu_pmu);
> > > 
> > >   	smmu_pmu->pmu = (struct pmu) {
> > > +		.module		= THIS_MODULE,
> > 
> > I thought platform_driver_register() did this automatically?
> 
> For the platform device itself, yes, but this is for the PMU device - perf
> needs to take a reference to the module, otherwise the platform device can
> still be pulled out from under its feet.

Urgh, gross.

> I can't remember if we ever discussed making perf_pmu_register() do the same
> trick as platform_device_register() and friends, but obviously it's a
> possibility.

Yeah, but I suppose this patch is the right thing to do for now. I'll queue
it as a fix.

Will
