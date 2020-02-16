Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A89C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ABB20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581855621;
	bh=PHE098dmEFXu6oYKRN+BUb6ZDWnNqCSxtkdjvGF2pTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nua83AkxwpN7brKpn+n74VGr/oWLcW2Zo5DfQjkMc0eodqN6fToV/NrHCEC9/dC/x
	 rGDyCAoGwM/QW7sigKGCW7UOdkjUK+8B0bjyYl0Qfd9nH7oe/5GatnLWpWTFYZwONM
	 zaa/FquGxMtkiBQwQI2xsh3PoQZDKfbQ86yVXJG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBPMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 07:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBPMUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 07:20:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C246E2084E;
        Sun, 16 Feb 2020 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581855618;
        bh=PHE098dmEFXu6oYKRN+BUb6ZDWnNqCSxtkdjvGF2pTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLB4k6d5m716NQ/OnptZFHwuDttAwPI5QM5iXZt/PFVxpU9IuVtZr1BpdVnH+/2S/
         fCGJbSX4O4LkA5jjwca8DDCoj4/edZOOOW9vL2KcChpkh/W9ahYgUb8Pf7bhDifY3l
         GzmT3SHkFhHgNH3Q7kf3XpjCLyXkZjJ1LKc+bHhw=
Date:   Sun, 16 Feb 2020 08:21:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Grant Likely <grant.likely@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Message-ID: <20200216072111.GA14598@kroah.com>
References: <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com>
 <20200129111717.GA3928@sirena.org.uk>
 <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
 <20200131090650.GA2267325@kroah.com>
 <CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com>
 <20200214214051.GA4192967@kroah.com>
 <409eb745-aab2-86a7-bd3a-9e8e05bed057@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409eb745-aab2-86a7-bd3a-9e8e05bed057@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 12:41:07PM +0000, Benjamin GAIGNARD wrote:
> 
> On 2/14/20 10:40 PM, Greg KH wrote:
> > On Fri, Feb 14, 2020 at 05:05:07PM +0100, Linus Walleij wrote:
> >> On Fri, Jan 31, 2020 at 10:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >>> Why do people want to abuse the platform bus so much?  If a device is on
> >>> a bus that can have such a controller, then it is on a real bus, use it!
> >> I'm not saying it is a good thing, but the reason why it is (ab)used so
> >> much can be found in:
> >> drivers/of/platform.c
> >>
> >> TL;DR: struct platform_device is the Device McDeviceFace and
> >> platform bus the Bus McBusFace used by the device tree parser since
> >> it is slightly to completely unaware of what devices it is actually
> >> spawning.
> > <snip>
> >
> > Yeah, great explaination, and I understand.  DT stuff really is ok to be
> > on a platform bus, as that's what almost all of them are.
> >
> > But, when you try to start messing around with things like this
> > "firewall" says it is doing, it's then obvious that this really isn't a
> > DT like thing, but rather you do have a bus involved with a controller
> > so that should be used instead.
> 
> Ok but how put in place a new bus while keeping the devices on platform
> bus to avoid changing all the drivers ?

You don't, you put them all on your real bus, as that is what you now
have.

> > Or just filter away the DT stuff so that the kernel never even sees
> > those devices, which might just be simplest :)
> 
> yes but we lost the possibility to change the firewall configuration at
> run time. I do expect to be able to describe in the DT firewall configuration
> and to use them at run time. That could allow, for example, to handover
> a HW block to the coprocessor when the main core is going to be suspended
> to save power.

Then use a real bus :)

thanks,

greg k-h
