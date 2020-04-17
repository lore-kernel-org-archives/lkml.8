Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D586C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CA62064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsaRh5/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgDQNOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDQNOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:14:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LHJhPbLaaNiTTXhuFNZjeRvwvUAbGtJVs/CsxLmZi2Y=; b=AsaRh5/JwJB0BAveJU7qOl7BgV
        Kxanvr9ibiy07Do+GkhkdWMrI3SE7g5Mc/ovkUqWESOqzCT6o37hjv62GaHxl0z86fx4jOijm1pSt
        ap+WOq6n7ApPSRZrlwfnWVn9ztMAZCzS+uqcZFSbPOBNmWUA7j0bTgnjcoUh3ssa9IPQOyQ0m6YsN
        jjHvkMVxJvWY7cmuZ76/BQE6uoXKMD4C39VjQ3LRspJ2VaNuLMU+ZhmPldf4Sq0527zJ4Ckg94pH2
        XlFzxzTdTitfu1K24WKOiIcewFoPNUDPC9TJ5ywjnzJ2O3gdni3UlDXGDV4yL1dB6qqIiq/+XoLDQ
        gbKMRU3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPQp9-0007LB-2S; Fri, 17 Apr 2020 13:14:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 247E53006E0;
        Fri, 17 Apr 2020 15:14:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 062342B120754; Fri, 17 Apr 2020 15:14:24 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:14:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200417131424.GR20713@hirez.programming.kicks-ass.net>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200406130155.GB29306@infradead.org>
 <20200417125735.GN27762@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417125735.GN27762@paasikivi.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:57:35PM +0300, Sakari Ailus wrote:
> Hi Christoph,
> 
> On Mon, Apr 06, 2020 at 06:01:55AM -0700, Christoph Hellwig wrote:
> > On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > > 
> > > __get_vm_area() is an exported symbol, make sure the callers stay in
> > > the expected memory range. When calling this function with memory
> > > ranges outside of the VMALLOC range *bad* things can happen.
> > > 
> > > (I noticed this when I managed to corrupt the kernel text by accident)
> > 
> > Maybe it is time to unexport it?  There are only two users:
> > 
> >  - staging/media/ipu3 really should be using vmap.  And given that it
> >    is a staging driver it really doesn't matter anyway if we break it.
> 
> It's not very polite to suggest breaking other people's drivers for such a
> small matter, staging or not. That'd be bound to break kernel compilation
> for a lot of people, if for nothing else.
> 
> Anyway, thanks for cc'ing me. I agree with suggestion and I'll submit a
> patch to address it.

Already done, see:

  https://lkml.kernel.org/r/20200414131348.444715-5-hch@lst.de
