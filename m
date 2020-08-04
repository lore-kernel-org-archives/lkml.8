Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4888B22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596535422;
	bh=B9xrpei0Bo8lOQ4/GpWeP/lLc0dF8lSZjAbEwyC8Z/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aUn7T/ZOwLHP42PPUJR1OYtcgsTX++7maWTw3TthyLUXsJ9XC6p9G5LBUyKNssXY6
	 dgG1npgbiQH45kfn+/u5dyCN4okcI/wosCHajMwNnsSp3GjlfAZCnJLdw9kUeULNvF
	 K6K5XTDibkefYAmDB2fxYNmNbjaZ/WW97m0BAXfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgHDKDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbgHDKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:03:40 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A96622B40;
        Tue,  4 Aug 2020 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596535419;
        bh=B9xrpei0Bo8lOQ4/GpWeP/lLc0dF8lSZjAbEwyC8Z/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIitEWRZ2r6vfSgRGOd9L45wg9k1zY+ZcZ2/Bag8vTG2bBPAAcebfqAYi/86NL+1j
         LRhkZnXXomYhcDx7rWkEWtC5DGrdyOqeD9pUQH26pophFeLizz+vNYqDUSXR1idqhM
         qklDRDhzgJpiCrJ5brl7b4lOCISiLmnbfvLwlqEw=
Date:   Tue, 4 Aug 2020 13:03:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 6/6] mm: document semantics of ZONE_MOVABLE
Message-ID: <20200804100333.GC8243@kernel.org>
References: <20200804072408.5481-1-david@redhat.com>
 <20200804072408.5481-7-david@redhat.com>
 <20200804093323.GB8243@kernel.org>
 <65deeb21-63fe-d1c1-bb87-74a08035f79a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65deeb21-63fe-d1c1-bb87-74a08035f79a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:55:10AM +0200, David Hildenbrand wrote:
> On 04.08.20 11:33, Mike Rapoport wrote:
> > On Tue, Aug 04, 2020 at 09:24:08AM +0200, David Hildenbrand wrote:
> >> Let's document what ZONE_MOVABLE means, how it's used, and which special
> >> cases we have regarding unmovable pages (memory offlining vs. migration /
> >> allocations).
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> >> Cc: Mike Rapoport <rppt@kernel.org>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Several nits below, othersize
> > 
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> >> ---
> >>  include/linux/mmzone.h | 34 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index f6f884970511d..600d449e7d9e9 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -372,6 +372,40 @@ enum zone_type {
> >>  	 */
> >>  	ZONE_HIGHMEM,
> >>  #endif
> >> +	/*
> >> +	 * ZONE_MOVABLE is similar to ZONE_NORMAL, except that it *primarily*
> >> +	 * only contains movable pages. Main use cases are to make memory
> > 
> > "Primarily only" sounds awkward. Maybe
> > 
> > 	... except that it only contains movable pages with few exceptional
> > 	cases described below. 
> > 
> > And then 
> > 
> > 	Main use cases for ZONE_MOVABLE are ...
> 
> Ack!
> 
> > 
> >> +	 * offlining more likely to succeed, and to locally limit unmovable
> >> +	 * allocations - e.g., to increase the number of THP/huge pages.
> >> +	 * Notable special cases are:
> >> +	 *
> >> +	 * 1. Pinned pages: (Long-term) pinning of movable pages might
> > 
> > 		            ^long, capital L looked out of place for me
> 
> Ack!
> 
> > 
> >> +	 *    essentially turn such pages unmovable. Memory offlining might
> >> +	 *    retry a long time.
> >> +	 * 2. memblock allocations: kernelcore/movablecore setups might create
> >> +	 *    situations where ZONE_MOVABLE contains unmovable allocations
> >> +	 *    after boot. Memory offlining and allocations fail early.
> >> +	 * 3. Memory holes: Such pages cannot be allocated. Applies only to
> >> +	 *    boot memory, not hotplugged memory. Memory offlining and
> >> +	 *    allocations fail early.
> > 
> > I would clarify where page struct for abscent memory come from
> 
> Something like:
> 
> Memory holes: We might have a memmap for memory holes, for example, if

               ^w ;-)

> we have sections that are only partially System RAM. Such pages cannot
> be ...

How about

... sections that are only partially populated 

?
 
> ?
> 
> Thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
