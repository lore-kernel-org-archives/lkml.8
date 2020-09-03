Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745D3C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D6A2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgICUmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:42:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41302 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgICUmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:42:21 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kDw3k-00D6Kv-1j; Thu, 03 Sep 2020 22:42:16 +0200
Date:   Thu, 3 Sep 2020 22:42:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: dp83867: Fix various styling and space
 issues
Message-ID: <20200903204216.GC3112546@lunn.ch>
References: <20200903141510.20212-1-dmurphy@ti.com>
 <76046e32-a17d-b87c-26c7-6f48f4257916@gmail.com>
 <4d38ac31-8646-2c4f-616c-1a1341721819@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d38ac31-8646-2c4f-616c-1a1341721819@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >   #define DP83867_CFG4_SGMII_ANEG_MASK (BIT(5) | BIT(6))
> > >   #define DP83867_CFG4_SGMII_ANEG_TIMER_11MS   (3 << 5)
> > >   #define DP83867_CFG4_SGMII_ANEG_TIMER_800US  (2 << 5)
> > > -#define DP83867_CFG4_SGMII_ANEG_TIMER_2US    (1 << 5)
> > > +#define DP83867_CFG4_SGMII_ANEG_TIMER_2US    BIT(5)
> > 
> > Now the definitions are inconsistent, you would want to drop this one
> > and stick to the existing style.
> 
> OK I was a little conflicted making that change due to the reasons you
> mentioned.  But if that is an acceptable warning I am ok with it.

Hi Dan

I work around this by using hex:

#define DP83867_CFG4_SGMII_ANEG_TIMER_11MS   (0x3 << 5)
#define DP83867_CFG4_SGMII_ANEG_TIMER_800US  (0x2 << 5)
#define DP83867_CFG4_SGMII_ANEG_TIMER_2US    (0x1 << 5)

checkpatch does not complain about that.

	   Andrew
