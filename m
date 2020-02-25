Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE4C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7738722527
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwiY7o+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgBYDag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:30:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728779AbgBYDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582601434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of3nosS8oU936PJEYpW7qNnO8kX+HHJe6v2iVwoEUOg=;
        b=WwiY7o+GDu0/k2lejkAlLjqg45gH8UcpTHV0R/AdgcJZJh1MH1t88jDeAhYWuWafviuOYJ
        zUIYjC3fOsdPfgB7BACDmVuIi/4AHD8K1wBmkT53xrDV7+hnyPwdjcZ5MF25ErZwx3emla
        BujL5djTk39XFl+KKbcwOawG3xxCm0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-L7yu7l6DPj2oybCYzxfyBw-1; Mon, 24 Feb 2020 22:30:30 -0500
X-MC-Unique: L7yu7l6DPj2oybCYzxfyBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C410AB0E3F;
        Tue, 25 Feb 2020 03:30:27 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84CCB620D8;
        Tue, 25 Feb 2020 03:30:18 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
 <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
 <20200224145607.2729f47b.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1b2673e7-56ff-7d69-af2d-503a97408d95@redhat.com>
Date:   Tue, 25 Feb 2020 11:30:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224145607.2729f47b.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/24 =E4=B8=8B=E5=8D=889:56, Halil Pasic wrote:
> On Mon, 24 Feb 2020 17:26:20 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> That's better.
>>
>> How about attached?
>>
>> Thanks
> Thanks Jason! It does avoid the translation overhead in vhost.
>
> Tested-by: Halil Pasic <pasic@linux.ibm.com>
>
> Regarding the code, you fence it in virtio-net.c, but AFAIU this featur=
e
> has relevance for other vhost devices as well. E.g. what about vhost
> user? Would it be the responsibility of each virtio device to fence thi=
s
> on its own?


Yes, it looks to me it's better to do that in virtio_set_features_nocheck=
()


>
> I'm also a bit confused about the semantics of the vhost feature bit
> F_ACCESS_PLATFORM. What we have specified on virtio level is:
> """
> This feature indicates that the device can be used on a platform where
> device access to data in memory is limited and/or translated. E.g. this
> is the case if the device can be located behind an IOMMU that translate=
s
> bus addresses from the device into physical addresses in memory, if the
> device can be limited to only access certain memory addresses or if
> special commands such as a cache flush can be needed to synchronise dat=
a
> in memory with the device. Whether accesses are actually limited or
> translated is described by platform-specific means. If this feature bit
> is set to 0, then the device has same access to memory addresses
> supplied to it as the driver has. In particular, the device will always
> use physical addresses matching addresses used by the driver (typically
> meaning physical addresses used by the CPU) and not translated further,
> and can access any address supplied to it by the driver. When clear,
> this overrides any platform-specific description of whether device
> access is limited or translated in any way, e.g. whether an IOMMU may b=
e
> present.
> """
>
> I read this like the addresses may be IOVAs which require
> IMMU translation or GPAs which don't.
>
> On the vhost level however, it seems that F_IOMMU_PLATFORM means that
> vhost has to do the translation (via IOTLB API).


Yes.


>
> Do I understand this correctly? If yes, I believe we should document
> this properly.


Good point. I think it was probably wrong to tie F_IOMMU_PLATFORM to=20
IOTLB API. Technically IOTLB can work with GPA->HVA mapping. I=20
originally use a dedicated feature bit (you can see that from commit=20
log), but for some reason Michael tweak it to virtio feature bit. I=20
guess it was probably because at that time there's no way to specify e.g=20
backend capability but now we have VHOST_GET_BACKEND_FEATURES.

For now, it was probably too late to fix that but document or we can add=20
the support of enabling IOTLB via new backend features.


>
> BTW I'm still not 100% on the purpose and semantics of the
> F_ACCESS_PLATFORM feature bit. But that is a different problem.


Yes, I aggree that we should decouple the features that does not belongs=20
to device (protected, encrypted, swiotlb etc) from F_IOMMU_PLATFORM. But=20
Michael and other have their points as well.

Thanks


>
> Regards,
> Halil
>

