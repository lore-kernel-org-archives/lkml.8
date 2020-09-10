Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB8C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1120C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIJSE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:04:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55776 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgIJSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:03:10 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kGQuP-00E6iA-2R; Thu, 10 Sep 2020 20:02:57 +0200
Date:   Thu, 10 Sep 2020 20:02:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: dp83869: support Wake on LAN
Message-ID: <20200910180257.GD3354160@lunn.ch>
References: <20200903114259.14013-1-dmurphy@ti.com>
 <20200903114259.14013-3-dmurphy@ti.com>
 <20200905113428.5bd7dc95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <5051f1e2-4f8e-a021-df6c-d4066938422f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5051f1e2-4f8e-a021-df6c-d4066938422f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >   static int dp83869_config_port_mirroring(struct phy_device *phydev)
> > >   {
> > >   	struct dp83869_private *dp83869 = phydev->priv;
> > Overall this code looks quite similar to dp83867, is there no way to
> > factor this out?
> 
> Factor what out?  Yes the DP83867 and DP83869 are very similar in registers
> and bitmaps.  They just differ in their feature sets.
> 
> The WoL code was copied and pasted to the 869 and I would like to keep the
> two files as similar as I can as it will be easier to fix and find bugs.

It will be even easier if they shared the same code. You could create
a library of functions, like bcm-phy-lib.c.

  Andrew
