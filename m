Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D7C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC7E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2ECly9xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAPNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:30:31 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40984 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPNaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g1qwtKIRjlBajTodzOst5ddyTTUcuYWbTRPXsMESids=; b=2ECly9xqL7ZjMne7Gw+M+ysy1d
        /7HZ35Le8voRmEzt+T0tpSwyIwWvia+UREroW3r0qd9euHylc6hvW07tf9i1WAnOMBjG9az1NP8+h
        jAUuZ5HNpRekdP7lp0ZyAEqbepMWpqGADpnWeBI124VKpmHIdwcsCWDO7eOGAMs9OOrg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1is5EA-00054x-2R; Thu, 16 Jan 2020 14:30:26 +0100
Date:   Thu, 16 Jan 2020 14:30:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Subject: Re: [PATCH 1/4] net: phy: adin: const-ify static data
Message-ID: <20200116133026.GB19046@lunn.ch>
References: <20200116091454.16032-1-alexandru.ardelean@analog.com>
 <20200116091454.16032-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116091454.16032-2-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:14:51AM +0200, Alexandru Ardelean wrote:
> Some bits of static data should have been made const from the start.
> This change adds the const qualifier where appropriate.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
