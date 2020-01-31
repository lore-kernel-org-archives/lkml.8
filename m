Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A5A20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580461614;
	bh=V7vDxMmmNX8/A1ufnjJg7tEfNXHbzelUW1ofiI0bxCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ykg1Y16iKsHPIYuz7fSk//fNyQhqIZE4Om10Nla+tqIrao/ZoyMqL6UUZu5bljjJw
	 Zgb2ppFKij1DdElalyY41fqV3IdClPWku8zVuPEEKNwsOc6OczQi5JXZzJyCtKp6oR
	 BN/Z9fVqNh04+RspMfbJxWA+/13pHnwIjcO8GK78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgAaJGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgAaJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:06:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551E5206F0;
        Fri, 31 Jan 2020 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580461612;
        bh=V7vDxMmmNX8/A1ufnjJg7tEfNXHbzelUW1ofiI0bxCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0OJFeMQhpY0sXS4zKX09ro+1I0G5B1zntn688rrb6fejMrX5MpTjefojd56PxR47
         Cw8hOA8PzmnyJwKYIJsmrolmv4wa4yXRi1RiuZB+V1u8IvySYxMHUYNUwqG+E6s6vt
         txWo1RkgBOlq4TGaf3Vn9xq5d6tPdnJj/B5jv60c=
Date:   Fri, 31 Jan 2020 10:06:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20200131090650.GA2267325@kroah.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com>
 <20200129111717.GA3928@sirena.org.uk>
 <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:37:27AM +0000, Benjamin GAIGNARD wrote:
> 
> On 1/29/20 12:17 PM, Mark Brown wrote:
> > On Wed, Jan 29, 2020 at 10:52:40AM +0100, Greg KH wrote:
> >
> >> It just needs to be part of the bus logic for the specific bus that this
> >> "firewall" is on.  Just like we do the same thing for USB or thunderbolt
> >> devices.  Put this in the bus-specific code please.
> > I'd expect that this is going to affect at least platform and AMBA
> > buses.
> 
> Correct me if I'm wrong but creating a new type of bus would mean
> that all the drivers living on this bus must be changed to register 
> themselves on this bus ?

Yes.

> Or does a solution exist to let them live on the platform bus and call 
> firewalled bus before been probed ?

Why do people want to abuse the platform bus so much?  If a device is on
a bus that can have such a controller, then it is on a real bus, use it!

> All the impacted drivers could work on the existing bus with or without 
> the firewall so I don't want to break

break what?

> 
> that.

Odd line-break :)

Just register the driver on both busses, no big deal.

Stop abusing the platform bus code for things that it is not for.

thanks,

greg k-h
