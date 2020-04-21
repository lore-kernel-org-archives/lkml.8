Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02961C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2009206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUWj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgDUWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:39:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D628C0610D5;
        Tue, 21 Apr 2020 15:39:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9BBD8128E6F50;
        Tue, 21 Apr 2020 15:39:27 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:39:26 -0700 (PDT)
Message-Id: <20200421.153926.2019141615844261499.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, vladimir.oltean@nxp.com,
        claudiu.manoil@nxp.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [v3, 0/7] Support programmable pins for Ocelot PTP driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200420024651.47353-1-yangbo.lu@nxp.com>
References: <20200420024651.47353-1-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Apr 2020 15:39:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon, 20 Apr 2020 10:46:44 +0800

> The Ocelot PTP clock driver had been embedded into ocelot.c driver.
> It had supported basic gettime64/settime64/adjtime/adjfine functions
> by now which were used by both Ocelot switch and Felix switch.
> 
> This patch-set is to move current ptp clock code out of ocelot.c driver
> maintaining as a single ocelot_ptp.c driver, and to implement 4
> programmable pins with only PTP_PF_PEROUT function for now.
> The PTP_PF_EXTTS function will be supported in the future, and it should
> be implemented separately for Felix and Ocelot, because of different
> hardware interrupt implementation in them.
> ---
> Changes for v2:
> 	- Put PTP driver under drivers/net/ethernet/mscc/.
> 	- Dropped MAINTAINERS patch. Kept original maintaining.
> 	- Initialized PTP separately in ocelot/felix platforms.
> 	- Supported PPS case in programmable pin.
> 	- Supported disabling pin function since deadlock is fixed by Richard.
> 	- Returned -EBUSY if not finding pin available.
> Changes for v3:
> 	- Re-sent.

Series applied to net-next, thanks.
