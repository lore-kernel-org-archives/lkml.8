Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97867C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA74206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgF2Doj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgF2Doi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:44:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC8C03E979;
        Sun, 28 Jun 2020 20:44:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7EDD5129A4D41;
        Sun, 28 Jun 2020 20:44:37 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:44:36 -0700 (PDT)
Message-Id: <20200628.204436.799047852779320132.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        kuba@kernel.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, lkp@intel.com
Subject: Re: [PATCH net] bridge: mrp: Fix endian conversion and some other
 warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200628134516.3767607-1-horatiu.vultur@microchip.com>
References: <20200628134516.3767607-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Jun 2020 20:44:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 28 Jun 2020 15:45:16 +0200

> The following sparse warnings are fixed:
> net/bridge/br_mrp.c:106:18: warning: incorrect type in assignment (different base types)
> net/bridge/br_mrp.c:106:18:    expected unsigned short [usertype]
> net/bridge/br_mrp.c:106:18:    got restricted __be16 [usertype]
> net/bridge/br_mrp.c:281:23: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:281:23:    expected struct list_head *entry
> net/bridge/br_mrp.c:281:23:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:332:28: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:332:28:    expected struct list_head *new
> net/bridge/br_mrp.c:332:28:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:332:40: warning: incorrect type in argument 2 (different modifiers)
> net/bridge/br_mrp.c:332:40:    expected struct list_head *head
> net/bridge/br_mrp.c:332:40:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:682:29: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:682:29:    expected struct list_head const *head
> net/bridge/br_mrp.c:682:29:    got struct list_head [noderef] *
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 2f1a11ae11d222 ("bridge: mrp: Add MRP interface.")
> Fixes: 4b8d7d4c599182 ("bridge: mrp: Extend bridge interface")
> Fixes: 9a9f26e8f7ea30 ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied, thank you.
