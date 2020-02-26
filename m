Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFAC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF872468D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UkD16FX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgBZPpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:45:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35314 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgBZPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3E7w4HszEsiPDzMy+hldTRLgCjGx/tQUMWCGTcQGxQk=; b=UkD16FX8hvXHmFGyhjZqRRhRH6
        mjoU2CVba/ZujN7LKUqyesGD4xtSdK3Yx4ptzi5N4x4MjSk5J81Fbu43Y4RLaFHW8Nig2Pnkxw6kk
        RtaOATBPgUdBCSfwyIvNkOtb+lqduriwo+u0WXqRr5+cceEl89J/pLsElx8tKQ0Pcc4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j6ysL-0006hw-8c; Wed, 26 Feb 2020 16:45:29 +0100
Date:   Wed, 26 Feb 2020 16:45:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss@0leil.net
Subject: Re: [PATCH net] net: phy: mscc: fix firmware paths
Message-ID: <20200226154529.GJ7663@lunn.ch>
References: <20200226152650.1525515-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226152650.1525515-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:26:50PM +0100, Antoine Tenart wrote:
> The firmware paths for the VSC8584 PHYs not not contain the leading
> 'microchip/' directory, as used in linux-firmware, resulting in an
> error when probing the driver. This patch fixes it.
> 
> Fixes: a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
