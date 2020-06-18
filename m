Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111F020578
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFRBPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:15:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45354 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgFRBNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:36 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jlj7O-0012r4-Tx; Thu, 18 Jun 2020 03:13:26 +0200
Date:   Thu, 18 Jun 2020 03:13:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 1/3] net: phy: mscc: move shared probe code into a
 helper
Message-ID: <20200618011326.GA249144@lunn.ch>
References: <20200617213326.1532365-1-heiko@sntech.de>
 <20200617213326.1532365-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617213326.1532365-2-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:33:24PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The different probe functions share a lot of code, so move the
> common parts into a helper to reduce duplication.
> 
> This moves the devm_phy_package_join below the general allocation
> but as all components just allocate things, this should be ok.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
