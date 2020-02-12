Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B9C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A12420848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcrBI/Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBLHd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:33:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgBLHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581492807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJhg7KkEzOGnn4hSvrDQwQ/QlaSsdTM15d7DcDDIQpU=;
        b=hcrBI/MkM1c9RsItq76HrFO2oMHliA9y6rCxcOgfum5InA1uY3fOE01GIY8HNvrG7KlH0Z
        mDWFfbmGWrbFJn+z+Zkt+pakeQ8LVNLWQSORDzgA1xKgtuQJwj0fXPNvfWZRODUsj/fhtr
        qt8hQSfRv2WQd8uBDPIyuazkV28nIlE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-IzQ775j7OY-M0ILju85TAw-1; Wed, 12 Feb 2020 02:33:25 -0500
X-MC-Unique: IzQ775j7OY-M0ILju85TAw-1
Received: by mail-qv1-f71.google.com with SMTP id b8so920677qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sJhg7KkEzOGnn4hSvrDQwQ/QlaSsdTM15d7DcDDIQpU=;
        b=c2NIhTmvpakFs5wQjd2F1EP5H4kD9UUZ9J3xbOa+z/51n5RT0qn9GBeMJG9WzMIdRn
         lMYYX9SuuUge75ye3S5UXolCGNN9RHX+4/m6hpMfMZ3pojpwVLfFyZ6xIND5YjP8i5fj
         6hUG1vklTUCCnsLqwf1qry5P9URmjf7I8Dxrwg6HDgtjjSJNddFZgp66f7Ta7GEHn640
         Sj5RRlk9BWOtRPPAOubl2hZSOVJckug0R5o2Vh+5sXDAa++50UQyigDpu/+MP8DZA/lC
         kcAWBlVfopMkWQndlSj6xLIXmEIVkQDSDB6Vu0amFuvhC0HWH57VwzCwCGLEUTmzG9Ut
         fn/w==
X-Gm-Message-State: APjAAAWSvmUqdbL9IKhKX2DnlSiMf/PUC2o/GxXNaNipVf0ewJDd5g/j
        6Tq+epv1GZpm79DqgvZ5/Gf8a6VhEUHgRo6Sd1f2hFio1oedTi1gW1WYZmOnRWK0i0o1C09QI2C
        zOF6JggA4jQ5N+0SVtfjQkyLu
X-Received: by 2002:a37:7245:: with SMTP id n66mr6550701qkc.202.1581492805429;
        Tue, 11 Feb 2020 23:33:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrwLw9tJ+j7cQsj4KIfybcSmpt4S0r5Ij00Kd6ddFwi9Qet0H0RfsmeBuMxbC3RCsQtJIU9A==
X-Received: by 2002:a37:7245:: with SMTP id n66mr6550688qkc.202.1581492805139;
        Tue, 11 Feb 2020 23:33:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id k15sm3284451qkk.103.2020.02.11.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:33:24 -0800 (PST)
Date:   Wed, 12 Feb 2020 02:33:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200212023051-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:54:53AM +0800, Liu, Jing2 wrote:
> 
> On 2/11/2020 3:40 PM, Jason Wang wrote:
> 
> 
>     On 2020/2/11 下午2:02, Liu, Jing2 wrote:
> 
> 
> 
>         On 2/11/2020 12:02 PM, Jason Wang wrote:
> 
> 
>             On 2020/2/11 上午11:35, Liu, Jing2 wrote:
> 
> 
>                 On 2/11/2020 11:17 AM, Jason Wang wrote:
> 
> 
>                     On 2020/2/10 下午5:05, Zha Bin wrote:
> 
>                         From: Liu Jiang<gerry@linux.alibaba.com>
> 
>                         Userspace VMMs (e.g. Qemu microvm, Firecracker) take
>                         advantage of using
>                         virtio over mmio devices as a lightweight machine model
>                         for modern
>                         cloud. The standard virtio over MMIO transport layer
>                         only supports one
>                         legacy interrupt, which is much heavier than virtio
>                         over PCI transport
>                         layer using MSI. Legacy interrupt has long work path
>                         and causes specific
>                         VMExits in following cases, which would considerably
>                         slow down the
>                         performance:
> 
>                         1) read interrupt status register
>                         2) update interrupt status register
>                         3) write IOAPIC EOI register
> 
>                         We proposed to add MSI support for virtio over MMIO via
>                         new feature
>                         bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt
>                         performance.
> 
>                         With the VIRTIO_F_MMIO_MSI feature bit supported, the
>                         virtio-mmio MSI
>                         uses msi_sharing[1] to indicate the event and vector
>                         mapping.
>                         Bit 1 is 0: device uses non-sharing and fixed vector
>                         per event mapping.
>                         Bit 1 is 1: device uses sharing mode and dynamic
>                         mapping.
> 
> 
> 
>                     I believe dynamic mapping should cover the case of fixed
>                     vector?
> 
> 
>                 Actually this bit *aims* for msi sharing or msi non-sharing.
> 
>                 It means, when msi sharing bit is 1, device doesn't want vector
>                 per queue
> 
>                 (it wants msi vector sharing as name) and doesn't want a high
>                 interrupt rate.
> 
>                 So driver turns to !per_vq_vectors and has to do dynamical
>                 mapping.
> 
>                 So they are opposite not superset.
> 
>                 Thanks!
> 
>                 Jing
> 
> 
> 
>             I think you need add more comments on the command.
> 
>             E.g if I want to map vector 0 to queue 1, how do I need to do?
> 
>             write(1, queue_sel);
>             write(0, vector_sel);
> 
> 
>         That's true. Besides, two commands are used for msi sharing mode,
> 
>         VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> 
>         "To set up the event and vector mapping for MSI sharing mode, driver
>         SHOULD write a valid MsiVecSel followed by
>         VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command to
>         map the configuration change/selected queue events respectively.  "
>         (See spec patch 5/5)
> 
>         So if driver detects the msi sharing mode, when it does setup vq,
>         writes the queue_sel (this already exists in setup vq), vector sel and
>         then MAP_QUEUE command to do the queue event mapping.
> 
> 
> 
>     So actually the per vq msix could be done through this.
> 
> Right, per vq msix can also be mapped by the 2 commands if we want. 
> 
> The current design benefits for those devices requesting per vq msi that driver
> 
> doesn't have to map during setup each queue,
> 
> since we define the relationship by default.

Point being to save some exits for configuration? How much does it
save? IMHO we need to find a way to drastically simplify this interface,
to cut down the new LOC to at most 100-200, proportionally to the
performance gain it gives.


> 
>     I don't get why you need to introduce MSI_SHARING_MASK which is the charge
>     of driver instead of device.
> 
> MSI_SHARING_MASK is just for identifying the msi_sharing bit in readl(MsiState)
> (0x0c4). The device tells whether it wants msi_sharing.
> 
> MsiState register: R
> 
> le32 {
>     msi_enabled : 1;
>     msi_sharing: 1;
>     reserved : 30;
> };
> 
>     The interrupt rate should have no direct relationship with whether it has
>     been shared or not.
> 
> 
> 
>     Btw, you introduce mask/unmask without pending, how to deal with the lost
>     interrupt during the masking then?
> 
> 
> 
>         For msi non-sharing mode, no special action is needed because we make
>         the rule of per_vq_vector and fixed relationship.
> 
>         Correct me if this is not that clear for spec/code comments.
> 
> 
> 
>     The ABI is not as straightforward as PCI did. Why not just reuse the PCI
>     layout?
> 
>     E.g having
> 
>     queue_sel
>     queue_msix_vector
>     msix_config
> 
>     for configuring map between msi vector and queues/config
> 
> Thanks for the advice. :)
> 
> Actually when looking into pci, the queue_msix_vector/msix_config is the msi
> vector index, which is the same as the mmio register MsiVecSel (0x0d0).
> 
> So we don't introduce two extra registers for mapping even in sharing mode.
> 
> What do you think?
> 
> 
> 
>     Then
> 
>     vector_sel
>     address
>     data
>     pending
>     mask
>     unmask
> 
>     for configuring msi table?
> 
> PCI-like msix table is not introduced to device and instead simply use commands
> to tell the mask/configure/enable.
> 
> Thanks!
> 
> Jing
> 
> 
>     Thanks
> 
> 
> 
>         Thanks!
> 
>         Jing
> 
> 
> 
> 
>             ?
> 
>             Thanks
> 
> 
> 
> 
> 
> 
>                     Thanks
> 
> 
> 
>                     ---------------------------------------------------------------------
> 
>                     To unsubscribe, e-mail:
>                     virtio-dev-unsubscribe@lists.oasis-open.org
>                     For additional commands, e-mail:
>                     virtio-dev-help@lists.oasis-open.org
> 
> 
> 
> 
> 
> 
> 
> 

