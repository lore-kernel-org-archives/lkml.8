Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB4AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBCC2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHnbMR3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2KeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:34:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37693 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgG2KeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596018849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thftSHsPkDGewUeVkLBJnkZJRKIUZfFRNAXaBwnUwP8=;
        b=RHnbMR3m2H4FAYohi3C9cpcx894w1kXXbPsIslb09hNZEbAVzcjG21HhGYBlygXcZwJ2pQ
        YQ887WnPruxeDuRBzzOQfYhl2UwddRtPzWEif8ZolVqyp2gQsp96qGUhqCKPz9nJtLM3/1
        gVeDRaGENVU38kAtcfvt9zarK3IKkN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-UWsuWmXYMmuNPeKCqp9kJA-1; Wed, 29 Jul 2020 06:34:05 -0400
X-MC-Unique: UWsuWmXYMmuNPeKCqp9kJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA4A79EC3;
        Wed, 29 Jul 2020 10:34:03 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F3FE10013D0;
        Wed, 29 Jul 2020 10:34:01 +0000 (UTC)
Date:   Wed, 29 Jul 2020 18:33:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        mhocko@kernel.org, rientjes@google.com, mgorman@suse.de,
        walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [PATCH v4] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-ID: <20200729103359.GE14854@MiWiFi-R3L-srv>
References: <20200728034938.14993-1-songmuchun@bytedance.com>
 <20200728132453.GB14854@MiWiFi-R3L-srv>
 <1b507031-d475-b495-bb4a-2cd9e665d02f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b507031-d475-b495-bb4a-2cd9e665d02f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/20 at 09:46am, Mike Kravetz wrote:
> On 7/28/20 6:24 AM, Baoquan He wrote:
> > Hi Muchun,
> > 
> > On 07/28/20 at 11:49am, Muchun Song wrote:
> >> In the reservation routine, we only check whether the cpuset meets
> >> the memory allocation requirements. But we ignore the mempolicy of
> >> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> >> memory allocation may fail due to mempolicy restrictions and receives
> >> the SIGBUS signal. This can be reproduced by the follow steps.
> >>
> >>  1) Compile the test case.
> >>     cd tools/testing/selftests/vm/
> >>     gcc map_hugetlb.c -o map_hugetlb
> >>
> >>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
> >>     system. Each node will pre-allocate one huge page.
> >>     echo 2 > /proc/sys/vm/nr_hugepages
> >>
> >>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
> >>     numactl --membind=0 ./map_hugetlb 4
> > 
> > I think supporting the  mempolicy of MPOL_BIND case is a good idea.
> > I am wondering what about the other mempolicy cases, e.g MPOL_INTERLEAVE,
> > MPOL_PREFERRED. Asking these because we already have similar handling in
> > sysfs, proc nr_hugepages_mempolicy writting. Please see
> > __nr_hugepages_store_common() for detail.
> 
> There is a high level difference in the function of this code and the code
> called by the sysfs and proc interfaces.  This patch is dealing with reserving
> huge pages in the pool for later use.  The sysfs and proc interfaces are
> allocating huge pages to be added to the pool.
> 
> Using mempolicy to decide how to allocate huge pages is pretty straight
> forward.  Using mempolicy to reserve pages is almost impossible to get
> correct.  The comment at the beginning of hugetlb_acct_memory() and modified
> by this patch summarizes the issues.
> 
> IMO, at this time it makes little sense to perform checks for more than
> MPOL_BIND at reservation time.  If we ever take on the monumental task of
> supporting mempolicy directed per-node reservations throughout the life of
> a process, support for other policies will need to be taken into account.

I haven't figured out the difficulty of using mempolicy very clearly, will 
read more codes and digest and understand your words. Thanks a lot for
these details.

Thanks
Baoquan

