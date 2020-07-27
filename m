Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7D2206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xt1tz2xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgG0Pnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgG0Pnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:43:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33188C061794;
        Mon, 27 Jul 2020 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DTiJ9DCKSihE4ycmCvc3MBz3EguzZmtKetvhRYWhQ6s=; b=xt1tz2xi4gFW1RBYpqonj0wO2
        Vhy82d52V/bO7PkJUW4NbK7p9SnY59C+3iPXG6bdK7L6MDy75jmSLRmUK1LT/rrwDfbmRXEmBoML/
        l6ffTZkhsJitXdhUeWM2HSCSHhHGmHEbY682TCBWO+mny9ybadR8497BWvxGvccE4pkyqT8vOu580
        +dUp6Gs8QEkDsjnraaOBYbQNvY1rjID70opjpsqtj/cwXf0XYSilmK+kFAgx82cteXuOGB6acUuAo
        avLfdgmogGQ8hMyq1c6RmT+5iAn2y6HV3hd60P2oNixKLymg+h7oC7moU4uSXN/oBh3MI7tl0pKT3
        NAaTsyBYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44858)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k05Hs-00031S-09; Mon, 27 Jul 2020 16:43:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k05Hr-0003mQ-5e; Mon, 27 Jul 2020 16:43:35 +0100
Date:   Mon, 27 Jul 2020 16:43:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, miguelborgesdefreitas@gmail.com,
        a.zummo@towertech.it, baruch@tkos.co.il, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727154335.GL1551@shell.armlinux.org.uk>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk>
 <20200727154104.GE239143@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727154104.GE239143@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:41:04PM +0200, Alexandre Belloni wrote:
> On 27/07/2020 16:24:39+0100, Russell King - ARM Linux admin wrote:
> > On Mon, Jul 27, 2020 at 04:49:38PM +0200, Alexandre Belloni wrote:
> > > On 27/07/2020 10:45:53+0100, Russell King - ARM Linux admin wrote:
> > > > > This is but this shouldn't be a DT property as it has to be changed
> > > > > dynamically. I'm working on an ioctl interface to change this
> > > > > configuration.
> > > > 
> > > > Why does it need to be changed dynamically?  If the hardware components
> > > > are not fitted to allow the RTC to be safely used without DSM, then
> > > > why should userspace be able to disable DSM?
> > > 
> > > For RTCs with a standby mode, you want to be able to return to standby
> > > mode.
> > > 
> > > That would happen for example after factory flashing in that common use
> > > case:
> > >  - the board is manufactured
> > >  - Vbackup is installed, the RTC switches to standby mode
> > >  - the board is then booted to flash a system, Vprimary is now present,
> > >    the RTC switches to DSM.
> > > 
> > > At this point, if the board is simply shut down, the RTC will start
> > > draining Vbackup before leaving the factory. Instead, we want to be able
> > > to return to standby mode until the final user switches the product on
> > > for the first time.
> > 
> > I don't think you're understanding what's going on with this proposed
> > patch.  The cubox-i does work today, and the RTC does survive most
> > power-downs. There are situations where it doesn't.
> > 
> > So, let's take your process above.
> > 
> > - the board is manufactured
> > - Vbackup is installed, the RTC switches to standby mode
> > - the board is then booted to flash a system, Vprimary is now present
> > - the board is powered down.  the RTC _might_ switch over to battery
> >   if it notices the power failure in time, or it might not.  A random
> >   sample of units leaving the factory have the RTC in standby mode.
> >   Others are draining the battery.
> > 
> > I'm not saying what you propose isn't a good idea.  I'm questioning
> > why we should expose this in the generic kernel on platforms where
> > it's likely to end up with the RTC being corrupted.
> > 
> 
> Note that I didn't say we should expose settings that are not working
> but it is a different discussion.

It isn't a different discussion - that is exactly what the point of
my emails to you all along have been!

So, can we please have that discussion, it is pertinent to this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
