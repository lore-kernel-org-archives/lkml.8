Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170B22074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593569390;
	bh=eoerlDq0jq33nBxOyIP192wzXoIP45xb+HMF4L54sis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mjWgv51FXsfXla8J51UKLpu3ktTI/eOyoUrVSUHYfGKDj+QRo+EM5OX4tuW9GwPCD
	 1v36utCQb4pXzIduUeTKQpurDtl1xiSmp/doF+g9oerZE0uMiWQl46zT9A4YDMcqSv
	 yAoxdQWKPkSizSBPiAojf/YuqbgBW3GM/PaUuFEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGACJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGACJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:09:33 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344712074D;
        Wed,  1 Jul 2020 02:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593569373;
        bh=eoerlDq0jq33nBxOyIP192wzXoIP45xb+HMF4L54sis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D4lvFjrP7/gXpPVCuaDLzbxJ5drqo+jOu/sn+9nnHVlvXXWcp4N0YAzU3iaKz0xIe
         n7KiQtBc5SEPwvc0wYxfFOxeNCEeX2dO7r48ULrO/vLhNEkwoE/31DWotWv9s+K7/k
         5f9XjTJ33nGnMHiBtZMLKTVYAAzeRbneHKzI8bOM=
Date:   Tue, 30 Jun 2020 19:09:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm/cma.c: use exact_nid true to fix possible per-numa
 cma leak
Message-Id: <20200630190931.04967b5e8bdf29c33f3c8005@linux-foundation.org>
In-Reply-To: <20200630190825.GB37586@carbon.dhcp.thefacebook.com>
References: <20200628074345.27228-1-song.bao.hua@hisilicon.com>
        <20200630190825.GB37586@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 12:08:25 -0700 Roman Gushchin <guro@fb.com> wrote:

> On Sun, Jun 28, 2020 at 07:43:45PM +1200, Barry Song wrote:
> > Calling cma_declare_contiguous_nid() with false exact_nid for per-numa
> > reservation can easily cause cma leak and various confusion.
> > For example, mm/hugetlb.c is trying to reserve per-numa cma for gigantic
> > pages. But it can easily leak cma and make users confused when system has
> > memoryless nodes.
> > 
> > In case the system has 4 numa nodes, and only numa node0 has memory.
> > if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> > for 4 different numa nodes. since exact_nid=false in current code, all
> > 4 numa nodes will get cma successfully from node0, but hugetlb_cma[1 to 3]
> > will never be available to hugepage will only allocate memory from
> > hugetlb_cma[0].
> > 
> > In case the system has 4 numa nodes, both numa node0&2 has memory, other
> > nodes have no memory.
> > if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> > for 4 different numa nodes. since exact_nid=false in current code, all
> > 4 numa nodes will get cma successfully from node0 or 2, but hugetlb_cma[1]
> > and [3] will never be available to hugepage as mm/hugetlb.c will only
> > allocate memory from hugetlb_cma[0] and hugetlb_cma[2].
> > This causes permanent leak of the cma areas which are supposed to be
> > used by memoryless node.
> > 
> > Of cource we can workaround the issue by letting mm/hugetlb.c scan all
> > cma areas in alloc_gigantic_page() even node_mask includes node0 only.
> > that means when node_mask includes node0 only, we can get page from
> > hugetlb_cma[1] to hugetlb_cma[3]. But this will cause kernel crash in
> > free_gigantic_page() while it wants to free page by:
> > cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order)
> > 
> > On the other hand, exact_nid=false won't consider numa distance, it
> > might be not that useful to leverage cma areas on remote nodes.
> > I feel it is much simpler to make exact_nid true to make everything
> > clear. After that, memoryless nodes won't be able to reserve per-numa
> > CMA from other nodes which have memory.
> 
> Totally agree.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 

Do we feel this merits a cc:stable?
