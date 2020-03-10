Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D72C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A90CR9b+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCJSrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:47:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726426AbgCJSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583866054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvrq31NBMkv7Vsef+6f+mBGyLXD/eDRO+WBoQLnMO/s=;
        b=A90CR9b+5ERYZcvA94Ya8A4/iAfjbnY5QXsrpGjcZeEwdmVz5nVXuVFen/6a7ud9pqb+Gt
        d97xe8b+yVxT5N0FS7iFqbEY+JVGe2+DxQAFWvzWU2MmgS5CYLFcHqJvxy1xeAwUi0pyAE
        benwlQ2NrIltU/T8D82YEtuxLswDLTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-lrpkCCq3MUejwZtd_UU6uw-1; Tue, 10 Mar 2020 14:47:30 -0400
X-MC-Unique: lrpkCCq3MUejwZtd_UU6uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82A2477;
        Tue, 10 Mar 2020 18:47:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDAF6277A4;
        Tue, 10 Mar 2020 18:47:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7B8B322021D; Tue, 10 Mar 2020 14:47:20 -0400 (EDT)
Date:   Tue, 10 Mar 2020 14:47:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310184720.GD38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310071043-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310071043-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:12:25AM -0400, Michael S. Tsirkin wrote:
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
> > +	int ret;
> > +
> > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > +		return false;
> > +	}
> > +
> > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > +	if (ret < 0) {
> > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > +			__func__);
> > +		return false;
> > +	}
> > +
> > +	phys_addr = pci_resource_start(pci_dev, bar);
> > +	bar_len = pci_resource_len(pci_dev, bar);
> > +
> > +        if (offset + len > bar_len) {
> > +                dev_err(&pci_dev->dev,
> > +                        "%s: bar shorter than cap offset+len\n",
> > +                        __func__);
> > +                return false;
> > +        }
> > +
> 
> Something wrong with indentation here.

Will fix all indentation related issues in this patch.

> Also as long as you are validating things, it's worth checking
> offset + len does not overflow.

Something like addition of following lines?

+       if ((offset + len) < offset) {
+               dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
+                       __func__);
+               return false;
+       }

Vivek

