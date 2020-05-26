Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB16AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5AA207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qc24MTL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEZNdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:33:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49576 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEZNdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=I/38hME52ErJyCvXyLLFLGqQK5hFQ9kP0oyclECrgjM=; b=qc24MTL7q392chZM1zWuH7BTQJ
        gQP4/JJGQF32itvJDFl3E5U+kZAKYvBb3ceok+WNibouiFhwXgt4xzZKGIKsCGbFquddd72bBhjrT
        CLLUv6A192maeh9BerM+WDF75IFy4jbkc0LhZJ9sfC3bcbmpNj4ceQUL+ov+huSGZSgg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdZhL-003Hlx-MQ; Tue, 26 May 2020 15:32:51 +0200
Date:   Tue, 26 May 2020 15:32:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1] net: phy: at803x: add cable diagnostics
 support for ATH9331 and ATH8032
Message-ID: <20200526133251.GI768009@lunn.ch>
References: <20200526100823.2331-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526100823.2331-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:08:23PM +0200, Oleksij Rempel wrote:
> Add support for Atheros 100Bast-T PHYs. The only difference seems to be
> the ability to test 2 pares instead of 4 and the lack of 1000Bast-T
> specific register.

s/Bast-T/Base-T/g
s/pares/pairs/

Otherwise this looks good.

	  Andrew
