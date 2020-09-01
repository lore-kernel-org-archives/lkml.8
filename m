Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757C12067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZlLRrQPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgIAQpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgIAQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:45:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D20C061244;
        Tue,  1 Sep 2020 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J6+IAA1/Qxueriknxq0uDzpiCbpmOl/UdSGkYlD7U80=; b=ZlLRrQPIe93CNqVC+FS8YzQzYd
        rWTRmnfnVe4PrHV0eGjlsLYs2/bCm3uAYRhLUShzIwOxLkNAi5EsVnA/8PW247F7PlnB1oZ1i+VPF
        ckSNOCdKKbP4P6lcE91/dFTauRGtsBvPOjbkuK70bYXa0bgV1CHZ9o5KFzOqvsUQdH7xD00b6Xdje
        bbTGAnw1h/pMb5Hl1pPrwS3HlDCBa/S0tzP98kr099iODZlB2w6bqohtYmgbFIq6iqYnBlTAfPR1k
        K354XF/18p7rjBeMl5XxCmiya5C9LcWxDpAdcB3HWuEbN84yGAkllyga1VKABA16UTlUILuH5CxT0
        j+qiLLBg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD9Pl-0000mR-V8; Tue, 01 Sep 2020 16:45:46 +0000
Date:   Tue, 1 Sep 2020 17:45:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
Message-ID: <20200901164545.GP14765@casper.infradead.org>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
 <20200901164132.GD669796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901164132.GD669796@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:41:32AM -0700, Eric Biggers wrote:
> On Tue, Sep 01, 2020 at 05:28:15PM +0100, David Howells wrote:
> > 
> > Hi Willy,
> > 
> > Here's a set of patches to expand the use of the readahead_control struct,
> > essentially from do_sync_mmap_readahead() down.  Note that I've been
> > passing the number of pages to read in rac->_nr_pages, and then saving it
> > and changing it certain points, e.g. page_cache_readahead_unbounded().
> > 
> > Also pass file_ra_state into force_page_cache_readahead().
> > 
> > Also there's an apparent minor bug in khugepaged.c that I've included a
> > patch for: page_cache_sync_readahead() looks to be given the wrong size in
> > collapse_file().
> > 
> 
> What branch does this apply to?

He's done it on top of http://git.infradead.org/users/willy/pagecache.git

I was hoping he'd include
http://git.infradead.org/users/willy/pagecache.git/commitdiff/c71de787328809026cfabbcc5485cb01caca8646
http://git.infradead.org/users/willy/pagecache.git/commitdiff/f3a1cd6447e29a54b03efc2189d943f12ac1c9b9
http://git.infradead.org/users/willy/pagecache.git/commitdiff/c03d3a5a5716bb0df2fe15ec528bbd895cd18e6e

as the first three patches in the series; then it should apply to Linus'
tree.
