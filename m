Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677DC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7921744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhhX1pB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgBYQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:42:42 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38558 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgBYQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:42:42 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so11367373ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/LX9XNhUE11/OIZMbEr4Ajar8HsvmlKhhiknvCsycI=;
        b=vhhX1pB4UEvGJm9ScD/HunfF61LfSOlTrZOOsE9ePWGshDfnw0/FkOz1uKt4rNd91F
         Yj3vTKDLp7/kQynwpcM/ChuY0meT8IHXYubvOnTq68xmH8gwy+/R2HkxnOBHnaecV3Ej
         1J/+PC8LEavy/qfdQ00lRC/6Tx8TXpPsqoUUbDIsFip1XMAuIRCbMHB9QwPksab5YnPY
         DnSbubLyv1Fn07Hzm4FaaZHVo6KTWdNSXKmVUZ9xihahJYz/XA0Yehga8gV/utarfx5u
         A9vfxFUEkwo3exsY4oTkORFfuTqoAG6lkunAMMbL628c0aL10uFCv1sP9CZ9ISOggxmT
         bNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/LX9XNhUE11/OIZMbEr4Ajar8HsvmlKhhiknvCsycI=;
        b=K83WI0BO8rlT9JN5KF0+AYVRY3IZxDKpKcDDspfI9ra23G6chDeGn0U3cot3MuJ4vY
         oINPrMALwJij5/UjFEnhZXTF0C7j6NYyUpg9CRZ4yQxfEfgfMxtXrtD9YnvnY5kjEltg
         ne7lHQvWqpbXyKsmmpyBSqXdfTj3SU9Ab+xxYHruRzeUvpCdEIKnzb/5MdPendOy6JiS
         pOztAzpCv1AhKLmbRH41WaIsG66A+YzrAQ0GTogAL6xufoXVywPD6FqKHnCYLIUMO5Vo
         GCyfsxvsZyEUD/Vahfr7b28J6W7RaGXhyskZxaImyPcK2WwfCz0iXotnF8K3DHXSewAG
         j27w==
X-Gm-Message-State: APjAAAWVeYm7DwMmdaYj8FCSQhOVrG7y4pS+k7ZjmImNmQtHSTYBZ3w0
        StHrv6acdkgX+kasKbPdM2ZgIZeJN6sUWujARnc=
X-Google-Smtp-Source: APXvYqwib/81OTAZBeJWH60Xfj4oh8o6WoK5rj9DBjLeHUbvnHYW+38uGTYgNPOW1+OQuw87PzQh36tVKNi2emb+9Vw=
X-Received: by 2002:a92:dac3:: with SMTP id o3mr71110937ilq.237.1582648960946;
 Tue, 25 Feb 2020 08:42:40 -0800 (PST)
MIME-Version: 1.0
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <20200221040237-mutt-send-email-mst@kernel.org> <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
 <CAKgT0UeZzcigv65xjgNucFaohVHKu8MSg+-_8=YG3WiC590Xzw@mail.gmail.com>
 <939de9de-d82a-aed2-6a51-57a55d81cbff@redhat.com> <CAKgT0UfGYqNbiFUTTbVRz3=-zftsJ5fNKeRT21PJGD+a1Knceg@mail.gmail.com>
 <c11572bd-f4ff-421f-a9d8-46603641521c@redhat.com>
In-Reply-To: <c11572bd-f4ff-421f-a9d8-46603641521c@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 25 Feb 2020 08:42:29 -0800
Message-ID: <CAKgT0Udw7PNJWzTPJNt8-akburMKHKjDbLMUdGWc-i=RfzxQ-w@mail.gmail.com>
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

On Tue, Feb 25, 2020 at 12:09 AM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> > I guess the question is if pressuring the guest to compact the memory
> > to create more THP pages would add value versus letting the pressure
> > from the inflation cause more potential fragmentation.
>
> Would be interesting to see some actual numbers. Right now, it's just
> speculations. I know that there are ideas to do proactive compaction,
> maybe that has a similar effect.
>
> [...]
>
> >
> >>>
> >>>> There was some work on huge page ballooning in a paper I read. But once
> >>>> the guest is out of huge pages to report, it would want to fallback to
> >>>> smaller granularity (down to 4k, to create real memory pressure), where
> >>>> you would end up in the very same situation you are right now. So it's -
> >>>> IMHO - only of limited used.
> >>>
> >>> I wouldn't think it would be that limited of a use case. By having the
> >>> balloon inflate with higher order pages you should be able to put more
> >>> pressure on the guest to compact the memory and reduce fragmentation
> >>> instead of increasing it. If you have the balloon flushing out the
> >>> lower order pages it is sitting on when there is pressure it seems
> >>> like it would be more likely to reduce fragmentation further.
> >>
> >> As we have balloon compaction in place and balloon pages are movable, I
> >> guess fragmentation is not really an issue.
> >
> > I'm not sure that is truly the case. My concern is that by allocating
> > the 4K pages we are breaking up the higher order pages and we aren't
> > necessarily guaranteed to obtain all pieces of the higher order page
> > when we break it up. As a result we could end up causing the THP pages
> > to be broken up and scattered between the balloon and other consumers
>
> We are allocating movable memory. We should be working on/creating
> movable pageblocks. Yes, other concurrent allcoations can race with the
> allocation. But after all, they are likely movable as well (because they
> are allocating from a movable pageblock) and we do have compaction in
> place. There are corner cases but in don't think they are very relevant.
>
> [...]

The main advantage as I see it though is that you can much more likely
inflate an entire THP page if you are allocating 2M pages versus 4K
pages simply because if another thread ends up stealing one of those
pages while you are trying to inflate the balloon it will be
problematic. In addition by switching over to the scatterlist approach
it would be possible to process 512 pages as a single entry which is
already more than double the number of PFNs currently supported by
virtio balloon.

> >> Especially page compaction/migration in the guest might be tricky. AFAIK
> >> it only works on oder-0 pages. E.g., whenever you allocated a
> >> higher-order page in the guest and reported it to your hypervisor, you
> >> want to split it into separate order-0 pages before adding them to the
> >> balloon list. Otherwise, you won't be able to tag them as movable and
> >> handle them via the existing balloon compaction framework - and that
> >> would be a major step backwards, because you would be heavily
> >> fragmenting your guest (and even turning MAX_ORDER - 1 into unmovable
> >> pages means that memory offlining/alloc_contig_range() users won't be
> >> able to move such pages around anymore).
> >
> > Yes, from what I can tell compaction will not touch anything that is
> > pageblock size or larger. I am not sure if that is an issue or not.
> >
> > For migration is is a bit of a different story. It looks like there is
> > logic in place for migrating huge and transparent huge pages, but not
> > higher order pages. I'll have to take a look through the code some
> > more to see just how difficult it would be to support migrating a 2M
> > page. I can probably make it work if I just configure it as a
> > transparent huge page with the appropriate flags and bits in the page
> > being set.
>
> Note: With virtio-balloon you actually don't necessarily want to migrate
> the higher-order page. E.g., migrating a higher-order page might fail
> because there is no migration target available. Instead, you would want
> "migrate" to multiple smaller pieces. This is esp., interesting for
> alloc_contig_range() users. Something that the current 4k pages can
> handle just nicely.

That is why I am thinking it would be worthwhile to explore the
current THP approaches being used. If I could get virtio balloon to
act as though it is allocating THP pages then what I would get is the
ability to handle migration and the fact that THP pages already get
broken up into lower order pages if they cannot be allocated as a
higher order page. In reality the balloon driver doesn't really care
about if the page is mapped as 1 2M page or 512 4K ones, however it
would be preferred if we could get the linear 2M mapping.

> >
> >> But then, the balloon compaction will result in single 4k pages getting
> >> moved and deflated+inflated. Once you have order-0 pages in your list,
> >> deflating higher-order pages becomes trickier.
> >
> > I probably wouldn't want to maintain them as individual lists. In my
> > mind it would make more sense to have two separate lists with separate
> > handlers for each. Then in the event of something such as a deflate we
> > could choose what we free based on the number of pages we need to
> > free. That would allow us to deflate the balloon quicker in the case
> > of a low-memory condition which should improve our responsiveness. In
> > addition with the driver sitting on a reserve of higher-order pages it
> > could help to alleviate fragmentation in such a case as well since it
> > could release larger contiguous blocks of memory.
> >
> >> E.g., have a look at the vmware balloon (drivers/misc/vmw_balloon.c). It
> >> will allocate either 4k or 2MB pages, but won't be able to handle them
> >> for balloon compaction. They don't even bother about other granularity.
> >>
> >>
> >> Long story short: Inflating higher-order pages could be good for
> >> inflation performance in some setups, but I think you'll have to fall
> >> back to lower-order allocations +  balloon compaction on 4k.
> >
> > I'm not entirely sure that is the case. It seems like with a few
> > tweaks to things we could look at doing something like splitting the
> > balloon so that we have a 4K and a 2M balloon. At that point it would
> > just be a matter of registering a pair of address space handlers so
> > that the 2M balloons are handled correctly if there is a request to
> > migrate their memory. As far as compaction that is another story since
> > it looks like 2M pages will not be compacted.
>
> I am not convinced what you describe is a real issue that needs such a
> solution. Maybe we can come up with numbers that prove this. (e.g.,
> #THP, fragmentation, benchmark performance in your guest, etc.).

As I see it there are several issues to be addressed here.

1. As the size of memory increases I am not certain that operating a
balloon at 4K page size is going to make sense for much longer.
2. Inflating with 4K pages is likely to force the guest memory to be
split up at the host level, and will be expensive as it requires an
operation per 4K page on the host.
3. Inflating with 4K pages makes it impossible to currently identify
if the entire THP has been freed since we can only inflate half of a
THP page at a time.

> I'll try digging out that huge page ballooning for KVM paper, maybe that
> has any value.

Thanks. Also if you have any specific benchmarks in mind that would be
useful as well for establishing the criteria for what a
proof-of-concept would need to accomplish.
