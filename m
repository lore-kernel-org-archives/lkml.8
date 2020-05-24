Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048EDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC67120825
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhpWBa9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgEXTMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbgEXTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:12:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CAC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:12:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o13so12375440otl.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pTUti2iXX/HBqPw+z4+24eIvkZrygpmEFB+h6bK3Nmw=;
        b=qhpWBa9i7c7elhwkam2/ANNIvn6v/uMNoMQt6T6WcKbBuR8oiWSKQTSsheuLHCMzQQ
         DirBC59lqDOEE56j5+q9esfziom9Fsj6g1FKhe1/raPCxstCJdspslppNNQog9Da4wBV
         TpFKk8QYOW3Y+X+6cCrxdsBPuu9iAbIRwCfUxdnu0yv+9Eig0nk9IO61hTnKA00+rpNm
         JRWM2ue8xw2c88OYjvcEisXmfYyrSHb7ItPRShFV8yI2ZMA4DRqBJWzLOcPSXgQYtBWo
         FohQ4USDDLrcGncoaYxNJR7kCkye3MTEApPNITgzTw5lczxKaM3ZDN0hBaHI22Yfzs2e
         owwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pTUti2iXX/HBqPw+z4+24eIvkZrygpmEFB+h6bK3Nmw=;
        b=hBx1Ba+KwU/glB3IsT1VPW9eXniOKcq9gNxgXY6FaIgNrsZyBhERoZuJuPOepzcIn9
         vk9bucTm4Mer1yQcnJzMcFh8J9OPHMx808vcbvyzm0SdC/wGgA9kq7ngBLK0QGgAe9cK
         IH+BkqLRYD4876oS7YCnPI+j9c/0JeHQ6s68YesSVC7qPBiESvMBalfounwCXff+nszx
         a25Yaq29R9j0ei1xTW58xKSmzlMYp7aXg6NBD5xk/6ZcBQ8vgKunqh9nOLOljokvn9q5
         WrShwIpB7q3CrtRGy5lcNSiO3wZBXb6AAkqA0pl7OPgZpK7KrBefgtGaRbIFAP/tNuBc
         DyNg==
X-Gm-Message-State: AOAM531Qmvtk+DqQbz8W/RkjA/fxu5g68aBaKcqWP0U39bki8/cJXqTV
        1OhGdffExSzAnKIFFFkroyl6pcr/K40=
X-Google-Smtp-Source: ABdhPJwy+hC5I5E5Rn6xDqS7/+IUpTlI0yZmhW/si0NNH0sK7DmSuLqoI2I5jZCeaCHSdtM/qfbGCw==
X-Received: by 2002:a9d:8e7:: with SMTP id 94mr18908037otf.370.1590347558212;
        Sun, 24 May 2020 12:12:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c26sm4403012oov.13.2020.05.24.12.12.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 24 May 2020 12:12:36 -0700 (PDT)
Date:   Sun, 24 May 2020 12:12:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
In-Reply-To: <63fe94c7-78d1-ae03-00da-ba0e6d207a70@yandex-team.ru>
Message-ID: <alpine.LSU.2.11.2005241150250.3059@eggly.anvils>
References: <158937872515.474360.5066096871639561424.stgit@buzz> <alpine.LSU.2.11.2005231650070.1171@eggly.anvils> <63fe94c7-78d1-ae03-00da-ba0e6d207a70@yandex-team.ru>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020, Konstantin Khlebnikov wrote:
> On 24/05/2020 04.01, Hugh Dickins wrote:
> > On Wed, 13 May 2020, Konstantin Khlebnikov wrote:
> > 
> > > Function isolate_migratepages_block() runs some checks out of lru_lock
> > > when choose pages for migration. After checking PageLRU() it checks extra
> > > page references by comparing page_count() and page_mapcount(). Between
> > > these two checks page could be removed from lru, freed and taken by slab.
> > > 
> > > As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> > > Race window is tiny. For certain workload this happens around once a
> > > year.
> > 
> > Around once a year, that was my guess too. I have no record of us ever
> > hitting this, but yes it could happen when you have CONFIG_DEBUG_VM=y
> > (which I too like to run with, but would not recommend for users).
> 
> Yep, but for large cluster and pinpointed workload this happens surprisingly
> frequently =) I've believed into this race only after seeing statistics for
> count of compactions and how it correlates with incidents.
> 
> Probably the key component is a slab allocation from network irq/bh context
> which interrupts compaction exactly at this spot.

Yes, I bet you're right.

> 
> > 
> > > 
> > > 
> > >   page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180
> > > index:0x0 compound_mapcount: 0
> > >   flags: 0x500000000008100(slab|head)
> > >   raw: 0500000000008100 dead000000000100 dead000000000200
> > > ffff88ff7712c180
> > >   raw: 0000000000000000 0000000080200020 00000001ffffffff
> > > 0000000000000000
> > >   page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
> > >   ------------[ cut here ]------------
> > >   kernel BUG at ./include/linux/mm.h:628!
> > >   invalid opcode: 0000 [#1] SMP NOPTI
> > >   CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W
> > > 4.19.109-27 #1
> > >   Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
> > >   RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> > > 
> > > 
> > > To fix just opencode page_mapcount() in racy check for 0-order case and
> > > recheck carefully under lru_lock when page cannot escape from lru.
> > > 
> > > Also add checking extra references for file pages and swap cache.
> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > Fixes: 119d6d59dcc0 ("mm, compaction: avoid isolating pinned pages")
> > 
> > Not really, that commit was correct at the time it went in.
> > 
> > > Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
> > 
> > Exactly, that commit was well-intentioned, but did not allow for this
> > (admittedly very exceptional) usage.  How many developers actually
> > make the mistake of applying page_mapcount() to their slab pages?
> > None, I expect.  That VM_BUG_ON_PAGE() is there for documentation,
> > and could just be replaced by a comment - and Linus would be happy
> > with that.
> 
> Ok, I'll redo the fix in this way.

Thanks.

> 
> > 
> > > ---
> > >   mm/compaction.c |   17 +++++++++++++----
> > >   1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/compaction.c b/mm/compaction.c
> > > index 46f0fcc93081..91bb87fd9420 100644
> > > --- a/mm/compaction.c
> > > +++ b/mm/compaction.c
> > > @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control
> > > *cc, unsigned long low_pfn,
> > >   		}
> > >     		/*
> > > -		 * Migration will fail if an anonymous page is pinned in
> > > memory,
> > > +		 * Migration will fail if an page is pinned in memory,
> > >   		 * so avoid taking lru_lock and isolating it unnecessarily in
> > > an
> > > -		 * admittedly racy check.
> > > +		 * admittedly racy check simplest case for 0-order pages.
> > > +		 *
> > > +		 * Open code page_mapcount() to avoid
> > > VM_BUG_ON(PageSlab(page)).
> > 
> > But open coding page_mapcount() is not all that you did.  You have
> > (understandably) chosen to avoid calling page_mapping(page), but...
> > 
> > > +		 * Page could have extra reference from mapping or swap
> > > cache.
> > >   		 */
> > > -		if (!page_mapping(page) &&
> > > -		    page_count(page) > page_mapcount(page))
> > > +		if (!PageCompound(page) &&
> > > +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
> > > +				(!PageAnon(page) || PageSwapCache(page)))
> > >   			goto isolate_fail;
> > 
> > Isn't that test going to send all the file cache pages with buffer heads
> > in page->private, off to isolate_fail when they're actually great
> > candidates for migration?
> 
> Yes. What a shame. Adding page_has_private() could fix that?
> 
> Kind of
> 
> page_count(page) > page_mapcount(page) +
> (PageAnon(page) ? PageSwapCache(page) : (1 + page_has_private(page)))

Certainly it was fixable, but I'm too lazy to want to think through
the correct answer; and though I'm often out of sympathy with helper
functions (why do people want an inline bool function for every simple
flag test?!?!), here is a place that cries out for a helper, if you
complicate it beyond page_count > page_mapcount (especially when
driven into that detail of adding 1 to _mapcount).

> 
> or probably something like this:
> 
> page_count(page) > page_mapcount(page) +
> (PageAnon(page) ? PageSwapCache(page) : GUP_PIN_COUNTING_BIAS)
> 
> I.e. skip only file pages pinned by dma or something slower.
> I see some movements in this direction in recent changes.
> 
> of course that's independent matter.

Yes, once the gup/pin conversion is widespread, I expect that it will
allow a better implementation of this compaction test, one not limited
to the anonymous pages.  (We do internally use a patch extending the
current test to file pages, which in practice has saved a lot of time
wasted on failing compactions: but, last I looked anyway, it gets some
cases wrong - cases we happen not to care about ourselves, but would
be unacceptable upstream.  So I hope the distinction of pinned pages
will work out well here later.)

Hugh
