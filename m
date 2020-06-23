Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD033C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A2720780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HduvbxdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgFWBmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:42:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2661 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgFWBmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:42:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef15de50000>; Mon, 22 Jun 2020 18:41:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 18:42:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 18:42:09 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 01:42:00 +0000
Subject: Re: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private
 page migration
To:     John Hubbard <jhubbard@nvidia.com>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-3-rcampbell@nvidia.com>
 <f2bf81df-8faa-0f51-3f74-cb3b31d96aad@nvidia.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <730e85c9-33b5-9c57-7123-057b75cbbddf@nvidia.com>
Date:   Mon, 22 Jun 2020 18:42:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f2bf81df-8faa-0f51-3f74-cb3b31d96aad@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592876517; bh=Ho+eCbZjhjTrWCRD06h7Akh+zdWN7QHUk5iaHdiOb78=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HduvbxdXCCaTYo2FwaJeEyDbubHHSvfFOBN8SAUgTT/+gxdroCg0XP9zOCR9PccQu
         fWyBb99xw54tnFfOXqz9xBmtszRGg402zAk9PYF4qbEpWas5Pj2eGbKqP+2oT52RRy
         YqFHh0Yil5k4ll/T46AYPd8l3s7b+Zas8LaZF4TECSmq6f3MoVb6OApcAGbsztSD15
         t7NW+E0fWnF3KMaoz0CR+fseEbAPpfUEUnIXzwmheZzSxmTqcBR5Ch79BY5khNACyI
         UNwawM84nbUjWdnuuD4oX+X3AcuyevmKQtS3MNmEdTCdwQud160PdKWaZ4AOWB3tvq
         fTqOdii5CKNZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/20 5:30 PM, John Hubbard wrote:
> On 2020-06-22 16:38, Ralph Campbell wrote:
>> The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
>> migrate memory in the given address range to device private memory. The
>> source pages might already have been migrated to device private memory.
>> In that case, the source struct page is not checked to see if it is
>> a device private page and incorrectly computes the GPU's physical
>> address of local memory leading to data corruption.
>> Fix this by checking the source struct page and computing the correct
>> physical address.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>> =C2=A0 drivers/gpu/drm/nouveau/nouveau_dmem.c | 8 ++++++++
>> =C2=A0 1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/no=
uveau/nouveau_dmem.c
>> index cc9993837508..f6a806ba3caa 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
>> @@ -540,6 +540,12 @@ static unsigned long nouveau_dmem_migrate_copy_one(=
struct nouveau_drm *drm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(src & MIGRATE_PFN_MIGRATE))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 if (spage && is_device_private_page(spage)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 paddr =3D nouveau_dmem_page_=
addr(spage);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *dma_addr =3D DMA_MAPPING_ER=
ROR;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpage =3D nouveau_dmem_page_alloc_locked(=
drm);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dpage)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> @@ -560,6 +566,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(s=
truct nouveau_drm *drm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_free_page;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +done:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_=
PFNMAP_V0_VRAM |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((paddr >> PAGE_S=
HIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (src & MIGRATE_PFN_WRITE)
>> @@ -615,6 +622,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct migrate_vma args =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vma=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D vma,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .start=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .src_owner=C2=A0=C2=A0=C2=A0=
 =3D drm->dev,
>=20
> Hi Ralph,
>=20
> This .src_owner setting does look like a required fix, but it seems like
> a completely separate fix from what is listed in this patch's commit
> description, right? (It feels like a casualty of rearranging the patches.=
)
>=20
>=20
> thanks,

It's a bit more complex. There is a catch-22 here with the change to mm/mig=
rate.c.
Without this patch or mm/migrate.c, a second call to clEnqueueSVMMigrateMem=
()
for the same address range will invalidate the GPU mapping to device privat=
e memory
created by the first call.
With this patch but not mm/migrate.c, the first call to clEnqueueSVMMigrate=
Mem()
will fail to migrate normal anonymous memory to device private memory.
Without this patch but including the change to mm/migrate.c, a second call =
to
clEnqueueSVMMigrateMem() will crash the kernel because dma_map_page() will =
be
called with the device private PFN which is not a valid CPU physical addres=
s.
With both changes, a range of anonymous and device private pages can be mig=
rated
to the GPU and the GPU page tables updated properly.
