Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60046C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A5E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bxYTcd9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAPNzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:55:22 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41076 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPNzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QH3B/z2oVQVzHP8s8L4grOFm0S+F0cJq3brTy9vKP4Y=; b=bxYTcd9hZEjpjg9zuTVvpVflat
        FAkf/Tjlh+7lrn5SvVSVf4WgPMtkXMBlkavVVRPAJ0gM+dDtqBOYbWLeskchsNf5gqmbj5RxsQcE2
        Mr+Jo8nG6tFj35AmmkLvhMNf23dgJZdNrhOafjTsD4he23pYsewThKGGDB3HwdmbgWEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1is5cE-0005GC-5C; Thu, 16 Jan 2020 14:55:18 +0100
Date:   Thu, 16 Jan 2020 14:55:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Subject: Re: [PATCH 3/4] net: phy: adin: implement support for 1588
 start-of-packet indication
Message-ID: <20200116135518.GF19046@lunn.ch>
References: <20200116091454.16032-1-alexandru.ardelean@analog.com>
 <20200116091454.16032-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116091454.16032-4-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:14:53AM +0200, Alexandru Ardelean wrote:
> The ADIN1300 & ADIN1200 PHYs support detection of IEEE 1588 time stamp
> packets. This mechanism can be used to signal the MAC via a pulse-signal
> when the PHY detects such a packet.

Do you have patches for a MAC driver? I want to see how this connects
together.

	Thanks
		Andrew	
