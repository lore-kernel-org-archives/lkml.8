Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D0EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl6IOjX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgBKL6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:58:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727669AbgBKL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581422321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHVm75D8rqdio+fBEx7/QYHo8H/jQwK3ulKDlXOb1xI=;
        b=Zl6IOjX4hkj8rzu5wX5orZK+O6/l+lCiGeSKUvMa/2iYgXecwKamcJxY+x0o8uNb1J+jZL
        3ZLuG9/uPIEuMVia6yHbTyXFPu8I8Jh+L31cs+QpqaZclPIERoORti1z+ouzlDn5iIOIOY
        fIUCbrUjQCODTgamahK0/f99SC5/8qw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-_JsqlZOgOCWtpUX1Q1lflQ-1; Tue, 11 Feb 2020 06:58:39 -0500
X-MC-Unique: _JsqlZOgOCWtpUX1Q1lflQ-1
Received: by mail-qt1-f199.google.com with SMTP id p12so6397842qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VHVm75D8rqdio+fBEx7/QYHo8H/jQwK3ulKDlXOb1xI=;
        b=omO/lNyi8538cC0KS2lT7gvAjZWpSocEkQwMNMZZmqMudIU3+vLDeia6y6tacYVL/4
         1G3saZcTP4rjpdj0OViMAEmjdU+7fenAvCHbNjDgC4bFgUw1F05tEmZ1GGbedpF9mPql
         uGkYyHdrXLhJ24yUG1PcS6O610FlowmI7ayTdLmnAc7pqpeIbkzp5VAWYS63V70CfJ5S
         tNuu+pNUX/r/GnsXGo0lEWLiAQgDCod4vGVVyrxhANp0KHpf3aJCQG/+UbAvB7USuwKk
         7BbYTP4qc6pdSOhboAFxfN+h+llL8oQCXo/6DEI5EkKNi+5TVht+adDdA4W1MOwSpuH6
         ZPFw==
X-Gm-Message-State: APjAAAWz4wAKaus4g38HrA+44yYMv2Gj3xPpaH80Sfa0aZ2pBwBHikdn
        cBU4Ckiys5/ZJb360NPzq4/EMyjNFIYlDABOAlKbgvyvDai3pimNvbE0mNo8VT/ghCdniO+sspt
        eEJp99qxEr467/+Nmo7xY/poz
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr2062798qtw.9.1581422319022;
        Tue, 11 Feb 2020 03:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3iwCy7bP7e6NfjLXRRT82iDb6Mi5NXCWXeUBQu8ZeoM18uqn2tMhurYWG6eCqvIq/nZKg1w==
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr2062781qtw.9.1581422318713;
        Tue, 11 Feb 2020 03:58:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id e64sm2004999qtd.45.2020.02.11.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:58:37 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:58:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211065319-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
> 
> On 2020/2/11 下午2:02, Liu, Jing2 wrote:
> > 
> > 
> > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > 
> > > On 2020/2/11 上午11:35, Liu, Jing2 wrote:
> > > > 
> > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > 
> > > > > On 2020/2/10 下午5:05, Zha Bin wrote:
> > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > 
> > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take
> > > > > > advantage of using
> > > > > > virtio over mmio devices as a lightweight machine model for modern
> > > > > > cloud. The standard virtio over MMIO transport layer
> > > > > > only supports one
> > > > > > legacy interrupt, which is much heavier than virtio over
> > > > > > PCI transport
> > > > > > layer using MSI. Legacy interrupt has long work path and
> > > > > > causes specific
> > > > > > VMExits in following cases, which would considerably slow down the
> > > > > > performance:
> > > > > > 
> > > > > > 1) read interrupt status register
> > > > > > 2) update interrupt status register
> > > > > > 3) write IOAPIC EOI register
> > > > > > 
> > > > > > We proposed to add MSI support for virtio over MMIO via new feature
> > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> > > > > > 
> > > > > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> > > > > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > > > > Bit 1 is 0: device uses non-sharing and fixed vector per
> > > > > > event mapping.
> > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > > 
> > > > > 
> > > > > I believe dynamic mapping should cover the case of fixed vector?
> > > > > 
> > > > Actually this bit *aims* for msi sharing or msi non-sharing.
> > > > 
> > > > It means, when msi sharing bit is 1, device doesn't want vector
> > > > per queue
> > > > 
> > > > (it wants msi vector sharing as name) and doesn't want a high
> > > > interrupt rate.
> > > > 
> > > > So driver turns to !per_vq_vectors and has to do dynamical mapping.
> > > > 
> > > > So they are opposite not superset.
> > > > 
> > > > Thanks!
> > > > 
> > > > Jing
> > > 
> > > 
> > > I think you need add more comments on the command.
> > > 
> > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > > 
> > > write(1, queue_sel);
> > > write(0, vector_sel);
> > 
> > That's true. Besides, two commands are used for msi sharing mode,
> > 
> > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> > 
> > "To set up the event and vector mapping for MSI sharing mode, driver
> > SHOULD write a valid MsiVecSel followed by
> > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command to
> > map the configuration change/selected queue events respectively.  " (See
> > spec patch 5/5)
> > 
> > So if driver detects the msi sharing mode, when it does setup vq, writes
> > the queue_sel (this already exists in setup vq), vector sel and then
> > MAP_QUEUE command to do the queue event mapping.
> > 
> 
> So actually the per vq msix could be done through this. I don't get why you
> need to introduce MSI_SHARING_MASK which is the charge of driver instead of
> device. The interrupt rate should have no direct relationship with whether
> it has been shared or not.
> 
> Btw, you introduce mask/unmask without pending, how to deal with the lost
> interrupt during the masking then?

pending can be an internal device register. as long as device
does not lose interrupts while masked, all's well.

There's value is being able to say "this queue sends no
interrupts do not bother checking used notification area".
so we need way to say that. So I guess an enable interrupts
register might have some value...
But besides that, it's enough to have mask/unmask/address/data
per vq.


> 
> > For msi non-sharing mode, no special action is needed because we make
> > the rule of per_vq_vector and fixed relationship.
> > 
> > Correct me if this is not that clear for spec/code comments.
> > 
> 
> The ABI is not as straightforward as PCI did. Why not just reuse the PCI
> layout?
> 
> E.g having
> 
> queue_sel
> queue_msix_vector
> msix_config
> 
> for configuring map between msi vector and queues/config
> 
> Then
> 
> vector_sel
> address
> data
> pending
> mask
> unmask
> 
> for configuring msi table?
> 
> Thanks
> 
> 
> > Thanks!
> > 
> > Jing
> > 
> > 
> > > 
> > > ?
> > > 
> > > Thanks
> > > 
> > > 
> > > > 
> > > > 
> > > > > Thanks
> > > > > 
> > > > > 
> > > > > 
> > > > > ---------------------------------------------------------------------
> > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > > > 
> > > > 
> > > 

