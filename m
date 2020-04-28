Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BE62085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGrwQTpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD1UlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:41:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51321 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1UlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588106471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4eENH6tB0EGZ/BA2dzhb17ThkK45wZijHpRT5Rx0P7Q=;
        b=XGrwQTpu8pFriydV1NgZDH0yBZpe9wwndwTZClFps71bZnTf7NG9BkbtrFytEmF/aBJbOv
        pAIStCYapt0TkY8Ye4VlR86LXPitdO4QNZNCJ3c38LWX9osQQux3XiVEEOGDd9AEW4Jt3L
        xXZBp9/KC+kC3d8njgpvXgrbOoAKix8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-2fb_s1c8MjuFErkdhvxfKg-1; Tue, 28 Apr 2020 16:41:09 -0400
X-MC-Unique: 2fb_s1c8MjuFErkdhvxfKg-1
Received: by mail-wr1-f70.google.com with SMTP id a3so71163wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4eENH6tB0EGZ/BA2dzhb17ThkK45wZijHpRT5Rx0P7Q=;
        b=SKrn/aO1DY29b6ZjcThgl8aEjHP4DBwy/KF9UYsiNuwPRrTkWNl0I/myF9EsnVASnO
         YYoTwJ5t+c1Qga8Yfbp9iymQKczc2nSuXJl5IG5Q9UaMITSA3CtIiRwUOJHI6dRob+4C
         X/OAbLpLQKgW2/a86MeLkLBqyRFeZiy6VO0ZYwrIkyVdtqj32gIHUhyfAfIESxLlqzMi
         6TZB5CfQS/0QfdaGopSzL/GPOZFUIk3YKp2mYhjk7AqjkvfsKzt0pNPR3y2JL8VTS9qv
         uxPoujTPKAe52sdn6tzicl+jT2P5s28tjuxnkPSZC5hWHq7G6f8FnxUSYGrxrDGJ/jc7
         IyAQ==
X-Gm-Message-State: AGi0PuaZePdxC+L5sQvMtx2fcVdHnwJ45QCnAM5DD+uffIpD5WnMkB2t
        hHhBSC0hTXBLWEHefN66X7+gCv+DEpeHabXrgAmc+t+d0wfUTAKhalCwJEiOb/LfxIWGcp8k+H+
        60gLm9wPJbu75qmTXteQBdPay
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr35941303wrb.54.1588106468376;
        Tue, 28 Apr 2020 13:41:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ29J3wRFwAKcd5VfgZy6d80BpVLKwPqj7y7vEzsoMHleANkL6oMYbQYlmbWERgm90rIizbxg==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr35941287wrb.54.1588106468180;
        Tue, 28 Apr 2020 13:41:08 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id 33sm27359373wrp.5.2020.04.28.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:41:07 -0700 (PDT)
Date:   Tue, 28 Apr 2020 16:41:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200428163448-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428174952.GA5097@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> * Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:
> 
> > Okay, but how is all this virtio specific?  For example, why not allow
> > separate swiotlbs for any type of device?
> > For example, this might make sense if a given device is from a
> > different, less trusted vendor.
> 
> Is swiotlb commonly used for multiple devices that may be on different trust
> boundaries (and not behind a hardware iommu)?

Even a hardware iommu does not imply a 100% security from malicious
hardware. First lots of people use iommu=pt for performance reasons.
Second even without pt, unmaps are often batched, and sub-page buffers
might be used for DMA, so we are not 100% protected at all times.


> If so, then yes it sounds like a
> good application of multiple swiotlb pools.
> 
> > All this can then maybe be hidden behind the DMA API.
> 
> Won't we still need some changes to virtio to make use of its own pool (to
> bounce buffers)? Something similar to its own DMA ops proposed in this patch?

If you are doing this for all devices, you need to either find a way
to do this without chaning DMA ops, or by doing some automatic change
to all drivers.


> > > +void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
> > > +{
> > > +	if (!bounce_buf_paddr)
> > > +		return;
> > > +
> > > +	set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
> > 
> > 
> > I don't think DMA API maintainers will be happy with new users
> > of set_dma_ops.
> 
> Is there an alternate API that is more preffered?

all this is supposed to be part of DMA API itself. new drivers aren't
supposed to have custom DMA ops.

> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

