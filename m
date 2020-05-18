Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858FD20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dg9vVUjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgEROuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:50:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37228 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgEROuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g/tUXb4ly8xE4Vp3fNrWElVjFfmCixuKmriyRVpDO58=; b=Dg9vVUjdtMK1CDdz60T2BkGs2s
        +Cio0LxX9eTLHhU6dIUIxajJSHd4x2QUYvm4NUwlJzZiomu7JnkSark9Flube+92vtx86die1Bf0f
        lAcMlNM33JuaeaghBm5S+XAbrzHf1jGQ/kPoNVqRkDPzbjc6klBoTNTKGPu7CxpWbubg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jah6F-002cQU-Eu; Mon, 18 May 2020 16:50:39 +0200
Date:   Mon, 18 May 2020 16:50:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com, kuba@kernel.org,
        Yufeng Mo <moyufeng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: Re: [PATCH net-next] net: phy: realtek: add loopback support for
 RTL8211F
Message-ID: <20200518145039.GA624248@lunn.ch>
References: <1589358344-14009-1-git-send-email-tanhuazhong@huawei.com>
 <20200513131226.GA499265@lunn.ch>
 <cb82153d-e14e-8e97-b3b8-210135fbdee6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb82153d-e14e-8e97-b3b8-210135fbdee6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, Andrew.
> 
> There are two type of phys we are using, rtl8211f and "Marvell 88E1512".
> "Marvell 88E1512" has already supported loopback
> (f0f9b4ed2338 ("net: phy: Add phy loopback support in net phy framework")).

> So now we adds loopback support to the rtl8211f.
> From the data sheet other phys should support this loopback as well, but
> we have no way to verify it. What's your suggestion?

So you checked the datasheets for the RTL8201CP, RTL8201F, RTL8208,
RTL8211B, RTL8211DN, etc?

For all those you have datasheets for, please also add loopback
support. I'm just trying to avoid one PHY from twelve in that driver
having loopback support, when they all probably can.

       Andrew
