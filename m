Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EFCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DAB20719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596445236;
	bh=iRFKgEQS2710N3aM+UY14ahjPfc80BpLMsJmaeFWt/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eOCvo6qP4XH/qbVy/6YAa723P3vAkI0e8SKCSG3ItOImUyX3+igK6UyoDh9QITel4
	 k9IeIgx6kUp0cor7ACTKik90NUokb2Q9GS51MmJCiV4vdxs/biIHAVsvxy7jcn4xNH
	 Vn2Gn2ifc65GTvHjqvCiMrEzgREd30BUh894+eW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHCJAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:00:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgHCJAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:00:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B3CAAD12;
        Mon,  3 Aug 2020 09:00:49 +0000 (UTC)
Date:   Mon, 3 Aug 2020 11:00:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/19] mm: memcontrol: decouple reference counting
 from page accounting
Message-ID: <20200803090033.GE5174@dhcp22.suse.cz>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623174037.3951353-6-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry for coming late here.

On Tue 23-06-20 10:40:23, Roman Gushchin wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> The reference counting of a memcg is currently coupled directly to how
> many 4k pages are charged to it.  This doesn't work well with Roman's new
> slab controller, which maintains pools of objects and doesn't want to keep
> an extra balance sheet for the pages backing those objects.
> 
> This unusual refcounting design (reference counts usually track pointers
> to an object) is only for historical reasons: memcg used to not take any
> css references and simply stalled offlining until all charges had been
> reparented and the page counters had dropped to zero.  When we got rid of
> the reparenting requirement, the simple mechanical translation was to take
> a reference for every charge.
> 
> More historical context can be found in commit e8ea14cc6ead ("mm:
> memcontrol: take a css reference for each charged page"), commit
> 64f219938941 ("mm: memcontrol: remove obsolete kmemcg pinning tricks") and
> commit b2052564e66d ("mm: memcontrol: continue cache reclaim from offlined
> groups").
> 
> The new slab controller exposes the limitations in this scheme, so let's
> switch it to a more idiomatic reference counting model based on actual
> kernel pointers to the memcg:
> 
> - The per-cpu stock holds a reference to the memcg its caching
> 
> - User pages hold a reference for their page->mem_cgroup. Transparent
>   huge pages will no longer acquire tail references in advance, we'll
>   get them if needed during the split.
> 
> - Kernel pages hold a reference for their page->mem_cgroup
> 
> - Pages allocated in the root cgroup will acquire and release css
>   references for simplicity. css_get() and css_put() optimize that.
> 
> - The current memcg_charge_slab() already hacked around the per-charge
>   references; this change gets rid of that as well.

just for completeness
- tcp accounting will handle reference in mem_cgroup_sk_{alloc,free}

As all those paths are handling the reference count differently it is
probably good to remind that in a comment:
/* Caller is responsible to hold reference for the existence of the charged object *

for try_charge function.

We will need to be more careful (e.g. http://lkml.kernel.org/r/alpine.LSU.2.11.2007302011450.2347@eggly.anvils)
but considering that the old model doesn't fit with the new slab
accounting as mentioned above this is not really something terrible to
live with.

[...]
> @@ -5456,7 +5460,10 @@ static int mem_cgroup_move_account(struct page *page,
>  	 */
>  	smp_mb();
>  
> -	page->mem_cgroup = to; 	/* caller should have done css_get */
> +	css_get(&to->css);
> +	css_put(&from->css);
> +
> +	page->mem_cgroup = to;
>  
>  	__unlock_page_memcg(from);

What prevents from memcg to be released here?

-- 
Michal Hocko
SUSE Labs
