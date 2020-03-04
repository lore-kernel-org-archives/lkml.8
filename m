Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A98C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A71207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583305265;
	bh=5dSFTcmBx6dmmeOBWTXYE4TNNsxJSM/YZDSHZwHtaKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kWqstC3B8JPRvicug+0iwsC6ThxgClZR3JmtQa2zdVfgJiJR97n9PiB/yZs/3zHo9
	 gw8WUfyfpWxdEo5rbd6Vzl+w5B52nlpKxFOdQJuNRGeAfp8d580a0hWs3u6FHhUsMM
	 CUql8p0cTpGVJYJkSRkBgAYFuUFdvMqzxsN7zVwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCDHBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgCDHBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:01:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C1C2073D;
        Wed,  4 Mar 2020 07:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583305262;
        bh=5dSFTcmBx6dmmeOBWTXYE4TNNsxJSM/YZDSHZwHtaKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMbeQr/f9y11OFuloHo6j+F4ckDHepijvQWmviM8nCY+FBuVPiYYm1Iq/NftJ7QmQ
         0BH+HhXlzibQpqItSEm521mf+2xcx/8xSQbGxiAoEzO6YGkShMGe0QQ3oQBNp/Xyox
         UFPT20xGyZG9Lu/kJx2eWvHTcw0x2lnhETWSfXxA=
Date:   Wed, 4 Mar 2020 08:01:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
Message-ID: <20200304070100.GA1271591@kroah.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <20200217085130.GJ1339021@ulmo>
 <20200227173226.GA1114616@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227173226.GA1114616@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:32:26PM +0100, Thierry Reding wrote:
> On Mon, Feb 17, 2020 at 09:51:30AM +0100, Thierry Reding wrote:
> > On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
> > > This patch series adds OTG support on XUSB hardware used in Tegra210 and
> > > Tegra186 SoCs.
> > > 
> > > This patchset is composed with :
> > >  - dt bindings of XUSB Pad Controller
> > >  - dt bindings for XUSB device Driver
> > >  - Tegra PHY driver for usb-role-switch and usb-phy
> > >  - Tegra XUSB host mode driver to support OTG mode
> > >  - Tegra XUSB device mode driver to use usb-phy and multi device mode
> > >  - dts for XUSB pad controller
> > >  - dts for xudc for Jetson TX1 and TX2
> > >  - dts for Jetson-TK1
> > >  - dts for Jetson-Nano
> > > 
> > > Tegra Pad controller driver register for role switch updates for
> > > OTG/peripheral capable USB ports and adds usb-phy for that corresponding
> > > USB ports.
> > > 
> > > Host and Device mode drivers gets usb-phy from USB2's phy and registers
> > > notifier for role changes to perform corresponding role tasks.
> > > 
> > > Order of merging Patches:
> > > Please merge DT changes first followed Tegra PHY driver changes and then
> > > USB driver changes.
> > 
> > Felipe, Greg, Kishon,
> > 
> > Given the runtime dependencies between these various parts, I could pick
> > these up into the Tegra tree if you provide an Acked-by.
> 
> Ping. Are you guys okay if I pick these up into the Tegra tree?

That's up to Felipe, I have no opinion :)
