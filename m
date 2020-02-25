Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17EC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DD20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huf6GL8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgBYANt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:13:49 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:35607 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBYANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:13:48 -0500
Received: by mail-io1-f43.google.com with SMTP id h8so911041iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECA1aGLo+frh/OshMcsb16y+uCvc99U8KvDj/t0sKMA=;
        b=huf6GL8ZJLcWAPRfHPh4oTUaD41r9ciHcDXXF4HPr4ffbrhE93oOh3Jqez5oaqbNOo
         iE0fSr975mUEMtRM+Im4ecIDoE+Pocl546lxQU0EKuGjq/p8MwL6LgP4/wOB85ff40AK
         JB13HFMGWlrU+TNQ+/KnXhB4b5YUSyXw6etD/xO9v4vWE0AsGQh/KLyYX/UPxIbHqFjs
         45OEZ3KBumKuwoLq6A4ctHOcrqCBYnzq0p1FWceFwXn3JHLTLgz/4hanoNIWtBa0cnE4
         85lMD8e5ymrZCzqArhAnP8f8amoI7VjkfoeVtmhY0ZUSxU3sPq9Mx9OxaCLJqJPpEwm+
         b1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECA1aGLo+frh/OshMcsb16y+uCvc99U8KvDj/t0sKMA=;
        b=RU760fmpoghKev/jcHAr/yQg+NZoe0VyRRw3AFnEsjnB65cWs2J+A6wLB0UjcpKRHG
         iHj/Bbrxk/BbJnVfivHwebhLxUvmaaUYz2CucfyAKf4T0Yah16qCdpRYB579CVaeOeCH
         g8HnPTDIRQj+Q5i16mH7asqHSpTt6AjgnV+1OVB2pn75CCns41ELn50WT3Uxbak2dyy9
         Shbqyqer6bwRxremOPS+rPRty0J957fraFrAYisNm1UTrouaYXjmyz+XlPMCkMpVaMxG
         pVSFxHKCBQ5DBGJLgMSLlVLUnrXQ/IGXeGdsyCK5Ul9P65kqJ2JtbImcB/Wkp1kbOEzE
         FYmA==
X-Gm-Message-State: APjAAAU6lyNBPN+YHmtNfGNOzDGB/+uXGkK7lI3W/dbmARCzl2zf88WD
        5CRG7pi5Prv2D9dzzRRA6wRNtnBEFrbF1oI61F8=
X-Google-Smtp-Source: APXvYqyeD8nLn6YI+PZ9dWEiSDMJIj01EF1mUuL25MdIQtpMNwvXZiq+zDoSUwUTRpKub8U3m35rhd9hCnLj7wQDP40=
X-Received: by 2002:a02:7f54:: with SMTP id r81mr57115847jac.121.1582589626222;
 Mon, 24 Feb 2020 16:13:46 -0800 (PST)
MIME-Version: 1.0
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <20200221040237-mutt-send-email-mst@kernel.org> <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
 <CAKgT0UeZzcigv65xjgNucFaohVHKu8MSg+-_8=YG3WiC590Xzw@mail.gmail.com> <939de9de-d82a-aed2-6a51-57a55d81cbff@redhat.com>
In-Reply-To: <939de9de-d82a-aed2-6a51-57a55d81cbff@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 24 Feb 2020 16:13:34 -0800
Message-ID: <CAKgT0UfGYqNbiFUTTbVRz3=-zftsJ5fNKeRT21PJGD+a1Knceg@mail.gmail.com>
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

On Mon, Feb 24, 2020 at 2:22 AM David Hildenbrand <david@redhat.com> wrote:
>
>
> >>> 1. we can probably teach QEMU to always use the pbp
> >>> machinery - will be helpful to reduce number of madvise calls too.
> >>
> >> The pbp machinery only works in the special case where the target page
> >> size > 4k and the guest is nice enough to send the 4k chunks of a target
> >> page sequentially. If the guest sends random pages, it is not of any use.
> >
> > Honestly I hadn't looked that close at the code. I had looked it over
> > briefly when I was working on the page reporting logic and had decided
> > against even bothering with it when I decided to use the scatterlist
> > approach since I can simply ignore the pages that fall below the
> > lowest order supported for the reporting.
>
> Yes, it's rather a hack for a special use case.
>
> >
> >>>
> >>> 2. Something we should do is teach balloon to
> >>> inflate using address/length pairs instead of PFNs.
> >>> This way we can pass a full THP in one go.
> >>
> >> The balloon works on 4k pages only. It is expected to break up THP and
> >> harm performance. Or if that's not possible *do nothing*. Similar to
> >> when balloon inflation is inhibited (e.g., vfio).
> >
> > Yes, but I think the point is that this is counter productive. If we
> > can allocate something up to MAX_ORDER - 1 and hand that to the
> > balloon driver instead then it would make the driver much more
> > efficient. We could basically just work from the highest available
> > order to the lowest and if that pushes us to the point of breaking up
> > THP pages then at that point it would make sense. Us allocating the
> > lower order pages first just makes it more difficult to go through and
> > compact pages back up to higher order. The goal should really always
> > be highest order to lowest order for inflation, and lowest to highest
> > for deflation. That way we put pressure on the guest to compact its
> > memory making it possible for us to squeeze it down even smaller and
> > provide more THP pages for the rest of the system.
>
> While the initial inflate path would be fine, I am more concerned about
> deflation/balloon compaction handling (see below, split to order-0
> pages). Because you really want to keep page compaction working.
>
> Imagine you would allocate higher-order pages in your balloon that are
> not movable, then the kernel would have less higher/order pages to work
> with which might actually harm performance in your guest.
>
> I think of it like that: Best performance is huge page in guest and
> host. Medium performance is huge page in guest xor host. Worst
> performance is no huge page.
>
> If you take away huge pages in your guest for your balloon, you limit
> the cases for "best performance", esp. less THP in your guest. You'll be
> able to get medium performance if you inflate lower-order pages in your
> guest but don't discard THP in your host - while having more huge pages
> for THP available. You'll get worst performance if you inflate
> lower-order pages in your guest and discard THP in your host.

My concern is more the fact that while the balloon driver may support
migration there is a chance that the other threads holding onto the
pages might not. That is why I am thinking that if possible we should
avoid breaking up a THP page unless we have to. By doing that it puts
pressure on the guest to try and keep more of the memory it has more
compact so as to avoid fragmentation.

I guess the question is if pressuring the guest to compact the memory
to create more THP pages would add value versus letting the pressure
from the inflation cause more potential fragmentation.

> >
> >> There was some work on huge page ballooning in a paper I read. But once
> >> the guest is out of huge pages to report, it would want to fallback to
> >> smaller granularity (down to 4k, to create real memory pressure), where
> >> you would end up in the very same situation you are right now. So it's -
> >> IMHO - only of limited used.
> >
> > I wouldn't think it would be that limited of a use case. By having the
> > balloon inflate with higher order pages you should be able to put more
> > pressure on the guest to compact the memory and reduce fragmentation
> > instead of increasing it. If you have the balloon flushing out the
> > lower order pages it is sitting on when there is pressure it seems
> > like it would be more likely to reduce fragmentation further.
>
> As we have balloon compaction in place and balloon pages are movable, I
> guess fragmentation is not really an issue.

I'm not sure that is truly the case. My concern is that by allocating
the 4K pages we are breaking up the higher order pages and we aren't
necessarily guaranteed to obtain all pieces of the higher order page
when we break it up. As a result we could end up causing the THP pages
to be broken up and scattered between the balloon and other consumers
of memory. If one of those other consumers is responsible for the
fragmentation that is causing us to be working on trying to compact
the memory it is possible it would just make things worse.

> >
> >> With what you suggest, you'll harm performance to reuse more memory.
> >> IMHO, ballooning can be expected to harm performance. (after all, if you
> >> inflate a 4k page in your guest, the guest won't be able to use a huge
> >> page around that page anymore as well - until it compacts balloon
> >> memory, resulting in new deflate/inflate steps). But I guess, it depends
> >> on the use case ...
> >
> > I think it depends on how you are using the balloon. If you have the
> > hypervisor only doing the MADV_DONTNEED on 2M pages, while letting it
> > fill the balloon in the guest with everything down to 4K it might lead
> > to enough memory churn to actually reduce the fragmentation as the
> > lower order pages are inflated/deflated as we maintain memory
> > pressure. It would probably be an interesting experiment if nothing
> > else, and probably wouldn't take much more than a few tweaks to make
> > use of inflation/deflation queues similar to what I did with the page
> > reporting/hinting interface and a bit of logic to try allocating from
> > highest order to lowest.
> >
>
> Especially page compaction/migration in the guest might be tricky. AFAIK
> it only works on oder-0 pages. E.g., whenever you allocated a
> higher-order page in the guest and reported it to your hypervisor, you
> want to split it into separate order-0 pages before adding them to the
> balloon list. Otherwise, you won't be able to tag them as movable and
> handle them via the existing balloon compaction framework - and that
> would be a major step backwards, because you would be heavily
> fragmenting your guest (and even turning MAX_ORDER - 1 into unmovable
> pages means that memory offlining/alloc_contig_range() users won't be
> able to move such pages around anymore).

Yes, from what I can tell compaction will not touch anything that is
pageblock size or larger. I am not sure if that is an issue or not.

For migration is is a bit of a different story. It looks like there is
logic in place for migrating huge and transparent huge pages, but not
higher order pages. I'll have to take a look through the code some
more to see just how difficult it would be to support migrating a 2M
page. I can probably make it work if I just configure it as a
transparent huge page with the appropriate flags and bits in the page
being set.

> But then, the balloon compaction will result in single 4k pages getting
> moved and deflated+inflated. Once you have order-0 pages in your list,
> deflating higher-order pages becomes trickier.

I probably wouldn't want to maintain them as individual lists. In my
mind it would make more sense to have two separate lists with separate
handlers for each. Then in the event of something such as a deflate we
could choose what we free based on the number of pages we need to
free. That would allow us to deflate the balloon quicker in the case
of a low-memory condition which should improve our responsiveness. In
addition with the driver sitting on a reserve of higher-order pages it
could help to alleviate fragmentation in such a case as well since it
could release larger contiguous blocks of memory.

> E.g., have a look at the vmware balloon (drivers/misc/vmw_balloon.c). It
> will allocate either 4k or 2MB pages, but won't be able to handle them
> for balloon compaction. They don't even bother about other granularity.
>
>
> Long story short: Inflating higher-order pages could be good for
> inflation performance in some setups, but I think you'll have to fall
> back to lower-order allocations +  balloon compaction on 4k.

I'm not entirely sure that is the case. It seems like with a few
tweaks to things we could look at doing something like splitting the
balloon so that we have a 4K and a 2M balloon. At that point it would
just be a matter of registering a pair of address space handlers so
that the 2M balloons are handled correctly if there is a request to
migrate their memory. As far as compaction that is another story since
it looks like 2M pages will not be compacted.
