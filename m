Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83038205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgEMTvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390607AbgEMTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:51:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4DC061A0C;
        Wed, 13 May 2020 12:51:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4BD08127EDEB5;
        Wed, 13 May 2020 12:51:19 -0700 (PDT)
Date:   Wed, 13 May 2020 12:51:18 -0700 (PDT)
Message-Id: <20200513.125118.530283029054955948.davem@davemloft.net>
To:     michael@walle.cc
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next v2] net: phy: at803x: add cable diagnostics
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200513161252.27723-1-michael@walle.cc>
References: <20200513161252.27723-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 May 2020 12:51:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>
Date: Wed, 13 May 2020 18:12:52 +0200

> The AR8031/AR8033 and the AR8035 support cable diagnostics. Adding
> driver support is straightforward, so lets add it.
> 
> The PHY just do one pair at a time, so we have to start the test four
> times. The cable_test_get_status() can block and therefore we can just
> busy poll the test completion and continue with the next pair until we
> are done.
> The time delta counter seems to run at 125MHz which just gives us a
> resolution of about 82.4cm per tick.
 ...
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This doesn't apply cleanly to net-next, please respin.
