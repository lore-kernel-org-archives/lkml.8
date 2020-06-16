Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF77C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D7120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtI1BBNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgFPMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:18:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34287 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728699AbgFPMR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592309877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vju3588GEq9YcdXsm65at6pfHEf0IhlWVQ3WlBIC6pw=;
        b=ZtI1BBNs3IvsqCcmyoxX/G53LyZoJi5olsFzUYO5bX6CyHk5Rcpa/dujErXCP83rO3Oeww
        oWkV9TcUtrZI8zrhBCrwhGoSFte51R9g1Fm64qXGxX2H/AylR1/1Zrrna/Rr8a4d9T9Pr5
        snLu2wlCseSTG5vScMKMJTfvGmTQytk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-WwocTxxVNHGDoImqyIeBAg-1; Tue, 16 Jun 2020 08:17:55 -0400
X-MC-Unique: WwocTxxVNHGDoImqyIeBAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78541009456;
        Tue, 16 Jun 2020 12:17:52 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8C2260BEC;
        Tue, 16 Jun 2020 12:17:46 +0000 (UTC)
Date:   Tue, 16 Jun 2020 14:17:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        David Gibson <david@gibson.dropbear.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200616141744.61b3a139.cohuck@redhat.com>
In-Reply-To: <20200616135726.04fa8314.pasic@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
        <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
        <20200616115202.0285aa08.pasic@linux.ibm.com>
        <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
        <20200616135726.04fa8314.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 13:57:26 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 16 Jun 2020 12:52:50 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > >>   int virtio_finalize_features(struct virtio_device *dev)
> > >>   {
> > >>   	int ret = dev->config->finalize_features(dev);
> > >> @@ -179,6 +184,10 @@ int virtio_finalize_features(struct virtio_device *dev)
> > >>   	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
> > >>   		return 0;
> > >>   
> > >> +	if (arch_needs_iommu_platform(dev) &&
> > >> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
> > >> +		return -EIO;
> > >> +    
> > > 
> > > Why EIO?    
> > 
> > Because I/O can not occur correctly?
> > I am open to suggestions.  
> 
> We use -ENODEV if feature when the device rejects the features we
> tried to negotiate (see virtio_finalize_features()) and -EINVAL when
> the F_VERSION_1 and the virtio-ccw revision ain't coherent (in
> virtio_ccw_finalize_features()). Any of those seems more fitting
> that EIO to me. BTW does the error code itself matter in any way,
> or is it just OK vs some error?

If I haven't lost my way, we end up in the driver core probe failure
handling; we probably should do -ENODEV if we just want probing to fail
and -EINVAL or -EIO if we want the code to moan.

