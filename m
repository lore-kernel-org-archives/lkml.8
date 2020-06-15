Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71379C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515952074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgFOUWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgFOUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:22:39 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A2C061A0E;
        Mon, 15 Jun 2020 13:22:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E9C2120ED49B;
        Mon, 15 Jun 2020 13:22:39 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:22:38 -0700 (PDT)
Message-Id: <20200615.132238.313795664514868636.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] MAINTAINERS: merge entries for felix and ocelot
 drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200615164244.2012128-1-olteanv@gmail.com>
References: <20200615164244.2012128-1-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Jun 2020 13:22:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon, 15 Jun 2020 19:42:44 +0300

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The ocelot switchdev driver also provides a set of library functions for
> the felix DSA driver, which in practice means that most of the patches
> will be of interest to both groups of driver maintainers.
> 
> So, as also suggested in the discussion here, let's merge the 2 entries
> into a single larger one:
> https://www.spinics.net/lists/netdev/msg657412.html
> 
> Note that the entry has been renamed into "OCELOT SWITCH" since neither
> Vitesse nor Microsemi exist any longer as company names, instead they
> are now named Microchip (which again might be subject to change in the
> future), so use the device family name instead.
> 
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied, thanks.
