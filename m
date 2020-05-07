Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75175C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550F224962
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vli+pyjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGKrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:47:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588848461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GBZ1BPaYoUZGlKv+l0CXQxh4T9djzRMOd1T5tvSABs=;
        b=Vli+pyjdj8+bz/fPqzfRhD7451Xh6lZaFiyhsqNWtWo1CcoRQ++NwjVflPyZ62UcJxxUun
        5ikaKQt6tLv5Qon4MCkPPZkw2aX/m4DP0Fl6uNPNwtpoPseQfUkGSzMl+RJkUfguBo27kV
        qgXl25PkiPuHpQHNb05lJhuB9YaF2/g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-m_lygjL-PreZ-2qxigJTfA-1; Thu, 07 May 2020 06:47:37 -0400
X-MC-Unique: m_lygjL-PreZ-2qxigJTfA-1
Received: by mail-wm1-f69.google.com with SMTP id s12so3133290wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GBZ1BPaYoUZGlKv+l0CXQxh4T9djzRMOd1T5tvSABs=;
        b=k3JlC/Y3el36wU8LqkcOe/OCmg5kpqi39tvVj2pJtB/KbyqPuve0BgA3ksfVG5LCf8
         8G5o089MfqIIkMi+5FxueIhj7CD8g8+Q8lJGdAd0q6mp/ZEdqB5TFSKm+j5qU4sKajHx
         +tG0WciYh+vAm2X3evk6W9w1gla0M51lGhIKJTy4mBOWdzYISfQRBFzmmSvevLRgq13U
         0grq9lAg0UxIwTGKQjAyPCyySttBEbtosXNdLM+o7ImVlGxUE5qNExAvnBi4h6Yiw++K
         vUQ/n59BuSdoc+fnVp6E/8+Bpc7MAcRRSsfBcUlGkceTd2vsMOP8HuHn7IaP+LvEtkb/
         onZw==
X-Gm-Message-State: AGi0PuaigzG//QtSfxPmpECL0HoH9r8KXpDRkh+0O/7QFNVtNM4mN8P9
        OkXwuD+g5fqg3jgHKX25lpEJhGbsHqeMzReMbUbnFUZpoAXlhy5CHAayKB2SlVnuLgVpa5wnBzi
        NIIXhsgR3NSjSQclm4rGmUdwl
X-Received: by 2002:adf:e751:: with SMTP id c17mr15873037wrn.351.1588848456323;
        Thu, 07 May 2020 03:47:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypLG5sLX7vjTBpzQVJYqyJozq0EEasF4Ci+xsJ7MLTLakuqA8erklYkKxDwmmh/F0jhS05XJgw==
X-Received: by 2002:adf:e751:: with SMTP id c17mr15873017wrn.351.1588848456163;
        Thu, 07 May 2020 03:47:36 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id a9sm7225179wmm.38.2020.05.07.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 03:47:35 -0700 (PDT)
Date:   Thu, 7 May 2020 06:47:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 10/15] MAINTAINERS: Add myself as virtio-mem maintainer
Message-ID: <20200507064709-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507103119.11219-11-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 12:31:14PM +0200, David Hildenbrand wrote:
> Let's make sure patches/bug reports find the right person.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Make this patch 2 in the series, or even squash into patch 1.

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d43ea5468b5..ad2b34f4dd66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18037,6 +18037,13 @@ S:	Maintained
>  F:	drivers/iommu/virtio-iommu.c
>  F:	include/uapi/linux/virtio_iommu.h
>  
> +VIRTIO MEM DRIVER
> +M:	David Hildenbrand <david@redhat.com>
> +L:	virtualization@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/virtio/virtio_mem.c
> +F:	include/uapi/linux/virtio_mem.h
> +
>  VIRTUAL BOX GUEST DEVICE DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  M:	Arnd Bergmann <arnd@arndb.de>
> -- 
> 2.25.3

