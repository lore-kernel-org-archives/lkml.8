Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5011FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2436720678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5UU5b+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbgDBNGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:06:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387580AbgDBNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrC91KuPE6k3Jhp+uJLt4SSvrtT8vBXML157M+Ugy6U=;
        b=g5UU5b+A3nAWyad+35py6y4m3JBxJR7kcKh5i6peOaTYGKz7P1vophMZTLnyFvnTx/rAL4
        B1Q2QSwH/6L08KT6iP57QciQeYR+9zPx52rIgLAMS/txpweaMFDsIfGroNppL68cB3zNBp
        T1MJ4+4N6jzQAttn6qR0QtfyLN1Mkf0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-3TEbypSmPauVlZJCVNeXDg-1; Thu, 02 Apr 2020 09:06:50 -0400
X-MC-Unique: 3TEbypSmPauVlZJCVNeXDg-1
Received: by mail-qk1-f199.google.com with SMTP id 187so2949731qkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrC91KuPE6k3Jhp+uJLt4SSvrtT8vBXML157M+Ugy6U=;
        b=rzYn17u9you80Y9XmzamOhODyrRiZf2HAq10C7hZEWjox2pFiPzgvKjeKG1kCVpcDn
         Ae9EF4J3712FPd+/DSasD1hOm5c2swoVJIFzdL28VsXW/YlUxPRiRFTKuv16Sl46DSQa
         GB6fQSzMxWrdaGNN2TfRvEASg/iFtzSLuUh6pK+SKdWgguYKtZ4TWO+GplAfElX3CG8T
         r6Qmt5ZaNMjTzXbSfsiVTziDIaWInPy+k6m921AExfng2VOANSXe3EfvV8nvkqPlBtkc
         dzd0jwlVwczvBFKTd69VLYtC6i2yn0CZ7VltWha3naNLiQRsMZ4dBG812y/Zfts/wo1E
         4nDw==
X-Gm-Message-State: AGi0PuYyI52VkzazyJMagAwWBXdw2CtJnBI7iPuv79q11VaeT3pW5Q/H
        r0cF6sRFb+avgCM3WJPUQcr+/BfAXlVXwgjRDwF/SHZhQ05PH68JcKHp6in9a9htBZ6bN6jY40o
        O1yfAx5MLMN3xUs09Ld3l4fUR
X-Received: by 2002:aed:3221:: with SMTP id y30mr2697921qtd.199.1585832806833;
        Thu, 02 Apr 2020 06:06:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypLglyzvuTR1yyzvDP10Ld4UV7njgo1av3F3+XpjVKRvR2Mjvu+DmlUsk/d6U6D9AcRrLED1zg==
X-Received: by 2002:aed:3221:: with SMTP id y30mr2697623qtd.199.1585832804115;
        Thu, 02 Apr 2020 06:06:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id o186sm3450365qke.39.2020.04.02.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 06:06:43 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:06:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] virtio-balloon: Make virtballoon_free_page_report
 static
Message-ID: <20200402090550-mutt-send-email-mst@kernel.org>
References: <20200402024302.35192-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402024302.35192-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:43:02AM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/virtio/virtio_balloon.c:168:5: warning:
>  symbol 'virtballoon_free_page_report' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This is for the mm tree right? You need to tag the subject
appropriately and copy the relevant lists.

> ---
>  drivers/virtio/virtio_balloon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 0ef16566c3f3..bc10f94718e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -165,8 +165,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  
>  }
>  
> +static
>  int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> -				   struct scatterlist *sg, unsigned int nents)
> +				 struct scatterlist *sg, unsigned int nents)
>  {
>  	struct virtio_balloon *vb =
>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
> -- 
> 2.17.1
> 

