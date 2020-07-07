Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F9A206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGGG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:59:05 -0400
Received: from gentwo.org ([3.19.106.255]:51566 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGG7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:59:04 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 3CA403FD78; Tue,  7 Jul 2020 06:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3976D3FD77;
        Tue,  7 Jul 2020 06:59:04 +0000 (UTC)
Date:   Tue, 7 Jul 2020 06:59:04 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
In-Reply-To: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2007070656120.1587@www.lameter.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020, Xunlei Pang wrote:

> This patch introduces two counters to maintain the actual number
> of partial objects dynamically instead of iterating the partial
> page lists with list_lock held.
>
> New counters of kmem_cache_node are: pfree_objects, ptotal_objects.
> The main operations are under list_lock in slow path, its performance
> impact is minimal.


If at all then these counters need to be under CONFIG_SLUB_DEBUG.

> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -616,6 +616,8 @@ struct kmem_cache_node {
>  #ifdef CONFIG_SLUB
>  	unsigned long nr_partial;
>  	struct list_head partial;
> +	atomic_long_t pfree_objects; /* partial free objects */
> +	atomic_long_t ptotal_objects; /* partial total objects */

Please in the CONFIG_SLUB_DEBUG. Without CONFIG_SLUB_DEBUG we need to
build with minimal memory footprint.

>  #ifdef CONFIG_SLUB_DEBUG
>  	atomic_long_t nr_slabs;
>  	atomic_long_t total_objects;
> diff --git a/mm/slub.c b/mm/slub.c



Also this looks to be quite heavy on the cache and on execution time. Note
that the list_lock could be taken frequently in the performance sensitive
case of freeing an object that is not in the partial lists.

