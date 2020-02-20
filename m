Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3FC11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F9208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7KIDtT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgBTVdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:33:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgBTVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582234425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4krYsiGh4Qek2SxgzuI/KbmEgksVX0a4JTAhD8CZkok=;
        b=i7KIDtT2qzdeIwMS+kdn6IK52lTALdEjC6u6zrd+LdWkpf3nqi5gn3luBkzwAhm9gtJDzu
        NscLpGEswyyFnrtTbuAorD8wtz3Ig0n1jgs27oJG4RJB4k4cGkPcQz35Ex3I9zzLKSGy0H
        hIXgpbJBSWKHSpBLWyfBPgBSVFH84nE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191--QJKFXCaNjey8YI3MCTrxA-1; Thu, 20 Feb 2020 16:33:43 -0500
X-MC-Unique: -QJKFXCaNjey8YI3MCTrxA-1
Received: by mail-qt1-f199.google.com with SMTP id r30so96920qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4krYsiGh4Qek2SxgzuI/KbmEgksVX0a4JTAhD8CZkok=;
        b=C7FMIilDSKknCdCmDgDLIWKGyTZ1wy9IgYW8aLiwfAJcsnIMHMNk6anUxFg0EflgKC
         PhgX91K8pKzP4zrG2nYJ11JBiIouzcxUptVxIwzoxemDslki3id15EnyGlxHmefdp33F
         PWXE2i2VGff7hsgRmqlS/qzEIUAU7uookRd2m8VX24nvZuE1d+9irKjsyv/6np8Jvuwi
         O6anPlwz+fXUgY9jaRQ7tWzbsijYXc6ldwuLeakUlunQJyBfgM86HA3KO5eAVpEX/rTb
         03REoHa/JiQ9+3xfAiwzuoWf79xav5FuhLayX3DgpbXgiCcA99gWlFn8f+WfyJ8o9nRb
         Hn/g==
X-Gm-Message-State: APjAAAWd5wxYQzxnt3q4turklqvyqsAZywUhSUG72ZH4fc1SVzJA2X6R
        79cGICcPz+DJcvaQ7NQaXkrtqRaB28+0Dcy2X4iMC7FJKVXJ+BogXoBr6/le3nhEu56plRr3pbW
        NuPhDhIW3ydmhkD8GfoBsNt+g
X-Received: by 2002:ac8:4886:: with SMTP id i6mr27992247qtq.160.1582234423178;
        Thu, 20 Feb 2020 13:33:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqykw+sIvY+6jifxdk4U8bBDoR068zA6NinyMfSe1te1gvQyzZNHuu8TE0YuobirJ95QLhxL3g==
X-Received: by 2002:ac8:4886:: with SMTP id i6mr27992229qtq.160.1582234422979;
        Thu, 20 Feb 2020 13:33:42 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id z27sm440818qtv.11.2020.02.20.13.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:33:42 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:33:35 -0500
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
Message-ID: <20200220163055-mutt-send-email-mst@kernel.org>
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
> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> effect The vhost code assumes it the addresses on the virtio descriptor
> ring are not guest physical addresses but iova's, and insists on doing a
> translation of these regardless of what transport is used (e.g. whether
> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> "vhost: new device IOTLB API".) On s390 this results in severe
> performance degradation (c.a. factor 10). BTW with ccw I/O there is
> (architecturally) no IOMMU, so the whole address translation makes no
> sense in the context of virtio-ccw.

So it sounds like a host issue: the emulation of s390 unnecessarily complicated.
Working around it by the guest looks wrong ...

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

