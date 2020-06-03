Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4647C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42E92074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TV9ewfNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFCSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:45:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AiPy53V6h1Oivo7tu+n6fDJ5NKi04giFj6hhH9RvvlU=; b=TV9ewfNUh79JaBAZMDU3270/0
        ZLCM2o1/xx5N2WSSyVShNt421sz8OXHZG2vgWPq5noPugob+kd0PeBUZVCYrr8UI7uSwVXHqhyNcO
        RfP9L1rzOda1bbJnqhg5OsdJuluVKc1RFkgsMQU3n2AiO/Td3CmIxuGOMDTx17r2li7NM8zmhf58v
        j5aGHivNTRR0vEvG4dhHKk8cOkzJmf54dr5CRv0DNaUPomD7nChe4uHemLk5YWGCI0trtmXe5s+hb
        SluksW3az6sBMpNqWuo+8uC6YpHzHNkr28H8jU8Ymx+9a9BFJa4m05TGTVNtLdPa++uFMxo79RDxR
        1c/ebxjZQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38460)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jgYNr-00066B-76; Wed, 03 Jun 2020 19:45:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jgYNo-0005ce-UV; Wed, 03 Jun 2020 19:45:00 +0100
Date:   Wed, 3 Jun 2020 19:45:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: v5.7: new core kernel option missing help text
Message-ID: <20200603184500.GC1551@shell.armlinux.org.uk>
References: <20200603173150.GB1551@shell.armlinux.org.uk>
 <jhjh7vshvwl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjh7vshvwl.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 07:00:26PM +0100, Valentin Schneider wrote:
> 
> On 03/06/20 18:31, Russell King - ARM Linux admin wrote:
> > Hi,
> >
> > A new kernel configuration option ("SCHED_THERMAL_PRESSURE") was
> > recently added, but has no help text. This is most unhelpful when
> > trying to configure the kernel, since one does not know what the
> > effect of answering yes or no to this option would be.
> >
> > Please supply a proper help text when adding core kernel options
> > so that people can make an informed decision when answering the
> > prompt, rather than just guessing.
> >
> 
> Right; does the below look good enough?

It's a start.  I'm still wondering whether I should answer yes or no
for the platforms I'm building for.

So far, all I've found is:

arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure

which really doesn't tell me anything about this.  So I'm still in
the dark.

I guess topology_get_thermal_pressure is provided by something in
drivers/ which will be conditional on some driver or something.

> 
> ---
> diff --git a/init/Kconfig b/init/Kconfig
> index 74a5ac65644f..f40cf852d00a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -441,6 +441,10 @@ config HAVE_SCHED_AVG_IRQ
>  config SCHED_THERMAL_PRESSURE
>         bool "Enable periodic averaging of thermal pressure"
>         depends on SMP
> +	help
> +	  This option allows the scheduler to be aware of CPU thermal throttling
> +	  (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
> +	  implemented.
> 
>  config BSD_PROCESS_ACCT
>         bool "BSD Process Accounting"
> ---
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
