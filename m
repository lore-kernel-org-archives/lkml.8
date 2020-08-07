Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19636C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB4B204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEnfdelS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHGTfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:35:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E5CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2izdhy9urvECJgu7c0L+DP8+hLwhvJe9LrSJI1uUoU=; b=nEnfdelSe1G9Q+nx+YpNh0mw1/
        +a4gGLD0aa9HwBzJxEjQA3qi4g3PXKSq79Y2zY7r0uTtXUyt2tr8itdma+mPNnJjLysKop3luLRvG
        +s7fjtFyK5BDV4QlN7hM/nOamL+SwvA0z5nuEEDEVkjWFjr9iEPhOAGmNcZDkABfyKoAlFsgnfKBI
        dcflAoOAEb0LQ5wMksJBIOfeRdBCdYEXiElhQbz8I5flB4ii8eeyt7t8c0xOeXGXxXRhYURPthiAf
        RSriqo9p5uWoZquYNMFKQWc4plLasbaF3PUqWR6M8S7fAD6PS3GH5YwF8HMfn+hn0rAXP3VhMVAj3
        wjY/kmAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4890-0001tN-N2; Fri, 07 Aug 2020 19:35:10 +0000
Date:   Fri, 7 Aug 2020 20:35:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200807193510.GG17456@casper.infradead.org>
References: <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils>
 <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
 <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
 <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
 <20200806180024.GB17456@casper.infradead.org>
 <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
 <alpine.LSU.2.11.2008071047510.1239@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008071047510.1239@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:41:09AM -0700, Hugh Dickins wrote:
> My home testing was, effectively, on top of c6fe44d96fc1 (v5.8 plus
> your two patches): I did not have in the io_uring changes from the
> current tree. In glancing there, I noticed one new and one previous
> instance of SetPageWaiters() *after* __add_wait_queue_entry_tail():
> are those correct?

By the way, don't do any performance testing on current Linus tree.
This commit:

commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
Author: Ming Lei <ming.lei@redhat.com>
Date:   Tue Jun 30 22:03:57 2020 +0800

    blk-mq: centralise related handling into blk_mq_get_driver_tag
    
    Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
    all are good to do during getting driver tag.
    
    Meantime blk-flush related code is simplified and flush request needn't
    to update the request table manually any more.
    
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Cc: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

slows everything down, at least on my test qemu system.  Seems like it's
losing block queue tags.
