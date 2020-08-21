Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA50620748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHURDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:01 -0400
Received: from elvis.franken.de ([193.175.24.41]:54990 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgHUQ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:57:42 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k9AME-0003dt-00; Fri, 21 Aug 2020 18:57:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 79A5CC0D8F; Fri, 21 Aug 2020 18:55:39 +0200 (CEST)
Date:   Fri, 21 Aug 2020 18:55:39 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] MIPS: cacheinfo: Add missing VCache
Message-ID: <20200821165539.GA15948@alpha.franken.de>
References: <20200820004253.3418-1-jiaxun.yang@flygoat.com>
 <20200820004253.3418-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820004253.3418-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 08:42:49AM +0800, Jiaxun Yang wrote:
> Victim Cache is defined by Loongson as per-core unified
> private Cache.
> Add this into cacheinfo and make cache levels selfincrement
> instead of hardcode levels.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kernel/cacheinfo.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
> index 47312c529410..83548331ee94 100644
> --- a/arch/mips/kernel/cacheinfo.c
> +++ b/arch/mips/kernel/cacheinfo.c
> @@ -35,6 +35,11 @@ static int __init_cache_level(unsigned int cpu)
>  
>  	leaves += (c->icache.waysize) ? 2 : 1;
>  
> +	if (c->vcache.waysize) {
> +		levels++;
> +		leaves++;
> +	}
> +
>  	if (c->scache.waysize) {
>  		levels++;
>  		leaves++;
> @@ -74,25 +79,38 @@ static int __populate_cache_leaves(unsigned int cpu)
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +	int level = 1;
>  
>  	if (c->icache.waysize) {
> -		/* L1 caches are per core */
> +		/* D/I caches are per core */
>  		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
> -		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_DATA);
> +		populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA);
>  		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
> -		populate_cache(icache, this_leaf, 1, CACHE_TYPE_INST);
> +		populate_cache(icache, this_leaf, level, CACHE_TYPE_INST);
> +		level++;
>  	} else {
> -		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
> +		populate_cache(dcache, this_leaf, level, CACHE_TYPE_UNIFIED);
> +		level++;
> +	}
> +
> +	if (c->vcache.waysize) {

why can't we insert vcache as level 4 and leave the rest of the file
alone ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
