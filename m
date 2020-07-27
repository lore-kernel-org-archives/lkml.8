Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E106CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C233A2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gNMTf3a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgG0RbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbgG0RbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:31:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CEC061794;
        Mon, 27 Jul 2020 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OWoBvMBmWyDilWMUdxwiwp8BDkF9aBjJr3HcaF0ozXo=; b=gNMTf3a99kpRORweCKLBEzsKU
        iSe3KroPt7Iqtw/bTqtUJLI9vbLgXjhJlmVBffJQNmOwMpMP444Elz5KmXqbFFYSaohyNGYv4trFv
        kLXIAej49+UmDQL8ZkxwyYIytiTS6jYsMNbGzKLZXhqjRnzYO+298DuWWtJJ/3F7w24d2Or+d16Gv
        Mr4LBEDVQeIAInXJvWmh7F6sxHglSw/9CUoqxs2GKOo3YdDcpdYsJ5AktzS+SGXMUVkN6hIl8BwvK
        RznIj6+WwBcv3VOUHARDlkq5x9OqDNV5L3g0xmJh7xkl0hjixEhim6FZVOCJy3WEb3hRWOBKjsynO
        HR4yAjzmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44886)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k06xh-00037t-BM; Mon, 27 Jul 2020 18:30:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k06xf-0003pn-Gq; Mon, 27 Jul 2020 18:30:51 +0100
Date:   Mon, 27 Jul 2020 18:30:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jon Nettleton <jon@solid-run.com>, Rob Herring <robh@kernel.org>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        a.zummo@towertech.it, Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727173051.GM1551@shell.armlinux.org.uk>
References: <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk>
 <20200727154104.GE239143@piout.net>
 <20200727154335.GL1551@shell.armlinux.org.uk>
 <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
 <20200727161632.GF239143@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727161632.GF239143@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 06:16:32PM +0200, Alexandre Belloni wrote:
> On 27/07/2020 17:55:50+0200, Jon Nettleton wrote:
> > > So, can we please have that discussion, it is pertinent to this patch.
> > >
> > 
> > Thinking about this some more, I believe whether or not an IOCTL
> > interface is in the works or needed is irrelevant.  This patch
> > describes the hardware and how it is designed and the topic of
> > discussion is if we need a simple boolean state, or if we need
> > something that could be used to support dynamic configuration in the
> > future.  I would rather make this decision now rather than keep
> > tacking on boolean config options, or revisit a bunch of device-tree
> > changes.
> 
> Something that would describe the hardware is a property telling whether
> the filter is present on VDD, not a property selecting DSM. The driver
> can then chose to avoid standard mode when needed.

Whether DSM needs to be enabled or not is _not_ just a function of
whether there is a filter present or not.

The requirement in the data sheet is that when the VDD supply drops
below 2.5V, it does not fall more than 0.7V/ms.  That can be
achieved many different ways, not only by adding a resistive filter
to the VDD supply to the RTC.  It could also be achieved via the design
of the power supply - for example, having a large enough reservoir
capacitor to ensure under all loads that the VDD supply will not fall
faster than 0.7V/ms.

There are many ways to meet this requirement.

Adding a DT property to indicate whether the filter is present or not
is definitely not the right approach.  Should we also add properties
for every possible solution to this problem.

	vdd-has-filter;
	psu-has-large-capacitors;
	... etc ...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
