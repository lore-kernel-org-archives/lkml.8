Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEhxI504"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgBCRLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:11:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgBCRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580749866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OCy8r+VxWXTJgkiB5bVYIPDHOx7WbPgsXxqFjuY5cMw=;
        b=IEhxI5048v2Qe8FeOSGL66aQsluXvBchDJb9XOGIK1HQMe58x5PDa1WyKCRWKCbTTDSmqR
        D2xg4dg2rWEhJo9VCUZs6Uy9Te2ZnHeICl27k5uuC3Au0PnyF0F3HQOKkgbqs6t6qN9aS8
        FAhYnsMD6GITporcSXCMu1X3i3JJtQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-EATBlwwbMbiMr0tXLapQjQ-1; Mon, 03 Feb 2020 12:10:57 -0500
X-MC-Unique: EATBlwwbMbiMr0tXLapQjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3034318B9FE1;
        Mon,  3 Feb 2020 17:10:55 +0000 (UTC)
Received: from [10.36.117.77] (ovpn-117-77.ams2.redhat.com [10.36.117.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4C805D9CA;
        Mon,  3 Feb 2020 17:10:50 +0000 (UTC)
Subject: Re: [PATCH 09/16] page-flags: define PG_reserved behavior on compound
 pages
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Steve Capper <steve.capper@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1426784902-125149-10-git-send-email-kirill.shutemov@linux.intel.com>
 <158048425224.2430.4905670949721797624@skylake-alporthouse-com>
 <20200203151844.mmgcwzz3igo7h6wj@box>
 <158074345183.25650.17229941243604183055@skylake-alporthouse-com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <b0843132-1905-6022-4b12-c919b02e103a@redhat.com>
Date:   Mon, 3 Feb 2020 18:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <158074345183.25650.17229941243604183055@skylake-alporthouse-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.20 16:24, Chris Wilson wrote:
> Quoting Kirill A. Shutemov (2020-02-03 15:18:44)
>> On Fri, Jan 31, 2020 at 03:24:12PM +0000, Chris Wilson wrote:
>>> Quoting Kirill A. Shutemov (2015-03-19 17:08:15)
>>>> As far as I can see there's no users of PG_reserved on compound page=
s.
>>>> Let's use NO_COMPOUND here.
>>>
>>> Much later than you would ever expect, but we just had a user update =
an
>>> ancient device and trip over this.
>>> https://gitlab.freedesktop.org/drm/intel/issues/1027
>>>
>>> In drm_pci_alloc() we allocate a high-order page (for it to be physic=
ally
>>> contiguous) and mark each page as Reserved.
>>>
>>>         dmah->vaddr =3D dma_alloc_coherent(&dev->pdev->dev, size,
>>>                                          &dmah->busaddr,
>>>                                          GFP_KERNEL | __GFP_COMP);
>>>
>>>         /* XXX - Is virt_to_page() legal for consistent mem? */
>>>         /* Reserve */
>>>         for (addr =3D (unsigned long)dmah->vaddr, sz =3D size;
>>>              sz > 0; addr +=3D PAGE_SIZE, sz -=3D PAGE_SIZE) {
>>>                 SetPageReserved(virt_to_page((void *)addr));
>>>         }
>>>
>>> It's been doing that since
>>>
>>> commit ddf19b973be5a96d77c8467f657fe5bd7d126e0f
>>> Author: Dave Airlie <airlied@linux.ie>
>>> Date:   Sun Mar 19 18:56:12 2006 +1100
>>>
>>>     drm: fixup PCI DMA support
>>>
>>> I haven't found anything to say if we are meant to be reserving the
>>> pages or not. So I bring it to your attention, asking for help.
>>
>> I don't see a real reason for these pages to be reserved. But I might =
be
>> wrong here.
>>
>> I tried to look around: other users (infiniband/ethernet) of
>> dma_alloc_coherent(__GFP_COMP) don't mess with PG_reserved.
>>
>> Could you try to drop it from DRM?
>=20
> That is the current plan. So long as there is nothing magical about
> either the __GFP_COMP or SetPageReserved, we should be able to drop the=
m
> without any functional change. Only 2 very old bits of HW (r128, ancien=
t
> i915) depend on this routine, and i915 seems, touch wood, quite happy
> with a plain dma_alloc_coherent().

I documented a while ago in include/linux/page-flags.h

"
Pages marked as PG_reserved include:
[...]
MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
not marked PG_reserved (as they might be in use by somebody else who
does not respect the caching strategy).
"

I also removed a bunch of users back then (and even had a patch to
remove this code here), but for this code I think I came to the
conclusion that it might be relevant for some archs.

git grep -o PageReserved | grep ioremap
arch/mips/mm/ioremap.c:PageReserved
arch/nios2/mm/ioremap.c:PageReserved
arch/parisc/mm/ioremap.c:PageReserved
arch/x86/mm/ioremap.c:PageReserved

It would be good to clarify if this here is actually needed (and in
addition the same pattern in other driver/ paths) and eventually update
the documentation.

--=20
Thanks,

David / dhildenb

