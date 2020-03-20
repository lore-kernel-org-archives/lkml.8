Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB65A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCTEDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:03:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTEDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:03:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C5E3A158F9845;
        Thu, 19 Mar 2020 21:03:29 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:03:29 -0700 (PDT)
Message-Id: <20200319.210329.1045324274739014303.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mscc: add missing check on a
 phy_write return value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200319124819.369431-1-antoine.tenart@bootlin.com>
References: <20200319124819.369431-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Mar 2020 21:03:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 19 Mar 2020 13:48:19 +0100

> Commit a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
> introduced a call to 'phy_write' storing its return value to a variable
> called 'ret'. But 'ret' never was checked for a possible error being
> returned, and hence was not used at all. Fix this by checking the return
> value and exiting the function if an error was returned.
> 
> As this does not fix a known bug, this commit is mostly cosmetic and not
> sent as a fix.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thanks.
