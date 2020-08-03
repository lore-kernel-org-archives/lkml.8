Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33242068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHCWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:38:57 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB5C06174A;
        Mon,  3 Aug 2020 15:38:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DBD3C12777713;
        Mon,  3 Aug 2020 15:22:10 -0700 (PDT)
Date:   Mon, 03 Aug 2020 15:38:55 -0700 (PDT)
Message-Id: <20200803.153855.1717799017490441577.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuba@kernel.org, fw@strlen.de, pshelar@ovn.org,
        martin.varghese@nokia.com, pabeni@redhat.com, edumazet@google.com,
        dcaratti@redhat.com, steffen.klassert@secunet.com,
        shmulik@metanetworks.com, kyk.segfault@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Use __skb_pagelen() directly in skb_cow_data()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1596274223-24555-1-git-send-email-linmiaohe@huawei.com>
References: <1596274223-24555-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:22:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Sat, 1 Aug 2020 17:30:23 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> In fact, skb_pagelen() - skb_headlen() is equal to __skb_pagelen(), use it
> directly to avoid unnecessary skb_headlen() call.
> 
> Also fix the CHECK note of checkpatch.pl:
>     Comparison to NULL could be written "!__pskb_pull_tail"
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied.
