Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F77C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AE20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfFJ4xwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBUJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:36:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726984AbgBUJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582277793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=U0bYpNSNKHRipT8BhnZLNuCRM3AVgjprr/+pj+mCBqo=;
        b=GfFJ4xwA2iLYxxzTArSanV7gfD1qDml5rtL6UrPhVvkXYa/3TQGTsEQqpcwibrphgCl9St
        f3l/afDMmS9hjJd6r1VaCq6KZT5AdebJexB5/7qnO8RZXUSjuWdoqy65nVldFxxcpF7wkc
        Mf2xQqFzextAeZgQBOFVbFXh19vBhTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-XlGvKxfZN9COvZxF1FW34w-1; Fri, 21 Feb 2020 04:36:30 -0500
X-MC-Unique: XlGvKxfZN9COvZxF1FW34w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1375C8017CC;
        Fri, 21 Feb 2020 09:36:29 +0000 (UTC)
Received: from [10.36.117.197] (ovpn-117-197.ams2.redhat.com [10.36.117.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3495D9E2;
        Fri, 21 Feb 2020 09:36:24 +0000 (UTC)
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <20200221040237-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f1be1da2-1acc-ddd9-3c06-bf11c0f39b8e@redhat.com>
Date:   Fri, 21 Feb 2020 10:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221040237-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.20 10:07, Michael S. Tsirkin wrote:
> On Thu, Feb 20, 2020 at 10:16:54AM -0800, Alexander Duyck wrote:
>> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> w=
rote:
>>>
>>> Currently when truncating shmem file, if the range is partial of THP
>>> (start or end is in the middle of THP), the pages actually will just =
get
>>> cleared rather than being freed unless the range cover the whole THP.
>>> Even though all the subpages are truncated (randomly or sequentially)=
,
>>> the THP may still be kept in page cache.  This might be fine for some
>>> usecases which prefer preserving THP.
>>>
>>> But, when doing balloon inflation in QEMU, QEMU actually does hole pu=
nch
>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not us=
ed.
>>> So, when using shmem THP as memory backend QEMU inflation actually do=
esn't
>>> work as expected since it doesn't free memory.  But, the inflation
>>> usecase really needs get the memory freed.  Anonymous THP will not ge=
t
>>> freed right away too but it will be freed eventually when all subpage=
s are
>>> unmapped, but shmem THP would still stay in page cache.
>>>
>>> Split THP right away when doing partial hole punch, and if split fail=
s
>>> just clear the page so that read to the hole punched area would retur=
n
>>> zero.
>>>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>
>> One question I would have is if this is really the desired behavior we
>> are looking for?
>>
>> By proactively splitting the THP you are likely going to see a
>> performance regression with the virtio-balloon driver enabled in QEMU.
>> I would suspect the response to that would be to update the QEMU code
>> to  identify the page size of the shared memory ramblock. At that
>> point I suspect it would start behaving the same as how it currently
>> handles anonymous memory, and the work done here would essentially
>> have been wasted other than triggering the desire to resolve this in
>> QEMU to avoid a performance regression.
>>
>> The code for inflating a the balloon in virtio-balloon in QEMU can be
>> found here:
>> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L6=
6
>>
>> If there is a way for us to just populate the value obtained via
>> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
>> which is the size I am assuming it is at since you indicated that it
>> is just freeing the base page size, then we could address the same
>> issue and likely get the desired outcome of freeing the entire THP
>> page when it is no longer used.
>>
>> - Alex
>=20
> Well that would be racy right? It could be THP when you call
> the function, by the time you try to free it, it's already
> split up ...
>=20
>=20
> Two more points:
>=20
> 1. we can probably teach QEMU to always use the pbp
> machinery - will be helpful to reduce number of madvise calls too.

The pbp machinery only works in the special case where the target page
size > 4k and the guest is nice enough to send the 4k chunks of a target
page sequentially. If the guest sends random pages, it is not of any use.

>=20
> 2. Something we should do is teach balloon to
> inflate using address/length pairs instead of PFNs.
> This way we can pass a full THP in one go.

The balloon works on 4k pages only. It is expected to break up THP and
harm performance. Or if that's not possible *do nothing*. Similar to
when balloon inflation is inhibited (e.g., vfio).

There was some work on huge page ballooning in a paper I read. But once
the guest is out of huge pages to report, it would want to fallback to
smaller granularity (down to 4k, to create real memory pressure), where
you would end up in the very same situation you are right now. So it's -
IMHO - only of limited used.

With what you suggest, you'll harm performance to reuse more memory.
IMHO, ballooning can be expected to harm performance. (after all, if you
inflate a 4k page in your guest, the guest won't be able to use a huge
page around that page anymore as well - until it compacts balloon
memory, resulting in new deflate/inflate steps). But I guess, it depends
on the use case ...

--=20
Thanks,

David / dhildenb

