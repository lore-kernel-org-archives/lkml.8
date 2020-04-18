Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC2BC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB9921D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="APlZsfS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDRON5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:13:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46400 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgDRONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Sjo4RN4J6c+4xL5CYuv4o5kkfZ+wnVlnpvdEyHvvIxk=; b=APlZsfS4+qrhB7JQZoQRJaG0Sn
        jUFbsPyOcgn/yHNmaXwU6p93mSRh8VmAjuwG49cXkEKqmESMdaXlvj9+/aI5BMw8Rn8oFBWK1+ywQ
        /yAspNWIQYZtY5DN6tdYy595xnmUC1Ix3zlM84E7TQhNpSNd2fOyqN5jN8Zcmmkpo/Mc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jPoE8-003Sz2-Ku; Sat, 18 Apr 2020 16:13:48 +0200
Date:   Sat, 18 Apr 2020 16:13:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/3] net: phy: broadcom: add helper to
 write/read RDB registers
Message-ID: <20200418141348.GA804711@lunn.ch>
References: <20200417192858.6997-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417192858.6997-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:28:56PM +0200, Michael Walle wrote:
> RDB regsiters are used on newer Broadcom PHYs. Add helper to read, write
> and modify these registers.

It would be nice to give a hint what RDB means?

Thanks
	Andrew
