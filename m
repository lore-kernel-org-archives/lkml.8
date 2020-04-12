Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A884C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D0520673
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pqgruber.com header.i=@pqgruber.com header.b="wCzovzOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D0520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pqgruber.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgDLRKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgDLRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:10:06 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 13:10:05 EDT
Received: from mail.pqgruber.com (mail.pqgruber.com [52.59.78.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C63C0A3BF7;
        Sun, 12 Apr 2020 10:03:39 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 90795C72B3D;
        Sun, 12 Apr 2020 19:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1586711017;
        bh=h5rmaNjv1K2NqnWO/qM8HinP3HArqEqSj+pZJ0R9K0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCzovzOj8mNTrdpRjHD+OGACB7ku2BLR5Wrx/Kjwrb5ShJo0cly7c9qGGTluOdV0C
         XBqOb/N1N5JD2Oa4b10UnfNx9i3V0bmvXDgPBxbqtL+vMr69fv/NqPHf7EAzlvevY6
         EsUT7TtpDS+AY6CuZ1lAvHRbIgtmwq8n4T5stgV8=
Date:   Sun, 12 Apr 2020 19:03:36 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell: Fix pause frame negotiation
Message-ID: <20200412170336.GA1826@workstation.tuxnet>
References: <20200408214326.934440-1-clemens.gruber@pqgruber.com>
 <20200410174304.22f812fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200411091705.GG25745@shell.armlinux.org.uk>
 <20200411132401.GA273086@workstation.tuxnet>
 <20200411134344.GI25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411134344.GI25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 02:43:44PM +0100, Russell King - ARM Linux admin wrote:
> The fiber code is IMHO very suspect; the decoding of the pause status
> seems to be completely broken. However, I'm not sure whether anyone
> actually uses that or not, so I've been trying not to touch it.

If the following table for the link partner advertisement is correct..
PAUSE           ASYM_PAUSE      MEANING
0               0               Link partner has no pause frame support
0               1               <-  Link partner can TX pause frames
1               0               <-> Link partner can RX and TX pauses
1               1                -> Link partner can RX pause frames

..then I think both pause and asym_pause have to be assigned
independently, like this:
phydev->pause = !!(lpa & LPA_1000XPAUSE);
phydev->asym_pause = !!(lpa & LPA_1000XPAUSE_ASYM);

(Using the defines from uapi mii.h instead of the redundant/combined
LPA_PAUSE_FIBER etc. which can then be removed from marvell.c)

Currently, if LPA_1000XPAUSE_ASYM is set we do pause=1 and asym_pause=1
no matter if LPA_1000XPAUSE is set. This could lead us to mistake a link
partner who can only send for one who can only receive pause frames.
^ Was this the problem you meant?

I saw that for the copper case and in other drivers, we first set the
ETHTOOL_LINK_MODE_(Asym_)Pause_BIT bit in lp_advertising and then set
phydev->(asym_)pause depending on the ETHTOOL_LINK_MODE_... bit.
Do you agree that we should also set the ETHTOOL_ bits in the fiber
case?

Does anybody have access to a Marvell PHY with 1000base-X Ethernet?
(I only have a 88E1510 + 1000Base-T at the home office)

Thanks,
Clemens
