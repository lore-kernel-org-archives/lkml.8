Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606B4206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E3LsETVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCMAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:00:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCMAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MPfBgBTboj0bc43lStM8yQNURezi9qaXT/nmdWm1JsM=; b=E3LsETVn3IXeki8GpaDrgp5/JI
        6t2GPu/fI6eiEvpFhzpVKK1TbPo0iSg7VXSvBBWU0t0BqMznSv+blD8lP9OmPWB5VtL4rvnesFP1j
        lUFKdBy3IZzvSIJQBsFV/W+tkvv5YmfWOiIE2LkGzOJ42bzANUBiNUcMa6w2HJlzA07gi3/QtgXWp
        9qi3NiUBVcQ4bznilDvQPGxPPtNRAfiqPVYrGz+bX1zvxy28KqibhLAw/99li534IQbTzefVuDEw2
        KX5iNKu4eGGo7wLbF2pXL5EmVR1h0HtggWhNWM511Q48vQFM08m0qtrvfE3g+8yEhkOlE3S2JB2XT
        12v3ljtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCXkn-00011T-PJ; Fri, 13 Mar 2020 00:00:41 +0000
Date:   Thu, 12 Mar 2020 17:00:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200313000041.GM22433@bombadil.infradead.org>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
 <20200312141826.djb7osbekhcnuexv@master>
 <20200312142535.GK22433@bombadil.infradead.org>
 <20200312225055.ksn4ujtkpjgkqiaf@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312225055.ksn4ujtkpjgkqiaf@master>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:50:55PM +0000, Wei Yang wrote:
> On Thu, Mar 12, 2020 at 07:25:35AM -0700, Matthew Wilcox wrote:
> >Yes, I thought about that.  I decided it wasn't a problem, as long as
> >the struct page remains aligned, and we now have a guarantee that allocations
> >above 512 bytes in size are aligned.  With a 64 byte struct page, as long
> 
> Where is this 512 bytes condition comes from?

Filesystems need to do I/Os from kmalloc addresses and those I/Os need to
be 512 byte aligned.

> >as we're allocating at least 8 pages, we know it'll be naturally aligned.
> >
> >Your calculation doesn't take into account the size of struct page.
> >128M / 64k is indeed 2k, but you forgot to multiply by 64, which takes
> >us to 128kB.
> 
> You are right. While would there be other combination? Or in the future?
> 
> For example, there are definitions of
> 
> #define SECTION_SIZE_BITS       26
> #define SECTION_SIZE_BITS       24
> 
> Are we sure it won't break some thing?

As I said, once it's at least 512 bytes, it'll be 512 byte aligned.  And I
can't see us having sections smaller than 8 pages, can you?
