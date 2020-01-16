Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44486C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2b1UJjee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAPOCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:02:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41124 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgAPOCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l/466cN8CiKF3IrmXujqdbRqr3Bz1WyntT4EutuhT1E=; b=2b1UJjee9oCy3gxIYJJF5QzpZ0
        HoQBqdDUHfiIG9sq1xLvVQ0X6PtB6npXyChS3ufnqyCqoAKtjOBfj2XO2Abyod9/194vtQqtCsRq1
        RaKnH4Q1POBKfx0OYW45fgVd0zQq/I5OlTKsTBCo+PS1oAHj9j5IZT4YoWbrbMey7loI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1is5jI-0005Li-Bv; Thu, 16 Jan 2020 15:02:36 +0100
Date:   Thu, 16 Jan 2020 15:02:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 3/4] net: phy: adin: implement support for 1588
 start-of-packet indication
Message-ID: <20200116140236.GH19046@lunn.ch>
References: <20200116091454.16032-1-alexandru.ardelean@analog.com>
 <20200116091454.16032-4-alexandru.ardelean@analog.com>
 <20200116135518.GF19046@lunn.ch>
 <efab72f360a2043bc8cf545dcc7f24d00f3269c6.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efab72f360a2043bc8cf545dcc7f24d00f3269c6.camel@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 01:58:55PM +0000, Ardelean, Alexandru wrote:
> On Thu, 2020-01-16 at 14:55 +0100, Andrew Lunn wrote:
> > [External]
> > 
> > On Thu, Jan 16, 2020 at 11:14:53AM +0200, Alexandru Ardelean wrote:
> > > The ADIN1300 & ADIN1200 PHYs support detection of IEEE 1588 time stamp
> > > packets. This mechanism can be used to signal the MAC via a pulse-
> > > signal
> > > when the PHY detects such a packet.
> > 
> > Do you have patches for a MAC driver? I want to see how this connects
> > together.
> 
> Nope.
> 
> I admit that on the MAC side, I'm not yet familiar how this is integrated.
> I'd need to study this more in-depth.

O.K.

Then i suggest you post patch #1 as a single patch. And then work on
the MAC side, and post both MAC and PHY as a complete and tested
patchset.

Thanks
	Andrew
