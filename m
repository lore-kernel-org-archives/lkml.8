Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CF52078A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592839965;
	bh=gfUHNtl3v6G7DBsAUjWQ13R1y8fpaJMeubi01elSukQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rPI9hMys4YzcSs0Qn/Kkai+ZCDE/JQoSkEn6HeyVYlCOOmiJeBoxhz+e53Rph8rQm
	 7f6mCWfuhYft4iKeZlnEwwA66tQnuiCkUTZLC1XJBMoIcrWv3TBE+0jx0/qcJGERLe
	 D+zBD+N5vcOzPN5KcKPUj+cL/G2KB4XvXQ48Wqjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgFVPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:32:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgFVPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:32:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id u26so255964wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cAmfTEzP0A9GNdwX1CUxrRImn2sCx7fggd7uZBD9QAA=;
        b=TwDxYRvJTuPbA3KCpRsQ6VIYsfqbKsYAwhAxbIf7t6unPN7fVfU2PrhR6XLws4eCFR
         0IeihdvEfoZse+bSXyzeH/TK4q43reMXyWSioujgOGtQqUzuJLQQ+rIRglURWGtVK8Zg
         xvd6+Sf+/3hKoe6+N3U/3BVVAXAC+qdgzXmsx7zk1qcI7FlMCHg1eyh+e4wtNhFxD+9j
         tYtH+4K5yi31lbs6cxy5Zqp/+yfc6CBCCicn7pHehGT+b/Th98G0c6vYXOJ26/vKEtrH
         EMBfcxGst5DUAOKGJZ8+hT5+r4Th7CDLkIjEVhHSLnuLWEN2eHcEfQDtx26S9MR345II
         b+RQ==
X-Gm-Message-State: AOAM533oK6Uh1IPz2N0SOyxpBaizn0vMDnwAaKzzw9Gk7N8FSVb+URx8
        RxSGFCMfj94M3KF1CYaDiOE=
X-Google-Smtp-Source: ABdhPJzP8YZhJJPd4r+UmJWVfWlzkqb3q+8tOhqk11fPZAfOjSka8ewnXJMWnWM/11eoh6hPIfxMrg==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr17906944wmj.117.1592839961302;
        Mon, 22 Jun 2020 08:32:41 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id t188sm17714258wmt.27.2020.06.22.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:32:40 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:32:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: document why shuffle_zone() is
 relevant
Message-ID: <20200622153239.GH31426@dhcp22.suse.cz>
References: <20200619125923.22602-1-david@redhat.com>
 <20200619125923.22602-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619125923.22602-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-06-20 14:59:21, David Hildenbrand wrote:
> It's not completely obvious why we have to shuffle the complete zone, as
> some sort of shuffling is already performed when onlining pages via
> __free_one_page(), placing MAX_ORDER-1 pages either to the head or the tail
> of the freelist. Let's document why we have to shuffle the complete zone
> when exposing larger, contiguous physical memory areas to the buddy.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

OK, this is an improvement. I would still prefer to have this claim
backed by some numbers but it seems we are not going to get any so we
can at least pretend to try as hard as possible especially when this is
not a hot path.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9b34e03e730a4..a0d81d404823d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -822,6 +822,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	zone->zone_pgdat->node_present_pages += onlined_pages;
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
> +	/*
> +	 * When exposing larger, physically contiguous memory areas to the
> +	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
> +	 * them either to the head or the tail of the freelist) is only helpful
> +	 * for mainining the shuffle, but not for creating the initial shuffle.
> +	 * Shuffle the whole zone to make sure the just onlined pages are
> +	 * properly distributed across the whole freelist.
> +	 */
>  	shuffle_zone(zone);
>  
>  	node_states_set_node(nid, &arg);
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
