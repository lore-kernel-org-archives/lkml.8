Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599B520786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqT9OFjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgHFRFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:05:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729919AbgHFREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596733446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nr31koH93+WFCQ1SShZUdSdGjjcRGiTN1IIFjT+aQyE=;
        b=dqT9OFjh82/6i2QXXKfTijTmXIgVx/zrnr1ljxrfCv1lQBLf63FQhf0+dUbD/bZvygaHmH
        5U4n7biRHtWgHtV+a5+3rKVVDcF3zSYSN/xHICDJVLrP/Q8XuuHwbhIkDNSBstSPSuXawU
        6TPCm8QtL8+aM7DfhtJ24Jh5eIQ4LFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-lN1pkvlkPziGH4o2l1s80Q-1; Thu, 06 Aug 2020 08:29:29 -0400
X-MC-Unique: lN1pkvlkPziGH4o2l1s80Q-1
Received: by mail-wr1-f69.google.com with SMTP id w7so12337662wre.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nr31koH93+WFCQ1SShZUdSdGjjcRGiTN1IIFjT+aQyE=;
        b=Iy6Q+H+BJq8iogLrTm18DhdOlZI/8O7gu8oJC1Dv7IC9BynpZ00TRRMYLhH0plr0kN
         zGNXchFdTEt+8uGPq2VTNsVkbw2w9EunXLOD0WC6kgixHnu68KmTYkFK//4d1Kl0Cnq2
         PR5WqAQzImJiN93O0OTfr5f3QHmpUIhugccQmBABdhJ8GOamJxZOa0vUMAy7fpbqwu8E
         KwmQ2NcEq6Wy6BozApBKJf8/3Y0K2zMJcRbDvr19dZ0HsWfTvHUbTk9eaYm6/dx2R8Nl
         FxLcPp23juVt8JQ8rYPAB2Rzr6N3luFaywBAtDOSRGwcNJUjaWz7ZsXH9p5FT2ZTiWkd
         AhIw==
X-Gm-Message-State: AOAM530OeXVRmwtXeeIyG9oQysaEaTkrw3QKRBJANHUzPnKbQ//PjOJ4
        V+NjN+7nufabGt0BnutPZsJhkLcDsLe54QJ+9PwCYRmmIli6kNJMi6VLpqS+JHLBTesVAEWk/Rj
        j2A5a41A0ZQ0QghLTSXQm1zo1
X-Received: by 2002:adf:ef44:: with SMTP id c4mr7084614wrp.84.1596716968174;
        Thu, 06 Aug 2020 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ4+AA6iquJ/sckIZtxP+kOJp4F9JmrvFvoL/Ez3y4VOCxeSwNfgBeYWoNlFlzVDFCbQoFrw==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr7084593wrp.84.1596716967976;
        Thu, 06 Aug 2020 05:29:27 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id z8sm6159274wmf.42.2020.08.06.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 05:29:26 -0700 (PDT)
Date:   Thu, 6 Aug 2020 08:29:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806082727-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > This patch introduce a config op to get valid iova range from the vDPA
> > > device.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  include/linux/vdpa.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 239db794357c..b7633ed2500c 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > >  	unsigned int index;
> > >  };
> > >  
> > > +/**
> > > + * vDPA IOVA range - the IOVA range support by the device
> > > + * @start: start of the IOVA range
> > > + * @end: end of the IOVA range
> > > + */
> > > +struct vdpa_iova_range {
> > > +	u64 start;
> > > +	u64 end;
> > > +};
> > > +
> > 
> > 
> > This is ambiguous. Is end in the range or just behind it?
> > How about first/last?
> 
> It is customary in the kernel to use start-end where end corresponds to
> the byte following the last in the range. See struct vm_area_struct
> vm_start and vm_end fields

Exactly my point:

include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address

in this case Jason wants it to be the last byte, not one behind.


> > 
> > 
> > 
> > >  /**
> > >   * vDPA_config_ops - operations for configuring a vDPA device.
> > >   * Note: vDPA device drivers are required to implement all of the
> > > @@ -134,6 +144,9 @@ struct vdpa_device {
> > >   * @get_generation:		Get device config generation (optional)
> > >   *				@vdev: vdpa device
> > >   *				Returns u32: device generation
> > > + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> > > + *				@vdev: vdpa device
> > > + *				Returns the iova range supported by the device
> > >   * @set_map:			Set device memory mapping (optional)
> > >   *				Needed for device that using device
> > >   *				specific DMA translation (on-chip IOMMU)
> > > @@ -195,6 +208,7 @@ struct vdpa_config_ops {
> > >  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
> > >  			   const void *buf, unsigned int len);
> > >  	u32 (*get_generation)(struct vdpa_device *vdev);
> > > +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > >  
> > >  	/* DMA ops */
> > >  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > -- 
> > > 2.20.1
> > 

