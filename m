Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D722A2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEVJjaKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHERVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728634AbgHERRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wryOIrrGjx7qHTonL03QxNMVi3GzMOIvfN7c2/DZ4s=;
        b=NEVJjaKPqP6OEUscpFv2MTMx9g7+xAXuHwL4p2KGMlCURbbxIPh3oR58CxOLoXIccchlIZ
        YmJXObQ7PCOPGmwZIJIG62evNNBU3gqBCSmKHCQezXsDqJHlzZBgZOI71E5Emht7+U2VrQ
        HR4f+ZkkHNjAjB9Smsu39NPdfGa6teQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-lRvZ2o2HM1WFPKOHNZYtJA-1; Wed, 05 Aug 2020 08:55:32 -0400
X-MC-Unique: lRvZ2o2HM1WFPKOHNZYtJA-1
Received: by mail-wr1-f72.google.com with SMTP id b13so10830996wrq.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wryOIrrGjx7qHTonL03QxNMVi3GzMOIvfN7c2/DZ4s=;
        b=WdqfjnGVcEtqXwhIfax+BCSmdP63Hiuiqwq3DEY1LaOYEwpkCwLv2SY9NSdlLchgg3
         4W3cMROu3axfxhzxAiw6dTju8QmxIOs1yKAEDDVA5GYOC8F61SW8+Q3Ndnzc0MZBI3kp
         zcnzYhC7ie/rsnHRzgCC1E9wFClV63UeUOnuhqwCX5tE/9oW9nr9IWedBgD+7srJbq3B
         FY4xpedMA1fWYpJb3oaLxcW9mMp42BPamK2Od5jmpCoh3X+kvd6zQRAeNeo2njKziNbp
         Jxkytb877l6gd02dmcswK/U2Ird1mmnKaDO4zBqz4LS/p+JS5PGz4XnVlOvjQPnm+Lk3
         A00A==
X-Gm-Message-State: AOAM533VTeM+QQ4qol8j3Pd+BAlsmLbpiy2ENUjbkDSpVLXB/is5o5qS
        O4j/hEXqUvzrVY94T9r0mehkpepeQ/WRkgtm2pW9yxiOgWlLGPXYq2vsF/FA89/7ZdsZOdFKRHe
        kWLP6PzqQmux0yXttzSlK/CGj
X-Received: by 2002:a5d:5641:: with SMTP id j1mr2726623wrw.399.1596632131183;
        Wed, 05 Aug 2020 05:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+d3vclQ9GPgtT3OT3+FcxmtxQjAU228iBaB3UFD2Bzh1BnV8/Gw9OtsyrBfKZn8DubjRAFQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1mr2726609wrw.399.1596632130998;
        Wed, 05 Aug 2020 05:55:30 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id 32sm2783363wrn.86.2020.08.05.05.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:55:30 -0700 (PDT)
Date:   Wed, 5 Aug 2020 08:55:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 3/4] vdpa: get_iova_range() is mandatory for device
 specific DMA translation
Message-ID: <20200805085217-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-4-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29:46AM +0800, Jason Wang wrote:
> In order to let userspace work correctly, get_iova_range() is a must
> for the device that has its own DMA translation logic.

I guess you mean for a device.

However in absence of ths op, I don't see what is wrong with just
assuming device can access any address.

> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index de211ef3738c..ab7af978ef70 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -82,6 +82,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	if (!!config->dma_map != !!config->dma_unmap)
>  		goto err;
>  
> +	if ((config->dma_map || config->set_map) &&
> +	    !config->get_iova_range)
> +		goto err;
> +
>  	err = -ENOMEM;
>  	vdev = kzalloc(size, GFP_KERNEL);
>  	if (!vdev)

What about devices using an IOMMU for translation?
IOMMUs generally have a limited IOVA range too, right?



> -- 
> 2.20.1

