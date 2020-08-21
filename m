Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CE920720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N57ygES0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHUSI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgHUSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598033333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9qHpOFDNeqWufuoItwhQ7elzxQPkm2GnHd+vVY9RCMg=;
        b=N57ygES0JzS32FQeva2wDMX+eamEPysjiQKB0oloaquyzzxGccBbUXzsVuYMeOtg0Kw6oc
        mqk/2GnomLzl6dyylxATlSF6yvrqWQ2lr/fPs7NZQGjkenkwUZoZSjcHxIa4glKy2nqYyD
        hMO0O1Sjb2CuzPGD3uol57feWdmX0jk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-zPgKvQ1JP-mal8a8Bebz4Q-1; Fri, 21 Aug 2020 14:08:51 -0400
X-MC-Unique: zPgKvQ1JP-mal8a8Bebz4Q-1
Received: by mail-qv1-f71.google.com with SMTP id i4so1767735qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qHpOFDNeqWufuoItwhQ7elzxQPkm2GnHd+vVY9RCMg=;
        b=a10gX72jvi+9XDylR94nuxSI0NJVGY4H/ApjYwKrEvxcns1ej6xo8ZGx9ZNpkYO5v9
         PhiVwi5+CBwJ/X6BxGRDqlVJS/2Nko/09WRX/aQ2/HHoiUQm84Vq1UMq7eyg0mANigW+
         4pk9D36TOplllGY6r4B6Nn4igz2yHz8NtFR1fi8X/Vnqy0pran3wKG5O/S10pZbCBsaf
         GkRboOjqUqkrlBgaTfA2CAoRI+GCdbe9tN6WyQtuZPN11rkGDEPu8Kq7wTwvpFSmjDPF
         og6zf1oweXRcYFgl0mncMey/AZoD2hzjmP7cdCJm0lc1CGivxDS4ey4jSeVcoBI+4XIc
         Fy1g==
X-Gm-Message-State: AOAM530atJMbsR2QC88dvQdCcWQZiovRAmQXAgB0fpBXL4e92OjthDwQ
        Q2jzf09cvBl4OBHq4oVamdHeq5ZjKkhOxNQjrP9/GtnWR8voCcBOI/2iRf3gID5oL697dk4Prpf
        UQClehGWtNzMwIp6GrXQ6K3Dq
X-Received: by 2002:ac8:78d:: with SMTP id l13mr3914546qth.188.1598033330991;
        Fri, 21 Aug 2020 11:08:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZnyUSBfDk5h+qyqxQ5TQrLX1+luZJQgUY+iSfxjhpOqd8iPytAYSJRCAyz64H2gj08AUcOg==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr3914531qth.188.1598033330702;
        Fri, 21 Aug 2020 11:08:50 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t8sm2780673qtc.50.2020.08.21.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:08:49 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:08:48 -0400
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
Message-ID: <20200821180848.GA11376@xz-x1>
References: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1>
 <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1>
 <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz>
 <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz>
 <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:00:59AM -0700, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 8:48 AM Jan Kara <jack@suse.cz> wrote:
> >
> > I was more concerned about the case where you decide to writeably map (i.e.
> > wp_page_reuse() path) a PageKsm() page.
> 
> Yeah, so I think what I do is stricter than what we used to do - any
> KSM page will never be re-used, simply because the KSM part will have
> incremented the page count.

IIUC, Jan wanted to point out the fact that KSM didn't increase page count for
stable pages (reasons are above get_ksm_page()).

> 
> So as far as I can tell, with that patch we will never ever share
> except for the "I really am the _only_ user of the page, there are no
> KSM or swap cache pages" case.
> 
> That's the whole point of the patch. Get rid of all the games. If
> there is *any* possible other use - be it KSM or swap cache or
> *anything*, we don't try to re-use it.
> 
> > And also here I was more concerned that page_mapcount != 1 || page_count !=
> > 1 check could be actually a weaker check than what reuse_swap_page() does.
> 
> If that is the case, then yes, that would be a problem.
> 
> But really, if page_count() == 1, then we're the only possible thing
> that holds that page. Nothing else can have a reference to it - by
> definition.

Do we still at least need to check the swap count if PageSwapCache(page)?

Besides a complete cleanup, I'm now thinking whether we should use a smaller
change like below.  IMHO we can still simplify the ksm special case before
taking the page lock. Since ksm page should be rare in general, then it seems
not worth it to let every single cow to check against it:

diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..b852d393bcc7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2928,9 +2928,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
         */
        if (PageAnon(vmf->page)) {
                int total_map_swapcount;
-               if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
-                                          page_count(vmf->page) != 1))
-                       goto copy;
                if (!trylock_page(vmf->page)) {
                        get_page(vmf->page);
                        pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -2946,6 +2943,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
                        }
                        put_page(vmf->page);
                }
+               if (page_count(vmf->page) != 1) {
+                       unlock_page(vmf->page);
+                       goto copy;
+               }
                if (PageKsm(vmf->page)) {
                        bool reused = reuse_ksm_page(vmf->page, vmf->vma,
                                                     vmf->address);

So we check page_count() (which covers KSM or normal pages) after we've got the
page lock, while we keep all the rest.  It's also safe for the removed
condition of PageSwapCache() && PageKsm() because reuse_ksm_page() later on
will check PageSwapCache() again.

Thanks,

-- 
Peter Xu

