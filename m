Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122DC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E03207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580276955;
	bh=EOmr9+h3FKBEr7USHJlKgjOW/DsS8L2m+JUzkoI+K9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AAK4xTAlaAKwQghJVbGW0m9lLyBQB2O01DP15lQcPpfbzv6mwx0gOlp+OG8XgnrOc
	 x5C8CIyx0btTm2C0prXZdw+UYZYyrIeKYIUNJmL0VIrr5GW4MpPIXHGDR/yBaVLEQU
	 wlOfYlT7u6qhKnwMzMAsZSjr7gWbuKxT/cCPpSaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgA2FtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:49:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E652071E;
        Wed, 29 Jan 2020 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580276953;
        bh=EOmr9+h3FKBEr7USHJlKgjOW/DsS8L2m+JUzkoI+K9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQi8yP6OcruU4bHYp0E9eoPEgHZ3TU7AtcIgQASns0fNUpt/byNWEaOlTuAxs9dCL
         TrKfCNjj1fsqL+VBT1VOWhuHhz175FI99WPMO4yMEbENMUG3U2qBNUzlrqWKGUiQ3x
         4Xfe2+zN93ruTPYDEQAZmubinav4wtaImlY+rOv8=
Date:   Wed, 29 Jan 2020 06:49:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Message-ID: <20200129054909.GB3765925@kroah.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 08:29:45PM +0000, Benjamin GAIGNARD wrote:
> 
> On 1/28/20 5:57 PM, Greg KH wrote:
> > On Tue, Jan 28, 2020 at 04:41:29PM +0000, Benjamin GAIGNARD wrote:
> >> On 1/28/20 4:52 PM, Greg KH wrote:
> >>> On Tue, Jan 28, 2020 at 04:38:01PM +0100, Benjamin Gaignard wrote:
> >>>> The goal of this framework is to offer an interface for the
> >>>> hardware blocks controlling bus accesses rights.
> >>>>
> >>>> Bus firewall controllers are typically used to control if a
> >>>> hardware block can perform read or write operations on bus.
> >>> So put this in the bus-specific code that controls the bus that these
> >>> devices live on.  Why put it in the driver core when this is only on one
> >>> "bus" (i.e. the catch-all-and-a-bag-of-chips platform bus)?
> >> It is really similar to what pin controller does, configuring an
> >> hardware block given DT information.
> > Great, then use that instead :)
> I think that Linus W. will complain if I do that :)
> >
> >> I could argue that firewalls are not bus themselves they only interact
> >> with it.
> > They live on a bus, and do so in bus-specific ways, right?
> >
> >> Bus firewalls exist on other SoC, I hope some others could be added in
> >> this framework. ETZPC is only the first.
> > Then put it on the bus it lives on, and the bus that the drivers for
> > that device are being controlled with.  That sounds like the sane place
> > to do so, right?
> 
> If that means that all drivers have to be modified it will be 
> problematic because not all
> 
> are specifics to the SoC.

That's fine, we have loads of drivers that work on different types of
busses.

Or, if this really is the "platform bus" then use that.  (which is what
I was hinting at all along but no one seems to realize that, should have
been more obvious...)

> >>> And really, this should just be a totally new bus type, right?  And any
> >>> devices on this bus should be changed to be on this new bus, and the
> >>> drivers changed to support them, instead of trying to overload the
> >>> platform bus with more stuff.
> >> I have tried to use the bus notifier to avoid to add this code at probe
> >> time but without success:
> >>
> >> https://lkml.org/lkml/2018/2/27/300
> > Almost 2 years ago?  I can't remember something written 1 week ago...
> >
> > Yes, don't abuse the notifier chain.  I hate that thing as it is.
> >
> >> I have also tried to disable the nodes at runtime and Mark Rutland
> >> explain me why it was wrong.
> > The bus controller should do this, right?  Why not just do it there?
> 
> The bus controller is a different hardware block.

Of course it is, but it controls a bus, and there are devices on that
bus, right?  Don't circumvent things please.

greg k-h
