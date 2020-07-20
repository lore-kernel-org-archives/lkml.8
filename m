Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F186C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599082250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595211104;
	bh=PgDcAq+4nyz4PbXB7ez/Cs907K+I0Hwh/nXW03+MYaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z+CE83RtbGCQP4HSMt92luE5i+aMlQNDt5x8g/ib0LYyDyXDOBSzUSsvDBPTZi/bO
	 E8TETqLGktH8qyBbg95AnNlbcx02IURVVQYwJ+fcWFUcvmxHGdMEtLbygm+VkIVZ4P
	 m6zLtgfG6ZY23qU2DzDd4nBcNu4+uFKgd3r17nss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGTCLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgGTCLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:11:42 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15472208B3;
        Mon, 20 Jul 2020 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595211101;
        bh=PgDcAq+4nyz4PbXB7ez/Cs907K+I0Hwh/nXW03+MYaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYYOIPhjYHhrVPbinYr1Yu+dMXz1s1oqP1orozIz0nqL8+BlHf4G6rTrMRoHCqrfc
         yG4A/mlQ25vMLDKLq6LssLNpRR+ieh7scg5n3dK6hVfNRIUzlZ6nTKBrVGfUVRAsEr
         cn1ufSU/UGfA1eXN/Rqddi2dwmloZUaIMBK65mHA=
Date:   Mon, 20 Jul 2020 10:11:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Message-ID: <20200720021125.GC11560@dragon>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
 <20200710132423.497230-3-philippe.schenker@toradex.com>
 <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
 <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
 <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
 <83b230cef109e1a413ab1036c21ad763a1d127eb.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b230cef109e1a413ab1036c21ad763a1d127eb.camel@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:20:34AM +0000, Philippe Schenker wrote:
> On Tue, 2020-07-14 at 09:55 +0200, Ahmad Fatoum wrote:
> > Hello Philippe,
> > 
> > On 7/13/20 1:53 PM, Philippe Schenker wrote:
> > > On Mon, 2020-07-13 at 11:46 +0200, Ahmad Fatoum wrote:
> > > > Hello Philippe,
> > > > 
> > > > > +	extcon_usbc_det: usbc_det {
> > > > > +		compatible = "linux,extcon-usb-gpio";
> > > > 
> > > > According to 4602f3bff266 ("usb: common: add USB GPIO based
> > > > connection
> > > > detection driver"):
> > > > "the old way using extcon to support USB Dual-Role switch is now
> > > > deprecated
> > > >  when use Type-B connector."
> > > > 
> > > > Have you considered using a compatible = "gpio-usb-b-connector"
> > > > child
> > > > node instead?
> > > > 
> > > > Cheers,
> > > > Ahmad
> > > 
> > > Thanks for the Hint Ahmad,
> > > 
> > > I already tried and just now tried again but it doesn't work on our
> > > hardware. Are you sure this works with chipidea driver?
> > 
> > I haven't, just wanted to point its existence out in case you didn't
> > know.
> > Seems we need to call of_platform_populate somewhere in the driver.
> > Unsure what other changes are necessary.
> 
> Yep, thanks for that! It seems like that need to be really called as I
> can't get a probe of the new usb connector driver. I quickly grepped
> through code and saw that tegra USB driver is calling
> of_platform_populate and they also use that gpio-usb-b-connector.
> 
> > 
> > > Should this new usb-connector stuff work in general with every old
> > > driver?
> > 
> > If the driver support isn't there yet, I think use of extcon is fine
> > as is.

Shouldn't we improve chipidea driver to get it work with gpio-usb-b-connector?

Shawn
