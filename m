Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE227C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21D520717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGRBc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:32:56 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD89C0619D2;
        Fri, 17 Jul 2020 18:32:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7D9C111E45910;
        Fri, 17 Jul 2020 18:32:55 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:32:54 -0700 (PDT)
Message-Id: <20200717.183254.1462145544224960495.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     nicolas.ferre@microchip.com, kuba@kernel.org, andrew@lunn.ch,
        philippe.schenker@toradex.com, linux@rempel-privat.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: macb: use phy_interface_mode_is_rgmii
 everywhere
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200717233221.840294-1-alexandre.belloni@bootlin.com>
References: <20200717233221.840294-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:32:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sat, 18 Jul 2020 01:32:21 +0200

> There is one RGMII check not using the phy_interface_mode_is_rgmii()
> helper. This prevents the driver from configuring the MAC properly when
> using a phy-mode that is not just rgmii, e.g. rgmii-rxid. This became an
> issue on sama5d3 xplained since the ksz9031 driver is hadling phy-mode
> properly and the phy-mode has to be set to rgmii-rxid.
> 
> Fixes: bcf3440c6dd78bfe ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied, thank you.
