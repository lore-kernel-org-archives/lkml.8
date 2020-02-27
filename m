Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBCC4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4358A24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5m0NMvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgB0A4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:56:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35625 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgB0A4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:56:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so685363pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 16:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CNTEHspSiiNg+pjpT+dEySXRPqzCmJjtXrnip4uwgSk=;
        b=E5m0NMvU/MReze+fNBH++Q85YNPyahPGQZCR504O8X/1xE3XUrN2leYsjIYnyZamWq
         8Vs//E21r7kmcKw8brBGu3W6Zx1QvmRsMFePFLpIA5LSo+u3/OHRpI+3X4jLpKcnQP+0
         jjv44zluKHXWpfmgW3SUHt+OO1Gz+FAszwIM5z/RRsOzMa1rz5G4NGl8o9Kk1WIGI4ZJ
         6r9EiaFh6O1ZBkOPmhCHLO+MMOkhib5XpVstiDd4CIIziLgmsaqGbewSStxBM8dPahX2
         x1kGvp/FtFKwB4XhsqXbD+msNkXGyER2BtSsG9OsrMkxS4FN96RHLRLHZBRyQu7BUiMs
         pIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CNTEHspSiiNg+pjpT+dEySXRPqzCmJjtXrnip4uwgSk=;
        b=FGnXl0q2WUOeQrt1AeWazbZ6NM7GmqjFX8ORgpxFTjc1vYJLzS2R7QoGIO5Du4bI/G
         /HhdOoV1sRVKTAK/pKnWyhqY98R9VE11AzspheWpaAKSWwE5CZ/LrkxaEx9lZbZ6SZEe
         WEAINOO+eCcSqNu7nrFL6tOHRruvVNuLnv/RjEqHHzGWDR2QR3YViaOW/B+UsjUd8teK
         ijn3L5DUJjJD5Gbfzz+bPXKChFtFzJvUKqt+Zfb4ExPvxN6nsaltIsv2cX16gqJskgK6
         3jJSBBNjXkHmHa0JK6NJOZVKTXk8YwbQPuTJbR68QwwdT6KKq0312tMgBHrGAUg8bqrL
         uPPA==
X-Gm-Message-State: APjAAAUZws2+jEF6/gJ9M/i0Dp0+eqEQ1oEe3qOYQv33WXdMKTbjjJSA
        GjoNly3F8qF9FltL+PkFd8c4+A==
X-Google-Smtp-Source: APXvYqz0rDOChTyo8Mw9+zaEUMqvyXYzLNfdrX/QPAxe1+0HDveg7d8gE+OEtng+6JhQt7d28vDk/g==
X-Received: by 2002:a63:2266:: with SMTP id t38mr1528086pgm.145.1582764978368;
        Wed, 26 Feb 2020 16:56:18 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id y3sm4490374pff.52.2020.02.26.16.56.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 16:56:17 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:56:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <9c30a891-011b-e041-2647-444d09fa7b8a@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2002261647020.1381@eggly.anvils>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com> <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com> <9b8ff9ca-75b0-c256-cf37-885ccd786de7@linux.alibaba.com> <CAKgT0UfPW+DKZhze-hCL6mThak+qJjx4wb-rXn+NKnp6-9RBDQ@mail.gmail.com>
 <9c30a891-011b-e041-2647-444d09fa7b8a@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Yang Shi wrote:
> On 2/21/20 4:24 PM, Alexander Duyck wrote:
> > On Fri, Feb 21, 2020 at 10:24 AM Yang Shi <yang.shi@linux.alibaba.com>
> > wrote:
> > > On 2/20/20 10:16 AM, Alexander Duyck wrote:
> > > > On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com>
> > > > wrote:
> > > > > Currently when truncating shmem file, if the range is partial of THP
> > > > > (start or end is in the middle of THP), the pages actually will just
> > > > > get
> > > > > cleared rather than being freed unless the range cover the whole THP.
> > > > > Even though all the subpages are truncated (randomly or
> > > > > sequentially),
> > > > > the THP may still be kept in page cache.  This might be fine for some
> > > > > usecases which prefer preserving THP.
> > > > > 
> > > > > But, when doing balloon inflation in QEMU, QEMU actually does hole
> > > > > punch
> > > > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not
> > > > > used.
> > > > > So, when using shmem THP as memory backend QEMU inflation actually
> > > > > doesn't
> > > > > work as expected since it doesn't free memory.  But, the inflation
> > > > > usecase really needs get the memory freed.  Anonymous THP will not
> > > > > get
> > > > > freed right away too but it will be freed eventually when all
> > > > > subpages are
> > > > > unmapped, but shmem THP would still stay in page cache.
> > > > > 
> > > > > Split THP right away when doing partial hole punch, and if split
> > > > > fails
> > > > > just clear the page so that read to the hole punched area would
> > > > > return
> > > > > zero.
> > > > > 
> > > > > Cc: Hugh Dickins <hughd@google.com>
> > > > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > > One question I would have is if this is really the desired behavior we
> > > > are looking for?
> > > > 
> > > > By proactively splitting the THP you are likely going to see a
> > > > performance regression with the virtio-balloon driver enabled in QEMU.
> > > > I would suspect the response to that would be to update the QEMU code
> > > > to  identify the page size of the shared memory ramblock. At that
> > > > point I suspect it would start behaving the same as how it currently
> > > > handles anonymous memory, and the work done here would essentially
> > > > have been wasted other than triggering the desire to resolve this in
> > > > QEMU to avoid a performance regression.
> > > > 
> > > > The code for inflating a the balloon in virtio-balloon in QEMU can be
> > > > found here:
> > > > https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
> > > > 
> > > > If there is a way for us to just populate the value obtained via
> > > > qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
> > > > which is the size I am assuming it is at since you indicated that it
> > > > is just freeing the base page size, then we could address the same
> > > > issue and likely get the desired outcome of freeing the entire THP
> > > > page when it is no longer used.
> > > If qemu could punch hole (this is how qemu free file-backed memory) in
> > > THP unit, either w/ or w/o the patch the THP won't get split since the
> > > whole THP will get truncated. But, if qemu has to free memory in sub-THP
> > > size due to whatever reason (for example, 1MB for every 2MB section),
> > > then we have to split THP otherwise no memory will be freed actually
> > > with the current code. It is not about performance, it is about really
> > > giving memory back to host.
> > I get that, but at the same time I am not sure if everyone will be
> > happy with the trade-off. That is my concern.
> > 
> > You may want to change the patch description above if that is the
> > case. Based on the description above it makes it sound as if the issue
> > is that QEMU is using hole punch or MADV_DONTNEED with the wrong
> > granularity. Based on your comment here it sounds like you want to
> > have the ability to break up the larger THP page as soon as you want
> > to push out a single 4K page from it.
> 
> Yes, you are right. The commit log may be confusing. What I wanted to convey
> is QEMU has no idea if THP is used or not so it treats memory with base size
> unless hugetlbfs is used since QEMU is aware huge page is used in this case.
> This may sounds irrelevant to the problem, I would just remove that.

Oh, I'm sad to read that, since I was yanking most of your commit
message (as "Yang Shi writes") into my version, to give stronger
and independent justification for the change.

If I try to write about QEMU and ballooning myself, nonsense is sure to
emerge; but I don't know what part "I would just remove that" refers to.

May I beg you for an updated paragraph or two, explaining why you
want to see the change?

Thanks,
Hugh
