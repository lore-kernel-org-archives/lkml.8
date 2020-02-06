Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60157C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BD1217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH6pTMy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBFImx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:42:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727780AbgBFImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580978570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5pute0YCZDcno4dibedu61+QsxQ5lNDMb/vjNm/g7PU=;
        b=DH6pTMy0XnguxnhEekAEU28tw/GMTNacROIGPbgcG53vIruRsKAFJWq0wTLcwLDY5MEZQo
        kwArUohgFHNglkKtGxs4vzZFWE71MwS4zZfmCOAUo81t5fklTSR3DfGcVm8hS3Vf6GtmY3
        +z/7M8nxQxb0xZk/p1AOKRplyODkt5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Ka00OuzuOF2G23qg4JkF6g-1; Thu, 06 Feb 2020 03:42:45 -0500
X-MC-Unique: Ka00OuzuOF2G23qg4JkF6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCD159A1A0;
        Thu,  6 Feb 2020 08:42:43 +0000 (UTC)
Received: from [10.36.117.188] (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00DA1001B08;
        Thu,  6 Feb 2020 08:42:35 +0000 (UTC)
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200206013724-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <51955928-5a4b-c922-ee34-6e94b6cdd385@redhat.com>
Date:   Thu, 6 Feb 2020 09:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200206013724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.20 08:40, Michael S. Tsirkin wrote:
> On Wed, Feb 05, 2020 at 05:34:02PM +0100, David Hildenbrand wrote:
>> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrink=
er")
>> changed the behavior when deflation happens automatically. Instead of
>> deflating when called by the OOM handler, the shrinker is used.
>>
>> However, the balloon is not simply some slab cache that should be
>> shrunk when under memory pressure. The shrinker does not have a concep=
t of
>> priorities, so this behavior cannot be configured.
>>
>> There was a report that this results in undesired side effects when
>> inflating the balloon to shrink the page cache. [1]
>> 	"When inflating the balloon against page cache (i.e. no free memory
>> 	 remains) vmscan.c will both shrink page cache, but also invoke the
>> 	 shrinkers -- including the balloon's shrinker. So the balloon
>> 	 driver allocates memory which requires reclaim, vmscan gets this
>> 	 memory by shrinking the balloon, and then the driver adds the
>> 	 memory back to the balloon. Basically a busy no-op."
>>
>> The name "deflate on OOM" makes it pretty clear when deflation should
>> happen - after other approaches to reclaim memory failed, not while
>> reclaiming. This allows to minimize the footprint of a guest - memory
>> will only be taken out of the balloon when really needed.
>>
>> Especially, a drop_slab() will result in the whole balloon getting
>> deflated - undesired. While handling it via the OOM handler might not =
be
>> perfect, it keeps existing behavior. If we want a different behavior, =
then
>> we need a new feature bit and document it properly (although, there sh=
ould
>> be a clear use case and the intended effects should be well described)=
.
>>
>> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
>> this has no such side effects. Always register the shrinker with
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse fr=
ee
>> pages that are still to be processed by the guest. The hypervisor take=
s
>> care of identifying and resolving possible races between processing a
>> hinting request and the guest reusing a page.
>>
>> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
>> notifier with shrinker"), don't add a moodule parameter to configure t=
he
>> number of pages to deflate on OOM. Can be re-added if really needed.
>=20
> I agree. And to make this case even stronger:
>=20
> The oom_pages module parameter was known to be broken: whatever its
> value, we return at most VIRTIO_BALLOON_ARRAY_PFNS_MAX.  So module
> parameter values > 256 never worked, and it seems highly unlikely that
> freeing 1Mbyte on OOM is too aggressive.
> There was a patch
>  virtio-balloon: deflate up to oom_pages on OOM
> by Wei Wang to try to fix it:
> https://lore.kernel.org/r/1508500466-21165-3-git-send-email-wei.w.wang@=
intel.com
> but this was dropped.

Makes sense. 1MB is usually good enough.

>=20
>> Also, pay attention that leak_balloon() returns the number of 4k pages=
 -
>> convert it properly in virtio_balloon_oom_notify().
>=20
> Oh. So it was returning a wrong value originally (before 71994620bb25).
> However what really matters for notifiers is whether the value is 0 -
> whether we made progress. So it's cosmetic.

Yes, that's also my understanding.

>=20
>> Note1: using the OOM handler is frowned upon, but it really is what we
>>        need for this feature.
>=20
> Quite. However, I went back researching why we dropped the OOM notifier=
,
> and found this:
>=20
> https://lore.kernel.org/r/1508500466-21165-2-git-send-email-wei.w.wang@=
intel.com
>=20
> To quote from there:
>=20
> The balloon_lock was used to synchronize the access demand to elements
> of struct virtio_balloon and its queue operations (please see commit
> e22504296d). This prevents the concurrent run of the leak_balloon and
> fill_balloon functions, thereby resulting in a deadlock issue on OOM:
>=20
> fill_balloon: take balloon_lock and wait for OOM to get some memory;
> oom_notify: release some inflated memory via leak_balloon();
> leak_balloon: wait for balloon_lock to be released by fill_balloon.

fill_balloon does the allocation *before* taking the lock. tell_host()
should not allocate memory AFAIR. So how could this ever happen?

Anyhow, we could simply work around this by doing a trylock in
fill_balloon() and retrying in the caller. That should be easy. But I
want to understand first, how something like that would even be possible.

>> Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU)=
 we
>>        could actually skip sending deflation requests to our hyperviso=
r,
>>        making the OOM path *very* simple. Besically freeing pages and
>>        updating the balloon.
>=20
> Well not exactly. !VIRTIO_BALLOON_F_MUST_TELL_HOST does not actually
> mean "never tell host". It means "host will not discard pages in the
> balloon, you can defer host notification until after use".
>=20
> This was the original implementation:
>=20
> +       if (vb->tell_host_first) {
> +               tell_host(vb, vb->deflate_vq);
> +               release_pages_by_pfn(vb->pfns, vb->num_pfns);
> +       } else {
> +               release_pages_by_pfn(vb->pfns, vb->num_pfns);
> +               tell_host(vb, vb->deflate_vq);
> +       }
> +}
>=20
> I don't know whether completely skipping host notifications
> when !VIRTIO_BALLOON_F_MUST_TELL_HOST will break any hosts.

We discussed this already somewhere else, but here is again what I found.

commit bf50e69f63d21091e525185c3ae761412be0ba72
Author: Dave Hansen <dave@linux.vnet.ibm.com>
Date:   Thu Apr 7 10:43:25 2011 -0700

    virtio balloon: kill tell-host-first logic

    The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
    feature bit.  Whenever the bit is set, the guest kernel must
    always tell the host before we free pages back to the allocator.
    Without this feature, we might free a page (and have another
    user touch it) while the hypervisor is unprepared for it.

    But, if the bit is _not_ set, we are under no obligation to
    reverse the order; we're under no obligation to do _anything_.
    As of now, qemu-kvm defines the bit, but doesn't set it.

MUST_TELL_HOST really means "no need to deflate, just reuse a page". We
should finally document this somewhere.

--=20
Thanks,

David / dhildenb

