Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC53C206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GDwmkcDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgESTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:03:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39584 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9A+5GLQ4ZvDD5R6P8r1Zmt+li9/vFkdMpJLubAsAUJM=; b=GDwmkcDsZTEbdZnUdW4xyG49Bq
        mUeLP+79BCgs5oXv6W9Fy9JcP/IG1S+Cqg3c7/I6IqaEysybIXxuUVkqTTCQwzezGIvde8IrlPAAj
        rJWFDNWXhpVeMIL0NLNiKXDhvpgZxu1gFmG5RMG33+noqU9IYG68dbgqx6QTlUqIiZfE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jb7WG-002jqs-Vy; Tue, 19 May 2020 21:03:16 +0200
Date:   Tue, 19 May 2020 21:03:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: dp83869: Set opmode from straps
Message-ID: <20200519190316.GA652285@lunn.ch>
References: <20200519141813.28167-1-dmurphy@ti.com>
 <20200519141813.28167-3-dmurphy@ti.com>
 <20200519095818.425d227b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200519182916.GM624248@lunn.ch>
 <c45bae32-d26f-cbe5-626b-2afae4a557b3@ti.com>
 <20200519114843.34e65bcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <5d6d799f-f7b6-566a-5038-5901590f2e7b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6d799f-f7b6-566a-5038-5901590f2e7b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:59:16PM -0500, Dan Murphy wrote:
> Jakub
> 
> On 5/19/20 1:48 PM, Jakub Kicinski wrote:
> > On Tue, 19 May 2020 13:41:40 -0500 Dan Murphy wrote:
> > > > Is this now a standard GCC warning? Or have you turned on extra
> > > > checking?
> > > I still was not able to reproduce this warning with gcc-9.2.  I would
> > > like to know the same
> > W=1 + gcc-10 here, also curious to know which one of the two makes
> > the difference :)
> 
> W=1 made the difference I got the warning with gcc-9.2

I wonder if we should turn on this specific warning by default in
drivers/net/phy? I keep making the same mistake, and it would be nice
if GCC actually told me.

   Andrew
