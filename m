Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAE720849
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgEUN0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:26:46 -0400
Received: from foss.arm.com ([217.140.110.172]:46778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgEUN0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:26:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B24D6E;
        Thu, 21 May 2020 06:26:45 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 169BB3F305;
        Thu, 21 May 2020 06:26:43 -0700 (PDT)
Date:   Thu, 21 May 2020 14:26:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, john.garry@huawei.com,
        shawnguo@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Message-ID: <20200521132641.GB47848@C02TD0UTHF1T.local>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus>
 <20200520073304.GA23534@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520073304.GA23534@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:33:04AM +0100, Will Deacon wrote:
> On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
> > On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > > +static ssize_t ddr_perf_identifier_show(struct device *dev,
> > > +					struct device_attribute *attr,
> > > +					char *page)
> > > +{
> > > +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> > > +
> > > +	return sprintf(page, "%s\n", pmu->devtype_data->identifier);
> > 
> > Why do we need yet another way to identify the SoC from userspace?
> 
> I also really dislike this. What's the preferred way to identify the SoC
> from userspace? It's needed so that the perf userspace tool can describe
> perf events that are supported for the PMU, as this isn't probe-able
> directly from the hardware. We have the same issue with the SMMUv3 PMCG [1],
> and so we need to solve the problem for both DT and ACPI.

Worth noting that while in this case it happens to identify the SoC,
in general you can have distinct instances of system IP in a single
system, so I do think that we need *something* instance-specific, even
if that's combined with SoC info.

Where IP gets reused across SoCs, it makes sense for that to not depend
on top-level SoC info.

Thanks,
Mark.

> 
> Will
> 
> [1] https://lore.kernel.org/r/1587120634-19666-1-git-send-email-john.garry@huawei.com
