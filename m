Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA9C35DFA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4404A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6HkfSWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgBYIJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:09:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582618166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=MHIB3ZqqS2AmtLF2IjjxQkOoX7HR3CzmvaUYMY6sBhg=;
        b=E6HkfSWcS+KKSrlEzLtTyHf1O5IJWirbbR/Uavn2br4Ohv7C/Y55+PK70ckouDhI3s1YLU
        VNLSq1tNa31nMGm8e01nh8Xi045XvK0w8idEDkkcf30/kNp9a2bfnkID/bnkWlIC50JyAK
        DlEJDho4SbhNW4nD8zuo2mcJVd8McJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-d3_OmCY3N7OrLYJVPebKog-1; Tue, 25 Feb 2020 03:09:24 -0500
X-MC-Unique: d3_OmCY3N7OrLYJVPebKog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544E6107ACC4;
        Tue, 25 Feb 2020 08:09:22 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8534E8C072;
        Tue, 25 Feb 2020 08:09:17 +0000 (UTC)
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <20200221040237-mutt-send-email-mst@kernel.org>
 <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
 <CAKgT0UeZzcigv65xjgNucFaohVHKu8MSg+-_8=YG3WiC590Xzw@mail.gmail.com>
 <939de9de-d82a-aed2-6a51-57a55d81cbff@redhat.com>
 <CAKgT0UfGYqNbiFUTTbVRz3=-zftsJ5fNKeRT21PJGD+a1Knceg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <c11572bd-f4ff-421f-a9d8-46603641521c@redhat.com>
Date:   Tue, 25 Feb 2020 09:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfGYqNbiFUTTbVRz3=-zftsJ5fNKeRT21PJGD+a1Knceg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> I guess the question is if pressuring the guest to compact the memory
> to create more THP pages would add value versus letting the pressure
> from the inflation cause more potential fragmentation.

Would be interesting to see some actual numbers. Right now, it's just
speculations. I know that there are ideas to do proactive compaction,
maybe that has a similar effect.

[...]

>=20
>>>
>>>> There was some work on huge page ballooning in a paper I read. But o=
nce
>>>> the guest is out of huge pages to report, it would want to fallback =
to
>>>> smaller granularity (down to 4k, to create real memory pressure), wh=
ere
>>>> you would end up in the very same situation you are right now. So it=
's -
>>>> IMHO - only of limited used.
>>>
>>> I wouldn't think it would be that limited of a use case. By having th=
e
>>> balloon inflate with higher order pages you should be able to put mor=
e
>>> pressure on the guest to compact the memory and reduce fragmentation
>>> instead of increasing it. If you have the balloon flushing out the
>>> lower order pages it is sitting on when there is pressure it seems
>>> like it would be more likely to reduce fragmentation further.
>>
>> As we have balloon compaction in place and balloon pages are movable, =
I
>> guess fragmentation is not really an issue.
>=20
> I'm not sure that is truly the case. My concern is that by allocating
> the 4K pages we are breaking up the higher order pages and we aren't
> necessarily guaranteed to obtain all pieces of the higher order page
> when we break it up. As a result we could end up causing the THP pages
> to be broken up and scattered between the balloon and other consumers

We are allocating movable memory. We should be working on/creating
movable pageblocks. Yes, other concurrent allcoations can race with the
allocation. But after all, they are likely movable as well (because they
are allocating from a movable pageblock) and we do have compaction in
place. There are corner cases but in don't think they are very relevant.

[...]

>> Especially page compaction/migration in the guest might be tricky. AFA=
IK
>> it only works on oder-0 pages. E.g., whenever you allocated a
>> higher-order page in the guest and reported it to your hypervisor, you
>> want to split it into separate order-0 pages before adding them to the
>> balloon list. Otherwise, you won't be able to tag them as movable and
>> handle them via the existing balloon compaction framework - and that
>> would be a major step backwards, because you would be heavily
>> fragmenting your guest (and even turning MAX_ORDER - 1 into unmovable
>> pages means that memory offlining/alloc_contig_range() users won't be
>> able to move such pages around anymore).
>=20
> Yes, from what I can tell compaction will not touch anything that is
> pageblock size or larger. I am not sure if that is an issue or not.
>=20
> For migration is is a bit of a different story. It looks like there is
> logic in place for migrating huge and transparent huge pages, but not
> higher order pages. I'll have to take a look through the code some
> more to see just how difficult it would be to support migrating a 2M
> page. I can probably make it work if I just configure it as a
> transparent huge page with the appropriate flags and bits in the page
> being set.

Note: With virtio-balloon you actually don't necessarily want to migrate
the higher-order page. E.g., migrating a higher-order page might fail
because there is no migration target available. Instead, you would want
"migrate" to multiple smaller pieces. This is esp., interesting for
alloc_contig_range() users. Something that the current 4k pages can
handle just nicely.

>=20
>> But then, the balloon compaction will result in single 4k pages gettin=
g
>> moved and deflated+inflated. Once you have order-0 pages in your list,
>> deflating higher-order pages becomes trickier.
>=20
> I probably wouldn't want to maintain them as individual lists. In my
> mind it would make more sense to have two separate lists with separate
> handlers for each. Then in the event of something such as a deflate we
> could choose what we free based on the number of pages we need to
> free. That would allow us to deflate the balloon quicker in the case
> of a low-memory condition which should improve our responsiveness. In
> addition with the driver sitting on a reserve of higher-order pages it
> could help to alleviate fragmentation in such a case as well since it
> could release larger contiguous blocks of memory.
>=20
>> E.g., have a look at the vmware balloon (drivers/misc/vmw_balloon.c). =
It
>> will allocate either 4k or 2MB pages, but won't be able to handle them
>> for balloon compaction. They don't even bother about other granularity=
.
>>
>>
>> Long story short: Inflating higher-order pages could be good for
>> inflation performance in some setups, but I think you'll have to fall
>> back to lower-order allocations +  balloon compaction on 4k.
>=20
> I'm not entirely sure that is the case. It seems like with a few
> tweaks to things we could look at doing something like splitting the
> balloon so that we have a 4K and a 2M balloon. At that point it would
> just be a matter of registering a pair of address space handlers so
> that the 2M balloons are handled correctly if there is a request to
> migrate their memory. As far as compaction that is another story since
> it looks like 2M pages will not be compacted.

I am not convinced what you describe is a real issue that needs such a
solution. Maybe we can come up with numbers that prove this. (e.g.,
#THP, fragmentation, benchmark performance in your guest, etc.).

I'll try digging out that huge page ballooning for KVM paper, maybe that
has any value.

--=20
Thanks,

David / dhildenb

