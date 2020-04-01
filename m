Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DDC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C1020678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgDASVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:21:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37542 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbgDASVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:21:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 209BC11D69C3E;
        Wed,  1 Apr 2020 11:21:37 -0700 (PDT)
Date:   Wed, 01 Apr 2020 11:21:36 -0700 (PDT)
Message-Id: <20200401.112136.685481342101422062.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, linux@armlinux.org.uk, david@protonic.nl,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        netdev@vger.kernel.org, philippe.schenker@toradex.com
Subject: Re: [PATCH] net: phy: at803x: fix clock sink configuration on
 ATH8030 and ATH8035
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200401095732.23197-1-o.rempel@pengutronix.de>
References: <20200401095732.23197-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Apr 2020 11:21:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed,  1 Apr 2020 11:57:32 +0200

> The masks in priv->clk_25m_reg and priv->clk_25m_mask are one-bits-set
> for the values that comprise the fields, not zero-bits-set.
> 
> This patch fixes the clock frequency configuration for ATH8030 and
> ATH8035 Atheros PHYs by removing the erroneous "~".
> 
> To reproduce this bug, configure the PHY  with the device tree binding
> "qca,clk-out-frequency" and remove the machine specific PHY fixups.
> 
> Fixes: 2f664823a47021 ("net: phy: at803x: add device tree binding")
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied with Reported-by: fixed and queued up for -stable, thanks.
