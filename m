Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF91C55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3AA20747
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDWCjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgDWCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:39:08 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FCC03C1AB;
        Wed, 22 Apr 2020 19:39:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1880127AD655;
        Wed, 22 Apr 2020 19:39:07 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:39:07 -0700 (PDT)
Message-Id: <20200422.193907.1128604166633852958.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        david@protonic.nl, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        philippe.schenker@toradex.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next v3] net: phy: micrel: add phy-mode support for
 the KSZ9031 PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200422072137.8517-1-o.rempel@pengutronix.de>
References: <20200422072137.8517-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Apr 2020 19:39:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 22 Apr 2020 09:21:37 +0200

> Add support for following phy-modes: rgmii, rgmii-id, rgmii-txid, rgmii-rxid.
> 
> This PHY has an internal RX delay of 1.2ns and no delay for TX.
> 
> The pad skew registers allow to set the total TX delay to max 1.38ns and
> the total RX delay to max of 2.58ns (configurable 1.38ns + build in
> 1.2ns) and a minimal delay of 0ns.
> 
> According to the RGMII v1.3 specification the delay provided by PCB traces
> should be between 1.5ns and 2.0ns. The RGMII v2.0 allows to provide this
> delay by MAC or PHY. So, we configure this PHY to the best values we can
> get by this HW: TX delay to 1.38ns (max supported value) and RX delay to
> 1.80ns (best calculated delay)
> 
> The phy-modes can still be fine tuned/overwritten by *-skew-ps
> device tree properties described in:
> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thank you.
