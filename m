Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18867C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEFC2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKWyGkd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgFHN3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:29:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729214AbgFHN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591622948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAi5RnB11l/kNjeRk8ozS/jXDdeHeIrWEjaZ8oVwPv4=;
        b=OKWyGkd1pwRdILQTXpSQDQc08uqv3GrWExbVtJsi5G6VY4qEoneqpvj355/9vUc5oPCq39
        b0hAfVVJvOIMfJxHmHDod1+H2tYQfw0B5CIEd2/SM0nb8FgCd1wh2XaPZltsmWUsWce+Oa
        Nes9MmkTGdEclkNrlmd0DAM7bOsHiuY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-9dTzL1t0MfqOCyl95btTtg-1; Mon, 08 Jun 2020 09:29:06 -0400
X-MC-Unique: 9dTzL1t0MfqOCyl95btTtg-1
Received: by mail-wm1-f72.google.com with SMTP id k185so3932620wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 06:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tAi5RnB11l/kNjeRk8ozS/jXDdeHeIrWEjaZ8oVwPv4=;
        b=kQZ9wNr9TNArkgfpn/QmeHy/vd2PUpIytCP+HPSpG3QvfImF8f5HBx0qbPy/hom6LB
         wSfAurpZhXwQajNQt1mNkCZ/f4SPzGl+vq2xPvPZvFJPZ/jTT9ZR+6pejBIj1VSdpwc1
         bImrOW7ffD4e2A+xnlcAEP/MTl6KPh7UGgAsfAvqvYomgMQSFgMRw6xjbquuKbkEAdyj
         XMIQC69zK793FVQr2go5oQyA9CnViNyQhcxE0hyL5ePsOHIm7IkE7q4dPp8/nc+vZkdD
         mWXZMsaPyrjXj6kKemtkNZrRCmpPpXEmwF2HGyfpG31EWO5xo5Kf1m4xprhe3e2egmWG
         z/uA==
X-Gm-Message-State: AOAM532v4uiAm1LYz1tcHAz+cabVcF2uWZ8M5miDRuqYUL7PGWhgmOS+
        pOfSHHUqQFDsVdb5R+BcwCijwcD53XHg9AkJU2x8EecSTfodcwIqfekwHNR6J4LYQOUSAyU+EsH
        FaH6Q5RiLwlnyPWq+8Nq0NgTU
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr23250533wrs.223.1591622945520;
        Mon, 08 Jun 2020 06:29:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLsV4zKcIqO3YHdQC1Vbu08DLKVYtIAwGXFJX9rmOu7fddWNahirZvRHnTir6Z4zHxaZCpjg==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr23250502wrs.223.1591622945243;
        Mon, 08 Jun 2020 06:29:05 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id o20sm24303052wra.29.2020.06.08.06.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 06:29:04 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:29:01 -0400
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
Message-ID: <20200608092530-mutt-send-email-mst@kernel.org>
References: <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
 <20200608021438-mutt-send-email-mst@kernel.org>
 <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
 <20200608052041-mutt-send-email-mst@kernel.org>
 <9d2571b6-0b95-53b3-6989-b4d801eeb623@redhat.com>
 <20200608054453-mutt-send-email-mst@kernel.org>
 <bc27064c-2309-acf3-ccd8-6182bfa2a4cd@redhat.com>
 <20200608055331-mutt-send-email-mst@kernel.org>
 <61117e6a-2568-d0f4-8713-d831af32814d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61117e6a-2568-d0f4-8713-d831af32814d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:07:36PM +0800, Jason Wang wrote:
> 
> On 2020/6/8 下午5:54, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2020 at 05:46:52PM +0800, Jason Wang wrote:
> > > On 2020/6/8 下午5:45, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 08, 2020 at 05:43:58PM +0800, Jason Wang wrote:
> > > > > > > Looking at
> > > > > > > pci_match_one_device() it checks both subvendor and subdevice there.
> > > > > > > 
> > > > > > > Thanks
> > > > > > But IIUC there is no guarantee that driver with a specific subvendor
> > > > > > matches in presence of a generic one.
> > > > > > So either IFC or virtio pci can win, whichever binds first.
> > > > > I'm not sure I get there. But I try manually bind IFCVF to qemu's
> > > > > virtio-net-pci, and it fails.
> > > > > 
> > > > > Thanks
> > > > Right but the reverse can happen: virtio-net can bind to IFCVF first.
> > > 
> > > That's kind of expected. The PF is expected to be bound to virtio-pci to
> > > create VF via sysfs.
> > > 
> > > Thanks
> > > 
> > > 
> > > 
> > Once VFs are created, don't we want IFCVF to bind rather than
> > virtio-pci?
> 
> 
> Yes, but for PF we need virtio-pci.
> 
> Thanks
> 

(Ab)using the driver_data field for this is an option.
What do you think?

-- 
MST

