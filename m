Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4894C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C25220658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQuq9NA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHTVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:54:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgHTVy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597960495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0qPncheLw3CKXvEX1h3fwtoDZQE55eTmK3ToGqEFVE=;
        b=RQuq9NA3pnMwqdaTKvBW76u0N4JCY5EdCw8yCDuVgMcNPFEV9GzSPgq1tS18k0kohh9Xkd
        2bf5+uMfmWxZueAd8H/djDgMCXSUlRtRlbBMBc1raTACRjO0mroHYLs0+2CRtSFfRe/2xu
        jVwwXIk9NKfP09Z2Fgdm18bH5q7nAYA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-w2TVSKb4N86hlFPVVIh7oA-1; Thu, 20 Aug 2020 17:54:53 -0400
X-MC-Unique: w2TVSKb4N86hlFPVVIh7oA-1
Received: by mail-qv1-f72.google.com with SMTP id l10so16141qvw.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s0qPncheLw3CKXvEX1h3fwtoDZQE55eTmK3ToGqEFVE=;
        b=BxUbREmJIYTd9QbZaw0ZgSxlgcZtiGn9bIKWRYGePml22zY6TptSZo7KKQPm6tzkau
         cittJdIqOFydfSL6zvV1SnTned82EZWkAeSoFQ4PSK/jtn/FmcTktNEqHi5s3KofXi9t
         /G2cZx9kv8WmBKZkVv1p5l9Lo1Imsp2sflgFYWk1OsXGtREsiJt9tkSw5ABenek0dsfC
         WC2ReJ6cH9zn9j0W6ZDdjCay4s8RdQYvktsSrzuKKCHwaPYaGrb20gV99Eo4MrAHJWmz
         Em+bRcIDav7CySk07XhPahdInEHMj/b6v9paszZJFFXTujcrJbzSjOm8AtS+fY9Mg3pB
         ij6g==
X-Gm-Message-State: AOAM532my8IDkW4ynmoe7+PvwDPIe6v4rWY0Ic4HyZJ/2rmd+63xD4Cx
        fRGYjNr3TQoAsL9YQwD9bZHt8XoRqp/OmOJhxvxgZ4ffqNKNwNQVWRgbwH6SOQ5eQonUSkhv+mF
        Gd5wlJgC8ULlTpxGZMKmBFml+
X-Received: by 2002:a05:620a:12fb:: with SMTP id f27mr43312qkl.232.1597960492595;
        Thu, 20 Aug 2020 14:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfoqiD8raU/idXSD8wbKIq//ZtT7ZywNsaHa8GNY0rHZVP7tBG7VgPJSnDG0IFg/hihlBQaA==
X-Received: by 2002:a05:620a:12fb:: with SMTP id f27mr43288qkl.232.1597960492225;
        Thu, 20 Aug 2020 14:54:52 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id q68sm3139421qke.123.2020.08.20.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:54:51 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:54:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200820215449.GB358043@xz-x1>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1>
 <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:10:57PM -0700, Linus Torvalds wrote:
> On Tue, Aug 11, 2020 at 2:43 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > I don't know good enough on the reuse refactoring patch (which at least looks
> > functionally correct), but... IMHO we still need the enforced cow logic no
> > matter we refactor the page reuse logic or not, am I right?
> >
> > Example:
> >
> >   - Process A & B shares private anonymous page P0
> >
> >   - Process A does READ of get_user_pages() on page P0
> >
> >   - Process A (e.g., another thread of process A, or as long as process A still
> >     holds the page P0 somehow) writes to page P0 which triggers cow, so for
> >     process A the page P0 is replaced by P1 with identical content
> >
> > Then process A still keeps the reference to page P0 that potentially belongs to
> > process B or others?
> 
> The COW from process A will indeed keep a reference to page P0 (for
> whatever nefarious kernel use it did the GUP for). And yes, that page
> is still mapped into process B.
> 
> HOWEVER.
> 
> Since the GUP will be incrementing the reference count of said page,
> the actual problem has gone away. Because the GUP copy won't be
> modifying the page (it's a read lookup), and as long as process B only
> reads from the page, we're happily sharing a read-only page.
> 
> And if process B now starts writing to it, the "page_count()" check at
> fault time will trigger, and process B will do a COW copy.
> 
> So now we'll have three copies of the page: the original one is being
> kept for the GUP, and both A and B did their COW copies in their page
> tables.
> 
> And that's exactly what we wanted - they are all now containing
> different data, after all.
> 
> The problem with the *current* code is that we don't actually look at
> the page count at all, only the mapping count, so the GUP reference
> count is basically invisible.
> 
> And the reason we don't look too closely at the page count is that
> there's a lot of incidental things that can affect it, like the whole
> KSM reference, the swap cache reference, other GUP users etc etc. So
> we historically have tried to maximize the amount of sharing we can
> do.
> 
> But that "maximize sharing" is really complicated.
> 
> That's the big change of that simplification patch - it's basically
> saying that "whenever _anything_ else has a reference to that page,
> we'll just copy and not even try to share".

Sorry for the late reply, and thanks for the explanations.  That definitely
helped me to understand.

So, which way should we go?

I kind of prefer the new suggestion to remove code rather than adding new
codes.  I definitely don't know enough on the side effect of it, especially
performance-wise on either ksm or swap, but... IIUC the worst case is we'll get
some perf report later on, and it seems also not hard to revert the patch later
if we want.

Thanks,

-- 
Peter Xu

