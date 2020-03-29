Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA9C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 04:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475520659
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 04:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jAqvOvuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgC2EBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 00:01:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6495 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgC2EBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 00:01:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e801d600002>; Sat, 28 Mar 2020 21:00:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 28 Mar 2020 21:01:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 28 Mar 2020 21:01:19 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Mar
 2020 04:00:26 +0000
Subject: Re: [Patch v3] mm/page_alloc.c: use NODE_MASK_NONE define used_mask
To:     Wei Yang <richard.weiyang@gmail.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <jgg@ziepe.ca>, <david@redhat.com>, <bhe@redhat.com>
References: <20200329024217.5199-1-richard.weiyang@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8d6a1cd3-75cf-78c3-b83b-c5208a209f65@nvidia.com>
Date:   Sat, 28 Mar 2020 21:00:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200329024217.5199-1-richard.weiyang@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585454432; bh=5Fs3IE4i4iRLLBVddscrDk15dILBhHBWSFTEWwaYXSE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jAqvOvuMCuHbRMVfkrvc7NXqjfZYe7GA1kK6eR/W3qwFw9E5dbiyJW2a+LGbPfZaF
         3cGLy2B/TKxRXIxTKRcGcVW/uBjF0HD+QGjs09u7il5QpX+Sgr4VwD6XhCf5EqVDtd
         0PMY/9DoADs9Dm7w7NRTdIloOvXv5W5sDkvHjDTejNw5yTL2GuJkOAR4nblEC4oqsU
         9Jdhdql+ZWjFo+m1dCEwNikBv6DZpJpiGSaw0aeIVD6jYh+uSf+bW5vq05w/UTGwEu
         zavroNvgEMrAehJOmOleZtqO/vHMWfAA6pRwg9HZaT2HnDdDHnkBMLlX26FaaENAJk
         vxKMVgZfKgsug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/20 7:42 PM, Wei Yang wrote:
> For all 0 nodemask_t, we have already define macro NODE_MASK_NONE.
> Leverage this to define an all clear nodemask.

It would be a little clearer if you used wording more like this:

Subject: [Patch v3] mm/page_alloc.c: use NODE_MASK_NONE in build_zonelists()

Slightly simplify the code by initializing user_mask with
NODE_MASK_NONE, instead of later calling nodes_clear(). This saves
a line of code.


> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v3: adjust the commit log a little
> v2: use NODE_MASK_NONE as suggested by David Hildenbrand
> ---
>   mm/page_alloc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ef790dfad6aa..dfcf2682ed40 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>   {
>   	static int node_order[MAX_NUMNODES];
>   	int node, load, nr_nodes = 0;
> -	nodemask_t used_mask;
> +	nodemask_t used_mask = NODE_MASK_NONE;
>   	int local_node, prev_node;
>   
>   	/* NUMA-aware ordering of nodes */
>   	local_node = pgdat->node_id;
>   	load = nr_online_nodes;
>   	prev_node = local_node;
> -	nodes_clear(used_mask);
>   
>   	memset(node_order, 0, sizeof(node_order));
>   	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
> 

Honestly, I don't think it's really worth doing a patch for this, but
there's nothing wrong with the diff, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
