Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7539BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED6206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPNOC3KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCLIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:25:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbgCLIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584001520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqiBqBozQZrKbpqb6fps1Ub+53xZKmdnmK5P35tZZ6M=;
        b=GPNOC3KZYX+dQA+xo+kQ3kVzVJRcmjBGJVvjOXTwJkwzbwbENM1uEqDQCIPlC3OYdz5D4X
        d0QpjIrHkj2zJaRlDfKvlIk0AJXlN88e6EhbCo4VOkaJp9u81Vqxzp/9KaPDCfaJx/XCTh
        tWKg6T3HGBPMyhWIv4RS5rkD0o1ZjBY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-sQ-8U3lqMDe8_rckyUSW5g-1; Thu, 12 Mar 2020 04:25:15 -0400
X-MC-Unique: sQ-8U3lqMDe8_rckyUSW5g-1
Received: by mail-qt1-f199.google.com with SMTP id k20so2967764qtm.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqiBqBozQZrKbpqb6fps1Ub+53xZKmdnmK5P35tZZ6M=;
        b=TYzNiMCjCirMY/xgGCZmvMRNX85mr2K0hIQkuYJ1qfQeD7u9cETw0jVrriYVG1s6ua
         uQwTGgdW0cmG4+N+6elA3rMNuJqXYT4EfFcjROsT3h1BWMm0AAqNJKdQNeJENFRmO77v
         Gqzhon/ZgWO0PbFmpsVPJ10LAKwkUFvsE2acC/KtKIZBMyiC1y8mVHQwVd++qSSJBSKe
         NQmjDe6OJz4/8AD1i+KPrqKTy7vstymsNZq7BNZOK2o+72qPFAYcFCcvL2HZ2Ho9ObBl
         SbDYtfHf7/B7tBm8tdGmwatH3iLZk31Q62M23HN5iGP+f8aiV+fyNxN86oT0uBynB7FT
         67Ng==
X-Gm-Message-State: ANhLgQ0NVN45pPo+BMWBY8uiQdDs4mLo0jjr/OAK6yjhYgI72qMr3nr/
        71KxDwsMnOcBiZyXYlu99ST0MLXNSuBRc13a2D0nKURMTsay0PvxNRmZ95YXFfvMQ7HwFL4JN6i
        l5kfTuwiHK5smfm/ASJNQjFXW
X-Received: by 2002:a37:6215:: with SMTP id w21mr6548595qkb.149.1584001514432;
        Thu, 12 Mar 2020 01:25:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunTOq0UJjwugXSegnRqEyiS9dlQvVqcZDLsJQHR9PIHKEvp8WKkpEby0VCBTZybNkeotxyBA==
X-Received: by 2002:a37:6215:: with SMTP id w21mr6548575qkb.149.1584001514073;
        Thu, 12 Mar 2020 01:25:14 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id 82sm10496917qkd.62.2020.03.12.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:25:13 -0700 (PDT)
Date:   Thu, 12 Mar 2020 04:25:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, david@redhat.com, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
Message-ID: <20200312042340-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <1583999395-9131-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583999395-9131-2-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:49:55PM +0800, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
> It will set balloon size to THP size to handle the THP split issue.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

What's wrong with just using the PartiallyBalloonedPage machinery
instead? That would make it guest transparent.

> ---
>  hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++---------
>  include/standard-headers/linux/virtio_balloon.h |  4 ++
>  2 files changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7..cfe86b0 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
>              unsigned int p = virtio_ldl_p(vdev, &pfn);
>              hwaddr pa;
> +            size_t handle_size = BALLOON_PAGE_SIZE;
>  
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
>  
> -            section = memory_region_find(get_system_memory(), pa,
> -                                         BALLOON_PAGE_SIZE);
> -            if (!section.mr) {
> -                trace_virtio_balloon_bad_addr(pa);
> -                continue;
> -            }
> -            if (!memory_region_is_ram(section.mr) ||
> -                memory_region_is_rom(section.mr) ||
> -                memory_region_is_romd(section.mr)) {
> -                trace_virtio_balloon_bad_addr(pa);
> -                memory_region_unref(section.mr);
> -                continue;
> -            }
> +            if (virtio_has_feature(s->host_features,
> +                                   VIRTIO_BALLOON_F_THP_ORDER))
> +                handle_size = BALLOON_PAGE_SIZE << VIRTIO_BALLOON_THP_ORDER;
> +
> +            while (handle_size > 0) {
> +                section = memory_region_find(get_system_memory(), pa,
> +                                             BALLOON_PAGE_SIZE);
> +                if (!section.mr) {
> +                    trace_virtio_balloon_bad_addr(pa);
> +                    continue;
> +                }
> +                if (!memory_region_is_ram(section.mr) ||
> +                    memory_region_is_rom(section.mr) ||
> +                    memory_region_is_romd(section.mr)) {
> +                    trace_virtio_balloon_bad_addr(pa);
> +                    memory_region_unref(section.mr);
> +                    continue;
> +                }
>  
> -            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
> -                                               pa);
> -            if (!qemu_balloon_is_inhibited()) {
> -                if (vq == s->ivq) {
> -                    balloon_inflate_page(s, section.mr,
> -                                         section.offset_within_region, &pbp);
> -                } else if (vq == s->dvq) {
> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> -                } else {
> -                    g_assert_not_reached();
> +                trace_virtio_balloon_handle_output(memory_region_name(section.mr),
> +                                                   pa);
> +                if (!qemu_balloon_is_inhibited()) {
> +                    if (vq == s->ivq) {
> +                        balloon_inflate_page(s, section.mr,
> +                                             section.offset_within_region,
> +                                             &pbp);
> +                    } else if (vq == s->dvq) {
> +                        balloon_deflate_page(s, section.mr,
> +                                             section.offset_within_region);
> +                    } else {
> +                        g_assert_not_reached();
> +                    }
>                  }
> +                memory_region_unref(section.mr);
> +
> +                pa += BALLOON_PAGE_SIZE;
> +                handle_size -= BALLOON_PAGE_SIZE;
>              }
> -            memory_region_unref(section.mr);
>          }
>  
>          virtqueue_push(vq, elem, offset);
> @@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>  
>      memcpy(&config, config_data, virtio_balloon_config_size(dev));
>      dev->actual = le32_to_cpu(config.actual);
> +    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_ORDER))
> +        dev->actual <<= VIRTIO_BALLOON_THP_ORDER;
>      if (dev->actual != oldactual) {
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
> @@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
>      }
>      if (target) {
>          dev->num_pages = (vm_ram_size - target) >> VIRTIO_BALLOON_PFN_SHIFT;
> +        if (virtio_has_feature(dev->host_features,
> +                               VIRTIO_BALLOON_F_THP_ORDER))
> +            dev->num_pages >>= VIRTIO_BALLOON_THP_ORDER;
>          virtio_notify_config(vdev);
>      }
>      trace_virtio_balloon_to_target(target, dev->num_pages);
> @@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_THP_ORDER, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index 9375ca2..f54d613 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Set balloon page order to thp order */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
>  
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +
>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1
>  struct virtio_balloon_config {
> -- 
> 2.7.4

