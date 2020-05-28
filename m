Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE873C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF0320829
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="osJKPQ6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbgE1Qdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:33:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54896 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405048AbgE1Qde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=prqncY2KTs77FYfZ6+mgx2VwmntSpVLJQSpZE3MLMBQ=; b=osJKPQ6gfJzsqoRf6vlfSANjeQ
        Qydh8aBUHghgdRhzEm69eTopdwOBUSBekqlRDkHfP7otK2btWlBwYxK16hazZhd+I91EZWDhEJxsx
        ofwNq3G/1P2OOtFMI/nOzke3efqoxI8Xf9K2pjPy5LNTxuvpUxPXDeDhqroEV3Ld0Np4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jeLTD-003YNL-E5; Thu, 28 May 2020 18:33:27 +0200
Date:   Thu, 28 May 2020 18:33:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Enable autoneg bypass for
 1000BaseX/2500BaseX ports
Message-ID: <20200528163327.GF840827@lunn.ch>
References: <20200528121121.125189-1-tbogendoerfer@suse.de>
 <20200528130738.GT1551@shell.armlinux.org.uk>
 <20200528151733.f1bc2fcdcb312b19b2919be9@suse.de>
 <20200528135608.GU1551@shell.armlinux.org.uk>
 <20200528163335.8f730b5a3ddc8cd9beab367f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528163335.8f730b5a3ddc8cd9beab367f@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:33:35PM +0200, Thomas Bogendoerfer wrote:
> below is the dts part for the two network interfaces. The switch to
> the outside has two ports, which correlate to the two internal ports.
> And the switch propagates the link state of the external ports to
> the internal ports.

Hi Thomas

Any plans to add mainline support for this board?
Contribute the DT files?

    Andrew
