Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD57C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584B3206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmLl8KBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgFDSuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:50:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728834AbgFDSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591296644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6snlKjU8aRgZULuYnJpe7wNQI9bh2ev/bXaAzVSEvQ=;
        b=WmLl8KBQrOUEGCtp9YoGxmRFPdxgBNUh+NdrV+asBoOHDzqPKZqPR3GVYCyZoBJ11FbsJW
        WI1eq9K3RFxYiMoxl0uITD4p6j2d6B3LM24Hhi8G/BE/hO06XSM0HWUzqFqd0c4V5H1B6Z
        UgoqP4RLZ5z4hCdhuLhlMBFdIRHLmjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-ZsUb3tMLPOW1wcDE74g3ZQ-1; Thu, 04 Jun 2020 14:50:42 -0400
X-MC-Unique: ZsUb3tMLPOW1wcDE74g3ZQ-1
Received: by mail-wr1-f71.google.com with SMTP id e1so2790097wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W6snlKjU8aRgZULuYnJpe7wNQI9bh2ev/bXaAzVSEvQ=;
        b=na/3f+vAfZA5ptgnRk3NUNzFxGEtukjfqizzGf/4lQbavwhFdcbSaQP05EdLxcGxQx
         hVMCtIBLjewGxvee5rJRTxQWVR+3MSRzpeew+DLbWllGiIyiVizhZgavNJvrADLRMcKu
         vM0XoTMHSHQAN8ZTvb3ZuPKAvfQpKee5vTy/WvEhwh7If6Vh6b1dyzt+xuDMEaUIh1G4
         5P1cdKDo10Fut1gpP47hwXqS9j0AedtUMe5Wzt4n7WbLSpwziBfLj7bAhBsc33Iw7N7G
         RYc9KmnrIS5C4fam5ugnxl2T1D83FV4P7zxuh+2owzZsWmrr2Izk86YksgZyzh+SmDCM
         eMGw==
X-Gm-Message-State: AOAM530EipDAu5KDDgvdgidCn887mkBR83f0KhieDRCvoDhziWjOflle
        l4Sl/M+s9RK509uiEhFjQ9ScMZ3TyBo2rOsFDKN89TUGEI+CJO4yWxDlq0Ln4u/qwSzNdoLS1u2
        fn5RtDBziMFDOjcN4ZZi1a4nX
X-Received: by 2002:a1c:b656:: with SMTP id g83mr5563947wmf.151.1591296641702;
        Thu, 04 Jun 2020 11:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFWuENQHpNppZbCtXmj/W7gbwDx2OeFjgcac3birrs4llztufXXrEhiTnzIxGTS74oUPNMZw==
X-Received: by 2002:a1c:b656:: with SMTP id g83mr5563911wmf.151.1591296641446;
        Thu, 04 Jun 2020 11:50:41 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id d24sm8081830wmb.45.2020.06.04.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 11:50:40 -0700 (PDT)
Date:   Thu, 4 Jun 2020 14:50:37 -0400
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
Message-ID: <20200604145002-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010809-mutt-send-email-mst@kernel.org>
 <e722bb62-2a72-779a-f542-1096e8f609b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e722bb62-2a72-779a-f542-1096e8f609b8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:12:27PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午1:09, Michael S. Tsirkin wrote:
> > On Fri, May 29, 2020 at 04:03:02PM +0800, Jason Wang wrote:
> > > Note that since virtio specification does not support get/restore
> > > virtqueue state. So we can not use this driver for VM. This can be
> > > addressed by extending the virtio specification.
> > Looks like exactly the kind of hardware limitation VDPA is supposed to
> > paper over within guest. So I suggest we use this as
> > a litmus test, and find ways for VDPA to handle this without
> > spec changes.
> 
> 
> Yes, and just to confirm, do you think it's beneficial to extend virtio
> specification to support state get/set?
> 
> Thanks

Let's leave that for another day. For now vdpa should be flexible enough
to work on spec compliant VMs.

> 
> > 

