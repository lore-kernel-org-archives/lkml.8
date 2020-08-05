Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2307522CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRJ0YWpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHERZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:25:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20106 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728434AbgHERPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STRPg9BVyZpQBUjxmFISwRqEbAWE+bVhgTrTRTM6kiY=;
        b=VRJ0YWpQ0c+uP/Ryur/w7uLW71vp4g1RgsMpIO2s7gRtApGwh+olTcYZ5Hk+cSnYCQ7Q6u
        d4bXDDItqBdAxtGnfWNgTiXTG8/SnKbZm9Z62kHxrxkTClGioAhVDfDmqjwvuHKNyPwa+l
        z3TvFNoqnfJA+8KzhcBORmE73UDN5Kc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-yujJeULlM6ep_63dFh5SBg-1; Wed, 05 Aug 2020 08:52:02 -0400
X-MC-Unique: yujJeULlM6ep_63dFh5SBg-1
Received: by mail-wm1-f70.google.com with SMTP id z1so2674392wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STRPg9BVyZpQBUjxmFISwRqEbAWE+bVhgTrTRTM6kiY=;
        b=tErLCdiVGYs4bLyIHAEgLP9hxKU9Bhh4SZBz/JOazCFVc+vFkWNbfPYAKn3q8gjYoB
         n5S/nKbstMkc8Zx+yzDpJx+KwteVCPo/Eq15IcXCJ+uI1u0jVrLaArvzKil8US8vOupD
         yAfgIPYVQXRI3ls25UJ6xcJA1x8yO4jxs+xclX5cYwMq25bDvLrGupPBHlR3Yen+pOer
         jlJx+gijSfQHNIAxJldQG9YbGK5DBAqju2gLs2zY8Y4A0sHqCTxzYsvEZhMhzmlVlAY4
         dGu2kwvDp8SaIAFAqkDhGRQ3WqE/aRzOUv0K2jHeACEQkHoxj9i517W0UrNAILnr7qEu
         NPMw==
X-Gm-Message-State: AOAM530kjlr7ZcY+1zgcxhV4Ng1ysmyGcxbv1mi9Xl2ymzEsoXnZfe8g
        JdP/8iWbOyzTiePr7giokicybZh0oESODviRk2Y6qNcTkhySQsGCv24/SWbmvke9WSm3nW3MQkM
        kRoAf3eWWSbSaP7ETOjFsMrEd
X-Received: by 2002:adf:df91:: with SMTP id z17mr2983497wrl.149.1596631920758;
        Wed, 05 Aug 2020 05:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6umQ9Sab+V6SIKbgtKo5j71BttoOfNgpgZYy1vFuI8eJ1cruGln/hlGyt7wK7Wd/qXgH6+A==
X-Received: by 2002:adf:df91:: with SMTP id z17mr2983483wrl.149.1596631920602;
        Wed, 05 Aug 2020 05:52:00 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id p6sm2796795wmg.0.2020.08.05.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:51:59 -0700 (PDT)
Date:   Wed, 5 Aug 2020 08:51:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200805085035-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-2-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> This patch introduce a config op to get valid iova range from the vDPA
> device.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/vdpa.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db794357c..b7633ed2500c 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -41,6 +41,16 @@ struct vdpa_device {
>  	unsigned int index;
>  };
>  
> +/**
> + * vDPA IOVA range - the IOVA range support by the device
> + * @start: start of the IOVA range
> + * @end: end of the IOVA range
> + */
> +struct vdpa_iova_range {
> +	u64 start;
> +	u64 end;
> +};
> +


This is ambiguous. Is end in the range or just behind it?
How about first/last?



>  /**
>   * vDPA_config_ops - operations for configuring a vDPA device.
>   * Note: vDPA device drivers are required to implement all of the
> @@ -134,6 +144,9 @@ struct vdpa_device {
>   * @get_generation:		Get device config generation (optional)
>   *				@vdev: vdpa device
>   *				Returns u32: device generation
> + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> + *				@vdev: vdpa device
> + *				Returns the iova range supported by the device
>   * @set_map:			Set device memory mapping (optional)
>   *				Needed for device that using device
>   *				specific DMA translation (on-chip IOMMU)
> @@ -195,6 +208,7 @@ struct vdpa_config_ops {
>  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
>  			   const void *buf, unsigned int len);
>  	u32 (*get_generation)(struct vdpa_device *vdev);
> +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
>  
>  	/* DMA ops */
>  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> -- 
> 2.20.1

