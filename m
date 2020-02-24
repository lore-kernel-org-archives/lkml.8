Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74363C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348CD20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3w8vzuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBXKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:22:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27469 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727312AbgBXKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582539761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9rgk9Zdx+FYiuqh5+++l0IjJ99Bb5VPxuLSjFzEaQAI=;
        b=M3w8vzuWI8r2Ha7UCaxrSXPlP93Ye5iwXzHuiuvFx6/B6M11+g7Qbgt8wIRaoLKzXF0VUt
        3oluD+EoJwExWkWd7IhE2j0jMJ+Ivy68dHOswO5SOKYeVP8eNfOVAhxuXWxpcVBmRyXq6V
        hGxCQVwt9S3DfrYR+GnYYuHbAaqi8DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-JB8S9JRBOzy_WqCBWxRRrg-1; Mon, 24 Feb 2020 05:22:37 -0500
X-MC-Unique: JB8S9JRBOzy_WqCBWxRRrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C85E107ACC4;
        Mon, 24 Feb 2020 10:22:36 +0000 (UTC)
Received: from [10.36.118.8] (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C92C91853;
        Mon, 24 Feb 2020 10:22:28 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <939de9de-d82a-aed2-6a51-57a55d81cbff@redhat.com>
Date:   Mon, 24 Feb 2020 11:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeZzcigv65xjgNucFaohVHKu8MSg+-_8=YG3WiC590Xzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> 1. we can probably teach QEMU to always use the pbp
>>> machinery - will be helpful to reduce number of madvise calls too.
>>
>> The pbp machinery only works in the special case where the target page
>> size > 4k and the guest is nice enough to send the 4k chunks of a targ=
et
>> page sequentially. If the guest sends random pages, it is not of any u=
se.
>=20
> Honestly I hadn't looked that close at the code. I had looked it over
> briefly when I was working on the page reporting logic and had decided
> against even bothering with it when I decided to use the scatterlist
> approach since I can simply ignore the pages that fall below the
> lowest order supported for the reporting.

Yes, it's rather a hack for a special use case.

>=20
>>>
>>> 2. Something we should do is teach balloon to
>>> inflate using address/length pairs instead of PFNs.
>>> This way we can pass a full THP in one go.
>>
>> The balloon works on 4k pages only. It is expected to break up THP and
>> harm performance. Or if that's not possible *do nothing*. Similar to
>> when balloon inflation is inhibited (e.g., vfio).
>=20
> Yes, but I think the point is that this is counter productive. If we
> can allocate something up to MAX_ORDER - 1 and hand that to the
> balloon driver instead then it would make the driver much more
> efficient. We could basically just work from the highest available
> order to the lowest and if that pushes us to the point of breaking up
> THP pages then at that point it would make sense. Us allocating the
> lower order pages first just makes it more difficult to go through and
> compact pages back up to higher order. The goal should really always
> be highest order to lowest order for inflation, and lowest to highest
> for deflation. That way we put pressure on the guest to compact its
> memory making it possible for us to squeeze it down even smaller and
> provide more THP pages for the rest of the system.

While the initial inflate path would be fine, I am more concerned about
deflation/balloon compaction handling (see below, split to order-0
pages). Because you really want to keep page compaction working.

Imagine you would allocate higher-order pages in your balloon that are
not movable, then the kernel would have less higher/order pages to work
with which might actually harm performance in your guest.

I think of it like that: Best performance is huge page in guest and
host. Medium performance is huge page in guest xor host. Worst
performance is no huge page.

If you take away huge pages in your guest for your balloon, you limit
the cases for "best performance", esp. less THP in your guest. You'll be
able to get medium performance if you inflate lower-order pages in your
guest but don't discard THP in your host - while having more huge pages
for THP available. You'll get worst performance if you inflate
lower-order pages in your guest and discard THP in your host.

>=20
>> There was some work on huge page ballooning in a paper I read. But onc=
e
>> the guest is out of huge pages to report, it would want to fallback to
>> smaller granularity (down to 4k, to create real memory pressure), wher=
e
>> you would end up in the very same situation you are right now. So it's=
 -
>> IMHO - only of limited used.
>=20
> I wouldn't think it would be that limited of a use case. By having the
> balloon inflate with higher order pages you should be able to put more
> pressure on the guest to compact the memory and reduce fragmentation
> instead of increasing it. If you have the balloon flushing out the
> lower order pages it is sitting on when there is pressure it seems
> like it would be more likely to reduce fragmentation further.

As we have balloon compaction in place and balloon pages are movable, I
guess fragmentation is not really an issue.

>=20
>> With what you suggest, you'll harm performance to reuse more memory.
>> IMHO, ballooning can be expected to harm performance. (after all, if y=
ou
>> inflate a 4k page in your guest, the guest won't be able to use a huge
>> page around that page anymore as well - until it compacts balloon
>> memory, resulting in new deflate/inflate steps). But I guess, it depen=
ds
>> on the use case ...
>=20
> I think it depends on how you are using the balloon. If you have the
> hypervisor only doing the MADV_DONTNEED on 2M pages, while letting it
> fill the balloon in the guest with everything down to 4K it might lead
> to enough memory churn to actually reduce the fragmentation as the
> lower order pages are inflated/deflated as we maintain memory
> pressure. It would probably be an interesting experiment if nothing
> else, and probably wouldn't take much more than a few tweaks to make
> use of inflation/deflation queues similar to what I did with the page
> reporting/hinting interface and a bit of logic to try allocating from
> highest order to lowest.
>=20

Especially page compaction/migration in the guest might be tricky. AFAIK
it only works on oder-0 pages. E.g., whenever you allocated a
higher-order page in the guest and reported it to your hypervisor, you
want to split it into separate order-0 pages before adding them to the
balloon list. Otherwise, you won't be able to tag them as movable and
handle them via the existing balloon compaction framework - and that
would be a major step backwards, because you would be heavily
fragmenting your guest (and even turning MAX_ORDER - 1 into unmovable
pages means that memory offlining/alloc_contig_range() users won't be
able to move such pages around anymore).

But then, the balloon compaction will result in single 4k pages getting
moved and deflated+inflated. Once you have order-0 pages in your list,
deflating higher-order pages becomes trickier.

E.g., have a look at the vmware balloon (drivers/misc/vmw_balloon.c). It
will allocate either 4k or 2MB pages, but won't be able to handle them
for balloon compaction. They don't even bother about other granularity.


Long story short: Inflating higher-order pages could be good for
inflation performance in some setups, but I think you'll have to fall
back to lower-order allocations +  balloon compaction on 4k.

--=20
Thanks,

David / dhildenb

