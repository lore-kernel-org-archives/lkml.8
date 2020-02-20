Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA1C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9324650
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9QZQ6z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgBTVaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:30:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728975AbgBTVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582234202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
        b=Z9QZQ6z+3Jg+cBZ4q/9oSXYT1ToM107VKQ3ai9+L2gdzWef4eq7Sb8YlSgOtRIYHO/plp5
        nKarORGw/cSjB22isEmbDfgGGKR12Hp72jdNSX/UQKM3dhoAdyce8VnNS4n22jywR6X3TL
        XPatCt1lSX0X3nEkk0aDFzACmQoQLQE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-oa12Z3pLPGaipmkZvOU8Hg-1; Thu, 20 Feb 2020 16:29:59 -0500
X-MC-Unique: oa12Z3pLPGaipmkZvOU8Hg-1
Received: by mail-qt1-f198.google.com with SMTP id e37so94330qtk.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
        b=gqUAYtecgnR34LwvK8d64+NtEnmoPrBsuEewnQ57Vk1hEydQngRB9WSwqbnyBppSqv
         xVz2B7txf14HUj4LpxIxcpAsQO3HmLrAmELwa6pY8v8HUQif8uaaNb15NkHZtWFLjHk8
         cCDfoQecVz71UnjkC8s+WCL5FVHf32SzqUfdRLZGuZrYkROIFSRA0YLjhD9//vHICF9p
         /cJ3T6fNknaY2TY6PJtNEYDVMJIClzL3YPzg8k9dVT7lz/2mNvMueDRDN3ARZgi4VG8t
         tcS1V4lwLj/djMjSRqORONwvx3ZXbZo1Mmva4AVBJurH1UQRjeLeBuchkZ/IHrijn9Bj
         Wu2g==
X-Gm-Message-State: APjAAAWXPqSA3x5679WtH26VMdTMCWGoCqbITuQf1qiVGorjgJph2oEK
        F2gSW1Zxjyl1BG3HB87cNNn1oHYNquz7pQQPhmAfmGnXsZZa4mesAhGI5YoNYJITUUkBibuy791
        3IVsj5/Ci2E2OizCio1NIs30y
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036880qtn.368.1582234199337;
        Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCyE/IGRqPbb728yukodcrAAG8HoUGpZIWGc8w9a3plX9TiklcItDV0lrQNkao9NxMwpK5TQ==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036863qtn.368.1582234199118;
        Thu, 20 Feb 2020 13:29:59 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id c45sm453698qtd.43.2020.02.20.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:29:57 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:29:50 -0500
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
Message-ID: <20200220162747-mutt-send-email-mst@kernel.org>
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
> * This usage is not congruent with  standardised semantics of
> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> for using DMA API in virtio (orthogonal with respect to what is
> expressed by VIRTIO_F_IOMMU_PLATFORM). 

Quoting the spec:

  \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
  the device can be used on a platform where device access to data
  in memory is limited and/or translated. E.g. this is the case if the device can be located
  behind an IOMMU that translates bus addresses from the device into physical
  addresses in memory, if the device can be limited to only access
  certain memory addresses or if special commands such as
  a cache flush can be needed to synchronise data in memory with
  the device. Whether accesses are actually limited or translated
  is described by platform-specific means.
  If this feature bit is set to 0, then the device
  has same access to memory addresses supplied to it as the
  driver has.
  In particular, the device will always use physical addresses
  matching addresses used by the driver (typically meaning
  physical addresses used by the CPU)
  and not translated further, and can access any address supplied to it by
  the driver. When clear, this overrides any platform-specific description of
  whether device access is limited or translated in any way, e.g.
  whether an IOMMU may be present.

since device can't access encrypted memory,
this seems to match your case reasonably well.

-- 
MST

