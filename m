Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB7C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6593E20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPDw/Bs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZHH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:07:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56973 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgCZHH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585206475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcclFoRcUMXAmqI5wWRUbmFwT+7W1c3+/OsDIjflcfA=;
        b=VPDw/Bs2zpZzlz1dCXVJ8Ig1EhfPz5OuDGCHbY7+vI2opp6EDYbAApCnabtHsTTZJokr7R
        EadD6FAf7Cnzia5BRsMeiLaDBlzolxHFWt8XE+rLbBnr4quUQnO2Cn1x4HTHEumjxaAY93
        izRRxuVEdkuNrzJkFtGAshcO0xGkFqo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-UrSx3Uh4MaSroNC7RtFgvQ-1; Thu, 26 Mar 2020 03:07:50 -0400
X-MC-Unique: UrSx3Uh4MaSroNC7RtFgvQ-1
Received: by mail-wm1-f72.google.com with SMTP id p18so2060182wmk.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HcclFoRcUMXAmqI5wWRUbmFwT+7W1c3+/OsDIjflcfA=;
        b=YK++BBy9xJHsP3ZL3G4QTNiIvlF8uBNypD/AhnZGNqLRIlRndVHYVxSzNKety38w35
         dun4N04dNAruE6vGxIA+PgxjwHRPk2B9lA32mvGnE0Nk4X5tyxEYdNsHjB1Uo0qpzT3F
         j0mmsWLwgk6TljE7EQ/3gJg/jugHkTw7sUBo3htPxj/zA9/KHvjIn2zhLxCXMGPqq4Oh
         fwFeRYhnbGqchJTC11KT8l1qhWPKZra2HV04M8K7k+KU+vP9wR2JkOndjs+ey07zmh9W
         A/7ICWgReVifWkkegSTAI8zrg64hnjXJtpYkVTn1WoAPqUKcZ/LIPQpq+0FRTkoHsU58
         0a4Q==
X-Gm-Message-State: ANhLgQ02YnCGp28usvF+NZvf31zJzc4+AYaFlTHcjceJKOd+wPSfqrzN
        52MSEIbfgkBGXF5PC/gNqMFpYhydHakq6UFAR1BUG+YR2mXmbwKLme5tEErg5Q7Cb+fSMapcVQR
        pM9uE+yJxdJ+Jb7CoAN8DOKHl
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr7335578wrw.133.1585206469561;
        Thu, 26 Mar 2020 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyd/EPOwcyQHG07tKxst9zHxndG/LnYfA/RKr4oJerYtEj2yvFk8Wke9pviMCzagX64P7J3Q==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr7335547wrw.133.1585206469208;
        Thu, 26 Mar 2020 00:07:49 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
        by smtp.gmail.com with ESMTPSA id t2sm2145055wml.30.2020.03.26.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:07:48 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:07:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, david@redhat.com, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
Message-ID: <20200326030636-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <1583999395-9131-2-git-send-email-teawater@gmail.com>
 <20200312042340-mutt-send-email-mst@kernel.org>
 <C9436807-D9CA-49FD-AEE3-3B7CE4BBB711@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C9436807-D9CA-49FD-AEE3-3B7CE4BBB711@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:13:32PM +0800, teawater wrote:
> 
> 
> > 2020年3月12日 16:25，Michael S. Tsirkin <mst@redhat.com> 写道：
> > 
> > On Thu, Mar 12, 2020 at 03:49:55PM +0800, Hui Zhu wrote:
> >> If the guest kernel has many fragmentation pages, use virtio_balloon
> >> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> >> the balloon pages.
> >> Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
> >> It will set balloon size to THP size to handle the THP split issue.
> >> 
> >> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> > 
> > What's wrong with just using the PartiallyBalloonedPage machinery
> > instead? That would make it guest transparent.
> 
> In balloon_inflate_page:
>     rb_page_size = qemu_ram_pagesize(rb);
> 
>     if (rb_page_size == BALLOON_PAGE_SIZE) {
>         /* Easy case */
> 
> It seems that PartiallyBalloonedPage is only used when rb_page_size is greater than BALLOON_PAGE_SIZE.
> Do you mean I should modify the working mechanism of balloon_inflate_page function?
> 
> Thanks,
> Hui

Yes, we can tweak it to unconditionally combine pages to
a huge page.


> > 
> >> ---
> >> hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++---------
> >> include/standard-headers/linux/virtio_balloon.h |  4 ++
> >> 2 files changed, 47 insertions(+), 24 deletions(-)
> >> 
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index a4729f7..cfe86b0 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >> @@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >>         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
> >>             unsigned int p = virtio_ldl_p(vdev, &pfn);
> >>             hwaddr pa;
> >> +            size_t handle_size = BALLOON_PAGE_SIZE;
> >> 
> >>             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> >>             offset += 4;
> >> 
> >> -            section = memory_region_find(get_system_memory(), pa,
> >> -                                         BALLOON_PAGE_SIZE);
> >> -            if (!section.mr) {
> >> -                trace_virtio_balloon_bad_addr(pa);
> >> -                continue;
> >> -            }
> >> -            if (!memory_region_is_ram(section.mr) ||
> >> -                memory_region_is_rom(section.mr) ||
> >> -                memory_region_is_romd(section.mr)) {
> >> -                trace_virtio_balloon_bad_addr(pa);
> >> -                memory_region_unref(section.mr);
> >> -                continue;
> >> -            }
> >> +            if (virtio_has_feature(s->host_features,
> >> +                                   VIRTIO_BALLOON_F_THP_ORDER))
> >> +                handle_size = BALLOON_PAGE_SIZE << VIRTIO_BALLOON_THP_ORDER;
> >> +
> >> +            while (handle_size > 0) {
> >> +                section = memory_region_find(get_system_memory(), pa,
> >> +                                             BALLOON_PAGE_SIZE);
> >> +                if (!section.mr) {
> >> +                    trace_virtio_balloon_bad_addr(pa);
> >> +                    continue;
> >> +                }
> >> +                if (!memory_region_is_ram(section.mr) ||
> >> +                    memory_region_is_rom(section.mr) ||
> >> +                    memory_region_is_romd(section.mr)) {
> >> +                    trace_virtio_balloon_bad_addr(pa);
> >> +                    memory_region_unref(section.mr);
> >> +                    continue;
> >> +                }
> >> 
> >> -            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
> >> -                                               pa);
> >> -            if (!qemu_balloon_is_inhibited()) {
> >> -                if (vq == s->ivq) {
> >> -                    balloon_inflate_page(s, section.mr,
> >> -                                         section.offset_within_region, &pbp);
> >> -                } else if (vq == s->dvq) {
> >> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> >> -                } else {
> >> -                    g_assert_not_reached();
> >> +                trace_virtio_balloon_handle_output(memory_region_name(section.mr),
> >> +                                                   pa);
> >> +                if (!qemu_balloon_is_inhibited()) {
> >> +                    if (vq == s->ivq) {
> >> +                        balloon_inflate_page(s, section.mr,
> >> +                                             section.offset_within_region,
> >> +                                             &pbp);
> >> +                    } else if (vq == s->dvq) {
> >> +                        balloon_deflate_page(s, section.mr,
> >> +                                             section.offset_within_region);
> >> +                    } else {
> >> +                        g_assert_not_reached();
> >> +                    }
> >>                 }
> >> +                memory_region_unref(section.mr);
> >> +
> >> +                pa += BALLOON_PAGE_SIZE;
> >> +                handle_size -= BALLOON_PAGE_SIZE;
> >>             }
> >> -            memory_region_unref(section.mr);
> >>         }
> >> 
> >>         virtqueue_push(vq, elem, offset);
> >> @@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
> >> 
> >>     memcpy(&config, config_data, virtio_balloon_config_size(dev));
> >>     dev->actual = le32_to_cpu(config.actual);
> >> +    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_ORDER))
> >> +        dev->actual <<= VIRTIO_BALLOON_THP_ORDER;
> >>     if (dev->actual != oldactual) {
> >>         qapi_event_send_balloon_change(vm_ram_size -
> >>                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
> >> @@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
> >>     }
> >>     if (target) {
> >>         dev->num_pages = (vm_ram_size - target) >> VIRTIO_BALLOON_PFN_SHIFT;
> >> +        if (virtio_has_feature(dev->host_features,
> >> +                               VIRTIO_BALLOON_F_THP_ORDER))
> >> +            dev->num_pages >>= VIRTIO_BALLOON_THP_ORDER;
> >>         virtio_notify_config(vdev);
> >>     }
> >>     trace_virtio_balloon_to_target(target, dev->num_pages);
> >> @@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] = {
> >>                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >>     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >>                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> >> +    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
> >> +                    VIRTIO_BALLOON_F_THP_ORDER, false),
> >>     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
> >>      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
> >>      * property retains this quirk for QEMU 4.1 machine types.
> >> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> >> index 9375ca2..f54d613 100644
> >> --- a/include/standard-headers/linux/virtio_balloon.h
> >> +++ b/include/standard-headers/linux/virtio_balloon.h
> >> @@ -36,10 +36,14 @@
> >> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> >> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
> >> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> >> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Set balloon page order to thp order */
> >> 
> >> /* Size of a PFN in the balloon interface. */
> >> #define VIRTIO_BALLOON_PFN_SHIFT 12
> >> 
> >> +/* The order of the balloon page */
> >> +#define VIRTIO_BALLOON_THP_ORDER 9
> >> +
> >> #define VIRTIO_BALLOON_CMD_ID_STOP	0
> >> #define VIRTIO_BALLOON_CMD_ID_DONE	1
> >> struct virtio_balloon_config {
> >> -- 
> >> 2.7.4

