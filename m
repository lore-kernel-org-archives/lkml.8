Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8A422B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRWGGRmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgH0O1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgH0OQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598537756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mpQ/nk/cQTcpyoT6ZpURcUTf2Am8I9UP1TziC1aL0c=;
        b=KRWGGRmdeZvSM/iGMdxX6h5WNobFAacXFq32l9dXBw+dx1NcND7GKDBklp50H9rSAmP+R8
        VIPfg/g3FXSGCKYnQGFMceWntxhaUvTZJbAIieOyP7J2FE67Uy1LlWQTC2u21ijyF2y0OT
        m1p2t0xEw1CDq3rrY9+dHVFS3IYcoUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-JMfYdDJHMOO7743Y3S4CbA-1; Thu, 27 Aug 2020 10:15:52 -0400
X-MC-Unique: JMfYdDJHMOO7743Y3S4CbA-1
Received: by mail-qk1-f200.google.com with SMTP id v16so4903579qka.18
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mpQ/nk/cQTcpyoT6ZpURcUTf2Am8I9UP1TziC1aL0c=;
        b=op8q5z2ASx/2e6ZKTRJhqKq3KQx1jxoQVbbMdRQq1suvtRGwxC8A0K6grTvS65o0UI
         n43KHFzLKyZuOIa0/0iZux1lVndTttv/QQzZQGMCk/r1VgLQUEWehmrGUrxkK85UMIrP
         2t2oA5d90s5W5bCVdzRrH1AsXep9PaOkktyBE67E3vm2clrSp5S49lqv4AUcxF9pL1KK
         nlJf1LlXSL8FgxnGXzvJZ3m9fhCzK1Hre7PDAj2xSFtc8jFDDTNz8KOyNzQeNSOurRZl
         QOnDlh/tk09B7hL10iX3+Os8Xsm2X4YYFM+jd+kv/+7kppZfSDjJs6s+iXF86tTxy2x+
         7lPg==
X-Gm-Message-State: AOAM533ekcf6tqhyvaYvrK//JzTSJGl0NqMUdR+HAK7ixh2RRplCk5ev
        el68QWwjsxBY8EbNoRUsITG5dzEwDq8StE6YywLaV3DTLmea/2NP5PM0Yve5MlxTdu+374Nk0v7
        +H1CDf/QL71wKzIkyNDpq10kB
X-Received: by 2002:aed:3bb8:: with SMTP id r53mr3174844qte.289.1598537751928;
        Thu, 27 Aug 2020 07:15:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZQdefdIdYSXybj/P7LL8lVaFJUvvHCe3YBya4y4MISL6pwCTDTWgq7tbWmkHd8slSaJbDZQ==
X-Received: by 2002:aed:3bb8:: with SMTP id r53mr3174815qte.289.1598537751620;
        Thu, 27 Aug 2020 07:15:51 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id y24sm1795095qtv.71.2020.08.27.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:15:50 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:15:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] mm: Simplfy cow handling
Message-ID: <20200827141549.GA6059@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:49:54PM -0400, Peter Xu wrote:
> This is a small series that I picked up from Linus's suggestion [0] to simplify
> cow handling (and also more strict) by checking against page refcounts rather
> than mapcounts.
> 
> I'm CCing the author and reviewer of commit 52d1e606ee73 on ksm ("mm: reuse
> only-pte-mapped KSM page in do_wp_page()", 2019-03-05).  Please shoot if
> there's any reason to keep the logic, or it'll be removed in this series.  For
> more information, please refer to [3,4].
> 
> The new mm counter in the last patch can be seen as RFC, depending on whether
> anyone dislikes it... I used it majorly for observing the page reuses, so it is
> kind of optional.
> 
> Two tests I did:
> 
>   - Run a busy loop dirty program [1] that uses 6G of memory, restrict to 1G
>     RAM + 5G swap (cgroup).  A few hours later, all things still look good.
>     Make sure to observe (still massive) correct page reuses using the new
>     counter using the last patch, probably when swapping in.
> 
>   - Run umapsort [2] to make sure uffd-wp will work again after applying this
>     series upon master 5.9-rc1 (5.9-rc1 is broken).
> 
> In all cases, I must confess it's quite pleased to post a series with diffstat
> like this...  Hopefully this won't break anyone but only to make everything
> better.
> 
> Please review, thanks.
> 
> [0] https://lore.kernel.org/lkml/CAHk-=wjn90-=s6MBerxTuP=-FVEZtR-LpoH9eenEQ3A-QfKTZw@mail.gmail.com
> [1] https://github.com/xzpeter/clibs/blob/master/bsd/mig_mon/mig_mon.c
> [2] https://github.com/LLNL/umap-apps/blob/develop/src/umapsort/umapsort.cpp
> [3] https://lore.kernel.org/lkml/CAHk-=wh0syDtNzt9jGyHRV0r1pVX5gkdJWdenwmvy=dq0AL5mA@mail.gmail.com
> [4] https://lore.kernel.org/lkml/CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com

Is there more comments for this series on either reviews, or suggested tests to
carry out (before a broader trial)?

Thanks,

-- 
Peter Xu

