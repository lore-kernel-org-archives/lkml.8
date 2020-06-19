Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68289C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B1120773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgoISwGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgFSCkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:40:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgFSCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592534433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATi+E/1Y7wX1OXWf6v2SEFQsF6SBblKqHdhAPCibPk0=;
        b=fgoISwGhP/qoVvWc5y0oxCFLTupTDD/sZEw0mDGdfjiu31zoNPy68RPJ/McM9x8N12tjvS
        7PHk0/qafpzYsdARkZTPQLNcQd/1xQz8kzzPWFYVWJE1Q+PVYOwRepMki9UwbCX/E4j9M/
        0fSBJf/tn4+Xmm4K14/TJbZFo3IMqho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-qD6JRbmPMnOp4Z4IAuqLjA-1; Thu, 18 Jun 2020 22:40:29 -0400
X-MC-Unique: qD6JRbmPMnOp4Z4IAuqLjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF32107ACCA;
        Fri, 19 Jun 2020 02:40:27 +0000 (UTC)
Received: from mail (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 213C95D9E5;
        Fri, 19 Jun 2020 02:40:27 +0000 (UTC)
Date:   Thu, 18 Jun 2020 22:40:26 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619024026.GB21081@redhat.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 18, 2020 at 06:14:49PM -0700, Roman Gushchin wrote:
> I agree. The whole
> 
> 	page = alloc_pages_node(nid, alloc_flags, order);
> 	if (!page)
> 		continue;
> 	if (!order)
> 		break;
> 	if (!PageCompound(page)) {
> 		split_page(page, order);
> 		break;
> 	} else if (!split_huge_page(page)) {
> 		break;
> 	}
> 
> looks very suspicious to me.
> My wild guess is that gfp flags changed somewhere above, so we hit
> the branch which was never hit before.

Right to be suspicious about the above: split_huge_page on a regular
page allocated by a driver was never meant to work.

The PageLocked BUG_ON is just a symptom of a bigger issue, basically
split_huge_page it may survive, but it'll stay compound and in turn it
must be freed as compound.

The respective free method doesn't even contemplate freeing compound
pages, the only way the free method can survive, is by removing
__GFP_COMP forcefully in the allocation that was perhaps set here
(there are that many __GFP_COMP in that directory):

static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
{
	gfp_t gfp_flags;

	gfp_flags = GFP_KERNEL
		| __GFP_COMP	/* compound page lets parts be mapped */

And I'm not sure what the comment means here, compound or non compound
doesn't make a difference when you map it, it's not a THP, the
mappings must be handled manually so nothing should check PG_compound
anyway in the mapping code.

Something like this may improve things, it's an untested quick hack,
but this assumes it's always a bug to setup a compound page for these
DMA allocations and given the API it's probably a correct
assumption.. Compound is slower, unless you need it, you can avoid it
and then split_page will give contiguous memory page granular. Ideally
the code shouldn't call split_page at all and it should free it all at
once by keeping track of the order and by returning the order to the
caller, something the API can't do right now as it returns a plain
array that can only represent individual small pages.

Once this is resolved, you may want to check your config, iommu passthrough
sounds more optimal for a soundcard.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f68a62c3c32b..3dfbc010fa83 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -499,6 +499,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	if (unlikely(gfp & __GFP_COMP)) {
+		WARN();
+		gfp &= ~__GFP_COMP;
+	}
 
 	while (count) {
 		struct page *page = NULL;
@@ -522,13 +526,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 				continue;
 			if (!order)
 				break;
-			if (!PageCompound(page)) {
-				split_page(page, order);
-				break;
-			} else if (!split_huge_page(page)) {
-				break;
-			}
-			__free_pages(page, order);
+			split_page(page, order);
+			break;
 		}
 		if (!page) {
 			__iommu_dma_free_pages(pages, i);
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 6850d13aa98c..378f5a36ec5f 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -28,7 +28,6 @@ static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
 	gfp_t gfp_flags;
 
 	gfp_flags = GFP_KERNEL
-		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,

