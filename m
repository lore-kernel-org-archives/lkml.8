Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7259C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 04:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1410206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 04:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqQJCuM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgHPER1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 00:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgHPER0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 00:17:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B751C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 21:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E7QlbIVbd/kua+RC3z3/CIsH6rwOPqm/rCp6a5e3tB0=; b=nqQJCuM+Pp2/akFQ8SOxLAxR9h
        KQwQefXTFy+6Pqf8eqNwFFeHZbih5SK89H4QLXch0SddyZfioKGT7IIqQWTXig64Npscp9QwwDEKF
        E0AHFZTguAXzB7f2EufRNGEFhppaADrk0GW6jR+lGWTPD05isEhtDbK7wL8n0bUm75jGKdNBOOuio
        brxujJZldkr4OyIji5j4paeNkR9iV94l0yFyYhgBnqPl/d/aN4pkN8IX2CHYXIsd2pFFL9czNNlZH
        vxlrBVtF0uVJ/9O4oVqWK4L0sJtCxbz6fDsTbmdOgdgCwmznVH5AMxkbMnCVIDkP6J+5f3Z7BRcsP
        1UyPP8lg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7A6i-0001Ww-BV; Sun, 16 Aug 2020 04:17:20 +0000
Date:   Sun, 16 Aug 2020 05:17:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/pageblock: remove false sharing in pageblock_flags
Message-ID: <20200816041720.GG17456@casper.infradead.org>
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 11:47:57AM +0800, Alex Shi wrote:
> Current pageblock_flags is only 4 bits, so it has to share a char size
> in cmpxchg when get set, the false sharing cause perf drop.
> 
> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
> the only cost is half char per pageblock, which is half char per 128MB
> on x86, 4 chars in 1 GB.

I don't believe this patch has that effect, mostly because it still does
cmpxchg() on words instead of bytes.

But which functions would benefit?  It seems to me this cmpxchg() is
only called from the set_pageblock_migratetype() morass of functions,
none of which are called in hot paths as far as I can make out.

So are you just reasoning by analogy with the previous patch where you
have measured a performance improvement, or did you send the wrong patch,
or did I overlook a hot path that calls one of the pageblock migration
functions?
