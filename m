Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BABA2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/12E/PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgFHJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:55:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729222AbgFHJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591610106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwRQYwEhlzI9fhHIuV2ZDsHSs0DHTOaRaWRbv3sTP+c=;
        b=d/12E/PTZZOS/m71x9FcAvx0JclAsrIKYJnZ3jHZtixotEEjN547/6UBhSSmi41G0KUuPB
        pqZqIjVfdUC7xacohLVbGSNhF9IjRUTWyr5NnKCVoACZ6rqu96iLbqaQpntQFBXeKK0npj
        wXTsg66DIgitT1UHYMUPnFhY9jeC4gI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-kdXq02FKNxeAz68aTvtPSQ-1; Mon, 08 Jun 2020 05:55:04 -0400
X-MC-Unique: kdXq02FKNxeAz68aTvtPSQ-1
Received: by mail-wm1-f72.google.com with SMTP id h25so5200036wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zwRQYwEhlzI9fhHIuV2ZDsHSs0DHTOaRaWRbv3sTP+c=;
        b=tu9D5HxqBgjC8GAq2RYWXYvaZXQcfW7KQWSQZ8VC+IctDbRMKPAXl89vNoRiByz3Xt
         d7mzvkQQL6lVbu03S7cB4BJ6/K5Wf5xIG4m0RlOkfOtakOeaEz9vjgj62+PPMQPQ0N+R
         e3OFLnbqrHAPYQG0ubHEMuHXlkOwwsstZHBfynD0SDEExyB9zqNe4Zo0ut/cGbD5eK+A
         FQ7sI0mWEfO058Oe4a01DE9QwuEdvw4dCeLwLmiDnIBa/rxr5kPgjbNPDa9cBDVMLPYz
         bJnZjy3vwIEVD9UsXEA9XjJIZ3iO2dgLfH3dCWtK8crtbBxZcULe1TzpC8WVIaJQmity
         d9oQ==
X-Gm-Message-State: AOAM531kP4lcUTZhklitkSwc52phR4nxiDjGWdZGmajoTLa0VB1ouC2b
        cPDe97CGdwGNuL5O9I8Lx5ns3vwK8/rKOCSb/VrbhLnuixIq2AcFEpiXy3pLuy05qrXOez7eR5i
        UKjdNhH0Fbr0LRKM5SgLUeNRd
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr15633399wmg.63.1591610103133;
        Mon, 08 Jun 2020 02:55:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyikeAcTqFLpMRWXI7wepdD3aO0/ujjV4fOTEz+k46ZIFoeVHzdsv1BhrAhul2cvz6zw90caQ==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr15633384wmg.63.1591610102957;
        Mon, 08 Jun 2020 02:55:02 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id o15sm23160537wrv.48.2020.06.08.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:55:02 -0700 (PDT)
Date:   Mon, 8 Jun 2020 05:54:59 -0400
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
Message-ID: <20200608055331-mutt-send-email-mst@kernel.org>
References: <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
 <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
 <20200608021438-mutt-send-email-mst@kernel.org>
 <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
 <20200608052041-mutt-send-email-mst@kernel.org>
 <9d2571b6-0b95-53b3-6989-b4d801eeb623@redhat.com>
 <20200608054453-mutt-send-email-mst@kernel.org>
 <bc27064c-2309-acf3-ccd8-6182bfa2a4cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc27064c-2309-acf3-ccd8-6182bfa2a4cd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:46:52PM +0800, Jason Wang wrote:
> 
> On 2020/6/8 下午5:45, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2020 at 05:43:58PM +0800, Jason Wang wrote:
> > > > > Looking at
> > > > > pci_match_one_device() it checks both subvendor and subdevice there.
> > > > > 
> > > > > Thanks
> > > > But IIUC there is no guarantee that driver with a specific subvendor
> > > > matches in presence of a generic one.
> > > > So either IFC or virtio pci can win, whichever binds first.
> > > 
> > > I'm not sure I get there. But I try manually bind IFCVF to qemu's
> > > virtio-net-pci, and it fails.
> > > 
> > > Thanks
> > Right but the reverse can happen: virtio-net can bind to IFCVF first.
> 
> 
> That's kind of expected. The PF is expected to be bound to virtio-pci to
> create VF via sysfs.
> 
> Thanks
> 
> 
> 

Once VFs are created, don't we want IFCVF to bind rather than
virtio-pci?

-- 
MST

