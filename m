Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6088C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89057206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvUJshak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440841AbgDNPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440812AbgDNPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586879081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=BzB5oMxTcs28i5v+wgLniLN/z17MtkCtgFJc2Jx/oY8=;
        b=SvUJshakWJzsJJR6i5Qc+PhaU8x1qZybNVvG8iTUO5NnsdJw5/2MR0lUPjXyesuRsPYlLJ
        mG97yW0lN6fUTrqy8vPRpIs8Dlte7BZThNRZdblb2aObTLAzSbeTxhfwIPTk0lGWD3Qr4e
        vVld3+kIaAIxglVLPFilsgUPQg/AUng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-S-sn38VUMBqUPf2FuK47Ig-1; Tue, 14 Apr 2020 11:44:37 -0400
X-MC-Unique: S-sn38VUMBqUPf2FuK47Ig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ADFA149C0;
        Tue, 14 Apr 2020 15:44:35 +0000 (UTC)
Received: from [10.36.113.201] (ovpn-113-201.ams2.redhat.com [10.36.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7CB91001281;
        Tue, 14 Apr 2020 15:44:30 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090728.GA19572@open-light-1.localdomain>
 <7de81a1c-0568-b8dd-02c5-b109a2e74a04@redhat.com>
 <CAKgT0Uf2n10YM5V0osfRmO9Qveq_i=esfCq5o2Y0dO7c5SP1HQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <3b8c3ae3-fa4b-9158-50f7-e03718a7223a@redhat.com>
Date:   Tue, 14 Apr 2020 17:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf2n10YM5V0osfRmO9Qveq_i=esfCq5o2Y0dO7c5SP1HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.20 17:07, Alexander Duyck wrote:
> On Tue, Apr 14, 2020 at 5:01 AM David Hildenbrand <david@redhat.com> wr=
ote:
>>
>> On 12.04.20 11:07, liliangleo wrote:
>>> Zero out the page content usually happens when allocating pages,
>>> this is a time consuming operation, it makes pin and mlock
>>> operation very slowly, especially for a large batch of memory.
>>>
>>> This patch introduce a new feature for zero out pages before page
>>> allocation, it can help to speed up page allocation.
>>>
>>> The idea is very simple, zero out free pages when the system is
>>> not busy and mark the page with PG_zero, when allocating a page,
>>> if the page need to be filled with zero, check the flag in the
>>> struct page, if it's marked as PG_zero, zero out can be skipped,
>>> it can save cpu time and speed up page allocation.
>>>
>>> This serial is based on the feature 'free page reporting' which
>>> introduced by Alexander Duyck
>>>
>>> We can benefit from this feature in the flowing case:
>>>     1. User space mlock a large chunk of memory
>>>     2. VFIO pin pages for DMA
>>>     3. Allocating transparent huge page
>>>     4. Speed up page fault process
>>>
>>> My original intention for adding this feature is to shorten
>>> VM creation time when VFIO device is attached, it works good
>>> and the VM creation time is reduced obviously.
>>>
>>> Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> QEMU use 4K pages, THP is off
>>>                   round1      round2      round3
>>> w/o this patch:    23.5s       24.7s       24.6s
>>> w/ this patch:     10.2s       10.3s       11.2s
>>>
>>> QEMU use 4K pages, THP is on
>>>                   round1      round2      round3
>>> w/o this patch:    17.9s       14.8s       14.9s
>>> w/ this patch:     1.9s        1.8s        1.9s
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>
>>> Look forward to your feedbacks.
>>
>> I somehow have the feeling that this should not be glued to free page
>> reporting. After all, you are proposing your own status indicator for
>> each buddy page (PG_zero) already, which would mean you can build
>> something similar to free page reporting fairly easily, and have it
>> co-exist.
>>
>> The free page reporting infrastructure is helpful when wanting to
>> asynchronously batch-process higher-order pages. I don't see the
>> immediate need for the "batch-processing here".
>>
>> E.g., why not simply zero out pages as they are freed/placed into free
>> lists? Especially, this is one of the simple alternatives to free page
>> reporting as we have it today (guest zeroes free pages, hypervisor
>> detects free pages using e.g., ksm).
>=20
> The problem with doing it at free is that it would be just as
> expensive as doing it at allocation, only you would likely see it in
> more cases as more applications are more likely to free all of their
> memory at once on exit, while only a few will pin all of their pages
> at the start.

If you want to have zeroed-out memory, you'll have to pay a price. So
the question is "when to do it" and "how to do it". This series proposes
to do it asynchronously from another thread.

>=20
>> That could even allow you to avoid the PG_zero flag completely. E.g.,
>> once the feature is activated and running, all pages in the buddy free
>> lists are zeroed out already. Zeroing happens synchronously from the
>> page-freeing thread, not when starting a guest.
>>
>> Having that said, I agree with Dave here, that there might be better
>> alternatives for this somewhat-special-case.
>=20
> I wonder if it wouldn't make more sense to look at the option of
> splitting the initialization work up over multiple CPUs instead of
> leaving it all single threaded. The data above was creating a VM with
> 64GB of RAM and 32 CPUs. How fast could we zero the pages if we were
> performing the zeroing over those 32 CPUs? I wonder if we couldn't
> look at recruiting other CPUs on the same node to perform the zeroing

Sounds interesting, especially at allocation time. Maybe possible in
combination with Dave's comment "Use ramfs or hugetlbfs files. Have a
bunch of them sitting around, preallocated (and zeroed).". IMHO
something like that makes more sense than doing it asynchronously from
another thread "slowing down everybody that gets a speedup from
cache-hot pages coming out of the allocator" (Dave's comment again :) )

--=20
Thanks,

David / dhildenb

