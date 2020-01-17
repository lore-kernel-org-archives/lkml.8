Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA14C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0C24653
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAQKNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:13:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgAQKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:13:08 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 90F9C155C314E;
        Fri, 17 Jan 2020 02:13:05 -0800 (PST)
Date:   Fri, 17 Jan 2020 02:13:03 -0800 (PST)
Message-Id: <20200117.021303.345472263852340147.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, cphealy@gmail.com,
        rmk+kernel@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: Maintain MDIO device and bus
 statistics
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200116044856.1819-1-f.fainelli@gmail.com>
References: <20200116044856.1819-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jan 2020 02:13:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 15 Jan 2020 20:48:50 -0800

> We maintain global statistics for an entire MDIO bus, as well as broken
> down, per MDIO bus address statistics. Given that it is possible for
> MDIO devices such as switches to access MDIO bus addresses for which
> there is not a mdio_device instance created (therefore not a a
> corresponding device directory in sysfs either), we also maintain
> per-address statistics under the statistics folder. The layout looks
> like this:
> 
> /sys/class/mdio_bus/../statistics/
> 	transfers
> 	errrors
> 	writes
> 	reads
> 	transfers_<addr>
> 	errors_<addr>
> 	writes_<addr>
> 	reads_<addr>
> 
> When a mdio_device instance is registered, a statistics/ folder is
> created with the tranfers, errors, writes and reads attributes which
> point to the appropriate MDIO bus statistics structure.
> 
> Statistics are 64-bit unsigned quantities and maintained through the
> u64_stats_sync.h helper functions.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
