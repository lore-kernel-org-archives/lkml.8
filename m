Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41CBC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27ED21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587472218;
	bh=qQtYehG9aXc6oqveVNVJfIgcp/8UU+S2l7OqQ0wwifE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UU+Ev75PlP0stWeYVHvBVl8hRU3Jk6R9cWWGpGqnj9NoGVkVA7ORSp+56daBh83N2
	 5/d2WQuOHO3kMVMsObAkOBHN8Qv1oSF8ovLZYpOwc/DkoTiQYeue4n90ILXxCBzVDE
	 uE9QC6g6dmA8HmJ9gOXemiPsaQUGwg/Tykt9nCdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgDUMaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:30:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:30:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id y24so3457569wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pAwHkcOQqZAPUApEDJqSOvDREKT9CtAZr9rAL5nNWm8=;
        b=Im3QmORhPNKSuGvzSQ49JChgxiIsy6t3n1gQN499MYnwVUbtYaGu4lboDxpqqTETUp
         4DdktlkfpyEPm/wDjIrMAeG7Ybcw74/0oacWw0k7JBk+WTCSmoo55FP+g6FBTNjW1VmJ
         inG28qYVw+OFYqZZj1rZD/eFZ5AoWwF8TnzZxRE1MmL/vXB1RpJHVZ9orXtKkYh+365T
         CTQYGNnrn6z78bneYxT6XLFRSG597GjdWkGe3kfKnBgbYD05oIH+3o4DrRJcllniGGEy
         fQdx6B08P700i70PLlhaL1rV310FENbr/m9O1I+K9sq7Fnu7i+GvHaxofIggRfFGhDMs
         fo6Q==
X-Gm-Message-State: AGi0PuaaFGlmkrHj11Ig+k9HLE0++now82O0YsA4Rg11Pi0Mj0irxIzT
        AzvPfWr4EXhpBP7Iy6RdXQY=
X-Google-Smtp-Source: APiQypJ0vlUL5HwPeazsqwY03gy8wO3ZBhdkk84bZcUZzTJ0Pp1Ma/mpJlFhV9V+ZM/YDjwomgHO/Q==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr4621413wmd.65.1587472213583;
        Tue, 21 Apr 2020 05:30:13 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id l19sm3374267wmj.14.2020.04.21.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:30:12 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:30:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat
 with node_start_pfn
Message-ID: <20200421123011.GE27314@dhcp22.suse.cz>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416104707.20219-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply

On Thu 16-04-20 12:47:06, David Hildenbrand wrote:
> A hotadded node/pgdat will span no pages at all, until memory is moved to
> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
> when onlining memory blocks. We don't have to initialize the
> node_start_pfn to the memory we are adding.

You are right that the node is empty at this phase but that is already
reflected by zero present pages (hmm, I do not see spanned pages to be
set 0 though). What I am missing here is why this is an improvement. The
new node is already visible here and I do not see why we hide the
information we already know.
 
> Note: we'll also end up with pgdat->node_start_pfn == 0 when offlined the
> last memory block belonging to a node (via remove_pfn_range_from_zone()->
> update_pgdat_span()).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 47cf6036eb31..9b15ce465be2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -866,10 +866,9 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  }
>  
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
> -static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
> +static pg_data_t __ref *hotadd_new_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat;
> -	unsigned long start_pfn = PFN_DOWN(start);
>  
>  	pgdat = NODE_DATA(nid);
>  	if (!pgdat) {
> @@ -899,9 +898,8 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>  	}
>  
>  	/* we can use NODE_DATA(nid) from here */
> -
>  	pgdat->node_id = nid;
> -	pgdat->node_start_pfn = start_pfn;
> +	pgdat->node_start_pfn = 0;
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
>  	free_area_init_core_hotplug(nid);
> @@ -936,7 +934,6 @@ static void rollback_node_hotadd(int nid)
>  /**
>   * try_online_node - online a node if offlined
>   * @nid: the node ID
> - * @start: start addr of the node
>   * @set_node_online: Whether we want to online the node
>   * called by cpu_up() to online a node without onlined memory.
>   *
> @@ -945,7 +942,7 @@ static void rollback_node_hotadd(int nid)
>   * 0 -> the node is already online
>   * -ENOMEM -> the node could not be allocated
>   */
> -static int __try_online_node(int nid, u64 start, bool set_node_online)
> +static int __try_online_node(int nid, bool set_node_online)
>  {
>  	pg_data_t *pgdat;
>  	int ret = 1;
> @@ -953,7 +950,7 @@ static int __try_online_node(int nid, u64 start, bool set_node_online)
>  	if (node_online(nid))
>  		return 0;
>  
> -	pgdat = hotadd_new_pgdat(nid, start);
> +	pgdat = hotadd_new_pgdat(nid);
>  	if (!pgdat) {
>  		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
>  		ret = -ENOMEM;
> @@ -977,7 +974,7 @@ int try_online_node(int nid)
>  	int ret;
>  
>  	mem_hotplug_begin();
> -	ret =  __try_online_node(nid, 0, true);
> +	ret =  __try_online_node(nid, true);
>  	mem_hotplug_done();
>  	return ret;
>  }
> @@ -1031,7 +1028,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  	 */
>  	memblock_add_node(start, size, nid);
>  
> -	ret = __try_online_node(nid, start, false);
> +	ret = __try_online_node(nid, false);
>  	if (ret < 0)
>  		goto error;
>  	new_node = ret;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
