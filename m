Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B9C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D52A2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBZSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:31:29 -0500
Received: from gentwo.org ([3.19.106.255]:58966 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgBZSb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:31:29 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 885B43EC05; Wed, 26 Feb 2020 18:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 875FF3EC04;
        Wed, 26 Feb 2020 18:31:28 +0000 (UTC)
Date:   Wed, 26 Feb 2020 18:31:28 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: improve count_partial() for
 CONFIG_SLUB_CPU_PARTIAL
In-Reply-To: <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.21.2002261827440.8012@www.lameter.com>
References: <20200222092428.99488-1-wenyang@linux.alibaba.com> <alpine.DEB.2.21.2002240126190.13486@www.lameter.com> <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Roman Gushchin wrote:

> > I suggest that you simply use the number of partial slabs and multiply
> > them by the number of objects in a slab and use that as a value. Both
> > values are readily available via /sys/kernel/slab/<...>/
>
> So maybe something like this?
>
> @@ -5907,7 +5907,9 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>  	for_each_kmem_cache_node(s, node, n) {
>  		nr_slabs += node_nr_slabs(n);
>  		nr_objs += node_nr_objs(n);
> +#ifndef CONFIG_SLUB_CPU_PARTIAL
>  		nr_free += count_partial(n, count_free);
> +#endif
>  	}

Why would not having cpu partials screws up the counting of objects in
partial slabs?


You dont need kernel mods for this. The numbers are exposed already in
/sys/kernel/slab/xxx.


