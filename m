Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F519C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581FD222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RAWM/ekl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgCJNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55142 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbgCJNYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rJn5zMEeyKEpdgzeDpLuHWjmnGAtyMaZbRTxuWpfM88=; b=RAWM/eklBGXXMA3h7Bq7Rio8kp
        svHjjH9VNAAtDF+tgkTuML85pgXe6zRd2yDTut0nfjKLlT9WG1ZpXPURBiwkQwlIfmUvU0/hsPpRW
        A6kiRScXy00m0BJ1udPM/9tDGFvCyGYD9xryq35YanDgsFOmjZn0e4RuwScz6S/1i4EE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jBes9-0001oj-DC; Tue, 10 Mar 2020 14:24:37 +0100
Date:   Tue, 10 Mar 2020 14:24:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: mscc: fix header defines and
 descriptions
Message-ID: <20200310132437.GG5932@lunn.ch>
References: <20200310090720.521745-1-antoine.tenart@bootlin.com>
 <20200310090720.521745-4-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310090720.521745-4-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:07:20AM +0100, Antoine Tenart wrote:
> Cosmetic commit fixing the MSCC PHY header defines and descriptions,
> which were referring the to MSCC Ocelot MAC driver (see
> drivers/net/ethernet/mscc/).
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
