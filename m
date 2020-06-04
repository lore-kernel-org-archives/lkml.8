Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED51C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989962074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V2MTMQ2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFDJ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:29:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBECC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MgS8gWKu2xwJBHtlkgJWo+Yic1cWWOAH5Yb9qu9+1lI=; b=V2MTMQ2VnfpsIJFZXaMmTXG+W
        Num6U3FMJRpS82uvdHSlmZnqH7j2kPOAxMVpwZ+N2wn30N/ycOGfBlg5sB059EGPMdM/8USIlhL0/
        nocIWUdpFW1DIWL8zvVD8jDNSRVWa9Iv86QwF9/6lGHTb5Wgun0soBZt2KOBnSP6X+nLcmiHJynTV
        FOCCIlgClzsllwX59z5AEsDYNUTbcwjUhjNVFZK/G+ollIoECjsIdRw8ryqEubKElVqFiiHScuoOT
        n7eOIdEHUygUHqrTiG2+5fDlOpgg+PoVVfysHBfYXZjW27sWYQDaREptZ9xVOu39g+bc6NVV7i2VB
        qEBRgonFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41156)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jgmBK-0007jY-D5; Thu, 04 Jun 2020 10:29:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jgmBJ-0006KD-6z; Thu, 04 Jun 2020 10:29:01 +0100
Date:   Thu, 4 Jun 2020 10:29:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
Message-ID: <20200604092901.GE1551@shell.armlinux.org.uk>
References: <20200603173150.GB1551@shell.armlinux.org.uk>
 <jhjh7vshvwl.mognet@arm.com>
 <20200603184500.GC1551@shell.armlinux.org.uk>
 <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk>
 <jhjftbbj3qi.mognet@arm.com>
 <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
 <jhjeeqvi3m1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjeeqvi3m1.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:26:27AM +0100, Valentin Schneider wrote:
> 
> On 04/06/20 01:48, Thara Gopinath wrote:
> > Hi Russel/Valentin
> >
> > The feature itself like Valentin explained below allows scheduler to be
> > aware of cpu capacity reduced due to thermal throttling.
> > arch_set_thermal_pressure feeds the capped capacity to the scheduler and
> > hence the feature makes sense only if arch_set_thermal_pressure is
> > implemented. Having said that arch_set_thermal_pressure is implemented
> > in arch_topology driver for arm and arm64 platforms. But the feature
> > itself is not bound to arm/arm64 platforms. So it would make it wrong to
> > add a "depends on (ARM || ARM64) option."
> >
> > I agree with Vincent that allowing user to choose this option is
> > probably not the best. IMO, this should be enabled by default in arm64
> > defconfig considering both GENERIC_ARCH_TOPOLOGY and CPU_FREQ_THERMAL
> > are enabled by default.
> 
> Right, I had skimmed over that but it probably does make more sense not
> to bother users with it.
> 
> > So if it is acceptable three things to be done are:
> > 1. Add the help text.
> > 2. Don't allow SCHED_THERMAL_PRESSURE configurable by user
> > 3. Enable it by default in arm64 defconfig
> 
> ... and arm as well, I suppose?

If it's not a user visible option, then there's no point it being in
defconfig.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
