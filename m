Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED7C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103A5222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tzyCMYkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgBNUdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:33:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47170 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbgBNUdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vlat72TK2KwmfqvC4gryMeGdbsVvpdlox6r1LgVzu5I=; b=tzyCMYkbpEpnzfYM/OsJauRje3
        VJhyF5y+5PNkNlrc7UdwojZna3Crbh/EVjts2QTYBD+e+tAcJ7jR+PC4CcB4g3zn3vqr9jOD/EYQD
        VjfSSEwpFeVol5+zTH3uPW8QcqWrZF+r9whQAp7bX0tPpid0JHeTuHjxnQMcpRCrHWhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j2heA-0001vc-Bq; Fri, 14 Feb 2020 21:33:10 +0100
Date:   Fri, 14 Feb 2020 21:33:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: phy: restore mdio regs in the iproc mdio driver
Message-ID: <20200214203310.GQ31084@lunn.ch>
References: <20200214194858.8528-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214194858.8528-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:48:58AM -0800, Scott Branden wrote:
> From: Arun Parameswaran <arun.parameswaran@broadcom.com>
> 
> The mii management register in iproc mdio block
> does not have a reention register so it is lost on suspend.

reention?

	Andrew
