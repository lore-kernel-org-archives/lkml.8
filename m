Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1087EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB83920786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdmuQHHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgG2GnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:43:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42947 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgG2GnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:43:03 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 02:43:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596004981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCrW+09lbptolyLVHV/kS+2Iwz8f8KaQB9+crgZ4nRc=;
        b=WdmuQHHK8UmQ316mciZqPLs91y/4ujWNlus4fTbTG3W6ma59QCX1JW2/+tBzuZbeQUTRr+
        wPMsoQvFJUYYl+UQC+luxT4o9L+YV3B5FxikJum+3Wa6L3YXkX1DUYNZSIopot0TxjhQ3u
        VOUZPTE7QfPH/ySwrvj3TT3DKkqpQCs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Zd_QxJtxMM29nlkt1TLL-Q-1; Wed, 29 Jul 2020 02:36:39 -0400
X-MC-Unique: Zd_QxJtxMM29nlkt1TLL-Q-1
Received: by mail-ej1-f70.google.com with SMTP id r14so3266454eji.16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vCrW+09lbptolyLVHV/kS+2Iwz8f8KaQB9+crgZ4nRc=;
        b=HQTNg3PW9KNtNA/UBeNbQIpCwC93mH5WInDy1g4XTmjM3JUzTy4I82a/JgEms/MUsr
         zstDrLapi41d/svuaxtgEKEtFDiBhJ3Czoc5L2ZPqX1YhukQk5mvxRl8gnA8Fpt2247E
         H5pWnKgVjCgAqpRh2b9+o60LZEoanKMT/ncRxW+xkIVujjqjz8VrTsDilOzyi5Y6tSPX
         H/J2r5klA1Zpiw1gJm+zVM018tFqSoz+X/aXuy9awAdgSlL7WjiAryWG/wFel27JcTd6
         /iS925F0lOqANgNI0dO54QeU7v/EyEKwV+Dc1WT+Ha5qrDezSiMpjMj2NOHF/IYjjEQm
         sxmg==
X-Gm-Message-State: AOAM533Jiramd0bwOgtTOsiL3jB7TohkISbaOC+XD76TBt6o5cb8Ma9x
        QuWgeB9ms1GP13fMC3EtNK9uw86l8c0terAmX6NSbLQKGsRo2I2048xNACEOpirw+gCZqlv/f7G
        +0raNw6tMi8EbH7P64Ydb8Y80
X-Received: by 2002:a17:906:af72:: with SMTP id os18mr22077213ejb.43.1596004598343;
        Tue, 28 Jul 2020 23:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcOEQf3BfvpROnJUn2gc1RpMHWSlSuMLRoJwDln6tha4VHmjjudQEPLpp9B2oHlZl36OhE4A==
X-Received: by 2002:a17:906:af72:: with SMTP id os18mr22077187ejb.43.1596004598057;
        Tue, 28 Jul 2020 23:36:38 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c648d.dip0.t-ipconnect.de. [91.12.100.141])
        by smtp.gmail.com with ESMTPSA id y1sm1101921ede.7.2020.07.28.23.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 23:36:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem alignment
Date:   Wed, 29 Jul 2020 08:36:36 +0200
Message-Id: <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
To:     Jia He <justin.he@arm.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 29.07.2020 um 05:35 schrieb Jia He <justin.he@arm.com>:
>=20
> =EF=BB=BFWhen enabling dax pmem as RAM device on arm64, I noticed that kme=
m_start
> addr in dev_dax_kmem_probe() should be aligned w/ SECTION_SIZE_BITS(30),i.=
e.
> 1G memblock size. Even Dan Williams' sub-section patch series [1] had been=

> upstream merged, it was not helpful due to hard limitation of kmem_start:
> $ndctl create-namespace -e namespace0.0 --mode=3Ddevdax --map=3Ddev -s 2g -=
f -a 2M
> $echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> $echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> $cat /proc/iomem
> ...
> 23c000000-23fffffff : System RAM
>  23dd40000-23fecffff : reserved
>  23fed0000-23fffffff : reserved
> 240000000-33fdfffff : Persistent Memory
>  240000000-2403fffff : namespace0.0
>  280000000-2bfffffff : dax0.0          <- aligned with 1G boundary
>    280000000-2bfffffff : System RAM
> Hence there is a big gap between 0x2403fffff and 0x280000000 due to the 1G=

> alignment.
>=20
> Without this series, if qemu creates a 4G bytes nvdimm device, we can only=

> use 2G bytes for dax pmem(kmem) in the worst case.
> e.g.
> 240000000-33fdfffff : Persistent Memory=20
> We can only use the memblock between [240000000, 2ffffffff] due to the har=
d
> limitation. It wastes too much memory space.
>=20
> Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but the=
re
> are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
> SPARSEMEM_VMEMMAP, page bits in struct page ...
>=20
> Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem alignm=
ent
> with memory_block_size_bytes().
>=20
> Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax pm=
em
> can be used as ram with smaller gap. Also the kmem hotplug add/remove are b=
oth
> tested on arm64/x86 guest.
>=20

Hi,

I am not convinced this use case is worth such hacks (that=E2=80=99s what it=
 is) for now. On real machines pmem is big - your example (losing 50% is ext=
reme).

I would much rather want to see the section size on arm64 reduced. I remembe=
r there were patches and that at least with a base page size of 4k it can be=
 reduced drastically (64k base pages are more problematic due to the ridicul=
ous THP size of 512M). But could be a section size of 512 is possible on all=
 configs right now.

In the long term we might want to rework the memory block device model (even=
tually supporting old/new as discussed with Michal some time ago using a ker=
nel parameter), dropping the fixed sizes
- allowing sizes / addresses aligned with subsection size
- drastically reducing the number of devices for boot memory to only a hand f=
ull (e.g., one per resource / DIMM we can actually unplug again.

Long story short, I don=E2=80=99t like this hack.


> This patch series (mainly patch6/6) is based on the fixing patch, ~v5.8-rc=
5 [2].
>=20
> [1] https://lkml.org/lkml/2019/6/19/67
> [2] https://lkml.org/lkml/2020/7/8/1546
> Jia He (6):
>  mm/memory_hotplug: remove redundant memory block size alignment check
>  resource: export find_next_iomem_res() helper
>  mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
>  mm/page_alloc: adjust the start,end in dax pmem kmem case
>  device-dax: relax the memblock size alignment for kmem_start
>  arm64: fall back to vmemmap_populate_basepages if not aligned  with
>    PMD_SIZE
>=20
> arch/arm64/mm/mmu.c    |  4 ++++
> drivers/base/memory.c  | 24 ++++++++++++++++--------
> drivers/dax/kmem.c     | 22 +++++++++++++---------
> include/linux/ioport.h |  3 +++
> kernel/resource.c      |  3 ++-
> mm/memory_hotplug.c    | 39 ++++++++++++++++++++++++++++++++++++++-
> mm/page_alloc.c        | 14 ++++++++++++++
> 7 files changed, 90 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.17.1
>=20

