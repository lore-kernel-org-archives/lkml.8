Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008C0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EB8206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRPvIjyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgBKLWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:22:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36472 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727728AbgBKLWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581420124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uywzlgED9FQaejQMPT8+w69RgaNeWiLfzY9AcwWvmwg=;
        b=hRPvIjygClf432wTh2wSuk1BXNrNHcAOezemVpjjVtYRiwV8USqlsCsbEW83K1pGHTbNMR
        v5Gr+ezDCo/EmbWlKQ6zgayCEJFFhmqre6O9L++EE/W2i42IbbG7LlGZI4Xh/RwSPr1KZ6
        9t9bwlGDR7MK/q1lF3qyt06QqKArMlo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-8-LIvPDoPhOexdyXYJALwg-1; Tue, 11 Feb 2020 06:22:02 -0500
X-MC-Unique: 8-LIvPDoPhOexdyXYJALwg-1
Received: by mail-qt1-f199.google.com with SMTP id e37so6353621qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uywzlgED9FQaejQMPT8+w69RgaNeWiLfzY9AcwWvmwg=;
        b=uMpwFmqOMvgcjgPrqtKujN30iRzHP3b9vgRu0XhfKyhmsewSGLPvIHxdM5jETLgkBm
         wkQcnHdXZXgoCu8HwdNKlgPtoSUB1O4y2Yo/SwTqDwIuXa/x82z9RD7pHMNLXU/wBRAy
         kFHea7BH3Jlg123ZO8wSl4LNyJnnWIGRfcJWyrnA0zWnM21NSWPMdtHJ2qqcSYzI2H5B
         dF9+l5RP+haOPQ+0+C1/77nqZUeIgHwg0fDXvPlLFOu6DjQ7QI4o10tg1ycwr9w1mrqz
         P8gXIsg+ndQQARR0naXWnCL++k8+rFfoYOwgG+34ndQHEljypbualda/1pvOCUgQVcSv
         nI2Q==
X-Gm-Message-State: APjAAAXG2HbRIq9gZ9Dabtcxq5Wd/ET9+gX1RPrJkP2dUQWj5ayxiohP
        NgJx7ZTjO/AeuRLNy+ZH+n0aMqxEz5CcuoEriQZ61iyJH0Wb/i2iqt19+EiB/fLRrR1G5Bhufgn
        C3t7rn+mp2iMTxchl63xCWIJW
X-Received: by 2002:a37:4a46:: with SMTP id x67mr5025572qka.160.1581420122034;
        Tue, 11 Feb 2020 03:22:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz25NYgqQ4RyqKjzgoUmmDztlCipwhKzeimR0ml6ZS/X3NzdSxMN8c8069qeqewBEMoFh327Q==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr5025556qka.160.1581420121807;
        Tue, 11 Feb 2020 03:22:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id t23sm1896118qto.88.2020.02.11.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:22:00 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:21:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211061932-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:35:43AM +0800, Liu, Jing2 wrote:
> 
> On 2/11/2020 11:17 AM, Jason Wang wrote:
> > 
> > On 2020/2/10 下午5:05, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > 
> > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> > > virtio over mmio devices as a lightweight machine model for modern
> > > cloud. The standard virtio over MMIO transport layer only supports one
> > > legacy interrupt, which is much heavier than virtio over PCI transport
> > > layer using MSI. Legacy interrupt has long work path and causes specific
> > > VMExits in following cases, which would considerably slow down the
> > > performance:
> > > 
> > > 1) read interrupt status register
> > > 2) update interrupt status register
> > > 3) write IOAPIC EOI register
> > > 
> > > We proposed to add MSI support for virtio over MMIO via new feature
> > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> > > 
> > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
> > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > 
> > 
> > I believe dynamic mapping should cover the case of fixed vector?
> > 
> Actually this bit *aims* for msi sharing or msi non-sharing.
> 
> It means, when msi sharing bit is 1, device doesn't want vector per queue
> 
> (it wants msi vector sharing as name) and doesn't want a high interrupt
> rate.
> 
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
> 
> So they are opposite not superset.
> 
> Thanks!
> 
> Jing

what's the point of all this flexibility? the cover letter
complains about the code size of pci, then you go back
and add a ton of options with no justification.



> 
> > Thanks
> > 
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

