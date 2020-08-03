Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94296C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B3206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgHCNzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:55:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgHCNzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:55:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA709B5B9;
        Mon,  3 Aug 2020 13:55:36 +0000 (UTC)
Subject: Re: [PATCH] mm, memory_hotplug: update pcp lists everytime onlining a
 memory block
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b9502c00-521c-5b13-9c31-fd2da12bff6c@suse.cz>
Date:   Mon, 3 Aug 2020 15:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/20 2:54 PM, Charan Teja Reddy wrote:
> When onlining a first memory block in a zone, pcp lists are not updated
> thus pcp struct will have the default setting of ->high = 0,->batch = 1.
> This means till the second memory block in a zone(if it have) is onlined
> the pcp lists of this zone will not contain any pages because pcp's
> ->count is always greater than ->high thus free_pcppages_bulk() is
> called to free batch size(=1) pages every time system wants to add a
> page to the pcp list through free_unref_page(). To put this in a word,
> system is not using benefits offered by the pcp lists when there is a
> single onlineable memory block in a zone. Correct this by always
> updating the pcp lists when memory block is onlined.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Makes sense to me.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory_hotplug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index dcdf327..7f62d69 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -854,8 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	node_states_set_node(nid, &arg);
>  	if (need_zonelists_rebuild)
>  		build_all_zonelists(NULL);
> -	else
> -		zone_pcp_update(zone);
> +	zone_pcp_update(zone);
>  
>  	init_per_zone_wmark_min();
>  
> 

