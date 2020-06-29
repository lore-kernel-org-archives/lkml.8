Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED69C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F83E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnG2VuBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgF2TGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730365AbgF2TGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUfU3DwcJDvqG3254Hkil0FQVUF3NIrSHMy6nXbf4kc=;
        b=BnG2VuBjHIzQb04h2bRzyKJR99Wj+dJUNT1XT6k7OFua3jQuNncLfEdV/5E+xqWevnfLQC
        WqUmsiO5K+avw9V5oJrZN3Bp8AgEMXfYhZtymtxOOxMkdKkgPjXViy7a/nR8/fUGJkgP7g
        pwQtmk5sktZ1ytzzd9zDQMLAghOhsuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-srnLdMb6O5SSjgOgzzj6JA-1; Mon, 29 Jun 2020 12:05:38 -0400
X-MC-Unique: srnLdMb6O5SSjgOgzzj6JA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A4EBFC3;
        Mon, 29 Jun 2020 16:05:36 +0000 (UTC)
Received: from gondolin (ovpn-113-61.ams2.redhat.com [10.36.113.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB1960BEC;
        Mon, 29 Jun 2020 16:05:28 +0000 (UTC)
Date:   Mon, 29 Jun 2020 18:05:26 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200629180526.41d0732b.cohuck@redhat.com>
In-Reply-To: <20200629115651-mutt-send-email-mst@kernel.org>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
        <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
        <20200629115651-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 11:57:14 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
> > An architecture protecting the guest memory against unauthorized host
> > access may want to enforce VIRTIO I/O device protection through the
> > use of VIRTIO_F_IOMMU_PLATFORM.
> > 
> > Let's give a chance to the architecture to accept or not devices
> > without VIRTIO_F_IOMMU_PLATFORM.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  arch/s390/mm/init.c     |  6 ++++++
> >  drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
> >  include/linux/virtio.h  |  2 ++
> >  3 files changed, 30 insertions(+)

> > @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
> >  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
> >  		return 0;
> >  
> > +	if (arch_needs_virtio_iommu_platform(dev) &&
> > +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +		dev_warn(&dev->dev,
> > +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> > +		return -ENODEV;
> > +	}
> > +
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
> >  	status = dev->config->get_status(dev);
> >  	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {  
> 
> Well don't you need to check it *before* VIRTIO_F_VERSION_1, not after?

But it's only available with VERSION_1 anyway, isn't it? So it probably
also needs to fail when this feature is needed if VERSION_1 has not been
negotiated, I think.

