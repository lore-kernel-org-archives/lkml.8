Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02791C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 23:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D640E20704
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 23:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgHPXBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 19:01:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DDC061786;
        Sun, 16 Aug 2020 16:01:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8957311E47940;
        Sun, 16 Aug 2020 15:44:36 -0700 (PDT)
Date:   Sun, 16 Aug 2020 16:01:21 -0700 (PDT)
Message-Id: <20200816.160121.1844792203483101827.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuba@kernel.org, martin.varghese@nokia.com, fw@strlen.de,
        pshelar@ovn.org, dcaratti@redhat.com, edumazet@google.com,
        steffen.klassert@secunet.com, pabeni@redhat.com,
        shmulik@metanetworks.com, kyk.segfault@gmail.com,
        sowmini.varadhan@oracle.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: handle the return value of pskb_carve_frag_list()
 correctly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200815084641.18417-1-linmiaohe@huawei.com>
References: <20200815084641.18417-1-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Aug 2020 15:44:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Sat, 15 Aug 2020 04:46:41 -0400

> +	/* split line is in frag list */
> +	if (k == 0 && pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask)) {
> +		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
> +		if (skb_has_frag_list(skb))
> +			kfree_skb_list(skb_shinfo(skb)->frag_list);
> +		kfree(data);
> +		return -ENOMEM;

On error, the caller is going to kfree_skb(skb) which will take care of the
frag list.
