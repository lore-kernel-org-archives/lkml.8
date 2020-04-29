Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A4C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9F6206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI+fxZUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgD2PeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbgD2PeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588174443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKID24VeS04+SIozIuc8RuLZZFKJ5rduUKOoVcekO0A=;
        b=EI+fxZUkpwDkICVM1F7oJX0xQyeIpPzmzoCLqgTEUmFnrB0eV1O5SD9XQeLEEYvceSlU6i
        5d1/0Qn/qoNu3PGHwjbJeLtm+bOBf7gB2vJTaHc8EWPhx09Qalngyxmee/9sMM9ctUPcYq
        gg/q+n+DWbfIseQwhFA/nMqc0Ef+l7A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ImdkNTjmOe6_ppYkUyX08g-1; Wed, 29 Apr 2020 11:33:56 -0400
X-MC-Unique: ImdkNTjmOe6_ppYkUyX08g-1
Received: by mail-wm1-f69.google.com with SMTP id l21so1381740wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KKID24VeS04+SIozIuc8RuLZZFKJ5rduUKOoVcekO0A=;
        b=cTjNgOIOIFCvP0HX7XWZGt34QZfw9Vxv23B++mQJBCxmebmY2kY1RKE8iqHVkieQaB
         s3NNByUH41oM0Vq8gioDcVdDpJ2yGsMxgzO/pmVkc/GBYylhh8yzPXyXdmkawRJe4npe
         WJDPqhmm2cs89jpNE6+RHFcY5YuHN+JqcP3NvZgkDfU8XgFtBlJPc4d+OY//yNyDv6DF
         MuE7uzPci1bjHvsRJD3FPWkFHpEKULgqpm9vUdca33hCMWAP15Jqa+Ci7S2FfYN9eRq5
         Ce7+p45SOOezGEAisAfvJGUTj7/dSJYDeBFPQpcBNIIB2mpZ1htKkUdDYRVTBFQO3JNH
         7yVQ==
X-Gm-Message-State: AGi0PuZdKhku4shhfLOnjSqytIm/J8SEQtnpEAFKNEMEGrAoqUTpVzq4
        9Dk5Ds464ijZtethWnzMY6WW+fsf1T0jNsGjgs01eYwA2gE/Lywjgt7evDQJUhCy/5nD/6ZAJ2r
        E6AgD7UWg0Mfv2HKuPuSSMoug
X-Received: by 2002:adf:fecd:: with SMTP id q13mr42286156wrs.12.1588174435308;
        Wed, 29 Apr 2020 08:33:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJv7rM5XZdPpYa0XbuMbltzbpsnlCYEladdinC4riKF/z7q+xHJZ0Lq2AB1h1HtNI76PDhJ5w==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr42286134wrs.12.1588174435068;
        Wed, 29 Apr 2020 08:33:55 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id u7sm8832675wmg.41.2020.04.29.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:33:54 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:33:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: fix default for vhost_iotlb
Message-ID: <20200429113232-mutt-send-email-mst@kernel.org>
References: <20200429142317.1847441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429142317.1847441-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:23:04PM +0200, Arnd Bergmann wrote:
> During randconfig build testing, I ran into a configuration that has
> CONFIG_VHOST=m, CONFIG_VHOST_IOTLB=m and CONFIG_VHOST_RING=y, which
> makes the iotlb implementation left out from vhost_ring, and in turn
> leads to a link failure of the vdpa_sim module:
> 
> ERROR: modpost: "vringh_set_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> ERROR: modpost: "vringh_init_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> ERROR: modpost: "vringh_iov_push_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> ERROR: modpost: "vringh_iov_pull_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> ERROR: modpost: "vringh_complete_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> ERROR: modpost: "vringh_getdesc_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> 
> Work around it by setting the default for VHOST_IOTLB to avoid this
> configuration.
> 
> Fixes: e6faeaa12841 ("vhost: drop vring dependency on iotlb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I fixed this a while ago locally but never got around to sending the
> fix. If the problem has been addressed differently in the meantime,
> please ignore this one.


So I ended up not sending e6faeaa12841 upstream because of this problem.
But hey, that's a nice idea!
I'll queue something like this for the next release.

> ---
>  drivers/vhost/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 2c75d164b827..ee5f85761024 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VHOST_IOTLB
>  	tristate
> +	default y if VHOST=m && VHOST_RING=y
>  	help
>  	  Generic IOTLB implementation for vhost and vringh.
>  	  This option is selected by any driver which needs to support
> -- 
> 2.26.0

