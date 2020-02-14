Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFFC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1E42465D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581717269;
	bh=kPEmoqK5kkolXd/XtmxwGBw/rwiGBYbwTOnvH4ZJM78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eiUD6fVPAGUdLG2vj6zKTpurNqyffss8ZnhP1tRJRXnrHG/qSVQhfQq4LnK3NftC3
	 c3MIRgJdHogTbf74BoL/eHTxLsyYacuUMgJ44vY6mYTORwa2Y//U81PhwOHoqgTKIm
	 jaPDmLP33Kh+O0ljnALPzHYsDWGqM7pKrOVMquwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgBNVy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgBNVy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:54:28 -0500
Received: from localhost (unknown [65.119.211.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9152082F;
        Fri, 14 Feb 2020 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581717268;
        bh=kPEmoqK5kkolXd/XtmxwGBw/rwiGBYbwTOnvH4ZJM78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9uY5UhJq9FPMU/mfklwfFYxjFgMVB8LfJWzsjZEa7jR7fr2KONnwjlEf0RA6/iN/
         hyy0YWWftJ+6JERE6Sh2iYv5hXT01V62fcOFoznONFgeN8vuquNvlDrTva+TNtpx6C
         B7GBiR4PSLpHfT0+v5NNkLB1bTkBiZsTW94GoJx0=
Date:   Fri, 14 Feb 2020 16:40:51 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Grant Likely <grant.likely@arm.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
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
Message-ID: <20200214214051.GA4192967@kroah.com>
References: <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com>
 <20200129111717.GA3928@sirena.org.uk>
 <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
 <20200131090650.GA2267325@kroah.com>
 <CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 05:05:07PM +0100, Linus Walleij wrote:
> On Fri, Jan 31, 2020 at 10:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > Why do people want to abuse the platform bus so much?  If a device is on
> > a bus that can have such a controller, then it is on a real bus, use it!
> 
> I'm not saying it is a good thing, but the reason why it is (ab)used so
> much can be found in:
> drivers/of/platform.c
> 
> TL;DR: struct platform_device is the Device McDeviceFace and
> platform bus the Bus McBusFace used by the device tree parser since
> it is slightly to completely unaware of what devices it is actually
> spawning.

<snip>

Yeah, great explaination, and I understand.  DT stuff really is ok to be
on a platform bus, as that's what almost all of them are.

But, when you try to start messing around with things like this
"firewall" says it is doing, it's then obvious that this really isn't a
DT like thing, but rather you do have a bus involved with a controller
so that should be used instead.

Or just filter away the DT stuff so that the kernel never even sees
those devices, which might just be simplest :)

thanks,

greg k-h
