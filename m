Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56C3C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6EE216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgEAVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:46:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:43989 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEAVqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:46:33 -0400
IronPort-SDR: ki46bCnj3Z61G2GrH4aPO5nPF0Y97S6ek3H97z/shZHjwXexJwS/Su8gtDORcKDroO5KZUkp1t
 NKCnkRamlksQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 14:46:32 -0700
IronPort-SDR: APjvBuXoDHn2cvvuqaTFzkW4bnzIv2ckBl9UrbjPwTaOG32LjX6/6R80UAf8oYx2P+D8I4JkWh
 gEGfjESfaKWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="283301037"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.53.33])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 14:46:32 -0700
Subject: Re: [PATCH 1/3] mm/swap: simplify alloc_swap_slot_cache()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200430061143.450-1-thunder.leizhen@huawei.com>
 <20200430061143.450-2-thunder.leizhen@huawei.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <34318e00-fd1a-f8d7-14d4-0efa84b151d2@linux.intel.com>
Date:   Fri, 1 May 2020 14:46:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430061143.450-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/20 11:11 PM, Zhen Lei wrote:
> Both "slots" and "slots_ret" are only need to be freed when cache already
> allocated. Make them closer, seems more clear.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/swap_slots.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0975adc72253..01609b5f0c55 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -136,9 +136,16 @@ static int alloc_swap_slot_cache(unsigned int cpu)
>  
>  	mutex_lock(&swap_slots_cache_mutex);
>  	cache = &per_cpu(swp_slots, cpu);
> -	if (cache->slots || cache->slots_ret)
> +	if (cache->slots || cache->slots_ret) {
>  		/* cache already allocated */
> -		goto out;
> +		mutex_unlock(&swap_slots_cache_mutex);
> +
> +		kvfree(slots);
> +		kvfree(slots_ret);
> +
> +		return 0;
> +	}
> +
>  	if (!cache->lock_initialized) {
>  		mutex_init(&cache->alloc_lock);
>  		spin_lock_init(&cache->free_lock);
> @@ -155,15 +162,8 @@ static int alloc_swap_slot_cache(unsigned int cpu)
>  	 */
>  	mb();
>  	cache->slots = slots;
> -	slots = NULL;
>  	cache->slots_ret = slots_ret;
> -	slots_ret = NULL;
> -out:
>  	mutex_unlock(&swap_slots_cache_mutex);
> -	if (slots)
> -		kvfree(slots);
> -	if (slots_ret)
> -		kvfree(slots_ret);
>  	return 0;
>  }
>  
> 

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
