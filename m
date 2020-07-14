Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BDC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBBB20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LudDbIpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgGNIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73S/IVSRb41NQET//LecZg2QFojO2k5JSxkBwEYr01g=;
        b=LudDbIpb2+K6okx1k8v4M2w9GXHsTvGZkW3M7c58022E+81yNgR1BeLrU3JpE3UaQnn4iH
        9E2DkUSyHJpBUPuPljfq6s9YeIeD2K/SJQqgux1iqF9Rij7/oNuCC4mm8pIxK2dPfLefEC
        z9ljXI/MiCEQ7XG34K1UOj0RyVfKetw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-HwICBWc-OdGPqL68_hNR7w-1; Tue, 14 Jul 2020 04:55:08 -0400
X-MC-Unique: HwICBWc-OdGPqL68_hNR7w-1
Received: by mail-wr1-f72.google.com with SMTP id d11so20787487wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73S/IVSRb41NQET//LecZg2QFojO2k5JSxkBwEYr01g=;
        b=fUr3S6+cLy69qDXjDzfpPBfkZcBzSiBH3Yo5qavHlWCLTdQzZA1BUwROHDHIXNqHi1
         V8jaS10xc/HNCntIns/N2uelf4cjcuxVWghla/2cyx26LDi+I6f8IJ7JgLUuLWL0XoLM
         l+xG+QmPZBanIXoLVqUF+z9lernoNdDwBA0HfhTcMa20wVf05St/0BJ+sU41lBWAW14+
         mw03cLk2SagZkWT7YKvfOegkv88e9MA50fLjIHgtHV/YMBb9bppyCj1++1n3Y3hQ4/wy
         +RhHn2lnfoLYqn4TIADQXGWCKp4rxUaygNpARFP6E//sBXb7IJIVrpbqfXLQVJTA0LEU
         qs9g==
X-Gm-Message-State: AOAM533TnW0N5OlL9UA4pUIamU7DWsDMKgsVcfkdmn9W6YWNhm60hhJc
        XCh7Vhx3EYw2oeCGwi4Hp48//PN5Gs17aYdlQPO33DSGqG1+jxoUoHYzdZG4ntSntffEEZA1r3g
        /+km0/j8nqCogvpA5I6wmwIfZ
X-Received: by 2002:adf:9404:: with SMTP id 4mr3804662wrq.367.1594716907283;
        Tue, 14 Jul 2020 01:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpc9sR4tw7tvh47yW+jR4/3qcFEgQli9j7i7YqnWb9GTJR0Kq/zgQzCdCvkqBfrz3On5f+uw==
X-Received: by 2002:adf:9404:: with SMTP id 4mr3804647wrq.367.1594716907130;
        Tue, 14 Jul 2020 01:55:07 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id n5sm3324370wmi.34.2020.07.14.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:55:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 04:55:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH] virtio-balloon: Document byte ordering of poison_val
Message-ID: <20200714045454-mutt-send-email-mst@kernel.org>
References: <20200713203539.17140.71425.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713203539.17140.71425.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:35:39PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The poison_val field in the virtio_balloon_config is treated as a
> little-endian field by the host. Since we are currently only having to deal
> with a single byte poison value this isn't a problem, however if the value
> should ever expand it would cause byte ordering issues. Document that in
> the code so that we know that if the value should ever expand we need to
> byte swap the value on big-endian architectures.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Queued, thanks!

> ---
>  drivers/virtio/virtio_balloon.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1f157d2f4952..d0fd8f8dc6ed 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -974,6 +974,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		/*
>  		 * Let the hypervisor know that we are expecting a
>  		 * specific value to be written back in balloon pages.
> +		 *
> +		 * If the PAGE_POISON value was larger than a byte we would
> +		 * need to byte swap poison_val here to guarantee it is
> +		 * little-endian. However for now it is a single byte so we
> +		 * can pass it as-is.
>  		 */
>  		if (!want_init_on_free())
>  			memset(&poison_val, PAGE_POISON, sizeof(poison_val));

