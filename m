Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A53D20663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFipqD/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFGNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:52:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20957 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726561AbgFGNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591537919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+ZykWK8JdPOlw9O8iBRr/ktzWoLaWuHq+jzWrrmeS4=;
        b=MFipqD/M1CfXyxL0YGbfJYcxSdBc7Ybp6EwnQN27v2NdZnN7tuKZ97ZA45knWaK40cRhOu
        CWVfOVj9guEFnOxqCysQSJbRos0WmpqUH2LY1IekBbqJry4U9DNhO8yXQ1h0Jm9yVA3xex
        CWD8vYV6gL/QS1yjnMQK41Dm2KjxJak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-ySuURpLSNvqQpfRJ6Z7EbQ-1; Sun, 07 Jun 2020 09:51:57 -0400
X-MC-Unique: ySuURpLSNvqQpfRJ6Z7EbQ-1
Received: by mail-wm1-f70.google.com with SMTP id g84so4271032wmf.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 06:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j+ZykWK8JdPOlw9O8iBRr/ktzWoLaWuHq+jzWrrmeS4=;
        b=OXuR+L+CZTUdAeEm+MywFffFCVa7QA4VQfVpn7eKksUtA0AJC1p3Ul0EbyJ6RLO344
         XJcjvX1+CNNt6pqkqgxkvGJPgeK8yM9YFP1rEKo2T3USrJD4xdE76yb111SRVnjef3HH
         RKpfh64Hy1MZcc1JyljL3GevzHTTHvdRQ2Joqe8PZ/b+vDkBIu3Oishrl6CGTgdVdffj
         seNM5Nl5a8vO1s4DDr46anH0gQPF8q5ApI9ueswnEQOugDLjls9VXRl2Y8ZZ94sOM+QT
         xiLK+Iu/BV8y1dGZFxZmLC3u8yWhQao0/rKz8MM3wst85ig1wHLeUPM5kaTr1fSskWV+
         6/HA==
X-Gm-Message-State: AOAM533W3qsyegPB79BpCrR2507nn9l6ZN1fb+Fha83Hpi0ExE+IUyRp
        7j4Iy9uN/z0WUWWtiGJlOQ47rJn2mg8YUprLFx6WCRO65ouGav1W1xLUUsBVLTUB/GhQHtK5288
        caTuISHWvcgDCeBJ9Uy+4spu2
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr11840984wma.87.1591537916788;
        Sun, 07 Jun 2020 06:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2TmtCKZREalT4txL3yzsCeeXkK6uXYPX7CKkiC1Ju4AXoJxdH2DXwg3C6iSbfZNaMKmJQCQ==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr11840969wma.87.1591537916579;
        Sun, 07 Jun 2020 06:51:56 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id o8sm19747676wmb.20.2020.06.07.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 06:51:56 -0700 (PDT)
Date:   Sun, 7 Jun 2020 09:51:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Message-ID: <20200607095012-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 04:54:17PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午3:08, Jason Wang wrote:
> > > 
> > > > +static const struct pci_device_id vp_vdpa_id_table[] = {
> > > > +    { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> > > > +    { 0 }
> > > > +};
> > > This looks like it'll create a mess with either virtio pci
> > > or vdpa being loaded at random. Maybe just don't specify
> > > any IDs for now. Down the road we could get a
> > > distinct vendor ID or a range of device IDs for this.
> > 
> > 
> > Right, will do.
> > 
> > Thanks
> 
> 
> Rethink about this. If we don't specify any ID, the binding won't work.

We can bind manually. It's not really for production anyway, so
not a big deal imho.

> How about using a dedicated subsystem vendor id for this?
> 
> Thanks

If virtio vendor id is used then standard driver is expected
to bind, right? Maybe use a dedicated vendor id?

-- 
MST

