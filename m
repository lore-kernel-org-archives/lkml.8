Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2826C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB282176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582015229;
	bh=S7kwP8JZkRzp0ph4OowIBnZpsrqyTsoFMbCuAMQ+MYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iVnILwCcYwYyVvBOVxoh6aHVB2GRk3mbqzGQuWHrQyuqDeuS9qs5+dzqsSLmYsa4z
	 d9RR79NjMQgruRagWbn2RkvSyPkcSbpJmKzmUY4j60B2zQeR8EbavLqhEM3TNBSbis
	 1mGMaOXrHdkkxih9lKzgbl3+lQo+6yh5MUyha4i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgBRIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:40:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51286 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgBRIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:40:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so1850958wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 00:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y4L4vqax5DXxcdwoLUSziZL4YzCsONFZYcUjD/fBwIc=;
        b=GywDSw5WcriIpyIhsk5RX2Y3WMpz3BSTWeiSfqe5BxZ5If9cG9fUrON96LxNQdI3hG
         5LjYZPVrrdBfGqfXG2DPX9gRz/mbvpHkZ2wUhzsbQOqGaMlB8RGm8dPduQ+5pAaATM1S
         L5LkWSU+2OtrULoyXSCZrXKWZobnWJYVl7yvjSJF8INyp0bO3vxBtWNbKRFnLBaU/U2h
         38hYEsa+Qr4hpsR3H9f76AMl/dUsAYQwpBElKJz9HHSAUOo9q2IOiPEMKgvE6OZyEwxg
         uHxztHCBILueHJ6q2aZjYfxtycr3C36FFHnW1gGaUdPs+tLjS2UrYUwPNkS7f4mtJRR/
         PiOA==
X-Gm-Message-State: APjAAAXRK8e2dcjpqhjHNXMjfR0CY2oBCsPUK6QDyWHa0fW0mFgmscYZ
        zWzWoHZ6SapQX0I010UH0WU=
X-Google-Smtp-Source: APXvYqxQfED5fW8dxHW4UDTLGMrMLYVewY3D9xMIFdmBIm3GJmBYc8X91w7MFeF+Z293Qv4cTcFiBA==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr1782467wma.62.1582015224739;
        Tue, 18 Feb 2020 00:40:24 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r1sm5026822wrx.11.2020.02.18.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:40:23 -0800 (PST)
Date:   Tue, 18 Feb 2020 09:40:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [PATCH] mm/vmscan.c: remove cpu online notification for now
Message-ID: <20200218084023.GC21113@dhcp22.suse.cz>
References: <20200218004354.24996-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218004354.24996-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-02-20 08:43:54, Wei Yang wrote:
> The cpu online notification is used to adjust kswapd cpu affinity when a
> NUMA node gains a new CPU.
> 
> Since currently we don't see a real runtime configuration like this,
> let's drop this online notification for now.

This deserves much more explanation IMHO. What would you say about the
following.
"
kswapd kernel thread starts either with a CPU affinity set to the full
cpu mask of its target node or without any affinity at all if the node
is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
implements an elaborate way to update this mask when a cpu is onlined.

It is not really clear whether there is any actual benefit from this
scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
runtime. Drop the code for that reason. If there is a real usecase then
we can resurrect and simplify the code.
"
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
> v3:
>   * remove the cpu online notification suggested by Michal
> v2:
>   * rephrase the changelog
> ---
>  mm/vmscan.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 665f33258cd7..a4fdf3dc8887 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4023,27 +4023,6 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>  }
>  #endif /* CONFIG_HIBERNATION */
>  
> -/* It's optimal to keep kswapds on the same CPUs as their memory, but
> -   not required for correctness.  So if the last cpu in a node goes
> -   away, we get changed to run anywhere: as the first one comes back,
> -   restore their cpu bindings. */
> -static int kswapd_cpu_online(unsigned int cpu)
> -{
> -	int nid;
> -
> -	for_each_node_state(nid, N_MEMORY) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> -		const struct cpumask *mask;
> -
> -		mask = cpumask_of_node(pgdat->node_id);
> -
> -		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
> -			/* One of our CPUs online: restore mask */
> -			set_cpus_allowed_ptr(pgdat->kswapd, mask);
> -	}
> -	return 0;
> -}
> -
>  /*
>   * This kswapd start function will be called by init and node-hot-add.
>   * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
> @@ -4083,15 +4062,11 @@ void kswapd_stop(int nid)
>  
>  static int __init kswapd_init(void)
>  {
> -	int nid, ret;
> +	int nid;
>  
>  	swap_setup();
>  	for_each_node_state(nid, N_MEMORY)
>   		kswapd_run(nid);
> -	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -					"mm/vmscan:online", kswapd_cpu_online,
> -					NULL);
> -	WARN_ON(ret < 0);
>  	return 0;
>  }
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
