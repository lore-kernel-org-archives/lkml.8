Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA492064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsBG/Joa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgGOJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:50:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37679 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730854AbgGOJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594806626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ydFttueMnB9QE50pbDSZfOaR6o6M8obgxaWHaidDG2Q=;
        b=JsBG/JoarJjE3JQ323TT1hl+KmO+sc9Ws1cUt9TjQYpiNr2CRtB76zAxu8GuT1JqaSImBJ
        NaA3NIo0eIfMJy2ZGywoZDx4acMZwpO7zZBPVT2y5XgYZZ55F4/emuFYjL5fqVa6hBQXFv
        d6j85TyY93c2D9uQmrrNgMnHPlIfHZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-uxPjGXBKNiiHSzCq9BQV7A-1; Wed, 15 Jul 2020 05:50:24 -0400
X-MC-Unique: uxPjGXBKNiiHSzCq9BQV7A-1
Received: by mail-wr1-f69.google.com with SMTP id s16so682339wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ydFttueMnB9QE50pbDSZfOaR6o6M8obgxaWHaidDG2Q=;
        b=K9g76k2UjMvMph2jEmNI2tHUcAQ1UsuvKbwfAFIXaFb9PWXkzYMmdFqt+tAZpWPQGZ
         R6EBi/1SL+cnnrpUPMIWcb0LVq/P28Lv+cTnwT8q0vgFyFWNY289dLgjeUYR5etSVvoi
         B1Dcmg3c7NvKvxb2nKB9ArIE3tGtvCReVmZgkdSxu4u+1LV8x2ILrwK+IcTpilNuv9hZ
         Kjf1mkoToD48xRg5e1VdbM/5epQyxuEf6c2bYYox1a+tUpkjm8ZfVQyfv9KmCYsNsqGd
         SSPWJrC+3WecQccWCjBT1MKZwJ5pgBMoAL0p0iru9gWUOG/2eURVOdkr0BT0LudT9mu4
         rxxA==
X-Gm-Message-State: AOAM531hzg38+6L1PHkba4OCTmfWsuKPYkJw+WJ04FTW4GRI26QNbpZZ
        LsT349fxW6TW09L8MUs9Wdvd7te1zmY2Wlf5KBev0gyrqGj5fEsaMndov4MjkzKt46Sy30BU2ru
        AUAxKiSROpZknivoOBxBtrlT8
X-Received: by 2002:a5d:4607:: with SMTP id t7mr11055298wrq.251.1594806623783;
        Wed, 15 Jul 2020 02:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw20b6gyhY20GeUJvuPDUu72KPwVkCnwFQFKSJcxw9a/Ovrygxf08Gs5s2zyW8+HvaG4R7Z8Q==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr11055275wrq.251.1594806623576;
        Wed, 15 Jul 2020 02:50:23 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id 14sm2563305wmk.19.2020.07.15.02.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:50:22 -0700 (PDT)
Date:   Wed, 15 Jul 2020 05:50:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200715054807-mutt-send-email-mst@kernel.org>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:31:09AM +0200, Pierre Morel wrote:
> If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated. Use the new arch_validate_virtio_features() interface to
> fail probe if that's not the case, preventing a host error on access
> attempt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/init.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 6dc7c3b60ef6..d39af6554d4f 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -45,6 +45,7 @@
>  #include <asm/kasan.h>
>  #include <asm/dma-mapping.h>
>  #include <asm/uv.h>
> +#include <linux/virtio_config.h>
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  
> @@ -161,6 +162,33 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>  
> +/*
> + * arch_validate_virtio_features
> + * @dev: the VIRTIO device being added
> + *
> + * Return an error if required features are missing on a guest running
> + * with protected virtualization.
> + */
> +int arch_validate_virtio_features(struct virtio_device *dev)
> +{
> +	if (!is_prot_virt_guest())
> +		return 0;
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +		dev_warn(&dev->dev,
> +			 "legacy virtio not supported with protected virtualization\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "support for limited memory access required for protected virtualization\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {

What bothers me here is that arch code depends on virtio now.
It works even with a modular virtio when functions are inline,
but it seems fragile: e.g. it breaks virtio as an out of tree module,
since layout of struct virtio_device can change.

I'm not sure what to do with this yet, will try to think about it
over the weekend. Thanks!


> -- 
> 2.25.1

