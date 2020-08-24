Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07842063A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHXNir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgHXNgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:36:31 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBEC061573;
        Mon, 24 Aug 2020 06:36:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1EF1128286E1;
        Mon, 24 Aug 2020 06:19:42 -0700 (PDT)
Date:   Mon, 24 Aug 2020 06:36:28 -0700 (PDT)
Message-Id: <20200824.063628.435147255804257193.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: gain ipv4 mtu when mtu is not locked
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200824113528.44193-1-linmiaohe@huawei.com>
References: <20200824113528.44193-1-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 06:19:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Mon, 24 Aug 2020 07:35:28 -0400

> When mtu is locked, we should not obtain ipv4 mtu as we return immediately
> in this case and leave acquired ipv4 mtu unused.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  net/ipv4/route.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 8ca6bcab7b03..f0a0faf58267 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1013,13 +1013,14 @@ out:	kfree_skb(skb);
>  static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
>  {
>  	struct dst_entry *dst = &rt->dst;
> -	u32 old_mtu = ipv4_mtu(dst);
> +	u32 old_mtu;
>  	struct fib_result res;
>  	bool lock = false;

Please preserve the reverse christmas tree ordering of local variables here.
