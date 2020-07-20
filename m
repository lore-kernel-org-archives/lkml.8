Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7873207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGTBGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgGTBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:06:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF38C0619D2;
        Sun, 19 Jul 2020 18:06:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 99C3A12848046;
        Sun, 19 Jul 2020 18:06:08 -0700 (PDT)
Date:   Sun, 19 Jul 2020 18:06:05 -0700 (PDT)
Message-Id: <20200719.180605.1081706615520028720.davem@davemloft.net>
To:     michael@walle.cc
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
        alexandru.marginean@nxp.com, claudiu.manoil@nxp.com,
        heiko.thiery@gmail.com, linux@armlinux.org.uk,
        ioana.ciornei@nxp.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v7 0/4] net: enetc: remove bootloader
 dependency
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200719220336.6919-1-michael@walle.cc>
References: <20200719220336.6919-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Jul 2020 18:06:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>
Date: Mon, 20 Jul 2020 00:03:32 +0200

> These patches were picked from the following series:
> https://lore.kernel.org/netdev/1567779344-30965-1-git-send-email-claudiu.manoil@nxp.com/
> They have never been resent. I've picked them up, addressed Andrews
> comments, fixed some more bugs and asked Claudiu if I can keep their SOB
> tags; he agreed. I've tested this on our board which happens to have a
> bootloader which doesn't do the enetc setup in all cases. Though, only
> SGMII mode was tested.
 ...

Series applied, thank you.
