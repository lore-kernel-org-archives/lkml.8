Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1C22067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EflxfCon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHXRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:36:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03114C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PDGpX/gLn6F/h8sTkr6/xtJftCfZUJ0TMwjy5eqECbw=; b=EflxfCon92BXdyEpHqw0j6BRKB
        kHi1RfocRHJrsGcFweJYVWk1o8lsW3K+xRkyZRTDbZ4K1RcSRWQElpDgwAJsJndV0PRfjhdTnT5e1
        Z2R2bc9dUvv5a+bBZmqdI1FBJsLI36RsUiBo2mEWrU4jJwrl7I5jgj12xCCa42ItzmkhozXwebjRi
        5Ymj7UAF354UfSMh2mUB4v1cVVXDlM8U5BwnffhxApZ76471ZKtO3M1I0Z0OiS+L42gP4hHGVwYLz
        4MXysnyDzjjdB4x+71CKqGrCC/s+x8vVIEmtS/lMJPz/VDfFsxw1UVWFTJKz0m4OqFMTnWXCe5Hum
        SOLhP7JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAGOe-0006CA-2D; Mon, 24 Aug 2020 17:36:40 +0000
Date:   Mon, 24 Aug 2020 18:36:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200824173639.GD17456@casper.infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
 <20200824161620.GK24877@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824161620.GK24877@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:16:20PM +0200, Jan Kara wrote:
> On Wed 19-08-20 16:05:54, Matthew Wilcox (Oracle) wrote:
> > All callers of find_get_entries() use a pvec, so pass it directly
> > instead of manipulating it in the caller.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Rather than passing pvec to find_get_entries() and then making everybody
> use it, won't it more consistent WRT the naming to make everybody use
> pagevec_lookup_entries() (which is trivial at this point in the series) and
> then rename find_get_entries() to pagevec_lookup_entries()? I.e., I'd prefer
> if the final function was called pagevec_lookup_entries() because that is
> IMO more consistent with how other functions are named in this area...

It seemed more consistent to me to have everybody using
find_get_entries().  To me the pagevec functions:

1. Are in mm/swap.c (not really sure why)
2. Take pvec as the first argument, not the last
3. Wrap a find_* function

Whereas the find_* functions:

1. Are in mm/filemap.c
2. Take mapping as the first argument
3. Manipulate the XArray directly

We already have functions in filemap which take a pagevec, eg
page_cache_delete_batch() and delete_from_page_cache_batch().

So if we're going to merge the two functions, it seems more natural to
have it in filemap.c and called find_get_entries(), but I'm definitely
open to persuasion on this!
