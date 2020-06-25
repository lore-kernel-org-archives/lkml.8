Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29CF20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C79NzfYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406813AbgFYRmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:42:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10680 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405282AbgFYRmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:42:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef4e1a20001>; Thu, 25 Jun 2020 10:40:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jun 2020 10:42:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jun 2020 10:42:24 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 17:42:24 +0000
Subject: Re: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private
 page migration
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Christoph Hellwig <hch@lst.de>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Bharata B Rao <bharata@linux.ibm.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-3-rcampbell@nvidia.com> <20200624072355.GB18609@lst.de>
 <330f6a82-d01d-db97-1dec-69346f41e707@nvidia.com>
 <a9aba057-3786-8204-f782-6e8f3c290b35@nvidia.com>
 <20200625173144.GT6578@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <412b3a51-619a-4f94-da96-f4596e5eb510@nvidia.com>
Date:   Thu, 25 Jun 2020 10:42:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200625173144.GT6578@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593106851; bh=dVDtjOJNekdnS7jMIhDZrkR7SUVoPtPB26y7vdiQ8rc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=C79NzfYIZ/4/7K07xyDkDyWF09cLOtFqcAGWDpgLD6fZQTPfIVTxfx1KX73YbBEX5
         /lPoACQODhbk+hYa01hbXni4W78wr6AcXvVIyzAG0zdQlx2FtFg1fMjGGCHQ9GA8iu
         ZhYBp+2pngMltPsi9YG3jJwCKSJmCqJAqoXHEQLTZGDGuSNkde/g66HChAung88sMa
         Yn/fIm7hckavMnJq1E5saPfA+7u/Qkh3aGkER+w3SF8PIYoGYjuHKncp7/+hLfUWWo
         VokvfaTAX8aR6ZKyk9Guo7o3WeVENV12wbZ5ShgD2PtP+fkIq1KpbhHNNwmfFDGww0
         OSCwcLhSmr9Vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/20 10:31 AM, Jason Gunthorpe wrote:
> On Thu, Jun 25, 2020 at 10:25:38AM -0700, Ralph Campbell wrote:
>> Making sure to include linux-mm and Bharata B Rao for IBM's
>> use of migrate_vma*().
>>
>> On 6/24/20 11:10 AM, Ralph Campbell wrote:
>>>
>>> On 6/24/20 12:23 AM, Christoph Hellwig wrote:
>>>> On Mon, Jun 22, 2020 at 04:38:53PM -0700, Ralph Campbell wrote:
>>>>> The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
>>>>> migrate memory in the given address range to device private memory. T=
he
>>>>> source pages might already have been migrated to device private memor=
y.
>>>>> In that case, the source struct page is not checked to see if it is
>>>>> a device private page and incorrectly computes the GPU's physical
>>>>> address of local memory leading to data corruption.
>>>>> Fix this by checking the source struct page and computing the correct
>>>>> physical address.
>>>>
>>>> I'm really worried about all this delicate code to fix the mixed
>>>> ranges.=C2=A0 Can't we make it clear at the migrate_vma_* level if we =
want
>>>> to migrate from or two device private memory, and then skip all the wo=
rk
>>>> for regions of memory that already are in the right place?=C2=A0 This =
might be
>>>> a little more work initially, but I think it leads to a much better
>>>> API.
>>>>
>>>
>>> The current code does encode the direction with src_owner !=3D NULL mea=
ning
>>> device private to system memory and src_owner =3D=3D NULL meaning syste=
m
>>> memory to device private memory. This patch would obviously defeat that
>>> so perhaps a flag could be added to the struct migrate_vma to indicate =
the
>>> direction but I'm unclear how that makes things less delicate.
>>> Can you expand on what you are worried about?
>>>
>>> The issue with invalidations might be better addressed by letting the d=
evice
>>> driver handle device private page TLB invalidations when migrating to
>>> system memory and changing migrate_vma_setup() to only invalidate CPU
>>> TLB entries for normal pages being migrated to device private memory.
>>> If a page isn't migrating, it seems inefficient to invalidate those TLB
>>> entries.
>>>
>>> Any other suggestions?
>>
>> After a night's sleep, I think this might work. What do others think?
>>
>> 1) Add a new MMU_NOTIFY_MIGRATE enum to mmu_notifier_event.
>>
>> 2) Change migrate_vma_collect() to use the new MMU_NOTIFY_MIGRATE event =
type.
>>
>> 3) Modify nouveau_svmm_invalidate_range_start() to simply return (no inv=
alidations)
>> for MMU_NOTIFY_MIGRATE mmu notifier callbacks.
>=20
> Isn't it a bit of an assumption that migrate_vma_collect() is only
> used by nouveau itself?
>=20
> What if some other devices' device_private pages are being migrated?
>=20
> Jason
>=20

Good point. The driver needs a way of knowing the callback is due its call
to migrate_vma_setup() and not some other migration invalidation.
How about adding a void pointer to struct mmu_notifier_range
which migrate_vma_collect() can set to src_owner. If the event is
MMU_NOTIFY_MIGRATE and the src_owner matches the void pointer, then the
callback should be the one the driver initiated.
