Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9432520773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XRF2xro5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404680AbgFYRZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:25:50 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9156 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404342AbgFYRZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:25:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef4ddbf0000>; Thu, 25 Jun 2020 10:24:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jun 2020 10:25:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jun 2020 10:25:49 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 17:25:39 +0000
Subject: Re: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private
 page migration
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Bharata B Rao <bharata@linux.ibm.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-3-rcampbell@nvidia.com> <20200624072355.GB18609@lst.de>
 <330f6a82-d01d-db97-1dec-69346f41e707@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a9aba057-3786-8204-f782-6e8f3c290b35@nvidia.com>
Date:   Thu, 25 Jun 2020 10:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <330f6a82-d01d-db97-1dec-69346f41e707@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593105855; bh=uYfK6rsz5+ealU9/4gfA5Q+t0zfXrSyYkvAq9Mm4eGo=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XRF2xro5q/8nFW0qjYwB2C4HyBRCQPyCPqDcMZofasBrICeXUutwqnsZyPduCtLpq
         /ggcpTLFzaRb8MUCEsmqC8yYPn/2pY+ZgjZwdi3UDopmO98V/URpD7d9BSuxWKPA+G
         2nWK0ffA0twlTJi0w2nlPSyqlw9LesqC01C2zXdacZOl5IX+OEzPnbN5JxKfO+3mNq
         oLvpus8nOYzAdTC4mzG5HtY6eVcuvTk4GK+8EAbum/RRJFnP5wOzkH//3bk+0krJvj
         HKpTZHcZhZjtaWE+Kb3QksgDgj0vokNgKMFr+K5B2UagSY1t9LsD44MzthqGXgXuBU
         T0TO8BMY5JjBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sure to include linux-mm and Bharata B Rao for IBM's
use of migrate_vma*().

On 6/24/20 11:10 AM, Ralph Campbell wrote:
>=20
> On 6/24/20 12:23 AM, Christoph Hellwig wrote:
>> On Mon, Jun 22, 2020 at 04:38:53PM -0700, Ralph Campbell wrote:
>>> The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
>>> migrate memory in the given address range to device private memory. The
>>> source pages might already have been migrated to device private memory.
>>> In that case, the source struct page is not checked to see if it is
>>> a device private page and incorrectly computes the GPU's physical
>>> address of local memory leading to data corruption.
>>> Fix this by checking the source struct page and computing the correct
>>> physical address.
>>
>> I'm really worried about all this delicate code to fix the mixed
>> ranges.=C2=A0 Can't we make it clear at the migrate_vma_* level if we wa=
nt
>> to migrate from or two device private memory, and then skip all the work
>> for regions of memory that already are in the right place?=C2=A0 This mi=
ght be
>> a little more work initially, but I think it leads to a much better
>> API.
>>
>=20
> The current code does encode the direction with src_owner !=3D NULL meani=
ng
> device private to system memory and src_owner =3D=3D NULL meaning system
> memory to device private memory. This patch would obviously defeat that
> so perhaps a flag could be added to the struct migrate_vma to indicate th=
e
> direction but I'm unclear how that makes things less delicate.
> Can you expand on what you are worried about?
>=20
> The issue with invalidations might be better addressed by letting the dev=
ice
> driver handle device private page TLB invalidations when migrating to
> system memory and changing migrate_vma_setup() to only invalidate CPU
> TLB entries for normal pages being migrated to device private memory.
> If a page isn't migrating, it seems inefficient to invalidate those TLB
> entries.
>=20
> Any other suggestions?

After a night's sleep, I think this might work. What do others think?

1) Add a new MMU_NOTIFY_MIGRATE enum to mmu_notifier_event.

2) Change migrate_vma_collect() to use the new MMU_NOTIFY_MIGRATE event typ=
e.

3) Modify nouveau_svmm_invalidate_range_start() to simply return (no invali=
dations)
for MMU_NOTIFY_MIGRATE mmu notifier callbacks.

4) Leave the src_owner check in migrate_vma_collect_pmd() for normal pages =
so if the
device driver is migrating normal pages to device private memory, the drive=
r would
set src_owner =3D NULL and already migrated device private pages would be s=
kipped.
Since the mmu notifier callback did nothing, the device private entries rem=
ain valid
in the device's MMU. migrate_vma_collect_pmd() would still invalidate the C=
PU page
tables for migrated normal pages.
If the driver is migrating device private pages to system memory, it would =
set
src_owner !=3D NULL, normal pages would be skipped, but now the device driv=
er has to
invalidate device MMU mappings in the "alloc and copy" before doing the cop=
y.
This would be after migrate_vma_setup() returns so the list of migrating de=
vice
pages is known to the driver.

The rest of the migrate_vma_pages() and migrate_vma_finalize() remain the s=
ame.
