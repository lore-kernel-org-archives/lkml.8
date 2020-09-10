Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ECDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAAF20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIJT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgIJT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:26:18 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FCC061756;
        Thu, 10 Sep 2020 12:26:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B092F12A2A784;
        Thu, 10 Sep 2020 12:09:20 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:26:06 -0700 (PDT)
Message-Id: <20200910.122606.1088855592206611092.davem@davemloft.net>
To:     paul.davey@alliedtelesis.co.nz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] Allow more than 255 IPv4 multicast
 interfaces
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200907220408.32385-1-paul.davey@alliedtelesis.co.nz>
References: <20200907220408.32385-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 12:09:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Davey <paul.davey@alliedtelesis.co.nz>
Date: Tue,  8 Sep 2020 10:04:05 +1200

> Currently it is not possible to use more than 255 multicast interfaces
> for IPv4 due to the format of the igmpmsg header which only has 8 bits
> available for the VIF ID.  There is space available in the igmpmsg
> header to store the full VIF ID in the form of an unused byte following
> the VIF ID field.  There is also enough space for the full VIF ID in
> the Netlink cache notifications, however the value is currently taken
> directly from the igmpmsg header and has thus already been truncated.
> 
> Adding the high byte of the VIF ID into the unused3 byte of igmpmsg
> allows use of more than 255 IPv4 multicast interfaces. The full VIF ID
> is  also available in the Netlink notification by assembling it from
> both bytes from the igmpmsg.
> 
> Additionally this reveals a deficiency in the Netlink cache report
> notifications, they lack any means for differentiating cache reports
> relating to different multicast routing tables.  This is easily
> resolved by adding the multicast route table ID to the cache reports.
> 
> changes in v2:
>  - Added high byte of VIF ID to igmpmsg struct replacing unused3
>    member.
>  - Assemble VIF ID in Netlink notification from both bytes in igmpmsg
>    header.

Series applied, thank you.
