Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28442078D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QotuNI+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHWX6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgHWX6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598227110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ae7r/HXyjg622rAZ8QfwTlQQk+yC0y1DlfCIxiu/nc=;
        b=QotuNI+EnyUYa908DHy4tAzEm4mNSHqUpzqTQKWxZ9NSA5TnyTXlfNXFySEIUlFl1Am05B
        vKJsyMhmpDGMNrMkQgd+HAm5cXBnWSlQyxZ9aBkbA/pDjDdM1ZzneHNLFaFWBdh0k7vtas
        48V74fxsFT+kl20mGGh0Dr3dSUIcimE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-iNKuwR07O5qzlQMEuHDAMg-1; Sun, 23 Aug 2020 19:58:28 -0400
X-MC-Unique: iNKuwR07O5qzlQMEuHDAMg-1
Received: by mail-qt1-f197.google.com with SMTP id b18so5584699qte.18
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ae7r/HXyjg622rAZ8QfwTlQQk+yC0y1DlfCIxiu/nc=;
        b=cm1Kbc6AZ4elcgY2QnEnSfQfN54V1pl/pvzThlYqgXbnRpa52YrAduPCrmw0+zbF9O
         YksH4Zt6Gov1rtWMAf0o7oC78C30QES/NedJItopeEi3UpAOvI3TVGTmkKaBWDtFjOq1
         hmBdMDJ6Vf7GTqkwfcawrkosotAKOHVhWv81Vn4yka4S83g7lzNMhamWHeaXGyWFEEt3
         kXqiSfNQ2zyNHeo84joNJEo0qzpl+qLRF677wk0MSyBtWRSOL24zaVtC6AH4nczubc+w
         AXkbNb60vM+3nA2pBOodaSaeBEjhoN52mxkMpcb1kT8r5aYT6DBQ4gVCfXbKiv3Af3cb
         majg==
X-Gm-Message-State: AOAM533TRBhlwU3maerLghuJD5rZgKEmcDjr1uTqKBw3B9lfxkNV8lLZ
        B5+4XtiVPHlQmXMF2tARbwHWJGdmhCbNbgDNGcR0Ga0hyKV0gnni7oFSXRVh//iO2nYYCKaDXll
        GXZM1b+7AY/VJyZdkaUf5V1bc
X-Received: by 2002:a05:620a:11a6:: with SMTP id c6mr2555985qkk.209.1598227107712;
        Sun, 23 Aug 2020 16:58:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw56gNsSLcW71PTv1UE4TN1PQs6Y3F6UAPGREEyJaQjLJOideQJYeYOzUdjGc3RVUm6T2EP7w==
X-Received: by 2002:a05:620a:11a6:: with SMTP id c6mr2555961qkk.209.1598227107416;
        Sun, 23 Aug 2020 16:58:27 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g4sm8116313qka.25.2020.08.23.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 16:58:26 -0700 (PDT)
Date:   Sun, 23 Aug 2020 19:58:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] mm: Simplfy cow handling
Message-ID: <20200823235824.GA6231@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <CAHk-=wgQ_bqiEXrwnAratT+2N+VGdhEsK7xShaj04Dgo2JNwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ_bqiEXrwnAratT+2N+VGdhEsK7xShaj04Dgo2JNwtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 09:05:37AM -0700, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 4:50 PM Peter Xu <peterx@redhat.com> wrote:
> >
> >   - Run a busy loop dirty program [1] that uses 6G of memory, restrict to 1G
> >     RAM + 5G swap (cgroup).  A few hours later, all things still look good.
> >     Make sure to observe (still massive) correct page reuses using the new
> >     counter using the last patch, probably when swapping in.
> >
> >   - Run umapsort [2] to make sure uffd-wp will work again after applying this
> >     series upon master 5.9-rc1 (5.9-rc1 is broken).
> 
> I obviously like the diffstat, am wondering if you saw any throughput
> changes or similar for the busy-loop dirtying thing?

I didn't compare the two in my previous testing.

Firstly, although my program did output some dirty rate information in per
second basis, the dirty rate is kind of fluctuating during the runs due to
frequent swap in/out pages, and I cannot observe a stable dirty rate at least
with the patch applied.  I'm afraid I'll see similar thing even without
applying the patch. Maybe it'll show some statistic pattern if I do it per
10sec or longer, but not sure.

More importantly, I'm not sure whether that's the major case to compare either
if we want to have some rough understanding about patch 1 on the performance
impact.  The thing is, my test program only dirtied some private allocated
pages with itself as the only owner of the pages.  IIUC the page reuse logic
will trigger on either the old or new code because both the mapcount or
refcount will be one.  If we really want to compare the two, shouldn't we run
some tests that will trigger the COW differently before/after the patch?  E.g.,
when some pages are referenced by some GUP users and when COW happens with only
one pte mapped to the page.  I haven't thought deeper than this on such a test
yet.

So my previous testing was majorly for making sure the general cow and the swap
path will at least still behave as expected.

Thanks,

-- 
Peter Xu

