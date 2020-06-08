Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF347C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AD22076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJZhlPmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgFHPuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbgFHPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:50:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF50C08C5C2;
        Mon,  8 Jun 2020 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lb09cWOAemFWrXTFBWu5AF2ByTLTf6iK++5rNvKOF44=; b=qJZhlPmcOXGTC7Qd1RA6AuDl6L
        zH6tY8idQUmY7FzCLwKGNwuiGVMSoO9Rp3S2/4SoI1KBJOXHZa/Irl3BF4gbFogCJ+H/GECJgcLhO
        NXFASgAFNdfJHY5vjYNMSs2zaSkKvmindPUMC5CwWUp5SrZ/s4RjGMLSLwCeD4k2WlCiDVepPQ9Mk
        qei3P9+Sm9U3Scc/I7JIii8L2H0OhWm941JQEIDfvnjoiANcDh0GpYxtaGHYAaJ34XDheeS4bl2wa
        MybrU9yzKwgy50FA0ON6yeMVuWM7OvH6QhRbYIuChJceMEHzD8DiGv+gqAaZH4Y/CU9hy0ZSKwt6N
        IoILBjOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiK1V-0002aK-5E; Mon, 08 Jun 2020 15:49:17 +0000
Date:   Mon, 8 Jun 2020 08:49:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 01/14] mm/page_ext: Export lookup_page_ext() to GPL
 modules
Message-ID: <20200608154917.GA8408@infradead.org>
References: <20200608114047.26589-1-sjpark@amazon.com>
 <20200608114047.26589-2-sjpark@amazon.com>
 <cf508f7e-925c-790c-7477-9a1d8150336d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf508f7e-925c-790c-7477-9a1d8150336d@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 01:53:23PM +0200, David Hildenbrand wrote:
> > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> >  					MAX_ORDER_NR_PAGES);
> >  	return get_entry(base, index);
> >  }
> > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> >  
> >  static int __init alloc_node_page_ext(int nid)
> >  {
> > 
> 
> I've been told to always smuggle new EXPORTs into the patch that
> actually needs it (and cc relevant people on that patch instead).

A separate patch for anything remotely controversial really helps it
to stick out, so I think keeping it separate is a very good practice.
