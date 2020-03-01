Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB4C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50420857
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 07:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApgXQzmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgCAHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 02:32:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgCAHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 02:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583047959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3MMtrcMRfqYU2oZvn0CHa1Q2NrFI6ZpcljGvsY/uNA=;
        b=ApgXQzmLXHVWI3QHFWppZil2bnB6s+S775AUaZtNz2cSZUFnWnRbJT221no23YwpzjiW4h
        rQ8Dy4/0wfa3CrRqTle+XEeAy8iBhipyc+IxbjMOTZ0CCTOmW4ESd1LMwhHAhnKup6A9YW
        zrdQKZgnJxjV8D7t7arYIqlrkJBHz/I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-WLLadGc0OYOhbSTs-oW1ug-1; Sun, 01 Mar 2020 02:32:37 -0500
X-MC-Unique: WLLadGc0OYOhbSTs-oW1ug-1
Received: by mail-qv1-f69.google.com with SMTP id h17so1797725qvc.18
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 23:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3MMtrcMRfqYU2oZvn0CHa1Q2NrFI6ZpcljGvsY/uNA=;
        b=cUYkMxQnp0oCsPHf0NzNHHCWP8Y8Y9T04zqxeg2WqYaqH+2sGQEc4XvWowOrOA1slk
         ymSzdSafwKqaHOvibt8Xy/KqcQ/AghqIGwoSHJdXIR9+cQ5ePy9YiluLmXUTjr//qXvU
         LhG6UQg/OEevyaYQ3qNLJp5nSZIg/yu8VcrbhsRQtDVf0ppxigTFDo90+5eKYt5NYkmm
         mhtMRJfCqke/YH0GYpVZ5pLV8St6rrTM2lfUpEeIUZUzzDT0vpi6Ma6NJuIWCXfpkOQA
         YJox31EFHpXIKe+rDQE6Orj91bZVC9838DN5W+GWR+shmeo8Nn+efsY8U/D3yB1ibV35
         I4AA==
X-Gm-Message-State: APjAAAW8OJ7u/COVTxwhjQGAbNaaLNpDs5TcUELYY7Won7/RRDPCpaZk
        ZQ4WY6InExBhIH+aJngGONKkqb10V6deGMLMTsjLL7sWbro3bbXZZEZ7KHS2ZzV/JChO4yUTkZw
        3xsNpIMlbJaFiL3hRytvFF3cF
X-Received: by 2002:aed:2961:: with SMTP id s88mr9089083qtd.292.1583047957506;
        Sat, 29 Feb 2020 23:32:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4o0NEf1dzwXYaj5wYtjW9Bg5oEwnhhA9tWLJVrxErw/9mkSdYS/F6D4AtFN66bw9c8E/rYg==
X-Received: by 2002:aed:2961:: with SMTP id s88mr9089075qtd.292.1583047957280;
        Sat, 29 Feb 2020 23:32:37 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id f26sm7779304qtv.77.2020.02.29.23.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 23:32:35 -0800 (PST)
Date:   Sun, 1 Mar 2020 02:32:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ram Muthiah <rammuthiah@google.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from
 Kconfig
Message-ID: <20200301023025-mutt-send-email-mst@kernel.org>
References: <20200228232736.182780-1-rammuthiah@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228232736.182780-1-rammuthiah@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:27:36PM -0800, Ram Muthiah wrote:
> The legacy pci driver should no longer be default enabled. QEMU has
> implemented support for Virtio 1 for virtio-pci since June 2015
> on SHA dfb8e184db75.
> 
> Signed-off-by: Ram Muthiah <rammuthiah@google.com>

I see little reason to do this: y is safer and will boot on more
hypervisors, so people that aren't sure should enable it.

> ---
>  drivers/virtio/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615cf2afc..eacd0b90d32b 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -26,7 +26,6 @@ config VIRTIO_PCI
>  
>  config VIRTIO_PCI_LEGACY
>  	bool "Support for legacy virtio draft 0.9.X and older devices"
> -	default y
>  	depends on VIRTIO_PCI
>  	---help---
>            Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
> @@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
>  	  If disabled, you get a slightly smaller, non-transitional driver,
>  	  with no legacy compatibility.
>  
> -          So look out into your driveway.  Do you have a flying car?  If
> -          so, you can happily disable this option and virtio will not
> -          break.  Otherwise, leave it set.  Unless you're testing what
> -          life will be like in The Future.
> -
>  	  If unsure, say Y.
>  
>  config VIRTIO_PMEM
> -- 
> 2.25.0.265.gbab2e86ba0-goog

