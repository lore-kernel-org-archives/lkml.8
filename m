Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0339C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8359320707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407623AbgFYXAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgFYXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:00:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22FC08C5C1;
        Thu, 25 Jun 2020 16:00:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5228D12740311;
        Thu, 25 Jun 2020 16:00:13 -0700 (PDT)
Date:   Thu, 25 Jun 2020 16:00:09 -0700 (PDT)
Message-Id: <20200625.160009.461208269389991702.davem@davemloft.net>
To:     claudiu.beznea@microchip.com
Cc:     nicolas.ferre@microchip.com, kuba@kernel.org,
        alexandre.belloni@bootlin.com, antoine.tenart@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: macb: call pm_runtime_put_sync on failure
 path
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592993298-26533-1-git-send-email-claudiu.beznea@microchip.com>
References: <1592993298-26533-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jun 2020 16:00:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Wed, 24 Jun 2020 13:08:17 +0300

> Call pm_runtime_put_sync() on failure path of at91ether_open.
> 
> Fixes: e6a41c23df0d ("net: macb: ensure interface is not suspended on at91rm9200")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied and queued up for -stable.
