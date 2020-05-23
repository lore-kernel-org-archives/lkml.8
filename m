Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7855FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C1A20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgEWXdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:33:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A87C061A0E;
        Sat, 23 May 2020 16:33:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 523D01286F3A5;
        Sat, 23 May 2020 16:33:11 -0700 (PDT)
Date:   Sat, 23 May 2020 16:33:10 -0700 (PDT)
Message-Id: <20200523.163310.1379038150697586579.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: mscc: fix initialization of the
 MACsec protocol mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200522155545.881263-1-antoine.tenart@bootlin.com>
References: <20200522155545.881263-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 May 2020 16:33:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri, 22 May 2020 17:55:45 +0200

> At the very end of the MACsec block initialization in the MSCC PHY
> driver, the MACsec "protocol mode" is set. This setting should be set
> based on the PHY id within the package, as the bank used to access the
> register used depends on this. This was not done correctly, and only the
> first bank was used leading to the two upper PHYs being unstable when
> using the VSC8584. This patch fixes it.
> 
> Fixes: 1bbe0ecc2a1a ("net: phy: mscc: macsec initialization")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied and queued up for -stable, thanks.
