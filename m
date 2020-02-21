Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D5C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702B4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnDOGv1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBUDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:42:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729630AbgBUDmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582256535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9R0CosE6GfsLGrjcvEZLtqtG2P/xZ2EzhZiapF0r40=;
        b=NnDOGv1LEM4FSXHrp/MzpuMq3pUC8D84cHeMdWO46mFJkCqDGrCNF8P8shSREeXtwyiE3U
        M7IcB3WKR8RQzLb0C4tLi9CFKjBR6d/6EgMGEnQWgTx6C4luKpsrSLB5e8KgNp+07iRTCJ
        05F8WRFTXlLJBQF1uKJ8bhKRlLj8Tjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-StAG8-9rMQ-MWoQGwwCsyQ-1; Thu, 20 Feb 2020 22:42:11 -0500
X-MC-Unique: StAG8-9rMQ-MWoQGwwCsyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8ECDBA3;
        Fri, 21 Feb 2020 03:42:08 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71D391001281;
        Fri, 21 Feb 2020 03:41:59 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
To:     David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de>
 <20200221025915.GB2298@umbus.fritz.box>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8194d502-07d8-b798-a2b5-606a8c05b895@redhat.com>
Date:   Fri, 21 Feb 2020 11:41:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200221025915.GB2298@umbus.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/21 =E4=B8=8A=E5=8D=8810:59, David Gibson wrote:
> On Thu, Feb 20, 2020 at 05:13:09PM +0100, Christoph Hellwig wrote:
>> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
>>> index 867c7ebd3f10..fafc8f924955 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_devic=
e *vdev)
>>>   	if (!virtio_has_iommu_quirk(vdev))
>>>   		return true;
>>>  =20
>>> +	if (force_dma_unencrypted(&vdev->dev))
>>> +		return true;
>> Hell no.  This is a detail of the platform DMA direct implementation.
>> Drivers have no business looking at this flag, and virtio finally need=
s
>> to be fixed to use the DMA API properly for everything but legacy devi=
ces.
> So, this patch definitely isn't right as it stands, but I'm struggling
> to understand what it is you're saying is the right way.
>
> By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> see how being a legacy device or not relates to use of the DMA API.
>
> I *think* what you are suggesting here is that virtio devices that
> have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects=
.


Can this work for swiotlb?

Thanks


> Then the virtio driver can use the DMA API the same way for both
> F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.
>
> But if that works for !F_IOMMU_PLATFORM_DEVICES+F_VERSION_1 devices,
> then AFAICT it will work equally well for legacy devices.
>
> Using the DMA API for *everything* in virtio, legacy or not, seems
> like a reasonable approach to me.  But, AFAICT, that does require the
> DMA layer to have some kind of explicit call to turn on this
> behaviour, which the virtio driver would call during initializsation.
> I don't think we can do it 100% within the DMA layer, because only the
> driver can reasonably know when a device has this weird non-standard
> DMA behaviour.
>

