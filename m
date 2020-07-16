Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A318C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7BA2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF15XlEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGPGju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:39:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgGPGju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594881588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpP0mH47EUa4gYHjkk/BxjQD6yumtpgpcOHSj9loGxE=;
        b=HF15XlECGAJ9jMqad6NFpgrJf/KR+hIzCNZeF9GzsdKrsfcod1vfeWQCVI6un1l3XPsDk0
        beYxKzbF3Wkf8UnOB+oLNgpQKaPaNeaQySE1wuyQ7pjW1oUklsxj+ZYGtlguXJmGy+tFRY
        aFmldnTk33EQxtwxrx0nKQ8y4PDKs+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-xXMURBjHMrSI9obV2BNPhw-1; Thu, 16 Jul 2020 02:39:44 -0400
X-MC-Unique: xXMURBjHMrSI9obV2BNPhw-1
Received: by mail-wr1-f71.google.com with SMTP id o25so4711563wro.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpP0mH47EUa4gYHjkk/BxjQD6yumtpgpcOHSj9loGxE=;
        b=SIRJVpM125Tq5MVbuAN64/n29vl5eZvWh/tQCHRuFq6EOR/VzxrqRWVQDre/FoutOX
         hHVwbRY2ovTNpEOM5wepmYaL92h2BQhBOg2ga63FYbkSS2jecSFobnSB9q6Ed+MfGbKN
         sc/dXO7qOWVtxVBumzo3fOQu07lD+tmUAGONh18i5OZIf+dJTjpIcxFri0a2dKqV/FRk
         aMjmRaOCZdojpsuya+vSloCcF9+6+aw0gwSgsPpNcQxJ47jfHAAiNTywuZTG+bA00Gut
         h9xwrNAZ6x1abKSbCMLkTblAguVgq4FUBR6poPxQOgucA1aMtRtpno9ZGyr0s6NYaqbv
         70Rw==
X-Gm-Message-State: AOAM532y4aD/eSmxNzaO9yukukT47/NlrU9y/lrgUmMycRQVVwsnZLPN
        3g85N18cRXbErZquHv6hsIXKrmvBEwDOLgK5teo2hjlRS86h67xBIziuN8zPsZuQVPSu7fvHW5+
        ITBrXWqERKiePG8AgWKVYZTv/
X-Received: by 2002:a5d:4591:: with SMTP id p17mr3460241wrq.343.1594881583717;
        Wed, 15 Jul 2020 23:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3VgldvMJ2su+01++hUBPJJNqM48adq88ynHNwf0eV6ZBA8mXoC0Vsx4p+YmzOHAxQ/sH+3w==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr3460225wrq.343.1594881583537;
        Wed, 15 Jul 2020 23:39:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id b23sm7588607wmd.37.2020.07.15.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:39:42 -0700 (PDT)
Date:   Thu, 16 Jul 2020 02:39:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to deflate
 continuous pages
Message-ID: <20200716023910-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594867315-8626-6-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
> This commit adds a vq dcvq to deflate continuous pages.
> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
> from icvq and use madvise MADV_WILLNEED with the pages.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

This is arguably something to benchmark. Does guest benefit
from MADV_WILLNEED or loose performance?

> ---
>  hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>  include/hw/virtio/virtio-balloon.h |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d36a5c8..165adf7 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>  }
>  
>  static void balloon_deflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr mr_offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset,
> +                                 size_t size)
>  {
>      void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset;
> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      rb_page_size = qemu_ram_pagesize(rb);
>  
>      host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> +    size &= ~(rb_page_size - 1);
>  
>      /* When a page is deflated, we hint the whole host page it lives
>       * on, since we can't do anything smaller */
> -    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
> +    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>      if (ret != 0) {
>          warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>                      strerror(errno));
> @@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
>  
> -            if (vq == s->icvq) {
> +            if (vq == s->icvq || vq == s->dcvq) {
>                  uint32_t psize_ptr;
>                  if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
>                      break;
> @@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>                      balloon_inflate_page(s, section.mr,
>                                           section.offset_within_region,
>                                           psize, &pbp);
> -                } else if (vq == s->dvq) {
> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> +                } else if (vq == s->dvq || vq == s->dcvq) {
> +                    balloon_deflate_page(s, section.mr, section.offset_within_region,
> +                                         psize);
>                  } else {
>                      g_assert_not_reached();
>                  }
> @@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>  
>      if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
>          s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
> +        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      }
>  
>      reset_stats(s);
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 6a2514d..848a7fb 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>  
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> -- 
> 2.7.4

