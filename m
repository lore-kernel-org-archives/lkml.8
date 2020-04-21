Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C13C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D212074F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587472802;
	bh=IBTzn8dLkgJARiHQLlR080LrFf201bFhi1Mx/PTqPhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=19prQkjmxX827DOYBdyzV+EITHiqXC7uJ+s+2QHiiQ6QpayLEBV84RAC7u5J1WGb+
	 +zgWzaUOFKFpJrcxAvYILPUrtVURsKpKeOPBDdeZsek8VefbSu0JPwY/IZ2/mylT78
	 +LRcUaIPKlrzjwpRKe7OH1StyRBr/Ekid2e9lyo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgDUMkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:40:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39538 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgDUMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:39:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id y24so3492280wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuPLFkimWuCWGUf4RTGB0fzJ4keg1cVbd+1olbT2/Z8=;
        b=NvCiSxNS1b2tHyBBZ3pRos8wPqaAZXFbzVDbkPfEV+Aoq/zc4MVk4MPNo7Jwwlv8My
         ohkgDa6PB3vQ8PhBC3gN5tWPOp71T5MJKz6IQVNWvFwgT1Nog8bF28qAwHKBOd9nG3s2
         pGIwhKSqDpfuoGFFVYbpwMnu/XDP9rEvgBy8V49vCO7mfHieyQ08GqQf1GbCuFTr8+dc
         5eLyJBZ6+ZODMPLfodFmTfsinkmVOzPe/Xkviz8JUBuP/PQBq/ech2M1/aiyW2jL3LCk
         Nn8pwqzOyB+62OQsGi8iXoMItBpFb3WiOeRtR2nSmeFAwM9WGArEA42OZyxxGX8T5jek
         jfXA==
X-Gm-Message-State: AGi0Pub+Fqs+dhDFMzc+IP+KoODZ+Js7Lgxvn3FAGn83EF4DY9CF89ui
        CLczov8Nj7Jblxbfln/+0jc=
X-Google-Smtp-Source: APiQypI/CyQCAErgAxIZZX5m7BAQjn7WjN3SwqKqvewCm1OVxVlfTYE5d6yPmGJodNZr+y0h7QoV4Q==
X-Received: by 2002:a05:600c:2316:: with SMTP id 22mr4607519wmo.164.1587472795013;
        Tue, 21 Apr 2020 05:39:55 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id l19sm3409777wmj.14.2020.04.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:39:53 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:39:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH RFC 2/2] mm/memory_hotplug: handle memblocks only with
 CONFIG_ARCH_KEEP_MEMBLOCK
Message-ID: <20200421123953.GF27314@dhcp22.suse.cz>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416104707.20219-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-04-20 12:47:07, David Hildenbrand wrote:
> The comment in add_memory_resource() is stale: hotadd_new_pgdat() will
> no longer call get_pfn_range_for_nid(), as a hotadded pgdat will simply
> span no pages at all, until memory is moved to the zone/node via
> move_pfn_range_to_zone() - e.g., when onlining memory blocks.
> 
> The only archs that care about memblocks for hotplugged memory (either
> for iterating over all system RAM or testing for memory validity) are
> arm64, s390x, and powerpc - due to CONFIG_ARCH_KEEP_MEMBLOCK. Without
> CONFIG_ARCH_KEEP_MEMBLOCK, we can simply stop messing with memblocks.

OK, makes sense to me.

> For s390x, it seems to be fairly easy to avoid CONFIG_ARCH_KEEP_MEMBLOCK.
> arm64 could rework most code (esp., pfn_valid(), valid_phys_addr_range()
> and kexec_file_load()) to not require memblocks for hotplugged
> memory. E.g., as hotplugged memory has no holes and can be identified
> using !early_section(), arm64's variant of pfn_valid() could be reworked
> fairly easily to not require memblocks for hotadded memory. powerpc might
> be more involed.

I haven't checked these architectures but is the information really
useful for this patch?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

with a minor nit

> -	/*
> -	 * Add new range to memblock so that when hotadd_new_pgdat() is called
> -	 * to allocate new pgdat, get_pfn_range_for_nid() will be able to find
> -	 * this new range and calculate total pages correctly.  The range will
> -	 * be removed at hot-remove time.
> -	 */
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK

	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)

would be slightly nicer. This should work for all the ifedefs in this
patch.

>  	memblock_add_node(start, size, nid);
> +#endif
>  
>  	ret = __try_online_node(nid, false);
>  	if (ret < 0)
> @@ -1075,7 +1071,9 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  	/* rollback pgdat allocation and others */
>  	if (new_node)
>  		rollback_node_hotadd(nid);
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
>  	memblock_remove(start, size);
> +#endif
>  	mem_hotplug_done();
>  	return ret;
>  }
> @@ -1751,8 +1749,11 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	mem_hotplug_begin();
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
>  	memblock_free(start, size);
>  	memblock_remove(start, size);
> +#endif
>  	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
