Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0423C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A7120661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nR2k6fVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAJTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:33:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60578 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgAJTdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y+GDTn9tkHWTYtCXAFZVZoOP4Q0QrqzM4C7IlKEbmaY=; b=nR2k6fVjFvLF1j/GiSSvtMLFMl
        USN7WfA5tsouTLhDE1FUPbT1Jf5yFAg+ipFsCXEkrBRxOtjgr5tcZ+X5e9aWUrMyxiL9OjG4bdQyR
        9sKV8LVCVE9KQiJUiMDG/STXbtoArq8NmaVG2WeUPxB3jiHsWnvHiM6CQk26lJzpHCXY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1iq02T-0003sa-9C; Fri, 10 Jan 2020 20:33:45 +0100
Date:   Fri, 10 Jan 2020 20:33:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andre Przywara <andre.przywara@arm.com>, netdev@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <hancock@sedsystems.ca>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/14] net: axienet: Fix SGMII support
Message-ID: <20200110193345.GR19739@lunn.ch>
References: <20200110115415.75683-1-andre.przywara@arm.com>
 <20200110115415.75683-8-andre.przywara@arm.com>
 <20200110145849.GC25745@shell.armlinux.org.uk>
 <20200110173249.0b086a76@donnerap.cambridge.arm.com>
 <20200110180546.GK25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110180546.GK25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Phylink currently expects the result of the in-band negotiation at
> the MAC PCS to be propagated to the MAC by hardware (as this is what
> happens with mvneta and mvpp2, the first two MACs that phylink
> supports.)  If there is hardware that requires something else, then
> that will need to be revisited, and will result in not only code but
> also documentation updates as well.

Hi Russell

This is an issue i'm having at the moment with Marvell switches. They
do not propagate the results to the MAC. So when i get an interrupt
from the SERDES that the link is up, i'm programming the MAC as
needed.

	Andrew
