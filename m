Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24137C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31D62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi3Hw404"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHJOuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:50:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbgHJOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597071034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CmPgr4Q4WAZKNKGFTE7tvM8ImvK/kVdmqG/HrVAHjUk=;
        b=hi3Hw404FaxaD9QaKNWFb+v3JeiVoRk+t5CCVh6LbHNCIgOtLP3TZk512rVz4n1TTABr3+
        fOFNKYY1s13KMy2qKhtjcu8INH1umM/1AsIODCfe0FwG5Wqu/0vM7Spxv4S6p2fwj6RdTT
        61UDNFVOeHfW4PlK59+MYetIA0MVsdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-nDAT6UYOOhuk0ykGpsGy3g-1; Mon, 10 Aug 2020 10:50:30 -0400
X-MC-Unique: nDAT6UYOOhuk0ykGpsGy3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C9AE80BCA6;
        Mon, 10 Aug 2020 14:50:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1B7310016E8;
        Mon, 10 Aug 2020 14:50:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 41C7722036A; Mon, 10 Aug 2020 10:50:19 -0400 (EDT)
Date:   Mon, 10 Aug 2020 10:50:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/20] virtio: Implement get_shm_region for PCI
 transport
Message-ID: <20200810145019.GB455528@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-5-vgoyal@redhat.com>
 <20200810100327-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810100327-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:05:17AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 07, 2020 at 03:55:10PM -0400, Vivek Goyal wrote:
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > 
> > On PCI the shm regions are found using capability entries;
> > find a region by searching for the capability.
> > 
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > Cc: kvm@vger.kernel.org
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

[..]
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +
> > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > +		return false;
> > +	}
> > +
> > +	phys_addr = pci_resource_start(pci_dev, bar);
> > +	bar_len = pci_resource_len(pci_dev, bar);
> > +
> > +	if ((offset + len) < offset) {
> > +		dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
> > +			__func__);
> > +		return false;
> > +	}
> > +
> > +	if (offset + len > bar_len) {
> > +		dev_err(&pci_dev->dev, "%s: bar shorter than cap offset+len\n",
> > +			__func__);
> > +		return false;
> > +	}
> 
> Maybe move this to a common header so the checks can be reused by
> other transports? Can be a patch on top.

Will do as patch on top once these patches get merged. 

Thanks
Vivek

