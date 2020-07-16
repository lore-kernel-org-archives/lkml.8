Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9632C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDA0207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzYdJTqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGPVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:46:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgGPVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594935983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEo6DsOD3gtcpeqatc/jWU3HzAeT6ubK4oUjqlbQ034=;
        b=ZzYdJTqBcoRbBkP7QZdrktSO39GYoDQ1TTyaKvhVA7nF0B2KGthyCG/tUqVHB/1N7zJwqs
        kSJ02ArN2cQbk1lFf6gvM9wxQnJ4u+wQAeTSpisbYPa9I8/8i7QwH5PXWBFXBjOvz0DLp3
        4vdFmWTOazjnKe6EpGoKegSOw0Y+b5U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zClFBwsDO62qMaDyt9VNFQ-1; Thu, 16 Jul 2020 17:46:21 -0400
X-MC-Unique: zClFBwsDO62qMaDyt9VNFQ-1
Received: by mail-wr1-f71.google.com with SMTP id f5so6262938wrv.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BEo6DsOD3gtcpeqatc/jWU3HzAeT6ubK4oUjqlbQ034=;
        b=MklnkcnKSP6aHIKp3fsBBD76ME0g4j09I6SZbNblwjgFGPehfkmmKgrgIPprhcTjZL
         Xv338K+i2jAF0DRufed9l6SvREbRxmlOKXnseTWzEyyzWHcFtpm67FxplL4OXkLAsD7J
         moa8JawWPrG+icdX6Q+jsCqVwAnV6hMzu9ORpK+FussupGD7mxKgQoF+tbgP7vZcAQAD
         0e9fAA4w+vBVnbW+a7tpvWFZUPOJ+YqtRbMnwWOl6OtqW1AXnaAI1AIroW6OeQsMdBZr
         eBf9iUqLFjzJM0ynXRH7p8LHy1q4PdGCmBGS/h8iNVM692r7+jLrOB7fc4l43PygCxgK
         dIZA==
X-Gm-Message-State: AOAM532+IUNiB37J3cy9iCHFJ6q5r+JDihU78fjLWV9ZfP76mEL3NYYx
        iufKs6SPMiYePrNfyRukiYA7XysVhZhrkTYiJHrYTCb+izSmS6pt/nHBdFW4FUfMkoVp//cgzOm
        UCWcaaXG/V1xDfFwW+u7F+nmp
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr5994134wma.24.1594935980615;
        Thu, 16 Jul 2020 14:46:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykF2SVrQjmKDsKZhICrs30JZzeJmmbjM8l48AsSy4p8sKCLYwCNUjd1Gwxnb6QBEg+LM58nw==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr5994113wma.24.1594935980304;
        Thu, 16 Jul 2020 14:46:20 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id k4sm10900176wrp.86.2020.07.16.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:46:19 -0700 (PDT)
Date:   Thu, 16 Jul 2020 17:46:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200716174603-mutt-send-email-mst@kernel.org>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
 <20200715054807-mutt-send-email-mst@kernel.org>
 <bc5e09ad-faaf-8b38-83e0-5f4a4b1daeb0@redhat.com>
 <20200715074917-mutt-send-email-mst@kernel.org>
 <3782338a-6491-dc35-7c66-97b91a20df0d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3782338a-6491-dc35-7c66-97b91a20df0d@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:19:55PM +0200, Christian Borntraeger wrote:
> 
> 
> On 15.07.20 13:51, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2020 at 06:16:59PM +0800, Jason Wang wrote:
> >>
> >> On 2020/7/15 下午5:50, Michael S. Tsirkin wrote:
> >>> On Wed, Jul 15, 2020 at 10:31:09AM +0200, Pierre Morel wrote:
> >>>> If protected virtualization is active on s390, the virtio queues are
> >>>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> >>>> negotiated. Use the new arch_validate_virtio_features() interface to
> >>>> fail probe if that's not the case, preventing a host error on access
> >>>> attempt.
> >>>>
> >>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >>>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> >>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>> ---
> >>>>   arch/s390/mm/init.c | 28 ++++++++++++++++++++++++++++
> >>>>   1 file changed, 28 insertions(+)
> >>>>
> >>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> >>>> index 6dc7c3b60ef6..d39af6554d4f 100644
> >>>> --- a/arch/s390/mm/init.c
> >>>> +++ b/arch/s390/mm/init.c
> >>>> @@ -45,6 +45,7 @@
> >>>>   #include <asm/kasan.h>
> >>>>   #include <asm/dma-mapping.h>
> >>>>   #include <asm/uv.h>
> >>>> +#include <linux/virtio_config.h>
> >>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
> >>>> @@ -161,6 +162,33 @@ bool force_dma_unencrypted(struct device *dev)
> >>>>   	return is_prot_virt_guest();
> >>>>   }
> >>>> +/*
> >>>> + * arch_validate_virtio_features
> >>>> + * @dev: the VIRTIO device being added
> >>>> + *
> >>>> + * Return an error if required features are missing on a guest running
> >>>> + * with protected virtualization.
> >>>> + */
> >>>> +int arch_validate_virtio_features(struct virtio_device *dev)
> >>>> +{
> >>>> +	if (!is_prot_virt_guest())
> >>>> +		return 0;
> >>>> +
> >>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> >>>> +		dev_warn(&dev->dev,
> >>>> +			 "legacy virtio not supported with protected virtualization\n");
> >>>> +		return -ENODEV;
> >>>> +	}
> >>>> +
> >>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> >>>> +		dev_warn(&dev->dev,
> >>>> +			 "support for limited memory access required for protected virtualization\n");
> >>>> +		return -ENODEV;
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>>   /* protected virtualization */
> >>>>   static void pv_init(void)
> >>>>   {
> >>> What bothers me here is that arch code depends on virtio now.
> >>> It works even with a modular virtio when functions are inline,
> >>> but it seems fragile: e.g. it breaks virtio as an out of tree module,
> >>> since layout of struct virtio_device can change.
> >>
> 
> If you prefer that, we can simply create an arch/s390/kernel/virtio.c ?

How would that address the issues above?

