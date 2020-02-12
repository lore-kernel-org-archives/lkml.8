Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CD220873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/p0LXqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBLJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:55:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45989 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728846AbgBLJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581501345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFNhckmD80QJf6jRDOHI6PRM4MMiU94KSnf7/vGNBgo=;
        b=Q/p0LXqgDpcgKzMvSrWm/XzSjD+H2v+tacZqseLyP6o59P0EngN7O7FvtKsUxGhhT5Lghl
        bH+Cnaoz7+drwoVPiTrT1B/BGeyl6Tp7ymekC53oS9KJyGvzGxI/vfqeH8Y+38A70Jq97u
        ixeSlzhyB9hA9/Eae/cVdkG3oUU8QAA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-ZgcbkkfuMtCexj59ckLK2Q-1; Wed, 12 Feb 2020 04:55:44 -0500
X-MC-Unique: ZgcbkkfuMtCexj59ckLK2Q-1
Received: by mail-qt1-f199.google.com with SMTP id k27so894260qtu.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bFNhckmD80QJf6jRDOHI6PRM4MMiU94KSnf7/vGNBgo=;
        b=qw1AZ7i/CwPCILvm9fYLz94FmmYeNyVuk4Bjxl5xULTTZKCtLEcga7NMyHj2298ehz
         VkEdrpFKaQOIejQnxd4/7ed8BioEzl3A4O+isyOr9MFFkIP+zupj28jyh2/eQnf8UGvE
         9H5NCmUz/M5jdUoi3S65i9y1RxSigx/WTi0ilrjWHxPbFsMd9RQKhesqQOloPBviu5wI
         w119rD9hboD5DFVte0W2NOEHMQzWWaZ4DgC0l+0yDyc9SAmmcPiJlMLtNavGrrA/NV5U
         tpFKmxt5MtEbIM5y5pn1CIYDINsc4r/W1Bfhugcc209mE5VbRV3tolUTNRYyETwOH5OF
         NKPQ==
X-Gm-Message-State: APjAAAX6EnnhZggQQpF7arVhP/uhoRxRNaY2qVQvD5+z+Cw/dRAUvvTj
        Ytz5wa94LLjy0vHTb8zM8INFml2OIez3Ptsr34qj/MYucsRJJX5gwaNE1EPmfM4VjH3uarpuDMa
        n/qoa/0foSF97PugRP9exzZl0
X-Received: by 2002:a37:c20c:: with SMTP id i12mr6835436qkm.369.1581501343958;
        Wed, 12 Feb 2020 01:55:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCGfkRPm08o/LHssSKBU88oQZ98wfqpUmh8XnUJ6AgE1yA5tbBHLFkuTpDWg4gHursBy+Haw==
X-Received: by 2002:a37:c20c:: with SMTP id i12mr6835426qkm.369.1581501343730;
        Wed, 12 Feb 2020 01:55:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id d206sm3549894qke.66.2020.02.12.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 01:55:42 -0800 (PST)
Date:   Wed, 12 Feb 2020 04:55:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>,
        virtio-dev@lists.oasis-open.org, slp@redhat.com,
        jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200212045245-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
 <20200212024158-mutt-send-email-mst@kernel.org>
 <d4eb9cde-5d06-3df9-df28-15378a9c6929@redhat.com>
 <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:33:06PM +0800, Jason Wang wrote:
> 
> On 2020/2/12 下午4:53, Jason Wang wrote:
> > 
> > On 2020/2/12 下午4:18, Michael S. Tsirkin wrote:
> > > On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
> > > > On 2020/2/11 下午7:33, Michael S. Tsirkin wrote:
> > > > > On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > 
> > > > > > The standard virtio-mmio devices use notification register to signal
> > > > > > backend. This will cause vmexits and slow down the
> > > > > > performance when we
> > > > > > passthrough the virtio-mmio devices to guest virtual machines.
> > > > > > We proposed to update virtio over MMIO spec to add the per-queue
> > > > > > notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> > > > > > configure notify location for each queue.
> > > > > > 
> > > > > > [1]https://lkml.org/lkml/2020/1/21/31
> > > > > > 
> > > > > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
> > > > > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > > > > Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
> > > > > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > > > > > Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > > > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > > > Hmm. Any way to make this static so we don't need
> > > > > base and multiplier?
> > > > E.g page per vq?
> > > > 
> > > > Thanks
> > > Problem is, is page size well defined enough?
> > > Are there cases where guest and host page sizes differ?
> > > I suspect there might be.
> > 
> > 
> > Right, so it looks better to keep base and multiplier, e.g for vDPA.
> > 
> > 
> > > 
> > > But I also think this whole patch is unproven. Is someone actually
> > > working on QEMU code to support pass-trough of virtio-pci
> > > as virtio-mmio for nested guests? What's the performance
> > > gain like?
> > 
> > 
> > I don't know.
> > 
> > Thanks
> 
> 
> Btw, I think there's no need for a nested environment to test. Current
> eventfd hook to MSIX should still work for MMIO.
> 
> Thanks


Oh yes it's the wildcard thingy but how much extra performance does one get
from it with MMIO? A couple % might not be worth the trouble for MMIO.

-- 
MST

