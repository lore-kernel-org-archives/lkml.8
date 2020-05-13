Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3750DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E657B20671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbgEMTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387469AbgEMTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:36:13 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866EC061A0C;
        Wed, 13 May 2020 12:36:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA501127EA7F6;
        Wed, 13 May 2020 12:36:12 -0700 (PDT)
Date:   Wed, 13 May 2020 12:36:11 -0700 (PDT)
Message-Id: <20200513.123611.1272910638699127501.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        marex@denx.de, david@protonic.nl, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: phy: tja11xx: add cable-test support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200513123440.19580-1-o.rempel@pengutronix.de>
References: <20200513123440.19580-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 May 2020 12:36:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 13 May 2020 14:34:40 +0200

> Add initial cable testing support.
> This PHY needs only 100usec for this test and it is recommended to run it
> before the link is up. For now, provide at least ethtool support, so it
> can be tested by more developers.
> 
> This patch was tested with TJA1102 PHY with following results:
> - No cable, is detected as open
> - 1m cable, with no connected other end and detected as open
> - a 40m cable (out of spec, max lenght should be 15m) is detected as OK.
> 
> Current patch do not provide polarity test support. This test would
> indicate not proper wire connection, where "+" wire of main phy is
> connected to the "-" wire of the link partner.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks.
