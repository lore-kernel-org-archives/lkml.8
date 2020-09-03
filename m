Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE4C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DBC20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgICWOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICWOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:14:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4EC061244;
        Thu,  3 Sep 2020 15:14:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 27145127A0335;
        Thu,  3 Sep 2020 14:57:19 -0700 (PDT)
Date:   Thu, 03 Sep 2020 15:14:04 -0700 (PDT)
Message-Id: <20200903.151404.2085033333649714923.davem@davemloft.net>
To:     paul.davey@alliedtelesis.co.nz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] Allow more than 255 IPv4 multicast
 interfaces
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200902032222.25109-1-paul.davey@alliedtelesis.co.nz>
References: <20200902032222.25109-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 03 Sep 2020 14:57:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Davey <paul.davey@alliedtelesis.co.nz>
Date: Wed,  2 Sep 2020 15:22:20 +1200

> Currently it is not possible to use more than 255 multicast interfaces
> for IPv4 due to the format of the igmpmsg header which only has 8 bits
> available for the VIF ID.  There is enough space for the full VIF ID in
> the Netlink cache notifications, however the value is currently taken
> directly from the igmpmsg header and has thus already been truncated.
> 
> Using the full VIF ID in the Netlink notifications allows use of more
> than 255 IPv4 multicast interfaces if the user space routing daemon
> uses the Netlink notifications instead of the igmpmsg cache reports.
> 
> However doing this reveals a deficiency in the Netlink cache report
> notifications, they lack any means for differentiating cache reports
> relating to different multicast routing tables.  This is easily
> resolved by adding the multicast route table ID to the cache reports.

But this means that mrouted has no way to see the full 16-bit value
via traditional igmpmsg UAPI interfaces.

Please instead make use of the unused3 member to store the high
order 16-bits of the vifi_t in the igmpmsg, and then code your
netlink changes around that.

