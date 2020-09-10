Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6889DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CBF21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIJTje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgIJTjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:39:14 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64DC061573;
        Thu, 10 Sep 2020 12:39:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D25712A30019;
        Thu, 10 Sep 2020 12:22:27 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:39:13 -0700 (PDT)
Message-Id: <20200910.123913.1333297432408477303.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        john.fastabend@gmail.com, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net] net: sch_generic: aviod concurrent reset and
 enqueue op for lockless qdisc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1599562954-87257-1-git-send-email-linyunsheng@huawei.com>
References: <1599562954-87257-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 12:22:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 8 Sep 2020 19:02:34 +0800

> Currently there is concurrent reset and enqueue operation for the
> same lockless qdisc when there is no lock to synchronize the
> q->enqueue() in __dev_xmit_skb() with the qdisc reset operation in
> qdisc_deactivate() called by dev_deactivate_queue(), which may cause
> out-of-bounds access for priv->ring[] in hns3 driver if user has
> requested a smaller queue num when __dev_xmit_skb() still enqueue a
> skb with a larger queue_mapping after the corresponding qdisc is
> reset, and call hns3_nic_net_xmit() with that skb later.
> 
> Reused the existing synchronize_net() in dev_deactivate_many() to
> make sure skb with larger queue_mapping enqueued to old qdisc(which
> is saved in dev_queue->qdisc_sleeping) will always be reset when
> dev_reset_queue() is called.
> 
> Fixes: 6b3ba9146fe6 ("net: sched: allow qdiscs to handle locking")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> ChangeLog V2:
> 	Reuse existing synchronize_net().

Applied and queued up for -stable, thank you.
