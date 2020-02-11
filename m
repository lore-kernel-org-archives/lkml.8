Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB4C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12302467B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8gf/pvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgBKOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:00:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24839 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728734AbgBKOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581429630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiJCNKCKara6122SLriCEZQxiJm9yQK9HeliuKGXOc0=;
        b=I8gf/pvpNWY44s7QJJMMuU3cZRyr8FUfpXajLZ0oeJE9amqSbJERYtOhKYEqFsGGbwb0uM
        DVSfO8Qv/66EnDnILP4HPaVXzGi88YvNS8Ow5lhxWcFYZEdPVoI+JnjAQvHhXgvqqFWr4p
        YYdseOOYSK6awQfa+S+HyQuGKHwezl0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-nUqL_lqaP_OmVJpdihEiHg-1; Tue, 11 Feb 2020 09:00:27 -0500
X-MC-Unique: nUqL_lqaP_OmVJpdihEiHg-1
Received: by mail-qk1-f198.google.com with SMTP id y6so7094595qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IiJCNKCKara6122SLriCEZQxiJm9yQK9HeliuKGXOc0=;
        b=gHlg3Fso17bLaYUJK25BcTPmFcE19w5v3ce4ocreJq4cQyvKQ00WOLCvzo9nOSuEsW
         7OYJhvl7CwAGNdaEVrGwm5QIg8/BGariNl0nug9YxFcwKmyZO1glpIINf7JprCBuozOJ
         rALuACxg2Cl/2sQEaT4O9uk5qesZ02BtZ0hexlpEM8/2COfKhuqWYSUfc9og2+dC605y
         833puxTsiLCIQjPeFZC8NaEJRcgnGqZAOHIjEqhye8HjII74dR6+gs4r0HhQCvnjpXZ0
         FOj1t+QKEYU61dWCU9AMBTQYWwWFHb0cstHprZFzHhmdc49vTLGxfkaFx3lqIwF+RTVI
         udFQ==
X-Gm-Message-State: APjAAAVbGX6i21obmfKy5b9SQt82bq8lDS6m8nipM21DUAR8iHR5VFLu
        foGXNTCEgsBnI9yp/FcWq3G8G9fA+awLzBnub7bZ27LRSsAUE77M71pCI0q+FspJvdryXz002qk
        aL39T7gTI5f3lt34QRu6HIzq7
X-Received: by 2002:ac8:38e6:: with SMTP id g35mr15121171qtc.120.1581429627225;
        Tue, 11 Feb 2020 06:00:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzul9u4swtFOk02v4Rwi5cC4SpS1I1htVnEFQL+BCn8ZrTnpx5sW3iqgZ6OFG5Lv6LVBMzmXQ==
X-Received: by 2002:ac8:38e6:: with SMTP id g35mr15121130qtc.120.1581429626863;
        Tue, 11 Feb 2020 06:00:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id t23sm2118020qto.88.2020.02.11.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 06:00:26 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:00:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211090003-mutt-send-email-mst@kernel.org>
References: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:54PM +0800, Jason Wang wrote:
> 
> On 2020/2/11 下午8:08, Michael S. Tsirkin wrote:
> > On Tue, Feb 11, 2020 at 08:04:24PM +0800, Jason Wang wrote:
> > > On 2020/2/11 下午7:58, Michael S. Tsirkin wrote:
> > > > On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
> > > > > On 2020/2/11 下午2:02, Liu, Jing2 wrote:
> > > > > > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > > > > > On 2020/2/11 上午11:35, Liu, Jing2 wrote:
> > > > > > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > > > > > On 2020/2/10 下午5:05, Zha Bin wrote:
> > > > > > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > > > > > 
> > > > > > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take
> > > > > > > > > > advantage of using
> > > > > > > > > > virtio over mmio devices as a lightweight machine model for modern
> > > > > > > > > > cloud. The standard virtio over MMIO transport layer
> > > > > > > > > > only supports one
> > > > > > > > > > legacy interrupt, which is much heavier than virtio over
> > > > > > > > > > PCI transport
> > > > > > > > > > layer using MSI. Legacy interrupt has long work path and
> > > > > > > > > > causes specific
> > > > > > > > > > VMExits in following cases, which would considerably slow down the
> > > > > > > > > > performance:
> > > > > > > > > > 
> > > > > > > > > > 1) read interrupt status register
> > > > > > > > > > 2) update interrupt status register
> > > > > > > > > > 3) write IOAPIC EOI register
> > > > > > > > > > 
> > > > > > > > > > We proposed to add MSI support for virtio over MMIO via new feature
> > > > > > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> > > > > > > > > > 
> > > > > > > > > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> > > > > > > > > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > > > > > > > > Bit 1 is 0: device uses non-sharing and fixed vector per
> > > > > > > > > > event mapping.
> > > > > > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > > > > > > I believe dynamic mapping should cover the case of fixed vector?
> > > > > > > > > 
> > > > > > > > Actually this bit*aims*  for msi sharing or msi non-sharing.
> > > > > > > > 
> > > > > > > > It means, when msi sharing bit is 1, device doesn't want vector
> > > > > > > > per queue
> > > > > > > > 
> > > > > > > > (it wants msi vector sharing as name) and doesn't want a high
> > > > > > > > interrupt rate.
> > > > > > > > 
> > > > > > > > So driver turns to !per_vq_vectors and has to do dynamical mapping.
> > > > > > > > 
> > > > > > > > So they are opposite not superset.
> > > > > > > > 
> > > > > > > > Thanks!
> > > > > > > > 
> > > > > > > > Jing
> > > > > > > I think you need add more comments on the command.
> > > > > > > 
> > > > > > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > > > > > > 
> > > > > > > write(1, queue_sel);
> > > > > > > write(0, vector_sel);
> > > > > > That's true. Besides, two commands are used for msi sharing mode,
> > > > > > 
> > > > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> > > > > > 
> > > > > > "To set up the event and vector mapping for MSI sharing mode, driver
> > > > > > SHOULD write a valid MsiVecSel followed by
> > > > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command to
> > > > > > map the configuration change/selected queue events respectively.  " (See
> > > > > > spec patch 5/5)
> > > > > > 
> > > > > > So if driver detects the msi sharing mode, when it does setup vq, writes
> > > > > > the queue_sel (this already exists in setup vq), vector sel and then
> > > > > > MAP_QUEUE command to do the queue event mapping.
> > > > > > 
> > > > > So actually the per vq msix could be done through this. I don't get why you
> > > > > need to introduce MSI_SHARING_MASK which is the charge of driver instead of
> > > > > device. The interrupt rate should have no direct relationship with whether
> > > > > it has been shared or not.
> > > > > 
> > > > > Btw, you introduce mask/unmask without pending, how to deal with the lost
> > > > > interrupt during the masking then?
> > > > pending can be an internal device register. as long as device
> > > > does not lose interrupts while masked, all's well.
> > > 
> > > You meant raise the interrupt during unmask automatically?
> > > 
> > 
> > yes - that's also what pci does.
> > 
> > the guest visible pending bit is partially implemented in qemu
> > as per pci spec but it's unused.
> 
> 
> Ok.
> 
> 
> > 
> > > > There's value is being able to say "this queue sends no
> > > > interrupts do not bother checking used notification area".
> > > > so we need way to say that. So I guess an enable interrupts
> > > > register might have some value...
> > > > But besides that, it's enough to have mask/unmask/address/data
> > > > per vq.
> > > 
> > > Just to check, do you mean "per vector" here?
> > > 
> > > Thanks
> > > 
> > No, per VQ. An indirection VQ -> vector -> address/data isn't
> > necessary for PCI either, but that ship has sailed.
> 
> 
> Yes, it can work but it may bring extra effort when you want to mask a
> vector which is was shared by a lot of queues.
> 
> Thanks
> 

masking should be per vq too.

-- 
MST

