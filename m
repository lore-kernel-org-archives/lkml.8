Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEA2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgEAWAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:00:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:51521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgEAV77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:59:59 -0400
IronPort-SDR: bCIK57wnTBSZycO69vYSPwGkwW/pWIlGRlErsD3YCaYachtg/79svfm/8XRDk4Ki1kUYw5lkZB
 jyj268bi3Rww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 14:59:58 -0700
IronPort-SDR: CC0Dkgglp5p1yThlp9NS9qJg3mrlsrqx8YnyHPryiFHuAj1ws0sSj0suBVfBpTlYjWPh+gBuqJ
 nBKE4JZ+pKWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="283303372"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.53.33])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 14:59:58 -0700
Subject: Re: [PATCH 2/3] mm/swap: simplify enable_swap_slots_cache()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200430061143.450-1-thunder.leizhen@huawei.com>
 <20200430061143.450-3-thunder.leizhen@huawei.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <36a2f775-2f33-2b06-048a-8f82fd288d3b@linux.intel.com>
Date:   Fri, 1 May 2020 14:59:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430061143.450-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/20 11:11 PM, Zhen Lei wrote:
> Whether swap_slot_cache_initialized is true or false,
> __reenable_swap_slots_cache() is always called. To make this meaning
> clear, leave only one call to __reenable_swap_slots_cache(). This also
> make it clearer what extra needs be done when swap_slot_cache_initialized
> is false.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  mm/swap_slots.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 01609b5f0c55..b40394473a3c 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -240,21 +240,19 @@ static int free_slot_cache(unsigned int cpu)
>  
>  int enable_swap_slots_cache(void)
>  {
> -	int ret = 0;
> -
>  	mutex_lock(&swap_slots_cache_enable_mutex);
> -	if (swap_slot_cache_initialized) {
> -		__reenable_swap_slots_cache();
> -		goto out_unlock;
> -	}
> +	if (!swap_slot_cache_initialized) {
> +		int ret;
>  
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "swap_slots_cache",
> -				alloc_swap_slot_cache, free_slot_cache);
> -	if (WARN_ONCE(ret < 0, "Cache allocation failed (%s), operating "
> -			       "without swap slots cache.\n", __func__))
> -		goto out_unlock;
> +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "swap_slots_cache",
> +					alloc_swap_slot_cache, free_slot_cache);
> +		if (WARN_ONCE(ret < 0, "Cache allocation failed (%s), operating "
> +				       "without swap slots cache.\n", __func__))
> +			goto out_unlock;
> +
> +		swap_slot_cache_initialized = true;
> +	}
>  
> -	swap_slot_cache_initialized = true;
>  	__reenable_swap_slots_cache();
>  out_unlock:
>  	mutex_unlock(&swap_slots_cache_enable_mutex);
> 
