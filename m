Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA891206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588624567;
	bh=j+D4G91YVvT2I6r7MACf9KRILq64o0iwV58fg2WSfVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k+uJ9H0YISOXcov7+ywT3jxJFdpVyymeO3vW1JYnBIv0Zlqwi1JqjBk7rryGISUSh
	 3TaluwRDibjXRlleWf+2H9kg8k8X/f0hhK4eYcnIJ9OTKUdo6pvf5pZJJDgfh9SMQX
	 TuwDCG1uftPHKOGtzHmYjceRj5qq9dQq2z9/0ZPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEDUgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgEDUgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:36:05 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE292206A5;
        Mon,  4 May 2020 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588624564;
        bh=j+D4G91YVvT2I6r7MACf9KRILq64o0iwV58fg2WSfVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xsW3dOcnob5j/K34MNs8HXTo/Ywd/2DNr1eZ+0Dujl+XoSormMaSrD0B/EWx/3bfm
         aYvgnj0F9yJZa1yaV4tNxCtKSB2NAntO04NOxUcnaF+uyDh907PivEwY6ndc3yrdxa
         o7/ut+jbYwCh1jnH/S5wzP5L5XxP1CZBRT7LVqSM=
Date:   Mon, 4 May 2020 13:36:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Henry Willard <henry.willard@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Limit boost_watermark on small zones.
Message-Id: <20200504133604.5fd0b0b11b93bb4d9a0fed68@linux-foundation.org>
In-Reply-To: <20200504124409.GB3758@techsingularity.net>
References: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
        <20200501155729.a479c4b27f127d9aa866bd8e@linux-foundation.org>
        <20200504124409.GB3758@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 13:44:09 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Fri, May 01, 2020 at 03:57:29PM -0700, Andrew Morton wrote:
> > On Thu, 30 Apr 2020 17:49:08 -0700 Henry Willard <henry.willard@oracle.com> wrote:
> > 
> > > Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
> > > fragmentation event occurs") adds a boost_watermark() function which
> > > increases the min watermark in a zone by at least pageblock_nr_pages or
> > > the number of pages in a page block. On Arm64, with 64K pages and 512M
> > > huge pages, this is 8192 pages or 512M. It does this regardless of the
> > > number of managed pages managed in the zone or the likelihood of success.
> > > This can put the zone immediately under water in terms of allocating pages
> > > from the zone, and can cause a small machine to fail immediately due to
> > > OoM. Unlike set_recommended_min_free_kbytes(), which substantially
> > > increases min_free_kbytes and is tied to THP, boost_watermark() can be
> > > called even if THP is not active. The problem is most likely to appear
> > > on architectures such as Arm64 where pageblock_nr_pages is very large.
> > > 
> > > It is desirable to run the kdump capture kernel in as small a space as
> > > possible to avoid wasting memory. In some architectures, such as Arm64,
> > > there are restrictions on where the capture kernel can run, and therefore,
> > > the space available. A capture kernel running in 768M can fail due to OoM
> > > immediately after boost_watermark() sets the min in zone DMA32, where
> > > most of the memory is, to 512M. It fails even though there is over 500M of
> > > free memory. With boost_watermark() suppressed, the capture kernel can run
> > > successfully in 448M.
> > > 
> > > This patch limits boost_watermark() to boosting a zone's min watermark only
> > > when there are enough pages that the boost will produce positive results.
> > > In this case that is estimated to be four times as many pages as
> > > pageblock_nr_pages.
> > > 
> > 
> ...
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Cool.  I wonder if we should backport this into -stable kernels?  "can
cause a small machine to fail immediately" sounds serious, but
1c30844d2dfe is from December 2018.  Any thoughts?
