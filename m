Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2922078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgICBNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:13:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39204 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgICBNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:13:30 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kDdoa-00CxkT-UA; Thu, 03 Sep 2020 03:13:24 +0200
Date:   Thu, 3 Sep 2020 03:13:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: bcm_sf2: Ensure that MDIO diversion
 is used
Message-ID: <20200903011324.GE3071395@lunn.ch>
References: <20200902210328.3131578-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902210328.3131578-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:03:27PM -0700, Florian Fainelli wrote:
> Registering our slave MDIO bus outside of the OF infrastructure is
> necessary in order to avoid creating double references of the same
> Device Tree nodes, however it is not sufficient to guarantee that the
> MDIO bus diversion is used because of_phy_connect() will still resolve
> to a valid PHY phandle and it will connect to the PHY using its parent
> MDIO bus which is still the SF2 master MDIO bus.
> 
> Ensure that of_phy_connect() does not suceed by removing any phandle
> reference for the PHY we need to divert. This forces the DSA code to use
> the DSA slave_mii_bus that we register and ensures the MDIO diversion is
> being used.

Hi Florian

Sorry, i don't get this explanation. Can you point me towards a device
tree i can look at to maybe understand what is going on.

     Andrew
