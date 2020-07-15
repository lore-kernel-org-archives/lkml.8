Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE744C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1520729
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGOCuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:50:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgGOCuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:50:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1020212216B6C871097B;
        Wed, 15 Jul 2020 10:50:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:50:12 +0800
Subject: Re: [PATCH net-next] netpoll: Remove unused inline function
 netpoll_netdev_init()
To:     <edumazet@google.com>, <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>
References: <20200715024123.34288-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <1d95064a-4e5b-77f8-3969-e0ac64a161ab@huawei.com>
Date:   Wed, 15 Jul 2020 10:50:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200715024123.34288-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this.

On 2020/7/15 10:41, YueHaibing wrote:
> commit d565b0a1a9b6 ("net: Add Generic Receive Offload infrastructure")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/netpoll.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index f47af135bd56..e6a2d72e0dc7 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -102,9 +102,6 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
>  static inline void netpoll_poll_unlock(void *have)
>  {
>  }
> -static inline void netpoll_netdev_init(struct net_device *dev)
> -{
> -}
>  static inline bool netpoll_tx_running(struct net_device *dev)
>  {
>  	return false;
> 

