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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E533AC3566F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFFE24650
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1fGCSkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVAjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:39:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46029 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBVAjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:39:42 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so4275797ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkzVUvb4J3yMIlLcArUIbWQ/BtybgRg77idRRt9Ey0I=;
        b=F1fGCSkCdIyKeEo+oAV2qph81izXfYQYZFG3vZ0svm5XRYMOLXCxbc6SrtsKKX35gh
         AOcueM6f5QdKPqy7j/RzWkFHs0MshH/Xj6PeLcu3zSlzDmB/cxhwq+5vJPYJGmbTFnnk
         h/ug6mxJELKkMcSe3RaeOBz6KyPdv0487/ROuE/lSMI/Bcw+2JuZT4yR0bmx/OQ7iC7+
         sZKDz36Oow+QQ1zUeMqya0iSbmgQ8I6QMtOrygYHuCQIvQnM2LWxg8QZu6wN5hy+xz62
         mR4hLfENClVE8iTAgayXJHBSaT6tXaukg98zA/06xI/bEnBRpZRb7uDSvf+JB6oGU0Z4
         Gz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkzVUvb4J3yMIlLcArUIbWQ/BtybgRg77idRRt9Ey0I=;
        b=MFqqr1jSUC6wRiCKDYyR2hH0hk050ELvpNui3sMcszn07sLaIRv/lKQ2Np3X3kDWdy
         27kgAncCeT8BH9z/CQFI38c7sI4CssNBBT6n1UqeOS4NWfuL4qaTlzGjzb3LDsCOUQYI
         MxR6kEEWiX4+dn6YSNJymTQXNKPW1Fba7d51xlaqUaoGuvKq7coxIEwsA4q6JvF84X7b
         +RY2c9yQPFi+Su6qHIFjodyBLB+uDOKqpjwcj49jLSfxvLRKdCTGy3/yn+vSdOq4gOzW
         oG76nVDyDunFSPrLSA6RMRNGYX+81Pa8Z8dcfWaByQ8PCz67Ecyvxysahvi9xezcaN0Q
         RGPw==
X-Gm-Message-State: APjAAAVpZwNLnA4Seax1tBlaqvZsU2LZ6vbEEHES4FAkArS66hdLZ1nb
        jvKmVWMqCQeUnOy2Ph/4flKvuJc4Hyu3HG3xa4g=
X-Google-Smtp-Source: APXvYqwZNqbqBknDTZ924PZ+KEmEIgZJlqiYwYHYkujvNNeFFrr7Blpcnw+KegRUji229q+HvKAxQNk9Urng84RQn6Y=
X-Received: by 2002:a05:6638:3f9:: with SMTP id s25mr34883973jaq.83.1582331980873;
 Fri, 21 Feb 2020 16:39:40 -0800 (PST)
MIME-Version: 1.0
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <20200221040237-mutt-send-email-mst@kernel.org> <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
In-Reply-To: <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 21 Feb 2020 16:39:29 -0800
Message-ID: <CAKgT0UeZzcigv65xjgNucFaohVHKu8MSg+-_8=YG3WiC590Xzw@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP partially
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
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

On Fri, Feb 21, 2020 at 1:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.02.20 10:07, Michael S. Tsirkin wrote:
> > On Thu, Feb 20, 2020 at 10:16:54AM -0800, Alexander Duyck wrote:
> >> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >>>
> >>> Currently when truncating shmem file, if the range is partial of THP
> >>> (start or end is in the middle of THP), the pages actually will just get
> >>> cleared rather than being freed unless the range cover the whole THP.
> >>> Even though all the subpages are truncated (randomly or sequentially),
> >>> the THP may still be kept in page cache.  This might be fine for some
> >>> usecases which prefer preserving THP.
> >>>
> >>> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> >>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> >>> So, when using shmem THP as memory backend QEMU inflation actually doesn't
> >>> work as expected since it doesn't free memory.  But, the inflation
> >>> usecase really needs get the memory freed.  Anonymous THP will not get
> >>> freed right away too but it will be freed eventually when all subpages are
> >>> unmapped, but shmem THP would still stay in page cache.
> >>>
> >>> Split THP right away when doing partial hole punch, and if split fails
> >>> just clear the page so that read to the hole punched area would return
> >>> zero.
> >>>
> >>> Cc: Hugh Dickins <hughd@google.com>
> >>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> >>
> >> One question I would have is if this is really the desired behavior we
> >> are looking for?
> >>
> >> By proactively splitting the THP you are likely going to see a
> >> performance regression with the virtio-balloon driver enabled in QEMU.
> >> I would suspect the response to that would be to update the QEMU code
> >> to  identify the page size of the shared memory ramblock. At that
> >> point I suspect it would start behaving the same as how it currently
> >> handles anonymous memory, and the work done here would essentially
> >> have been wasted other than triggering the desire to resolve this in
> >> QEMU to avoid a performance regression.
> >>
> >> The code for inflating a the balloon in virtio-balloon in QEMU can be
> >> found here:
> >> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
> >>
> >> If there is a way for us to just populate the value obtained via
> >> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
> >> which is the size I am assuming it is at since you indicated that it
> >> is just freeing the base page size, then we could address the same
> >> issue and likely get the desired outcome of freeing the entire THP
> >> page when it is no longer used.
> >>
> >> - Alex
> >
> > Well that would be racy right? It could be THP when you call
> > the function, by the time you try to free it, it's already
> > split up ...
> >
> >
> > Two more points:
> >
> > 1. we can probably teach QEMU to always use the pbp
> > machinery - will be helpful to reduce number of madvise calls too.
>
> The pbp machinery only works in the special case where the target page
> size > 4k and the guest is nice enough to send the 4k chunks of a target
> page sequentially. If the guest sends random pages, it is not of any use.

Honestly I hadn't looked that close at the code. I had looked it over
briefly when I was working on the page reporting logic and had decided
against even bothering with it when I decided to use the scatterlist
approach since I can simply ignore the pages that fall below the
lowest order supported for the reporting.

> >
> > 2. Something we should do is teach balloon to
> > inflate using address/length pairs instead of PFNs.
> > This way we can pass a full THP in one go.
>
> The balloon works on 4k pages only. It is expected to break up THP and
> harm performance. Or if that's not possible *do nothing*. Similar to
> when balloon inflation is inhibited (e.g., vfio).

Yes, but I think the point is that this is counter productive. If we
can allocate something up to MAX_ORDER - 1 and hand that to the
balloon driver instead then it would make the driver much more
efficient. We could basically just work from the highest available
order to the lowest and if that pushes us to the point of breaking up
THP pages then at that point it would make sense. Us allocating the
lower order pages first just makes it more difficult to go through and
compact pages back up to higher order. The goal should really always
be highest order to lowest order for inflation, and lowest to highest
for deflation. That way we put pressure on the guest to compact its
memory making it possible for us to squeeze it down even smaller and
provide more THP pages for the rest of the system.

> There was some work on huge page ballooning in a paper I read. But once
> the guest is out of huge pages to report, it would want to fallback to
> smaller granularity (down to 4k, to create real memory pressure), where
> you would end up in the very same situation you are right now. So it's -
> IMHO - only of limited used.

I wouldn't think it would be that limited of a use case. By having the
balloon inflate with higher order pages you should be able to put more
pressure on the guest to compact the memory and reduce fragmentation
instead of increasing it. If you have the balloon flushing out the
lower order pages it is sitting on when there is pressure it seems
like it would be more likely to reduce fragmentation further.

> With what you suggest, you'll harm performance to reuse more memory.
> IMHO, ballooning can be expected to harm performance. (after all, if you
> inflate a 4k page in your guest, the guest won't be able to use a huge
> page around that page anymore as well - until it compacts balloon
> memory, resulting in new deflate/inflate steps). But I guess, it depends
> on the use case ...

I think it depends on how you are using the balloon. If you have the
hypervisor only doing the MADV_DONTNEED on 2M pages, while letting it
fill the balloon in the guest with everything down to 4K it might lead
to enough memory churn to actually reduce the fragmentation as the
lower order pages are inflated/deflated as we maintain memory
pressure. It would probably be an interesting experiment if nothing
else, and probably wouldn't take much more than a few tweaks to make
use of inflation/deflation queues similar to what I did with the page
reporting/hinting interface and a bit of logic to try allocating from
highest order to lowest.
