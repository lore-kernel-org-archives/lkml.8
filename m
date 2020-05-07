Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675BEC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE22064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgEGAr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEGAr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:47:56 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88FEC061A0F;
        Wed,  6 May 2020 17:47:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4D38112783B16;
        Wed,  6 May 2020 17:47:55 -0700 (PDT)
Date:   Wed, 06 May 2020 17:47:54 -0700 (PDT)
Message-Id: <20200506.174754.1326538013917922662.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     olteanv@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, vladimir.oltean@nxp.com,
        natechancellor@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] [net-next, v2] dsa: sja1105: dynamically allocate
 stats structure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200505153834.1437767-1-arnd@arndb.de>
References: <20200505153834.1437767-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 May 2020 17:47:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue,  5 May 2020 17:38:19 +0200

> The addition of sja1105_port_status_ether structure into the
> statistics causes the frame size to go over the warning limit:
> 
> drivers/net/dsa/sja1105/sja1105_ethtool.c:421:6: error: stack frame size of 1104 bytes in function 'sja1105_get_ethtool_stats' [-Werror,-Wframe-larger-than=]
> 
> Use dynamic allocation to avoid this.
> 
> Fixes: 336aa67bd027 ("net: dsa: sja1105: show more ethtool statistics counters for P/Q/R/S")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: remove extra ';'
>     remove bogus include/linux/warnings.h change

Applied, thanks Arnd.
