Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39229C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA582078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588833800;
	bh=eoewxEcztPKZgseIqH5a8ofrxeV00nYAqCkx5/jYb3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aGbiJFl51QvaWtW1f4WMBf7O5nLAjM0zJpMj1L3MeFQ4ypu+/7prLyL3ByqlanPnr
	 5avkSazQu0O7ys1bJSPy1a8JQfejj/WSpNAFU47lbeq6wnSGWphi8Hm2TWG+zN3rDj
	 /ZW/x2Ivu58AxQ55Dh4CXsneBGi+DTuV2T6bLTrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEGGnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgEGGnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:43:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B3620753;
        Thu,  7 May 2020 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588833798;
        bh=eoewxEcztPKZgseIqH5a8ofrxeV00nYAqCkx5/jYb3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPvD8KgwxMH5sL4bPiyyMBBEfy5TBjmlq04Aw0XMsUJjEQ8jvSzlTzfHiEmKlHW+r
         2ahOmscHtP7Qc1qH/Is0de9nXTf57xUtlFyEC5mTta8lWBwRXQFeYPrT54AURx+oOT
         36QF7pPCbOA45gItKGPKpB0Uf6Mka4US0fky+UOE=
Date:   Thu, 7 May 2020 08:43:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
Message-ID: <20200507064316.GC777100@kroah.com>
References: <20200430111258.6091-1-alcooperx@gmail.com>
 <20200430111258.6091-4-alcooperx@gmail.com>
 <20200505110036.GB93160@kroah.com>
 <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:23:01PM -0400, Alan Cooper wrote:
> > > +     irq = platform_get_irq(pdev, 0);
> > > +     if (irq < 0)
> >
> > "<=" right?
> 
> The example in the comment above platform_get_irq in platform.c says
> "if (irq < 0)"

There is work to fix that up on the mailing lists, 0 is not a valid irq :)

> > > +static int __init ehci_brcm_init(void)
> > > +{
> > > +     if (usb_disabled())
> > > +             return -ENODEV;
> >
> > You check this here, so why are you also checking it in the probe
> > function?
> 
> Good point. I'll remove the one in probe. This was another thing that
> came from the ehci and ohci platform drivers.  About a third of the
> drivers in this directory do this, probably because they started with
> the platform drivers. Do you think it's worth me submitting a patch to
> clean this up at some point?

Yes please.

> 
> >
> > thanks,
> >
> > greg k-h
> 
> I'll wait for your response before sending a V7.

Never wait for someone who you have no idea how much email they get :)

thanks,

greg k-h
