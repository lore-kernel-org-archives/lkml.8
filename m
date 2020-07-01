Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B700020760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGATWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:22:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18828C08C5C1;
        Wed,  1 Jul 2020 12:22:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54386121110AD;
        Wed,  1 Jul 2020 12:22:42 -0700 (PDT)
Date:   Wed, 01 Jul 2020 12:22:41 -0700 (PDT)
Message-Id: <20200701.122241.894076396008620124.davem@davemloft.net>
To:     claudiu.beznea@microchip.com
Cc:     nicolas.ferre@microchip.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: use hweight_long() to count
 set bits in queue_mask
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1593608931-3718-3-git-send-email-claudiu.beznea@microchip.com>
References: <1593608931-3718-1-git-send-email-claudiu.beznea@microchip.com>
        <1593608931-3718-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Jul 2020 12:22:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Wed, 1 Jul 2020 16:08:49 +0300

> @@ -3482,8 +3482,6 @@ static void macb_probe_queues(void __iomem *mem,
>  			      unsigned int *queue_mask,
 ...
> +	*num_queues = hweight_long(*queue_mask);

queue_mask is not a long, it is an unsinged int, therefore hweight32() is
probably more appropriate.
