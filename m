Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FA120890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FK/ZrIhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgE0IgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:36:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387924AbgE0If7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590568558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+EZfAPIOq5wJKJ38yZey1nhxQDhBegdsue0IWqi4uU=;
        b=FK/ZrIhn1walx8z9++B4n4yGSzZbNShLphOJxeTsvDDK6XvpsU7bE/GZYOTpqaxdaELJhq
        UYip0U5G++0443brxAYCPuhQ+CljT7J+kvohs3PBCvFqrE3iCj5+2KwywbYB7zv15912Ja
        um5IUVbI3YPuEH44YDDy/0GjPaHllPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-e4Pyv0JjOgCW32f8MUnx0A-1; Wed, 27 May 2020 04:35:54 -0400
X-MC-Unique: e4Pyv0JjOgCW32f8MUnx0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC2DD1005510;
        Wed, 27 May 2020 08:35:52 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3F11A8EA;
        Wed, 27 May 2020 08:35:46 +0000 (UTC)
Date:   Wed, 27 May 2020 10:35:45 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>, brouer@redhat.com
Subject: Re: [PATCH v3 17/19] mm: memcg/slab: use a single set of
 kmem_caches for all allocations
Message-ID: <20200527103545.4348ac10@carbon>
In-Reply-To: <8932b0f9-0d25-7298-c12c-b4ae455ef110@suse.cz>
References: <20200422204708.2176080-1-guro@fb.com>
        <20200422204708.2176080-18-guro@fb.com>
        <8932b0f9-0d25-7298-c12c-b4ae455ef110@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 16:55:05 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/22/20 10:47 PM, Roman Gushchin wrote:
> > Instead of having two sets of kmem_caches: one for system-wide and
> > non-accounted allocations and the second one shared by all accounted
> > allocations, we can use just one.
> > 
> > The idea is simple: space for obj_cgroup metadata can be allocated
> > on demand and filled only for accounted allocations.
> > 
> > It allows to remove a bunch of code which is required to handle
> > kmem_cache clones for accounted allocations. There is no more need
> > to create them, accumulate statistics, propagate attributes, etc.
> > It's a quite significant simplification.
> > 
> > Also, because the total number of slab_caches is reduced almost twice
> > (not all kmem_caches have a memcg clone), some additional memory
> > savings are expected. On my devvm it additionally saves about 3.5%
> > of slab memory.
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>  
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> However, as this series will affect slab fastpaths, and perhaps
> especially this patch will affect even non-kmemcg allocations being
> freed, I'm CCing Jesper and Mel for awareness as they AFAIK did work
> on network stack memory management performance, and perhaps some
> benchmarks are in order...

Thanks for the heads-up! 

We (should) all know Mel Gorman's tests, which is here[1]:
 [1] https://github.com/gormanm/mmtests

My guess is that these change will only be visible with micro
benchmarks of the slub/slab.  I my slab/slub micro benchmarks are
located here [2] https://github.com/netoptimizer/prototype-kernel/

It is kernel modules that is compiled against your devel tree and pushed
to the remote host.  Results are simply printk'ed in dmesg.
Usage compile+push commands documented here[3]:
 [3] https://prototype-kernel.readthedocs.io/en/latest/prototype-kernel/build-process.html

I recommend trying: "slab_bulk_test01"
 modprobe slab_bulk_test01; rmmod slab_bulk_test01
 dmesg

Result from these kernel module benchmarks are included in some
commits[4][5]. And in [4] I found some overhead caused by MEMCG.

 [4] https://git.kernel.org/torvalds/c/ca257195511d
 [5] https://git.kernel.org/torvalds/c/fbd02630c6e3
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

