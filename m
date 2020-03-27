Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28512C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E844C20663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pHcQG+1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgC0Wh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:37:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11048 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0Wh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:37:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e80380000>; Fri, 27 Mar 2020 15:37:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 15:37:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 27 Mar 2020 15:37:57 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 22:37:57 +0000
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
To:     Wei Yang <richard.weiyang@gmail.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <jgg@ziepe.ca>, <david@redhat.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
Date:   Fri, 27 Mar 2020 15:37:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327220121.27823-2-richard.weiyang@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585348664; bh=wICTeUYozVm+quzs+Nfk2y7usqwVZCyFqx6HcmkaOZ8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pHcQG+1rpMLT51VYJ5vwHY3KcztuvUeQ+z9YV1441wO/PKOnEAORx/0rFLZIesauj
         cfCQneKKlOonMfpsrRG8wh8HKxI5oZhhiCrUvpBLJXv1MJV4pdebOf+0cxhiW1aeE+
         HFeJzYf2EOz413btNGdoeSqcyPc186ZSPIL28V4TBBr4wTNfBtz5eyGKVUgQNbcK2A
         jYRuVnmbl26Yili5U6rQjrl769X4MLM0wBa9MCxLeMvaJ22pJrPC94Nb1hK2emlOs9
         Eo69UlF+kwWO+dcpBwZZoqsQi6n2zu2Kv8ruhUnbpW0Wr0jwYUNzP/HxXJMfq6dxb6
         Ov/10oWXxUU/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 3:01 PM, Wei Yang wrote:
> Since we always clear node_order before getting it, we can leverage
> compiler to do this instead of at run time.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>   mm/page_alloc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dfcf2682ed40..49dd1f25c000 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>   
>   static void build_zonelists(pg_data_t *pgdat)
>   {
> -	static int node_order[MAX_NUMNODES];
> +	static int node_order[MAX_NUMNODES] = {0};


Looks wrong: now the single instance of node_order is initialized just once by
the compiler. And that means that only the first caller of this function
gets a zeroed node_order array...


>   	int node, load, nr_nodes = 0;
>   	nodemask_t used_mask = NODE_MASK_NONE;
>   	int local_node, prev_node;
> @@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
>   	load = nr_online_nodes;
>   	prev_node = local_node;
>   
> -	memset(node_order, 0, sizeof(node_order));

...and all subsequent callers are left with whatever debris is remaining in
node_order. So this is not good.

The reason that memset() was used here, is that there aren't many other ways
to get node_order zeroed, given that it is a statically defined variable.


>   	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
>   		/*
>   		 * We don't want to pressure a particular node.
> 



thanks,
-- 
John Hubbard
NVIDIA
