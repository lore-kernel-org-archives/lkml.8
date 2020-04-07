Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427FCC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CDC20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj24B2Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDGKBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:01:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728189AbgDGKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586253690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=072pIwxp+i9xdZgez7LPJl0p0p/jipVd9TvhmmVdjNw=;
        b=Bj24B2Me/cQrfMMGFYQ4/xTQf7J5ZAx1ZDgt8qZkyyNJD3dBU3tsmTT3e8r6KLuDzLve58
        965t/r1rEa0nysBqkVqKFXXdHSBwXHEPBXEHiNDEFK6BBAJ3NC5QQ+550jDOgq899WgRnY
        SYGOvMYKbIXp076djxvbpgv5L/g5Poo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-CZw5_VC8OKyJh7WlTYTvsg-1; Tue, 07 Apr 2020 06:01:28 -0400
X-MC-Unique: CZw5_VC8OKyJh7WlTYTvsg-1
Received: by mail-wr1-f69.google.com with SMTP id t25so1486471wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=072pIwxp+i9xdZgez7LPJl0p0p/jipVd9TvhmmVdjNw=;
        b=f7e+LZ1r8SOHXGnt40TnmSejhpDBOzubeZJlTbZQ6bYJotezIflmNFT5yu8ncxJ9Dq
         jDsOlFrNcfPuMLmpCFRnOceMk8NOW+IKna/WMwkhblFsm6/WcvrbvVbokmffK0NUwIrw
         0fT8uW61Tf8Xkf2dnUm4qm99a0ZPFPgHC+Wf4X+27sbccrmriIQCrrWYaLcvNfYnKy03
         qss+2nIK8ZhO7x2xpbtakJQNCDaqsbpoXvEU8cixu6FokLWQFy9dtTi1RaS6pBFNqXtu
         ImXBOCPmSjwIxqPaOrDbHr3qZFn85maShlwK430x1RwZlf0tlIWG60we3WkaeD4r3c5/
         jWZw==
X-Gm-Message-State: AGi0PuYsgjgw5Xoj8Sc+1tMtHU4Z+0ZNpUwjC/nq8jd3QzTmBMFtzBB6
        ge5TRpAniB1PFXOj5F7YLUvtUe+oGB8MZbzxFTGZCAergECsy5Oz0xlaY6OkFdmbdyi9MvRP2Mg
        JBKGp08rfZ/eUJyulb4oRfTgL
X-Received: by 2002:a5d:5542:: with SMTP id g2mr1545343wrw.310.1586253687283;
        Tue, 07 Apr 2020 03:01:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKkTeznfj9q9APqorxfRPW8aui7Fzp+uWDvURlf9QkARfLMmwPoVunNlyo6XHiM3RPmDuhNog==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr1545322wrw.310.1586253687084;
        Tue, 07 Apr 2020 03:01:27 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id p22sm1622027wmc.42.2020.04.07.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:01:26 -0700 (PDT)
Date:   Tue, 7 Apr 2020 06:01:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20200407055832-mutt-send-email-mst@kernel.org>
References: <20200407130542.0e3b5d9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407130542.0e3b5d9d@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:05:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/gpu/drm/virtio/virtgpu_kms.c: In function 'virtio_gpu_init':
> drivers/gpu/drm/virtio/virtgpu_kms.c:153:38: error: 'VIRTIO_RING_F_INDIRECT_DESC' undeclared (first use in this function)
>   153 |  if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/virtio/virtgpu_kms.c:153:38: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   898952f9597e ("virtio: stop using legacy struct vring in kernel")
> 
> interacting with commit
> 
>   5edbb5608256 ("drm/virtio: fix ring free check")
> 
> from Linus' tree (post v5.6).
> 
> I have added the following merge fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 7 Apr 2020 12:58:26 +1000
> Subject: [PATCH] drm/virtio: fix up for include file changes
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

That's the right fix - anyone using VIRTIO_RING_F_INDIRECT_DESC
must include virtio_ring.h, not assume some other header
pulls it in.

Given Gerd's patch is in Linus' tree I'll put this one in mine to
make things easy.

Thanks!

> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 023a030ca7b9..f4ea4cef5e23 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -25,6 +25,7 @@
>  
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
>  
>  #include <drm/drm_file.h>
>  
> -- 
> 2.25.0
> 
> I do have to wonder why all this code has been added to the vhost tree
> during the second week of the merge window (especially when I see it
> rebased 4 times in one day :-().  Is it really intended for v5.7?
> -- 
> Cheers,
> Stephen Rothwell


