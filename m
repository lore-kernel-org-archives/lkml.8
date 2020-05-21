Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8ADC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B26B2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590066262;
	bh=MRCEC+nXdSDz6i5TZrMw6mLNWWrHvA60N+e767YVxns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OoU9zrbnop/PaLqucH75gGjUksD7wyKwewLb8gg6Fucd7AYqAmyS9yPRiaM6brSlk
	 bU9LAzfMz9Yp7x6TRiW6zs9DZEqpk37lBqHBfkbu5luH8Hgr4Ad3towatqNwuL/4fP
	 6+yClQ6mQzIyd3KaVCa9RB+pFYAyrTiKi9/AvQn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgEUNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgEUNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:04:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931022072C;
        Thu, 21 May 2020 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590066261;
        bh=MRCEC+nXdSDz6i5TZrMw6mLNWWrHvA60N+e767YVxns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmu3epPATx/GzY3jREbvlRwGrVQu7NJk8uFE7w/S8G1BcG1hgzymFGCxBxB3viHil
         R4Hecc/Gx26n2kk2sBrr248PsSUtFBnxZcpkpZTD3fq88XA76zFMe4Kr03Js3lMNcM
         cHsdSest9biXfmMIG+b2eQph4k3krZ8JUH+dhwf0=
Date:   Thu, 21 May 2020 14:04:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Message-ID: <20200521130415.GB5949@willie-the-truck>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus>
 <20200520073304.GA23534@willie-the-truck>
 <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:23:41AM -0600, Rob Herring wrote:
> On Wed, May 20, 2020 at 1:33 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
> > > On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > > > +static ssize_t ddr_perf_identifier_show(struct device *dev,
> > > > +                                   struct device_attribute *attr,
> > > > +                                   char *page)
> > > > +{
> > > > +   struct ddr_pmu *pmu = dev_get_drvdata(dev);
> > > > +
> > > > +   return sprintf(page, "%s\n", pmu->devtype_data->identifier);
> > >
> > > Why do we need yet another way to identify the SoC from userspace?
> >
> > I also really dislike this. What's the preferred way to identify the SoC
> > from userspace?
> 
> /proc/cpuinfo? ;)

The *SoC*!

> For an non-firmware specific case, I'd say soc_device should be. I'd
> guess ACPI systems don't use it and for them it's dmidecode typically.
> The other problem I have with soc_device is it is optional.

John -- what do you think about using soc_device to expose this information,
with ACPI systems using DMI data instead?

Will
