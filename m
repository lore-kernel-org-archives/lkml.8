Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC2CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF102083B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+mVvmA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgFSLjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:39:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730919AbgFSLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592566752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9d0X2yH4PD3KFMTh5p2Qj9w09XEwXAFgHugUlN26sqY=;
        b=a+mVvmA5IU0w72mt/ZtIF44KoSxWULGTxda2/Qb5jUFTJlZJeiu2TFUGO3n2CfXREiYOO3
        bYTlx73Hal+qXQjeBGNyiVPk6lEo5HM4QzaeX7yhajZiipgHij8fCYdy2CQpPvGMJmPGjH
        RFQiE5tn4by2dlYVYUfEQL3VOcXeULM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-AD8_x1PcPRippbNcA5c55A-1; Fri, 19 Jun 2020 07:39:10 -0400
X-MC-Unique: AD8_x1PcPRippbNcA5c55A-1
Received: by mail-wr1-f72.google.com with SMTP id o25so2303970wro.16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9d0X2yH4PD3KFMTh5p2Qj9w09XEwXAFgHugUlN26sqY=;
        b=BryXpag8P0xXw2ba32JL2s5f7K5uXdKUTIO1aPM+pyUwNbPQWBJbLusFinnreud0q8
         VQKeHXWNMV2D/PnIaNuFjmnW/nRxm3/gJhXbMSMpauDN3IELWeqNyiW4Breczdg/jkQH
         KaZe7mCixoBH+EjIfhN2yKDsTBwQR8ruVpmyHUbugxHuGBsMJeWp8E4BLRO4hSRXE7IT
         K/Qe6minklivNaoFbFQCdrN+fZQlMHZkZy25Uo8yKizuOj75+7gdPSZuq9fY53JkHYvw
         Q/S7dUHHirqWGEoH3IU95cEh61rd/NKOU7oUNwBgFk71Labs5ylsOYqy7aTl5tvR2tVF
         HS8Q==
X-Gm-Message-State: AOAM533EhrmqZYwHVWQSkme79bL4+Pfmt/SnuEakBN5S3INPmUfhEClf
        1G9Ff98vuXO3zJHZUP/hngixxePnXLAUfc/MJZXtboDI2B23AckuTmS//I8rvFiWn5Trw1WO8EY
        wJ2ABbP57OO0PfYSWDXAIHzLx
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr2567538wrw.18.1592566749430;
        Fri, 19 Jun 2020 04:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcRzn891sh2mmuqWJN1VVmUBNitsV9W5VKxNvKYYNB1FoJVfn8DXQQL1zuCyP5PRvsbUnX8g==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr2567517wrw.18.1592566749259;
        Fri, 19 Jun 2020 04:39:09 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
        by smtp.gmail.com with ESMTPSA id k206sm6799460wma.39.2020.06.19.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 04:39:08 -0700 (PDT)
Date:   Fri, 19 Jun 2020 07:39:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        lizefan@huawei.com, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: Fix build error due to improper use 'select'
Message-ID: <20200619073841-mutt-send-email-mst@kernel.org>
References: <20200619080333.194753-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619080333.194753-1-chenweilong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:03:33PM +0800, Weilong Chen wrote:
> As noted in:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
> "select should be used with care. select will force a symbol to a
> value without visiting the dependencies."
> Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
> Otherwise it will cause an error:
> https://bugzilla.kernel.org/show_bug.cgi?id=208245
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

Cc virtio mem maintainer:
M:      David Hildenbrand <david@redhat.com>


> ---
>  drivers/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..5c92e4a50882 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -85,7 +85,7 @@ config VIRTIO_MEM
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG_SPARSE
>  	depends on MEMORY_HOTREMOVE
> -	select CONTIG_ALLOC
> +	depends on CONTIG_ALLOC
>  	help
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
> -- 
> 2.17.1

