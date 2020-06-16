Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF76C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2DD20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iahQORBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFPMU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:20:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFPMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592310024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00I+rEnL5zfE1rppZBUcq4cMNwu7+BKdrw9mfoX5yzY=;
        b=iahQORBlMM6V4IaSGqpPrHAeHx5CD4ooWE4758TP+vQNLbGODPji3sPUgs73v3+8Bvjtq1
        DL2E5MFlxcxMGpS1pCRigUHFt3LssR5hOwWB0ESvuQrvfaf2LChW2P2HcZgQIEAwIE8/Vw
        R2Md89JSSh6bQrgoD9+XzQ8FRd+l0WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-YKyVA7qMMvCdTaMTQoDbVg-1; Tue, 16 Jun 2020 08:20:20 -0400
X-MC-Unique: YKyVA7qMMvCdTaMTQoDbVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD41835B5A;
        Tue, 16 Jun 2020 12:20:18 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCE957CAA5;
        Tue, 16 Jun 2020 12:20:12 +0000 (UTC)
Date:   Tue, 16 Jun 2020 14:20:10 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20200616142010.04b7ba19.cohuck@redhat.com>
In-Reply-To: <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
        <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
        <20200616115202.0285aa08.pasic@linux.ibm.com>
        <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 12:52:50 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-06-16 11:52, Halil Pasic wrote:
> > On Mon, 15 Jun 2020 14:39:24 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> @@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
> >>   	return is_prot_virt_guest();
> >>   }
> >>   
> >> +int arch_needs_iommu_platform(struct virtio_device *dev)  
> > 
> > Maybe prefixing the name with virtio_ would help provide the
> > proper context.  
> 
> The virtio_dev makes it obvious and from the virtio side it should be 
> obvious that the arch is responsible for this.
> 
> However if nobody has something against I change it.

arch_needs_virtio_iommu_platform()?

> 
> >   
> >> +{
> >> +	return is_prot_virt_guest();
> >> +}
> >> +
> >>   /* protected virtualization */
> >>   static void pv_init(void)
> >>   {

