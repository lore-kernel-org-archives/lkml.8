Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8516B20857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404948AbgFXVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404563AbgFXVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:48:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E74C061573;
        Wed, 24 Jun 2020 14:48:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CB1B812737AF6;
        Wed, 24 Jun 2020 14:48:37 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:48:37 -0700 (PDT)
Message-Id: <20200624.144837.358793393121356729.davem@davemloft.net>
To:     s.hauer@pengutronix.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.petazzoni@bootlin.com,
        kernel@pengutronix.de, linux@armlinux.org.uk
Subject: Re: [PATCH 2/2] net: ethernet: mvneta: Add back interface mode
 validation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200624070045.8878-2-s.hauer@pengutronix.de>
References: <20200624070045.8878-1-s.hauer@pengutronix.de>
        <20200624070045.8878-2-s.hauer@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jun 2020 14:48:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 24 Jun 2020 09:00:45 +0200

> When writing the serdes configuration register was moved to
> mvneta_config_interface() the whole code block was removed from
> mvneta_port_power_up() in the assumption that its only purpose was to
> write the serdes configuration register. As mentioned by Russell King
> its purpose was also to check for valid interface modes early so that
> later in the driver we do not have to care for unexpected interface
> modes.
> Add back the test to let the driver bail out early on unhandled
> interface modes.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied.

Please submit a proper patch series next time, with a header [PATCH 0/N]
posting.  Thank you.
