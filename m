Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105812084D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596178486;
	bh=fPtI3iB0w+i9NqvkRZZDNHizCXiZekrYk0lhbejzVOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bjl1LLm0q0ujArluSxzWz1eoNpOpqnq86cXPjlwErPsTWv9oo6FJAkuX1m65MBCtc
	 Y32EqjDjZtUJDFm25rl7RzG6w9FjekHLdUFa5f5GCTL3QIxGTftt+WH/pju4U/dBsH
	 UGEXqDh0QxDUFhLIZkT1j6ro4iiSpy/i+mYCZzN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgGaGyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbgGaGyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:54:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2660207F5;
        Fri, 31 Jul 2020 06:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596178484;
        bh=fPtI3iB0w+i9NqvkRZZDNHizCXiZekrYk0lhbejzVOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lr9L1KwKgWeUJgLL/j+abV6HCcYORLKzFEMMJkF7+dGwegpezY2pNaOemcq9rynaO
         BM3/yElUq2pxZ93BNdb9mWSAueNkErA+SwMdBSRxV70wtZ8CRihTEhSqNcqYbQ1Ujb
         VUOlZnPF3j6QRQIO5U37/xpQDgVjCmS3p+CyuLi4=
Date:   Fri, 31 Jul 2020 08:54:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Donnelly <John.P.donnelly@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2: [linux-4.14.y] ] dm cache: submit writethrough writes
 in parallel to origin and cache
Message-ID: <20200731065431.GB1518178@kroah.com>
References: <48659508-86e7-8107-75db-584b2896ad48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48659508-86e7-8107-75db-584b2896ad48@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:33:42PM -0500, John Donnelly wrote:
> From: Mike Snitzer <snitzer@redhat.com>
> 
> Discontinue issuing writethrough write IO in series to the origin and
> then cache.
> 
> Use bio_clone_fast() to create a new origin clone bio that will be
> mapped to the origin device and then bio_chain() it to the bio that gets
> remapped to the cache device.  The origin clone bio does _not_ have a
> copy of the per_bio_data -- as such check_if_tick_bio_needed() will not
> be called.
> 
> The cache bio (parent bio) will not complete until the origin bio has
> completed -- this fulfills bio_clone_fast()'s requirements as well as
> the requirement to not complete the original IO until the write IO has
> completed to both the origin and cache device.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> 
> (cherry picked from commit 2df3bae9a6543e90042291707b8db0cbfbae9ee9)
> 
> Fixes: 4ec34f2196d125ff781170ddc6c3058c08ec5e73 (dm bio record:
> save/restore bi_end_io and bi_integrity )
> 
> 4ec34f21 introduced a mkfs.ext4 hang on a LVM device that has been
> modified with lvconvert --cachemode=writethrough.
> 
> CC:stable@vger.kernel.org for 4.14.x .
> 
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Reviewed-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
> 
> conflicts:
> 	drivers/md/dm-cache-target.c. -  Corrected usage of
> 	writethrough_mode(&cache->feature) that was caught by
> 	compiler, and removed unused static functions : writethrough_endio(),
> 	defer_writethrough_bio(), wake_deferred_writethrough_worker()
> 	that generated warnings.
> ---
>  drivers/md/dm-cache-target.c | 94
> ++++++++++++++++++--------------------------

Line wrapped?

>  1 file changed, 38 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 69cdb29ef6be..2d9566bfe08b 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 Red Hat. All rights reserved.
> + i Copyright (C) 2012 Red Hat. All rights reserved.

What happened here?

This patch can't be applied as-is :(

greg k-h
