Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA59C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E00A221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r3sQoamw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgDQUMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:12:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45130 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgDQUMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=w/SB4eXqDsiq1IOqvbzW0ZcEg39EHOcVM/1ghf9g6Qo=; b=r3sQoamwlwN0VtGUudzQEQ9STp
        o2w91JBiuQvjoy8S/K7fbwZg5LmZToCVzt2ssOCWBXMf8RRdU3QXIgNdr/0bHaUF9RTyRgRj3UYuB
        k90lg3UwD5xfzefUOR8XbmaJkbxbBlcUeUqJtgQNoxmfak8n/rn5DfO9EpKmqfOm1NO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jPXLQ-003LW0-Cf; Fri, 17 Apr 2020 22:12:12 +0200
Date:   Fri, 17 Apr 2020 22:12:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/3] net: phy: add Broadcom BCM54140 support
Message-ID: <20200417201212.GH785713@lunn.ch>
References: <20200417192858.6997-1-michael@walle.cc>
 <20200417192858.6997-2-michael@walle.cc>
 <20200417193905.GF785713@lunn.ch>
 <ef747b543bd8dd34aea89a6243de8da4@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef747b543bd8dd34aea89a6243de8da4@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Michael
> > 
> > How much flexibility is there in setting the base address using
> > strapping etc? Is it limited to a multiple of 4?
> 
> You can just set the base address to any address. Then the following
> addresses are used:
>   base, base + 1, base + 2, base + 3, (base + 4)*

O.K, nothing as nice as base = my MOD 4.

:-(

	Andrew
