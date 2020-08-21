Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD26C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC1720714
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpWyyqs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHUTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbgHUTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598038269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHf1EBkT1Dy1Sxom78LRrOH5QXXkCxI+ZwxWCHSIPnM=;
        b=XpWyyqs/OU6JUfNfHPK36reHxJ1F00panReHGQhIncgb6UylwGdgFIq8yd2JoVczLwYqpN
        STrO/cwqMY8Kz4q5Mw++s2WA9qj1BvVDsyogTBW3kqHIMMi/dfb6q/0aR6HBJOnHzAr6pJ
        g41UStEo/KyrGMcfeixAQWc6fmhLIBg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-ab475QYfPwyHfzLWQbEVXg-1; Fri, 21 Aug 2020 15:31:03 -0400
X-MC-Unique: ab475QYfPwyHfzLWQbEVXg-1
Received: by mail-qv1-f70.google.com with SMTP id i4so1923821qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHf1EBkT1Dy1Sxom78LRrOH5QXXkCxI+ZwxWCHSIPnM=;
        b=CmcueUIMewMWBWE/ceKe4a2Qhj6s/VdBwWqJS6W165sdqHe/ynS0hx4O6nvvU7fEuG
         8QtK7UolLTb2tFBSZCehTggSbPcsKU8y/gZeO9YsPwuY2BNhw2/fSILj6POPGZ/770s9
         lNrXpvCWvtFWSsTRAIUNG51GM0FXA0puJ2O+f7+HnzmXfUvJNsZNKlpzqai2SyYgQvs1
         03n5Y7qSbm72VD7kLySg5tEgLr21dKFfcvF1suNDyUJJRN96HKoZhrhDO04WDej2sMte
         Fh3y8NvMHqfzpEDAJmL17MVtADxVLb42AxjwkMblE2diiZLTB6hMHMi08qckHmOn5Mfz
         ferA==
X-Gm-Message-State: AOAM530wZAtVq31Xk56ZFGDx9gGmGJb79kQSrle8U8wr/ZDqgtyqW6XV
        D3bjHdf0RJuz8/2uHj7VHv6HagwE+hWPrFlvGHLrf6bbQj1wNTBNdVxNOXiwWfXnQFguRKJOFVW
        imRz88039iiHpDB1ece0f9FI1
X-Received: by 2002:a37:9a97:: with SMTP id c145mr4112674qke.385.1598038263093;
        Fri, 21 Aug 2020 12:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIDT+dfkV6MshPTrHOcz6MO3y6HAU3upZRyOOq+yPyHjO60OLZanIZiouXFJFyoqVR7pfbaw==
X-Received: by 2002:a37:9a97:: with SMTP id c145mr4112646qke.385.1598038262741;
        Fri, 21 Aug 2020 12:31:02 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id o21sm2487226qkk.94.2020.08.21.12.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:31:01 -0700 (PDT)
Date:   Fri, 21 Aug 2020 15:31:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200821193100.GA38249@xz-x1>
References: <20200811214255.GE6353@xz-x1>
 <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1>
 <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz>
 <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz>
 <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
 <20200821180848.GA11376@xz-x1>
 <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:23:31AM -0700, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 11:08 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > IIUC, Jan wanted to point out the fact that KSM didn't increase page count for
> > stable pages (reasons are above get_ksm_page()).
> 
> Ouch.
> 
> > Do we still at least need to check the swap count if PageSwapCache(page)?
> 
> No. Because a PageSwapCache() page should be a perfectly normal page
> cache thing. It will increment the page count if it's active.
> 
> That PageKsm() thing that *doesn't* increment the page could does look
> worrisome, but
> 
> > So we check page_count() (which covers KSM or normal pages) after we've got the
> > page lock, while we keep all the rest.
> 
> Why would we keep the rest? I
> 
> The actual thing I would really want to get rid of is the page lock,
> in fact. We shouldn't need it in this path, and it's the most
> expensive part of it all. But that's also why I did the page count
> test optimistically unlocked - because if page_count is 1, then we
> really shouldn't contend with anything else, so hopefully the
> (currently quite expensive) page locking is actually a non-issue once
> you get there.
> 
> But the PageKsm() page_count() issue I didn't even realize. That worries me.

That's definitely tricky.. Though IMHO that's another KSM topic that we might
want to look into later besides the current effort to fix up the COW breaking
issue for gup.  For now, it shouldn't be hard for us as long as we do cow
always for KSM pages.  However, do we really want to revert the whole logic of
52d1e606ee73?  Asking because it still seems to be an improvement to me (after
all we'll need to look after KSM pages here).  So it seems still good to keep.

Thanks,

-- 
Peter Xu

