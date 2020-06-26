Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338F420B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFZUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:00:33 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBFC03E979;
        Fri, 26 Jun 2020 13:00:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D72CF118EE359;
        Fri, 26 Jun 2020 13:00:32 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:00:29 -0700 (PDT)
Message-Id: <20200626.130029.89317239393030387.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next v3 0/2] bridge: mrp: Extend MRP netlink
 interface with IFLA_BRIDGE_MRP_CLEAR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200626073349.3495526-1-horatiu.vultur@microchip.com>
References: <20200626073349.3495526-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Jun 2020 13:00:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 26 Jun 2020 09:33:47 +0200

> This patch series extends MRP netlink interface with IFLA_BRIDGE_MRP_CLEAR.
> To allow the userspace to clear all MRP instances when is started. The
> second patch in the series fix different sparse warnings.
> 
> v3:
>   - add the second patch to fix sparse warnings

These changes are completely unrelated.

The sparse stuff should probably be submitted to 'net'.

And I have to ask why you really need a clear operation.  Routing
daemons come up and see what routes are installed, and update their
internal SW tables to match.  This not only allows efficient restart
after a crash, but it also allows multiple daemons to work
cooperatively as an agent for the same forwarding/routing table.

Your usage model limits one daemon to manage the table and that
limitation is completely unnecessary.

Furthermore, even in a one-daemon scenerio, it's wasteful to throw
away all the work the previous daemon did to load the MRP entries into
the bridge.

Thanks.

