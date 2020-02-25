Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9CC35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A624656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCsw87TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgBYDqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:46:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54553 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgBYDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:46:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so655255pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nBKEYujmH34H+BGRlspRZjgflh5FhAi1GM2LK9lHp9Y=;
        b=kCsw87TQVBAcKM9r518ZN2dY0JnXQLbgsixeuPItAFDTAuz5aQNk+je1mKa7WdsGRL
         8d/R06elnlYBbC+yPkshoU+re5Q7XFmwPCF5k5/+Sjt4B4Q+a81bY0D1zt1ZXiKgItrL
         XYNqnMgeU32ZWBYGF09U51mzFVXb8FSufhT8q3A38NBg2vjBmWb02pNNdiFdhpy/brNY
         MInuc4adDRI7gZreobYOslgrfqFvh+QvUGpD1akF49oU8BAIddVpzgYY1ToSunW++66R
         nAzTOB9UV9jwBmUgY+GCx/JWtOh0pS4/8QNMoWlXP2DI7CQt1VfS8BQTwTD1zZd4Ts1s
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nBKEYujmH34H+BGRlspRZjgflh5FhAi1GM2LK9lHp9Y=;
        b=YBpWPZLdoo91nbJcvYYbtTe3/tHYPSRoLbJQmQWlHLRclUREYocGNOS9wyR8puFKZr
         UfY3lxC39F3XCBd7SaPf4DELFC9WDLd6fJ4PiSrJRqliUJ8B8xephtU1jT+SVVRKM11j
         iBiVqTEK1/okDNYdum0DXB4V2QiY4mWJWDUm8wFW153zMXfbx6qUmXCzBQgZZWxlklEU
         pEZ8O2DbDwjtQpmNiMd8hRTVT/w8fDDuYIYQLdwZr2YwddXofWdAX+Wu2v3STV/o0Avr
         lFx6mfZ0hgeTUi7BBP+cIXvR6q450XvhpPY97ksjteYUqfsBp5EAziprY2/0eCpnS2hg
         2rEQ==
X-Gm-Message-State: APjAAAWyAEuAGk0r6gMEdl8jOnYVXcYPFJbR87cw/uJItRzqGICORLTn
        bGMeqQq2VY3lU5ILPJMCWtNc2g==
X-Google-Smtp-Source: APXvYqzR8NjdGIYtc3wv0nyfI59xBnPCoN8iMgjTvfZXon/zEuw8qQ4yH3Tzya+emU21iHtqHC8mEg==
X-Received: by 2002:a17:90a:a617:: with SMTP id c23mr2897794pjq.32.1582602383213;
        Mon, 24 Feb 2020 19:46:23 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id z3sm14598681pfz.155.2020.02.24.19.46.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 19:46:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 19:46:02 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1912041601270.12930@eggly.anvils> <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Yang Shi wrote:
> On 12/4/19 4:15 PM, Hugh Dickins wrote:
> > On Wed, 4 Dec 2019, Yang Shi wrote:
> > 
> > > Currently when truncating shmem file, if the range is partial of THP
> > > (start or end is in the middle of THP), the pages actually will just get
> > > cleared rather than being freed unless the range cover the whole THP.
> > > Even though all the subpages are truncated (randomly or sequentially),
> > > the THP may still be kept in page cache.  This might be fine for some
> > > usecases which prefer preserving THP.
> > > 
> > > But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> > > So, when using shmem THP as memory backend QEMU inflation actually
> > > doesn't
> > > work as expected since it doesn't free memory.  But, the inflation
> > > usecase really needs get the memory freed.  Anonymous THP will not get
> > > freed right away too but it will be freed eventually when all subpages
> > > are
> > > unmapped, but shmem THP would still stay in page cache.
> > > 
> > > Split THP right away when doing partial hole punch, and if split fails
> > > just clear the page so that read to the hole punched area would return
> > > zero.
> > > 
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > > v2: * Adopted the comment from Kirill.
> > >      * Dropped fallocate mode flag, THP split is the default behavior.
> > >      * Blended Huge's implementation with my v1 patch. TBH I'm not very
> > > keen to
> > >        Hugh's find_get_entries() hack (basically neutral), but without
> > > that hack
> > Thanks for giving it a try.  I'm not neutral about my find_get_entries()
> > hack: it surely had to go (without it, I'd have just pushed my own patch).
> > I've not noticed anything wrong with your patch, and it's in the right
> > direction, but I'm still not thrilled with it.  I also remember that I
> > got the looping wrong in my first internal attempt (fixed in what I sent),
> > and need to be very sure of the try-again-versus-move-on-to-next conditions
> > before agreeing to anything.  No rush, I'll come back to this in days or
> > month ahead: I'll try to find a less gotoey blend of yours and mine.
> 
> Hi Hugh,
> 
> Any update on this one?

I apologize for my dreadful unresponsiveness.

I've spent the last day trying to love yours, and considering how mine
might be improved; but repeatedly arrived at the conclusion that mine is
about as nice as we can manage, just needing more comment to dignify it.

I did willingly call my find_get_entries() stopping at PageTransCompound
a hack; but now think we should just document that behavior and accept it.
The contortions of your patch come from the need to release those 14 extra
unwanted references: much better not to get them in the first place.

Neither of us handle a failed split optimally, we treat every tail as an
opportunity to retry: which is good to recover from transient failures,
but probably excessive.  And we both have to restart the pagevec after
each attempt, but at least I don't get 14 unwanted extras each time.

What of other find_get_entries() users and its pagevec_lookup_entries()
wrapper: does an argument to select this "stop at PageTransCompound"
behavior need to be added?

No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
new behavior - evicting the head from page cache removes all the tails
along with it, so getting the tails a waste of time there too, just as
it was in shmem_undo_range().

Whereas shmem_unlock_mapping() and shmem_seek_hole_data(), as they
stand, are not removing pages from cache, but actually wanting to plod
through the tails.  So those two would be slowed a little, while the
pagevec collects 1 instead of 15 pages.  However: if we care about those
two at all, it's clear that we should speed them up, by noticing the
PageTransCompound case and accelerating over it, instead of plodding
through the tails.  Since we haven't bothered with that optimization
yet, I'm not very worried to slow them down a little until it's done.

I must take a look at where we stand with tmpfs 64-bit ino tomorrow,
then recomment my shmem_punch_compound() patch and post it properly,
probably day after.  (Reviewing it, I see I have a "page->index +
HPAGE_PMD_NR <= end" test which needs correcting - I tend to live
in the past, before v4.13 doubled the 32-bit MAX_LFS_FILESIZE.)

I notice that this thread has veered off into QEMU ballooning
territory: which may indeed be important, but there's nothing at all
that I can contribute on that.  I certainly do not want to slow down
anything important, but remain convinced that the correct filesystem
implementation for punching a hole is to punch a hole.

Hugh
