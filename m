Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB3C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455682084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgB0Exz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:53:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgB0Exy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:53:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3FF0215B47CAF;
        Wed, 26 Feb 2020 20:53:54 -0800 (PST)
Date:   Wed, 26 Feb 2020 20:53:53 -0800 (PST)
Message-Id: <20200226.205353.1682191645507452325.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss@0leil.net
Subject: Re: [PATCH net] net: phy: mscc: fix firmware paths
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200226152650.1525515-1-antoine.tenart@bootlin.com>
References: <20200226152650.1525515-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Feb 2020 20:53:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 26 Feb 2020 16:26:50 +0100

> The firmware paths for the VSC8584 PHYs not not contain the leading
> 'microchip/' directory, as used in linux-firmware, resulting in an
> error when probing the driver. This patch fixes it.
> 
> Fixes: a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thanks Antoine.
