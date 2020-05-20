Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3DA2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgETKts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:49:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C096AD4D;
        Wed, 20 May 2020 10:49:49 +0000 (UTC)
Subject: Re: [PATCH v3 01/19] mm: memcg: factor out memcg- and lruvec-level
 changes out of __mod_lruvec_state()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-2-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a94d35e-c148-2471-6c6a-b213f220ed9b@suse.cz>
Date:   Wed, 20 May 2020 12:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> To convert memcg and lruvec slab counters to bytes there must be
> a way to change these counters without touching node counters.
> Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -713,30 +713,14 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  	return mem_cgroup_nodeinfo(parent, nid);
>  }
>  
> -/**
> - * __mod_lruvec_state - update lruvec memory statistics
> - * @lruvec: the lruvec
> - * @idx: the stat item
> - * @val: delta to add to the counter, can be negative
> - *
> - * The lruvec is the intersection of the NUMA node and a cgroup. This
> - * function updates the all three counters that are affected by a
> - * change of state at this level: per-node, per-cgroup, per-lruvec.
> - */
> -void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			int val)
> +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> +			      int val)
>  {
>  	pg_data_t *pgdat = lruvec_pgdat(lruvec);

Looks like the pgdat can now be moved into the MEMCG_CHARGE_BATCH if().

