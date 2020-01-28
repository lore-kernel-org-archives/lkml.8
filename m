Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D4C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA61A24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580230636;
	bh=0zx2j6Lsa9HwzHF4AoAgg97MA5gTZ+rv9fANMAw8vc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s4mRwTzgy6RTF+LSkjwjRV2GIj8vx3e/j2GDdiXHPBwJkmPLLuA/MtfYaxcpMVz+5
	 VZr+R+9WPLrihkLLX6T+dHsxXxIcxgXIV3PpR0yGwG/IvraI5uuHz+WNjiAM8DPTFE
	 aD3bFk6KSvy3gSHPWk4sHSBpoyvZB3eqre/26NpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgA1Q5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1Q5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:57:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD16214AF;
        Tue, 28 Jan 2020 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580230634;
        bh=0zx2j6Lsa9HwzHF4AoAgg97MA5gTZ+rv9fANMAw8vc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT54GEgub6xQ+dP1/kFc16jal8sv+sq/QzA3NbhbYxQo4EEtJbB311GkL0yZ1k6qL
         2Qz0YeWv1OD6dQr7NdpT404ix2ZEcx7+mxIghu5p6kgJTQgVvZiFPC2LXrSB+2xBJ9
         zMdfhIjclnj092JF68J3w0MHKFeYvqedJPNU9CMs=
Date:   Tue, 28 Jan 2020 17:57:12 +0100
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
Message-ID: <20200128165712.GA3667596@kroah.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:41:29PM +0000, Benjamin GAIGNARD wrote:
> 
> On 1/28/20 4:52 PM, Greg KH wrote:
> > On Tue, Jan 28, 2020 at 04:38:01PM +0100, Benjamin Gaignard wrote:
> >> The goal of this framework is to offer an interface for the
> >> hardware blocks controlling bus accesses rights.
> >>
> >> Bus firewall controllers are typically used to control if a
> >> hardware block can perform read or write operations on bus.
> > So put this in the bus-specific code that controls the bus that these
> > devices live on.  Why put it in the driver core when this is only on one
> > "bus" (i.e. the catch-all-and-a-bag-of-chips platform bus)?
> 
> It is really similar to what pin controller does, configuring an 
> hardware block given DT information.

Great, then use that instead :)

> I could argue that firewalls are not bus themselves they only interact 
> with it.

They live on a bus, and do so in bus-specific ways, right?

> Bus firewalls exist on other SoC, I hope some others could be added in 
> this framework. ETZPC is only the first.

Then put it on the bus it lives on, and the bus that the drivers for
that device are being controlled with.  That sounds like the sane place
to do so, right?

> > And really, this should just be a totally new bus type, right?  And any
> > devices on this bus should be changed to be on this new bus, and the
> > drivers changed to support them, instead of trying to overload the
> > platform bus with more stuff.
> 
> I have tried to use the bus notifier to avoid to add this code at probe 
> time but without success:
> 
> https://lkml.org/lkml/2018/2/27/300

Almost 2 years ago?  I can't remember something written 1 week ago...

Yes, don't abuse the notifier chain.  I hate that thing as it is.

> I have also tried to disable the nodes at runtime and Mark Rutland 
> explain me why it was wrong.

The bus controller should do this, right?  Why not just do it there?

thanks,

greg k-h
