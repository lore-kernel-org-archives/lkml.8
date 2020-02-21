Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3DCC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB8207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf5c+Gxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBUGWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:22:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbgBUGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582266163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qXib0FabgbTKY5pRwiBWRR8XUkKsOvRz+kOZ5ar6RE=;
        b=bf5c+Gxo/NV+RXfOvYxz0OyBrFLIQkbgG5ZnmwTiFySw62vlx6i6KADoXZnS97JqAl3XwJ
        74ocWg48AGSuCdOCvIbmP+bMJE/+rbDSfRRYIUgesLRgAYh+ok+hG1UTTIrhNyopvkQr8U
        XRxiovMHQyTBui9F5RIDJMspmPt/96o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-4HogxvKtMr2o0vgcZfl8sQ-1; Fri, 21 Feb 2020 01:22:40 -0500
X-MC-Unique: 4HogxvKtMr2o0vgcZfl8sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F968018A7;
        Fri, 21 Feb 2020 06:22:37 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4A528B57B;
        Fri, 21 Feb 2020 06:22:27 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-s390@vger.kernel.org,
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
Date:   Fri, 21 Feb 2020 14:22:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
> Currently if one intends to run a memory protection enabled VM with
> virtio devices and linux as the guest OS, one needs to specify the
> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> linux use the DMA API, which in turn handles the memory
> encryption/protection stuff if the guest decides to turn itself into
> a protected one. This however makes no sense due to multiple reasons:
> * The device is not changed by the fact that the guest RAM is
> protected. The so called IOMMU bypass quirk is not affected.
> * This usage is not congruent with  standardised semantics of
> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> for using DMA API in virtio (orthogonal with respect to what is
> expressed by VIRTIO_F_IOMMU_PLATFORM).
>
> This series aims to decouple 'have to use DMA API because my (guest) RA=
M
> is protected' and 'have to use DMA API because the device told me
> VIRTIO_F_IOMMU_PLATFORM'.
>
> Please find more detailed explanations about the conceptual aspects in
> the individual patches. There is however also a very practical problem
> that is addressed by this series.
>
> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following sid=
e
> effect The vhost code assumes it the addresses on the virtio descriptor
> ring are not guest physical addresses but iova's, and insists on doing =
a
> translation of these regardless of what transport is used (e.g. whether
> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> "vhost: new device IOTLB API".) On s390 this results in severe
> performance degradation (c.a. factor 10).


Do you see a consistent degradation on the performance, or it only=20
happen when for during the beginning of the test?


> BTW with ccw I/O there is
> (architecturally) no IOMMU, so the whole address translation makes no
> sense in the context of virtio-ccw.


I suspect we can do optimization in qemu side.

E.g send memtable entry via IOTLB API when vIOMMU is not enabled.

If this makes sense, I can draft patch to see if there's any difference.

Thanks


>
> Halil Pasic (2):
>    mm: move force_dma_unencrypted() to mem_encrypt.h
>    virtio: let virtio use DMA API when guest RAM is protected
>
>   drivers/virtio/virtio_ring.c |  3 +++
>   include/linux/dma-direct.h   |  9 ---------
>   include/linux/mem_encrypt.h  | 10 ++++++++++
>   3 files changed, 13 insertions(+), 9 deletions(-)
>
>
> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2

