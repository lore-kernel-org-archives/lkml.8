Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCCC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEC4206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um5htUAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgD2Gux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:50:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD2Guw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588143050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6znVgwkady/qyUcC0Ymv6eZmqJfdKpDAylZrbci5xI=;
        b=Um5htUAJ2VZu8FyejF842iCCwuyts9inT3FCYOoTD9gvb2UezeHOJztRHJCjTUZvFyM8iq
        yzL0aiTa/21rV4PX0RIK/PKhzMUClAiy8aimo3/DHq4m/6Zl1nRHiO2cikFxzc0wsgfyeR
        KUE5+PTCmPlMD0YQkesPbRAazsycJ30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-tsWh4ziFNRWRXhm15xen9w-1; Wed, 29 Apr 2020 02:50:47 -0400
X-MC-Unique: tsWh4ziFNRWRXhm15xen9w-1
Received: by mail-wm1-f69.google.com with SMTP id 71so622314wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 23:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6znVgwkady/qyUcC0Ymv6eZmqJfdKpDAylZrbci5xI=;
        b=K5TMA3QgUex3yYOF7mG7PkRdxUlNugdZzLz42E1f8x9AWNjGrXVklDtcJd0LFBwaTt
         nk2qhA3J5HbMxRjm9o9PlFcsyf9vjlFM7r92XNc79a/ZSYtQITJstS/pnTOH4ciO/hpu
         jPWGnTAqbg0SlNWYBCLn1D8kRSGfoiJ5As5ZlRZN5EXOJdZhlg8Y2TXH2k/bnBlx2Hsq
         sARxy9SB3bCBkX1U/sxApvGh+yMxnja+zN2BkjXKllpE8ig6Fmqe9U0wrA4dalXpEksR
         qqn/ejNnu8ctTYOXsSZwyz6fxuaS3uPoPGaxQ+0tUxBXLiN5B1Kim4WttSS+HdsbkrqB
         lkzA==
X-Gm-Message-State: AGi0PuYp+yKCb2Iw1H40uh9TTpe90Ye3IwpWBf5P+DBnZTRr0Uv0TTfg
        c4kyKh5Vwzzi546DDr21nXJ15Ep9JtstncYtgMkhKlIrSTcKKHqY9gEKipA2ej+fyfQrGbWzEW8
        zqu1S6RBbZDo3SaIMCefrl9a7
X-Received: by 2002:adf:ee05:: with SMTP id y5mr35944442wrn.176.1588143045963;
        Tue, 28 Apr 2020 23:50:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypKU82H1b9Eisqn07oeKyQe6zR7NModgo5aa23/Lf5/4LUDkNy1nlXScGKG6HiNZbbe2ek65jg==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr35944419wrn.176.1588143045703;
        Tue, 28 Apr 2020 23:50:45 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id g74sm6479515wme.44.2020.04.28.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 23:50:44 -0700 (PDT)
Date:   Wed, 29 Apr 2020 02:50:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Srivatsa Vaddagiri <vatsa@codeaurora.org>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429023842-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 01:42:13PM +0800, Lu Baolu wrote:
> On 2020/4/29 12:57, Michael S. Tsirkin wrote:
> > On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
> > > On 2020/4/29 4:41, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > > > > * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
> > > > > 
> > > > > > Okay, but how is all this virtio specific?  For example, why not allow
> > > > > > separate swiotlbs for any type of device?
> > > > > > For example, this might make sense if a given device is from a
> > > > > > different, less trusted vendor.
> > > > > Is swiotlb commonly used for multiple devices that may be on different trust
> > > > > boundaries (and not behind a hardware iommu)?
> > > > Even a hardware iommu does not imply a 100% security from malicious
> > > > hardware. First lots of people use iommu=pt for performance reasons.
> > > > Second even without pt, unmaps are often batched, and sub-page buffers
> > > > might be used for DMA, so we are not 100% protected at all times.
> > > > 
> > > 
> > > For untrusted devices, IOMMU is forced on even iommu=pt is used;
> > 
> > I think you are talking about untrusted *drivers* like with VFIO.
> 
> No. I am talking about untrusted devices like thunderbolt peripherals.
> We always trust drivers hosted in kernel and the DMA APIs are designed
> for them, right?
> 
> Please refer to this series.
> 
> https://lkml.org/lkml/2019/9/6/39
> 
> Best regards,
> baolu

Oh, thanks for that! I didn't realize Linux is doing this.

So it seems that with modern Linux, all one needs
to do on x86 is mark the device as untrusted.
It's already possible to do this with ACPI and with OF - would that be
sufficient for achieving what this patchset is trying to do?

Adding more ways to mark a device as untrusted, and adding
support for more platforms to use bounce buffers
sounds like a reasonable thing to do.

> > 
> > On the other hand, I am talking about things like thunderbolt
> > peripherals being less trusted than on-board ones.
> 
> 
> 
> > 
> > Or possibly even using swiotlb for specific use-cases where
> > speed is less of an issue.
> > 
> > E.g. my wifi is pretty slow anyway, and that card is exposed to
> > malicious actors all the time, put just that behind swiotlb
> > for security, and leave my graphics card with pt since
> > I'm trusting it with secrets anyway.
> > 
> > 
> > > and
> > > iotlb flush is in strict mode (no batched flushes); ATS is also not
> > > allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
> > > only apply page granularity protection. Swiotlb is now used for devices
> > > from different trust zone.
> > > 
> > > Best regards,
> > > baolu
> > 

