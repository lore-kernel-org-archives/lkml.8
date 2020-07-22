Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BED20729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDca0dIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgGVLqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:46:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726503AbgGVLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595418403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VA50D44PwP36EMatm3r8jkryzFI+xci/xyxPDoYxEHw=;
        b=CDca0dIawbO/q/8JOMnNOsHXDDSsCa6K74P5unPd8U/NHnt48jntlIpUw8py/kvWDYNXJL
        OsumW9kDsD9pLm2ngElLLMMkKVtcKZ1n+O6jGC4v4MH9f7wrnFZSFq4N5XWDtDWvbOJzGP
        0Qih+B6mekM1gLUryQr7xhQqqaGTbCY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-Ksn9SZTxPyqsU9MeeGIg9g-1; Wed, 22 Jul 2020 07:46:41 -0400
X-MC-Unique: Ksn9SZTxPyqsU9MeeGIg9g-1
Received: by mail-wr1-f72.google.com with SMTP id 5so518877wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VA50D44PwP36EMatm3r8jkryzFI+xci/xyxPDoYxEHw=;
        b=j3jzInXxEbalzjMODcNhJ73yRTHneW9KV8H50iyfF3OZNmDO6k9X8hi+LeQ3kftpGF
         R+/r4PsAXQd0kt128vc4qhwX7H+J1O10LKkL3Ele+31JKazFEmhEaLeWEEqcYO3WoLNQ
         dQ6V7FD9WXQloVlWfKI38k0ycgZDqiiP9SBebvw48Nl6kJgDSXUbd7Ro4Dx6Z10hRMUB
         5PfX4fXCkjRvay2Xm8SP9M5hq/7vfbJWBar17jEB8tPfpj8GOtM3epJNslWodPqDEufX
         P2AbHT+BXBXKp9XVb79Ofrvhrs2ekLSXGZQLhyan5D5KHVzwBr8N1S8bT7E0AEiDez7b
         aIKw==
X-Gm-Message-State: AOAM532NEKvCd5AS6Z2fZlrGL45ACOEDdRjtIsU5dKu0IZdXcABwSBcf
        cyIb3FT9V7zGU+4eQYLMBV1CKwsodGXKTEWfqKrOhEEitdqlJP7LUDsTO9bamKSWiTLN1pVKN5R
        1DrHOCahw+N1bg2Ni+SkAsp3e
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr14890862wrw.70.1595418400764;
        Wed, 22 Jul 2020 04:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT9fHDPnqPq43vdSPvjeRis+cuUR2jlT9N/471iNd7v56L0Upt0p7rdaoBly9Dp9gOrJm4TA==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr14890841wrw.70.1595418400524;
        Wed, 22 Jul 2020 04:46:40 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id 5sm6787929wmk.9.2020.07.22.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:46:39 -0700 (PDT)
Date:   Wed, 22 Jul 2020 07:46:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
Message-ID: <20200722074630-mutt-send-email-mst@kernel.org>
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701221040.3667868-3-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:10:40PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The "virtio_mmio.device=" command line argument allows a user to specify
> the size, address, and IRQ of a virtio device.  Previously the only
> requirement for the IRQ was that it be an unsigned integer.
> 
> Zero is an unsigned integer but an invalid IRQ number, and after
> a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> attempts to use IRQ 0 cause warnings.
> 
> If the user specifies IRQ 0, return failure instead of registering a device
> with IRQ 0.
> 
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 9d16aaffca9d..627ac0487494 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
>  			&vm_cmdline_id, &consumed);
>  
>  	/*
> -	 * sscanf() must processes at least 2 chunks; also there
> +	 * sscanf() must process at least 2 chunks; also there
>  	 * must be no extra characters after the last chunk, so
>  	 * str[consumed] must be '\0'
>  	 */
> -	if (processed < 2 || str[consumed])
> +	if (processed < 2 || str[consumed] || irq == 0)
>  		return -EINVAL;
>  
>  	resources[0].flags = IORESOURCE_MEM;
> -- 
> 2.25.1

