Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CC8C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F462071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580291564;
	bh=pdUBb1VQFGtjiKTWA/mvQZEtWw7DqY38KlcazbW826Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ndp9DsqmlscVtEiiInIsEOcJheNrdMykVVBFIwP+m9yayPJQ9be/bhUPd1KNoMFUF
	 SbUcUA2Aha24YAjfKY0qsZhjvrS5Fc8bf5VolDLIKE8r2+kKyoxzg2q5xLpKD1VkGC
	 r1MbUhOluL1IoBddfLM3iv/KPr7wcwne0XznqRwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA2Jwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:52:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D37B20708;
        Wed, 29 Jan 2020 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580291562;
        bh=pdUBb1VQFGtjiKTWA/mvQZEtWw7DqY38KlcazbW826Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUK2LESONcolYBI3s5wOXXcjHaEJ8H1iR0J80W8KANmfFzfT0PW9vRtvDxXC9Cvoi
         xR6FH51RcnUw429y18Ef34Rnlzqc5c2PVNuo0RvtR2gAPFjja/VVMeCXVNvIrBLEQo
         r1w+UKXRgGsUfod5GOM7fD45CDRTOq5SZ3Rnwk+Y=
Date:   Wed, 29 Jan 2020 10:52:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Message-ID: <20200129095240.GA3852081@kroah.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:42:39AM +0100, Linus Walleij wrote:
> On Tue, Jan 28, 2020 at 9:30 PM Benjamin GAIGNARD
> <benjamin.gaignard@st.com> wrote:
> > On 1/28/20 5:57 PM, Greg KH wrote:
> > > On Tue, Jan 28, 2020 at 04:41:29PM +0000, Benjamin GAIGNARD wrote:
> > >> On 1/28/20 4:52 PM, Greg KH wrote:
> 
> > >>> So put this in the bus-specific code that controls the bus that these
> > >>> devices live on.  Why put it in the driver core when this is only on one
> > >>> "bus" (i.e. the catch-all-and-a-bag-of-chips platform bus)?
> 
> > >> It is really similar to what pin controller does, configuring an
> > >> hardware block given DT information.
> 
> > > Great, then use that instead :)
> 
> > I think that Linus W. will complain if I do that :)
> 
> So the similarity would be something like the way that pin control
> states are configured in the device tree and the pin control
> handles are taken before probe in drivers/base/pinctrl.c embedding
> a hook into dd.c.
> 
> Not that it in any way controls any hardware even remotely
> similar to pin control. Pin control is an electronic thing,
> this firewalling is about bus access.
> 
> IIUC this framework wants to discover at kernel boot time
> whether certain devices are accessible to it or not by inspecting
> the state of the firewalling hardware and then avoid probing
> those that are inaccessible.
> 
> It needs the same deep hooks into dd.c to achieve this
> I believe.

It just needs to be part of the bus logic for the specific bus that this
"firewall" is on.  Just like we do the same thing for USB or thunderbolt
devices.  Put this in the bus-specific code please.

thanks,

greg k-h
