Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C118C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82102467B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A468YAmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBVAYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:24:53 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38616 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBVAYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:24:53 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so3123520ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8A1YE2lgpZQL8AL3OpYvUcklk0ocIiXfWyGf6voJc/k=;
        b=A468YAmhVxOg4ZCPKOO+HngxVCenqPG6tj44flBbVH8f0eC10zN6F7so5Iev26O7H3
         Dcsyd/DKYvl/F4qOhbUwZDjGaZHo+I6NqfzROPeoW+GPOiXj/5HtYN6ANTurUUlsuJaN
         8f0DGvEnng1nQwEWMBgCZAYHTG4b+WAwOJ5fgYtWTlP8+p9yMFax/5n8UAOOXpuytHyB
         2hE4m8cteF5vy3AH2wICcLz8Mi8V2SgRiC4nKCHUD2Ne+Bs1bClF0dMrRD6rQIo48kBv
         VxPIWQ5NlFCu2saASVViOuZxbRZfzoDCCWgikDXNTqOVuvbkg1tkP6SF84FmR+cL7RXg
         ohFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8A1YE2lgpZQL8AL3OpYvUcklk0ocIiXfWyGf6voJc/k=;
        b=rDaa187VTMhWDkyBKRGgDrgA+wXMBRjJiDkX1hX6ZrqiFAGCXMhJNB17piY0Q9W0SG
         rZXVzStOpgjxOU+IUvIEfe6PVPDgvwdihYOt/voroTSYz595x0gEMi+DYMK0J9NpMza1
         NgQnEVK41x1fC/7bLsLgttJiEb9ed7UlzhKHu39h+8g06JYHiZZ0n9IcsX9OEdrfEKPw
         owQ/LbpHDgMr7U9tbzKEd9drq4AucJLzSK38J2EjwOGewTBcNvWGaHXZ2Z3VsBXv9PQY
         xSTz+8WDoAnlESG/PBi4uJ/RxFW67P5EAUmolXERxFxW3ZdxvSguzH+AOzhEXu9ekE9h
         /cPQ==
X-Gm-Message-State: APjAAAVI7m5By8OyJP9hL0y2vI58dOiCh4ei4Ra397Ypu0oev+H/5ypH
        QrV+uzZXIxJ/j3iq15n6QeNOWH4d0/qg7MVCsgs=
X-Google-Smtp-Source: APXvYqzyTmI7bo/6oBqxlPJ5xgkoN62fwV92kXNShjSSyHmeuvF/zl8mHMsAJqA1ekSUggc1pmy4NQfL9c8FeSt751E=
X-Received: by 2002:a92:7402:: with SMTP id p2mr38368278ilc.64.1582331092334;
 Fri, 21 Feb 2020 16:24:52 -0800 (PST)
MIME-Version: 1.0
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com> <9b8ff9ca-75b0-c256-cf37-885ccd786de7@linux.alibaba.com>
In-Reply-To: <9b8ff9ca-75b0-c256-cf37-885ccd786de7@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 21 Feb 2020 16:24:41 -0800
Message-ID: <CAKgT0UfPW+DKZhze-hCL6mThak+qJjx4wb-rXn+NKnp6-9RBDQ@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP partially
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:24 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 2/20/20 10:16 AM, Alexander Duyck wrote:
> > On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >> Currently when truncating shmem file, if the range is partial of THP
> >> (start or end is in the middle of THP), the pages actually will just get
> >> cleared rather than being freed unless the range cover the whole THP.
> >> Even though all the subpages are truncated (randomly or sequentially),
> >> the THP may still be kept in page cache.  This might be fine for some
> >> usecases which prefer preserving THP.
> >>
> >> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> >> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> >> So, when using shmem THP as memory backend QEMU inflation actually doesn't
> >> work as expected since it doesn't free memory.  But, the inflation
> >> usecase really needs get the memory freed.  Anonymous THP will not get
> >> freed right away too but it will be freed eventually when all subpages are
> >> unmapped, but shmem THP would still stay in page cache.
> >>
> >> Split THP right away when doing partial hole punch, and if split fails
> >> just clear the page so that read to the hole punched area would return
> >> zero.
> >>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > One question I would have is if this is really the desired behavior we
> > are looking for?
> >
> > By proactively splitting the THP you are likely going to see a
> > performance regression with the virtio-balloon driver enabled in QEMU.
> > I would suspect the response to that would be to update the QEMU code
> > to  identify the page size of the shared memory ramblock. At that
> > point I suspect it would start behaving the same as how it currently
> > handles anonymous memory, and the work done here would essentially
> > have been wasted other than triggering the desire to resolve this in
> > QEMU to avoid a performance regression.
> >
> > The code for inflating a the balloon in virtio-balloon in QEMU can be
> > found here:
> > https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
> >
> > If there is a way for us to just populate the value obtained via
> > qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
> > which is the size I am assuming it is at since you indicated that it
> > is just freeing the base page size, then we could address the same
> > issue and likely get the desired outcome of freeing the entire THP
> > page when it is no longer used.
>
> If qemu could punch hole (this is how qemu free file-backed memory) in
> THP unit, either w/ or w/o the patch the THP won't get split since the
> whole THP will get truncated. But, if qemu has to free memory in sub-THP
> size due to whatever reason (for example, 1MB for every 2MB section),
> then we have to split THP otherwise no memory will be freed actually
> with the current code. It is not about performance, it is about really
> giving memory back to host.

I get that, but at the same time I am not sure if everyone will be
happy with the trade-off. That is my concern.

You may want to change the patch description above if that is the
case. Based on the description above it makes it sound as if the issue
is that QEMU is using hole punch or MADV_DONTNEED with the wrong
granularity. Based on your comment here it sounds like you want to
have the ability to break up the larger THP page as soon as you want
to push out a single 4K page from it.

I am not sure the description for the behavior of anonymous THP with
respect to QEMU makes sense either. Based on the description you made
it sound like it was somehow using the same process used for huge
pages. That isn't the case right? My understanding is that in the case
of an anonymous THP it is getting broken into 4K subpages and then
those are freed individually. That should leave you with the same
performance regression that I had brought up earlier.

So if anything it sounds like what you are really wanting is feature
parity with anonymous THP which will split the anonymous THP page when
a single 4K page within the THP is hit with MADV_DONTNEED.

- Alex
