Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38BEC11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2FC20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiBCIqXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBTUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:48:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728936AbgBTUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582231726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehW/C4q3o/MFSLK01WJohdnOjzA4tnd/QR6FiiqgjL0=;
        b=PiBCIqXgmSIzCl7kHDzaajWmCrBDxQVnTa884V2pmBUcEHrWXk6qdyYGf5l+KPzVuObE7E
        ygJ0vMIMFhd/k+eyw+I3tCHUsKOQng25f+stm7OEhfFWc8XOHpSfXYmAHoX0PXV8mZzwLc
        Gk2dXIlpHvlcoH4ngXJUH18btLQoiMk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-RzSLJYwkOc62S8CLlFoArw-1; Thu, 20 Feb 2020 15:48:44 -0500
X-MC-Unique: RzSLJYwkOc62S8CLlFoArw-1
Received: by mail-qt1-f197.google.com with SMTP id t9so25855qtn.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 12:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehW/C4q3o/MFSLK01WJohdnOjzA4tnd/QR6FiiqgjL0=;
        b=E+EaEyYUvzGFLq2sley12cAYfnJPt4jKKpS3A4ehpn4pJpPbEp9PeolbX19rM28zT1
         quMnM07vIFEqsR2qLCZd0NINO5mSfmfjvVCGL4pXcaF67+n77n+cpFtmKHvGD3+Xfjhl
         Gd0q7aVmKBzIXlbUwhTd2MKFLmLL//Ci1D9iAUalnnMgGEQ65737vqktm8p9VUMbBcLr
         rgmuqj6CSW4VhBT4E6A2mYE/lecF7K06pY3+8FSy5Y7Q1uKG0UahinGEAIIGZlDOK9/J
         RwaYZtJTsJj/ibHllzDc6nhGMImO82jlu4JF6ouqoyB5U2H93/lbaPDfT2tY4RupgHVs
         b4Sw==
X-Gm-Message-State: APjAAAX3/d9K+FnVJ1zdYKf68sSRL0OHhe5VlOBdnY7zM5kuNthlbtrk
        IlNbYBjE5G+AHdeqNlgS+gBAlSUcWzvP6lafHP4+n/EcM7X/EorUdQZaZ46ggKLNxBzyGMkWskg
        EPWIAy5l9BCgFnzMa5H79nKD6
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr27577871qkl.385.1582231723839;
        Thu, 20 Feb 2020 12:48:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8/6ncIbfogJ3gGTu5AoGgDYIF/agRj+iWjgwKDztDiB0lAfpoI0718ywEcHd9ifb45n14Hw==
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr27577859qkl.385.1582231723602;
        Thu, 20 Feb 2020 12:48:43 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id p8sm358226qtn.71.2020.02.20.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:48:42 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:48:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
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
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200220154718-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
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
> This series aims to decouple 'have to use DMA API because my (guest) RAM
> is protected' and 'have to use DMA API because the device told me
> VIRTIO_F_IOMMU_PLATFORM'.
> 
> Please find more detailed explanations about the conceptual aspects in
> the individual patches. There is however also a very practical problem
> that is addressed by this series. 
> 
> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> effect The vhost code assumes it the addresses on the virtio descriptor
> ring are not guest physical addresses but iova's, and insists on doing a
> translation of these regardless of what transport is used (e.g. whether
> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> "vhost: new device IOTLB API".) On s390 this results in severe
> performance degradation (c.a. factor 10). BTW with ccw I/O there is
> (architecturally) no IOMMU, so the whole address translation makes no
> sense in the context of virtio-ccw.

That's just a QEMU thing. It uses the same flag for VIRTIO_F_ACCESS_PLATFORM
and vhost IOTLB. QEMU can separate them, no need to change linux.


> Halil Pasic (2):
>   mm: move force_dma_unencrypted() to mem_encrypt.h
>   virtio: let virtio use DMA API when guest RAM is protected
> 
>  drivers/virtio/virtio_ring.c |  3 +++
>  include/linux/dma-direct.h   |  9 ---------
>  include/linux/mem_encrypt.h  | 10 ++++++++++
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> 
> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> -- 
> 2.17.1

