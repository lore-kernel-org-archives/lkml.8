Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3C206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i14svb7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgCaNB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:01:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41010 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgCaNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LJ0R4MpQxnnEtLA5Sx240/tS2yB62qhJWK23+9ujlDc=; b=i14svb7vwTB9Of4C0ngSQoihyx
        YZcwVDCUfNPutSrFCSQdxYpLpBdf3ErtAUDWyE8CG1PQiZk1ay90ehZhjyqUKseD6aBuwO6lNM3GG
        qcui11wHzvvvuvJyDZ5PTcuSqnenkAFKNViv7wmnXjOFdnDWT2FdNY4gMgkZtNTiAWwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jJGWC-000D2X-IJ; Tue, 31 Mar 2020 15:01:24 +0200
Date:   Tue, 31 Mar 2020 15:01:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, woojung.huh@microchip.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: Re: [PATCH] net: dsa: ksz: Select KSZ protocol tag
Message-ID: <20200331130124.GC24486@lunn.ch>
References: <20200331093651.23365-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331093651.23365-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:36:51PM +0300, Codrin Ciubotariu wrote:
> KSZ protocol tag is needed by the KSZ DSA drivers.
> 
> Fixes: 0b9f9dfbfab4 ("dsa: Allow tag drivers to be built as modules")
> Tested-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
