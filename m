Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728CC4345A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD60B22D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpd4ctnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgHFKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:04:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729289AbgHFKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596708027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OndzkDmNcgoNifiVvnQ+KZRjYfgTXWBU8ZH831EcGLA=;
        b=fpd4ctnjqxoKlkASyYkbfYgqlojy2pKz5NlJJyRzgNDxxErkXg2NKsfqWwuWVL7TWuZRLo
        OPRVRb4Qwo1FqR+eQ0ed9/za1vXcFe3lGCSB7/bzod8V2oi6MtllI0+1qKk5RUK8RAamVr
        lcjvDCFeHMXeQ553Z4gPS2cj0qqx6AU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-4OTyKbREO_6sna_L6eQh3A-1; Thu, 06 Aug 2020 06:00:25 -0400
X-MC-Unique: 4OTyKbREO_6sna_L6eQh3A-1
Received: by mail-wm1-f69.google.com with SMTP id q15so3910074wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OndzkDmNcgoNifiVvnQ+KZRjYfgTXWBU8ZH831EcGLA=;
        b=B7CClfPKwkcCZYuvyFFY+hwbtPA8OgdtbfLyWZu/uBkDQ++o0t8Ms5kAB4lkXwsGF4
         RbfHT2MwkTO7fZJonQXI2EZPUxp08UZOePNIqz+1VL1BFqXxns0CCALraHKMb3xpr9vR
         KFcA3CycCaItiE+F110GQAModgjOfYCa0gsX3nhQJ9Xv2ml03pQvuhTXqndtM7eKJQNE
         wln15BlKcm/uCX0ZtXmI7yBaDtjAHXsMp+7/kbpTrZPfUSb/Y5iADTuBRqka/z7Rb8we
         spVMQo1OKZxT9o1cttCDGFaEG6xcFxjo6kBSueBUgvsDkBZftv6MPom4MLuFIT91TYhS
         dg2w==
X-Gm-Message-State: AOAM5313iaxVvC+Qv1FGREh8Wc6ol+JwZMiAMQRdbZP6IqDmyjKK1yiH
        l0sQGLpT2rsex/z1YP+t5gxd8EVMiSMylAlda81YYPmqVxlatJd6i80cDIF+GjAbGITaGhRxg30
        yjZ3S4eYf3LAX3M60bREfIxnk
X-Received: by 2002:adf:a35e:: with SMTP id d30mr7131954wrb.53.1596708024438;
        Thu, 06 Aug 2020 03:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5PxHtKOZg3btYcrqVmyb7L9kNpR4DBCaDwStXUxvVDuujSnEeCKFRtxCmXegq8/gGKsNKQg==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr7131930wrb.53.1596708024241;
        Thu, 06 Aug 2020 03:00:24 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id z6sm6435422wml.41.2020.08.06.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:00:23 -0700 (PDT)
Date:   Thu, 6 Aug 2020 06:00:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200806055818-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
 <20200806015112-mutt-send-email-mst@kernel.org>
 <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:27:38PM +0800, Jason Wang wrote:
> 
> On 2020/8/6 下午1:53, Michael S. Tsirkin wrote:
> > On Thu, Aug 06, 2020 at 11:23:05AM +0800, Jason Wang wrote:
> > > On 2020/8/5 下午7:40, Michael S. Tsirkin wrote:
> > > > On Wed, Aug 05, 2020 at 02:14:07PM +0800, Jason Wang wrote:
> > > > > On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
> > > > > > Some legacy guests just assume features are 0 after reset.
> > > > > > We detect that config space is accessed before features are
> > > > > > set and set features to 0 automatically.
> > > > > > Note: some legacy guests might not even access config space, if this is
> > > > > > reported in the field we might need to catch a kick to handle these.
> > > > > I wonder whether it's easier to just support modern device?
> > > > > 
> > > > > Thanks
> > > > Well hardware vendors are I think interested in supporting legacy
> > > > guests. Limiting vdpa to modern only would make it uncompetitive.
> > > 
> > > My understanding is that, IOMMU_PLATFORM is mandatory for hardware vDPA to
> > > work.
> > Hmm I don't really see why. Assume host maps guest memory properly,
> > VM does not have an IOMMU, legacy guest can just work.
> 
> 
> Yes, guest may not set IOMMU_PLATFORM.
> 
> 
> > 
> > Care explaining what's wrong with this picture?
> 
> 
> The problem is virtio_vdpa, without IOMMU_PLATFORM it uses PA which can not
> work if IOMMU is enabled.
> 
> Thanks

So that's a virtio_vdpa limitation. In the same way, if a device
does not have an on-device iommu *and* is not behind an iommu,
then vdpa can't bind to it.

But this virtio_vdpa specific hack does not belong in a generic vdpa code.

> 
> > 
> > 
> > > So it can only work for modern device ...
> > > 
> > > Thanks
> > > 
> > > 
> > > > 
> > > > 

