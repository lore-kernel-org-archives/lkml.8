Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF482C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMsuwufF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgF2Sxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42165 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgF2Sxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGHkq0oMBoM51wDfqKc/ub/D6arDCkxAo/5yWsL9opI=;
        b=QMsuwufF00eEl8nlOhCJyF9FO+MjEOqCctMTECPa0tc9tmAMOfn6QauqIqvH3gt3DTYo8t
        2lUFQpNtBtbI1uJFknlWdWQOXr5P3aV+jZACH0+lb0ymx5BABQHIw1NlxYx28bHXn79dXS
        GbTWVV/8p4NUgMZBOgN8YGRmFk+Figg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-0lTKcZHpPomA47JgX2EeaQ-1; Mon, 29 Jun 2020 02:52:09 -0400
X-MC-Unique: 0lTKcZHpPomA47JgX2EeaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8848015FB;
        Mon, 29 Jun 2020 06:52:07 +0000 (UTC)
Received: from localhost (ovpn-13-12.pek2.redhat.com [10.72.13.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 813ED5C557;
        Mon, 29 Jun 2020 06:52:06 +0000 (UTC)
Date:   Mon, 29 Jun 2020 14:52:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-ID: <20200629065203.GJ3346@MiWiFi-R3L-srv>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626003459.D8E015CA@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/20 at 05:34pm, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I went to go add a new RECLAIM_* mode for the zone_reclaim_mode
> sysctl.  Like a good kernel developer, I also went to go update the
> documentation.  I noticed that the bits in the documentation didn't
> match the bits in the #defines.
> 
> The VM evidently stopped caring about RECLAIM_ZONE at some point (or
> never cared) and the #define itself was later removed as a cleanup.

From git history, it seems to never care about the RECLAIM_ZONE bit.

I think this patch is justified. I have one question about adding back
the RECLAIM_ZONE bit. Since we introduced RECLAIM_ZONE in the first
place, but never use it, removing it truly may fail some existing
script, does it mean we will never have chance to fix/clean up this kind
of mess?

Do we have possibility to remove it in mainline tree, let distos or
stable kernel maintainer take care of the back porting? Like this, any
stable kernel after 5.8, or any distrols which chooses post v5.8 kenrel
as base won't have this confusion. I am not objecting this patch, just
be curious if we have a way to fix/clean up for this type of issue.

Thanks
Baoquan

> Those things by themselves are fine.
> 
> But, the _other_ bit locations also got changed.  That's not OK because
> the bit values are documented to mean one specific thing and users
> surely rely on them meaning that one thing and not changing from
> kernel to kernel.  The end result is that if someone had a script
> that did:
> 
> 	sysctl vm.zone_reclaim_mode=1
> 
> That script went from doing nothing to writing out pages during
> node reclaim after the commit in question.  That's not great.
> 
> Put the bits back the way they were and add a comment so something
> like this is a bit harder to do again.  Update the documentation to
> make it clear that the first bit is ignored.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: commit 648b5cf368e0 ("mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE")
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@kernel.org
> ---
> 
>  b/Documentation/admin-guide/sysctl/vm.rst |   12 ++++++------
>  b/mm/vmscan.c                             |    9 +++++++--
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff -puN mm/vmscan.c~mm-vmscan-restore-old-zone_reclaim_mode-abi mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-restore-old-zone_reclaim_mode-abi	2020-06-25 17:32:11.559165912 -0700
> +++ b/mm/vmscan.c	2020-06-25 17:32:11.572165912 -0700
> @@ -4090,8 +4090,13 @@ module_init(kswapd_init)
>   */
>  int node_reclaim_mode __read_mostly;
>  
> -#define RECLAIM_WRITE (1<<0)	/* Writeout pages during reclaim */
> -#define RECLAIM_UNMAP (1<<1)	/* Unmap pages during reclaim */
> +/*
> + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> + * ABI.  New bits are OK, but existing bits can never change.
> + */
> +#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
> +#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
> +#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
>  
>  /*
>   * Priority for NODE_RECLAIM. This determines the fraction of pages
> diff -puN Documentation/admin-guide/sysctl/vm.rst~mm-vmscan-restore-old-zone_reclaim_mode-abi Documentation/admin-guide/sysctl/vm.rst
> --- a/Documentation/admin-guide/sysctl/vm.rst~mm-vmscan-restore-old-zone_reclaim_mode-abi	2020-06-25 17:32:11.562165912 -0700
> +++ b/Documentation/admin-guide/sysctl/vm.rst	2020-06-25 17:32:11.572165912 -0700
> @@ -938,7 +938,7 @@ in the system.
>  This is value OR'ed together of
>  
>  =	===================================
> -1	Zone reclaim on
> +1	(bit currently ignored)
>  2	Zone reclaim writes dirty pages out
>  4	Zone reclaim swaps pages
>  =	===================================
> @@ -948,11 +948,11 @@ that benefit from having their data cach
>  left disabled as the caching effect is likely to be more important than
>  data locality.
>  
> -zone_reclaim may be enabled if it's known that the workload is partitioned
> -such that each partition fits within a NUMA node and that accessing remote
> -memory would cause a measurable performance reduction.  The page allocator
> -will then reclaim easily reusable pages (those page cache pages that are
> -currently not used) before allocating off node pages.
> +Consider enabling one or more zone_reclaim mode bits if it's known that the
> +workload is partitioned such that each partition fits within a NUMA node
> +and that accessing remote memory would cause a measurable performance
> +reduction.  The page allocator will take additional actions before
> +allocating off node pages.
>  
>  Allowing zone reclaim to write out pages stops processes that are
>  writing large amounts of data from dirtying pages on other nodes. Zone
> _
> 

