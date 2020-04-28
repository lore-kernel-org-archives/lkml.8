Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29EC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBBA2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4rtNymu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD1Ww4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1Wwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB14C03C1AC;
        Tue, 28 Apr 2020 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F9aCSU3b/Wdv+eJFJpzYKn7Vwg6tH9sCBL5A5XUpJ4o=; b=d4rtNymuOqppTdZC6DJck2NtJL
        kjY0+YaEI3w4ebKpcllV7qIhx/P1D+TCuaw3XpmPMqUZhgkznKZ8dv3o7HSGtFWRi35AM13gWXI2S
        +oe/7fHyUfs7Zg1Iyx/H86z7wDagVQVC0Vw0zbn9kBL7S6XNudqlpL3qU0hLsMkj9rjjyFlJ3tmyd
        mdxPiXctEgyIcVboBqHvfOM8AKNoZ2bC+gQC1tYQQcDHXbQf81Hgr33ITRo7Bcm44ykPAgtX6mknN
        c3xC7RBbMjR3phdMIKElDEQ5j3uTQ4w0MWqdcEk5J8MxHaV542ZrfutfYx3ov4O5RY21sJiVzaivg
        5RFmQQdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTZ5w-0008Qz-1R; Tue, 28 Apr 2020 22:52:52 +0000
Date:   Tue, 28 Apr 2020 15:52:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 1/7] mm: Document x86 uses a linked list of pgds
Message-ID: <20200428225251.GM29705@bombadil.infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200428194449.22615-2-willy@infradead.org>
 <20200428214109.GB406458@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428214109.GB406458@iweiny-DESK2.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:41:09PM -0700, Ira Weiny wrote:
> On Tue, Apr 28, 2020 at 12:44:43PM -0700, Matthew Wilcox wrote:
> > x86 uses page->lru of the pages used for pgds, but that's not immediately
> > obvious to anyone looking to make changes.  Add a struct list_head to
> > the union so it's clearly in use for pgds.
> 
> Shouldn't pgd_list_{add,del}() use this list head variable instead of lru to
> complete the documentation?
> 
> Probably the list iteration loops arch/x86/* as well?

Yes, but I felt that was out of scope for this patchset.  Untangling the
uses of struct page is a long and messy business; if we have to fix
everything at once, we'll never get anywhere.  There's also the slab
users of page->lru instead of page->slab_list.

What I actually want to get to is:

struct page {
	unsigned long flags;
	union {
		struct file_page file;
		struct anon_page anon;
		struct pt_page pt;
		struct slab_page slab;
		struct tail_page tail;
		struct rcu_head rcu;
	};
	union {
		atomic_t _mapcount;
		...
	};
	atomic_t refcount;
	...
};

and then we can refer to page->pt.list and so on.
