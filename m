Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5093C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69821556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCAFYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:24:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgCAFYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:24:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ED93915BD8517;
        Sat, 29 Feb 2020 21:24:05 -0800 (PST)
Date:   Sat, 29 Feb 2020 21:24:05 -0800 (PST)
Message-Id: <20200229.212405.1585068735076348304.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: mscc: support LOS active low
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200227161010.GC1686232@kwain>
References: <20200227154033.1688498-1-antoine.tenart@bootlin.com>
        <20200227155440.GC5245@lunn.ch>
        <20200227161010.GC1686232@kwain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Feb 2020 21:24:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 27 Feb 2020 17:10:10 +0100

> Hello Andrew,
> 
> On Thu, Feb 27, 2020 at 04:54:40PM +0100, Andrew Lunn wrote:
>> On Thu, Feb 27, 2020 at 04:40:31PM +0100, Antoine Tenart wrote:
>> > 
>> > This series adds a device tree property for the VSC8584 PHY family to
>> > describe the LOS pin connected to the PHY as being active low. This new
>> > property is then used in the MSCC PHY driver.
>> 
>> I think i'm missing the big picture.
>> 
>> Is this for when an SFP is connected directly to the PHY? The SFP
>> output LOS, indicating loss of received fibre/copper signal, is active
>> low?
> 
> Yes, the SFP cage can be connected directly to the PHY, and the SFP LOS
> signal is active low (there's a pull-up on the LOS line).
> 
> Also, I realized I send this series before my other patches adding
> support for fibre mode on this PHY, so it may make more sense to send
> this one after.

Please do so, I'll mark these as deferred in patchwork.
