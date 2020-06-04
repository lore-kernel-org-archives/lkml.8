Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BB0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B015207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgFDW5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgFDW5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:57:17 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183EC08C5C0;
        Thu,  4 Jun 2020 15:57:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 992EF11F5F8D1;
        Thu,  4 Jun 2020 15:57:16 -0700 (PDT)
Date:   Thu, 04 Jun 2020 15:57:16 -0700 (PDT)
Message-Id: <20200604.155716.280327596063370464.davem@davemloft.net>
To:     rberg@berg-solutions.de
Cc:     andrew@lunn.ch, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan743x: Use correct MAC_CR configuration for 1 GBit
 speed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200603215414.3606-1-rberg@berg-solutions.de>
References: <20200603215414.3606-1-rberg@berg-solutions.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Jun 2020 15:57:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roelof Berg <rberg@berg-solutions.de>
Date: Wed,  3 Jun 2020 23:54:14 +0200

> Corrected the MAC_CR configuration bits for 1 GBit operation. The data
> sheet allows MAC_CR(2:1) to be 10 and also 11 for 1 GBit/s speed, but
> only 10 works correctly.
> 
> Devices tested:
> Microchip Lan7431, fixed-phy mode
> Microchip Lan7430, normal phy mode
> 
> Signed-off-by: Roelof Berg <rberg@berg-solutions.de>

Applied, thank you.
