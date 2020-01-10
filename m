Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F06C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E5A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oHQd2n9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAJT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:26:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60550 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgAJT00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6jPdN/ENCtLNkk2kqDNdgUU4Oc+Nk0hw6Y9fhX+wsys=; b=oHQd2n9HfH/96meRFN9XMQUPAy
        /8EUHoNp3myRFKRATb8HrwMqAteELQxmrRa3M2CmNiqEKgVn/oF+8qhrvLcS7MismZtiupt/006hR
        d5RXaogAh74aMief55Rl3T4pkU5yY5CVEPHGHANSIzc6fejzny6ApvlfHCGJK+88FGh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ipzvK-0003lY-6q; Fri, 10 Jan 2020 20:26:22 +0100
Date:   Fri, 10 Jan 2020 20:26:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] net: phy: DP83822: Update Kconfig with DP83825I
 support
Message-ID: <20200110192622.GQ19739@lunn.ch>
References: <20200110184702.14330-1-dmurphy@ti.com>
 <20200110184702.14330-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110184702.14330-3-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:47:00PM -0600, Dan Murphy wrote:
> Update the Kconfig description to indicate support for the DP83825I
> device as well.
> 
> Fixes: 32b12dc8fde1  ("net: phy: Add DP83825I to the DP83822 driver")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
