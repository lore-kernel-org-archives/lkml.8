Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309A720786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HaQASwrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHYQY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHYQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:24:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:24:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y65so2941227qtd.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gj5tvB00t2fBLXjwCrSobBJ+bjW9aJbA2r5vUkdMM7w=;
        b=HaQASwrHHq62VPx9m6xhmYR415FPe7pkL7ibCGuEGzTc0XvMOPfS4H0PpZG5pE52+w
         cvl0TB7VNpm5LfnRATPCzr6XAH1WMbwPdTmgZDuUww/T5baMmbByaxOSSFu7lqMh/rfu
         1t+uTnKFViI/jYlOSUAV7aVUVHWKeBnDWAqHPTpPCY2qvm+ZzbncPIl1AxkSxPG1rJlf
         uY62rn9HAYvIUHjLAxuiyILshEFYAZt5js0fRLF4uRCdkLPdnFJwvaNKSNd29jM4ZwNM
         bZ/b777T5bp19IIy6qd4OcDAeZ2LhtmEm0U7h6KkWXLXSEZMD1jPgrAUOjR6WPg/+t3l
         mPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gj5tvB00t2fBLXjwCrSobBJ+bjW9aJbA2r5vUkdMM7w=;
        b=ihe006JoiV/Jhr47IexCrOsCLC5S+vy/gkmeKvICYzct39vBSh1WtHvhpmUV9vr82i
         k7Qa1N/fgtsIY7ddYeF+knKox8AuJr/2q+0JXnqWFYqYjrT1JQ74PWVsjUPL+8/Pqad8
         FTEZbOukIckVFn3IywFl8pWtLApC+r53iGrUZ1VWwzb6im3TGvJBxliKfqIuE+yTWLVr
         8ayzORaXNS+M7b6459rCNCqw/a4/nb7KCnit/0CqR/PMlMRsl7anKJ5TzBM2qaQAo4Jt
         bxAOg9bIDc+7dCTN06T23lcGabqL/pafAzQU8FnMU/ISv2/vh0ceWgnk9PUSd1kn69LP
         Zbvw==
X-Gm-Message-State: AOAM533CwDWg/80WDO5EGp9Uo6p0JHIhZXVD+Ju6cjaaoqld1egnIsiH
        Daa2Y+JJ1dePAxcGiONDuZtCvg==
X-Google-Smtp-Source: ABdhPJwNjW6rNox7qHW4DMCZZaAlB5AETn243GjFntYbeEQil3db1Nfim25r2n2wwB/N74bzvrUeXA==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr9885085qtw.20.1598372695512;
        Tue, 25 Aug 2020 09:24:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:bdd3])
        by smtp.gmail.com with ESMTPSA id a20sm14167382qtw.45.2020.08.25.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:24:54 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:23:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200825162342.GC932571@cmpxchg.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
 <20200824161620.GK24877@quack2.suse.cz>
 <20200824173639.GD17456@casper.infradead.org>
 <20200825123324.GB32298@quack2.suse.cz>
 <20200825132814.GO17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825132814.GO17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:28:14PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 02:33:24PM +0200, Jan Kara wrote:
> > On Mon 24-08-20 18:36:39, Matthew Wilcox wrote:
> > > We already have functions in filemap which take a pagevec, eg
> > > page_cache_delete_batch() and delete_from_page_cache_batch().
> > 
> > Right but those are really pretty internal helper functions so I don't
> > think they form or strong precedence.
> 
> To be honest, I saw that as being the way forward for the page cache APIs.
> If we're going to use a batching mechanism, it should be pagevecs, and
> it should be built into the page cache interfaces rather than hanging
> out off on the side.

Agreed.

> > > So if we're going to merge the two functions, it seems more natural to
> > > have it in filemap.c and called find_get_entries(), but I'm definitely
> > > open to persuasion on this!
> > 
> > I agree that having non-trivial xarray code in mm/swap.c isn't attractive
> > either. Dunno, I dislike the inconsistency between find_get_pages() and
> > find_get_entries() you create but they aren't completely consistent anyway
> > so I can live with that. Or we can just leave the pagevec_lookup_entries()
> > wrapper and the API will stay consistent...
> 
> I was thinking about this some more [1] [2].  I think we can get to the
> point where find_get_pages(), find_get_entries() and find_get_pages_tag()
> (and all their variants) end up taking a pagevec as their last argument.

Agreed.

> Also, I was thinking that all these names are wrong.  Really, they're
> mapping_get_pages(), mapping_get_entries() and mapping_get_marked_pages().
> So maybe I should move in that direction.

That sounds like a lateral move in naming to me. The mapping prefix is
a slight improvement, but without the "find" it sounds like a refcount
operation and hides the fact that this is doing some sort of lookup
and has higher complexity.

It also makes working on this code easier on people not yet familiar
with it at the cost of people familiar with it. Remembering new names
for known concepts is a ton of mental churn.

So IMO the new names should be unambigously and significantly better
than the old ones to justify this.

Signed: somebody who is still struggling with the change from
exceptional entries in the radix tree to value entries in the xarray
(Are pointers or integers the values? Aren't they both "values"?)
