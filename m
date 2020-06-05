Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8238C207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgFEUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgFEUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:16:35 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2CC08C5C2;
        Fri,  5 Jun 2020 13:16:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EDFD4127B0475;
        Fri,  5 Jun 2020 13:16:34 -0700 (PDT)
Date:   Fri, 05 Jun 2020 13:16:34 -0700 (PDT)
Message-Id: <20200605.131634.322571423468863173.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        michael@walle.cc, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mscc: fix Serdes configuration in
 vsc8584_config_init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200605140009.1352990-1-antoine.tenart@bootlin.com>
References: <20200605140009.1352990-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Jun 2020 13:16:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  5 Jun 2020 16:00:09 +0200

> When converting the MSCC PHY driver to shared PHY packages, the Serdes
> configuration in vsc8584_config_init was modified to use 'base_addr'
> instead of 'base' as the port number. But 'base_addr' isn't equal to
> 'addr' for all PHYs inside the package, which leads to the Serdes still
> being enabled on those ports. This patch fixes it.
> 
> Fixes: deb04e9c0ff2 ("net: phy: mscc: use phy_package_shared")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thank you.
