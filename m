Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB99C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC1E207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqp3GCwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgESPdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:32:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF88C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3Xn2vlHyiuSMza94Q4JCwVe0wgbzIeAHHFRAxO0Poak=; b=rqp3GCwXLRoiSgDjVGsREzzqh2
        wsY53WRYBdnlRC/E1aZ/xzONTz5Cvr4/EKbfmuAbuVrshZxFIA74mEGtbnGXF2+0M6zk5HgIQ4ytW
        XqjjwqJLZUXMTd/5o3j77KRxZVUi4BCmomW86BmnTvbhW5zvaA3DGJM8KgEVnasgN3kcEcwBAWIH9
        kGJX+8elPI7V5Ptg8Z1paawPRqH7K4/EJZ5PCvm5wJ+CdmCzNNk9eHc9PgaL8Zyzm/J76IEG/o6Qd
        ziQeEr/9rhLGICHGKhShkMI0jcWvZkGVzxqaNLdPL0bvqHCbvfWxtBsiSK/BO/V7Ni32xPQH/g4PB
        o7R1b8Ww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4Ee-00067B-0U; Tue, 19 May 2020 15:32:52 +0000
Date:   Tue, 19 May 2020 08:32:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200519153251.GY16070@bombadil.infradead.org>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com>
 <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com>
 <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:20:40PM +0200, Laurent Dufour wrote:
> Le 19/05/2020 à 15:10, Michel Lespinasse a écrit :
> > On Mon, May 18, 2020 at 03:45:22PM +0200, Laurent Dufour wrote:
> > > Le 24/04/2020 à 03:39, Michel Lespinasse a écrit :
> > > > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> > > > should now go through the new mmap locking api. The mmap_lock is
> > > > still implemented as a rwsem, though this could change in the future.
> > > > 
> > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > > index dc9ef302f517..701f3995f621 100644
> > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > > > @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
> > > >    	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
> > > >    	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
> > > > -	might_lock_read(&current->mm->mmap_sem);
> > > > +	might_lock_read(&current->mm->mmap_lock);
> > > 
> > > Why not a mm_might_lock_read() new API to hide the mmap_lock, and add it to
> > > the previous patch?
> > 
> > I'm not sure why this is needed - we may rework the lock to be
> > something else than rwsem, but might_lock_read should still apply to
> > it and make sense ? I'm not sure what the extra API would bring...
> 
> I guess at one time the API would become might_lock_read_a_range(), isn't it?
> Furthermore this would hiding the lock's name which the goal of this series.

I think this assertion should be deleted from this driver.  It's there
in case get_user_pages_fast() takes the mmap sem.  It would make sense to
have this assertion in get_user_pages_fast() in case we take the fast path
which doesn't acquire the mmap_sem.  Something like this:

+++ b/mm/gup.c
@@ -2754,6 +2754,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
                                       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
                return -EINVAL;
 
+       might_lock_read(&current->mm->mmap_lock);
        start = untagged_addr(start) & PAGE_MASK;
        addr = start;
        len = (unsigned long) nr_pages << PAGE_SHIFT;

