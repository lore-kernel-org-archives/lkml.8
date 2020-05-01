Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C4C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E1E2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mSjUL5OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgEASh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbgEASh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:37:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B7C061A0C;
        Fri,  1 May 2020 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hMV97MmaX97miftrzqjeu0TBXLmOOMvlA9imPuzqGGI=; b=mSjUL5OMxeQvBqqi4Ta3hO1Gj
        UFl50vipSDu80044GX0Ev8w8ZYe5iRWjD9JffxVeJ7YUwr+hJgZVcfEfDvLNNyMmhZKmJpnQ1hlyS
        7Zle1gxsil4uQgR81WFUtXrSqmY6ODdbHXSIumbYWfYRnWC54p+obQpFAKPnAiJ2QE3/mG0F1TWv5
        jdPs+/CqSxJ35MCVQuN1jkCRr2Jf6h9dwJn3EKrieehni90AlqkB9cKN1GSvmtW1zW0p1esgLvFgp
        L7LzB3LEMIbMLJNhs/PGBmj6WpRxOBE/GYw9J41hNrlXl9sm2QyhLjrdgQAmR706dfHqZhSPApkWy
        3cyL+BsiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54906)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jUaX5-0005cR-LV; Fri, 01 May 2020 19:37:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jUaX1-0003KM-F2; Fri, 01 May 2020 19:37:03 +0100
Date:   Fri, 1 May 2020 19:37:03 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Walter Harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: sja1105: fix speed setting for 10 MBPS
Message-ID: <20200501183703.GS1551@shell.armlinux.org.uk>
References: <20200501134310.289561-1-colin.king@canonical.com>
 <9018be0b7dc441cd8aad625c6cc44e1c@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9018be0b7dc441cd8aad625c6cc44e1c@bfs.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 06:00:52PM +0000, Walter Harms wrote:
> IMHO it would be better to use switch case here to improve readability.
> 
> switch (bmcr & mask) {
> 
> case  BMCR_SPEED1000:
>                                  speed = SPEED_1000;
>                                  break;
> case  BMCR_SPEED100:
>                                  speed = SPEED_100;
>                                  break;
> case  BMCR_SPEED10:
>                                  speed = SPEED_10;
>                                  break;
> default:
>                                 speed = SPEED_UNKNOWN
> }
> 
> jm2c,
>  wh
> 
> btw: an_enabled ? why not !enabled, mich more easy to read

You misinterpret "an_enabled".  It's not "negated enabled".  It's not
even "disabled".  It's short for "autonegotiation enabled".  It's
positive logic too.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
