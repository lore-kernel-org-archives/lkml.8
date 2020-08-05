Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95287C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D39D20842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9j2o1Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHEUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727850AbgHEQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:40:19 -0400
X-Greylist: delayed 3566 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 12:40:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596645610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJk+gBSUOEE3QpuiYByxtg4+dvbr5r/Pq6TTI3Asc18=;
        b=I9j2o1YvOgMjOWcW1sHpa/hl+Sw3ABo5PBsvy7BYXDSIEaBFoUSHv061+5cK+C4FyAOKTN
        RL4fCNNJKNOOuE3yv9VnKiGcsuF3FnxdV3VpBSZv31ZuJBFQXm39sE4ZO7BZEGjheLbBUg
        7G8GzRyFzVEKcZPcYlAqo8hjWsVxPgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-0f5z5dajPBWD27hU59vXIA-1; Wed, 05 Aug 2020 10:24:23 -0400
X-MC-Unique: 0f5z5dajPBWD27hU59vXIA-1
Received: by mail-wm1-f70.google.com with SMTP id u144so2782484wmu.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJk+gBSUOEE3QpuiYByxtg4+dvbr5r/Pq6TTI3Asc18=;
        b=sBdEIGTOjhtAhiL0fZUPTjjObotf9qZEvh3TJGQ9zTA2A/W133rX582YlxAnvVI5mF
         wL69r7xenrLQ6Su/gdMNkxmMJ+Dt7vyJA5etrY/CA/+gL3SipjYOKDwFYScwfdYvq+Lp
         MBzqrRpEcEk4ybOVl2iZ7QfUeJ/FI3X+BadRlsCU37CK1evTVIU00CNkr8r3/e7xiOGS
         Py0Mc5i49W2sk0VfIxydlGcB/EQlOI1WUMmZc7/8F0gfJbq0dau56pnwYdDUAvYBSL5c
         Cnf9Ozfjlzfxcod4CZNCq84fCzDh7wYcre5QAE/RS1Uy5ZCHkKFFjxs0HH7P8oi/iuhG
         gyBQ==
X-Gm-Message-State: AOAM530aUrHPBOw6nkTVKo5dSWphVtUnoh5iI4E5leeGejCgahDKUooz
        kAmpTtEDQCb4IggIXkt+qwnSCsQ4V0c8+wyRQHuCVKOIim3Ndb1TD0Mp80kYx5u/wtLrVg5nZGU
        48dbOTHKVYNM6l7boCmwpc5pb
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3577308wmd.143.1596637461351;
        Wed, 05 Aug 2020 07:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxykd/6TYQBVQob6vYx2bOO/iHZmxM2Bk8CCL9fbpMhS8zjTz+5shlJ5og3sBNrgt6khAQqMA==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3577290wmd.143.1596637461088;
        Wed, 05 Aug 2020 07:24:21 -0700 (PDT)
Received: from steredhat ([5.171.198.65])
        by smtp.gmail.com with ESMTPSA id x11sm2840060wmc.33.2020.08.05.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 07:24:20 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:24:15 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 06/38] virtio_blk: correct tags for config space fields
Message-ID: <20200805142415.sqx7saezivvcolkt@steredhat>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-7-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-7-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:43:30AM -0400, Michael S. Tsirkin wrote:
> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/uapi/linux/virtio_blk.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 0f99d7b49ede..d888f013d9ff 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -57,20 +57,20 @@
>  
>  struct virtio_blk_config {
>  	/* The capacity (in 512-byte sectors). */
> -	__u64 capacity;
> +	__virtio64 capacity;
>  	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
> -	__u32 size_max;
> +	__virtio32 size_max;
>  	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
> -	__u32 seg_max;
> +	__virtio32 seg_max;
>  	/* geometry of the device (if VIRTIO_BLK_F_GEOMETRY) */
>  	struct virtio_blk_geometry {
> -		__u16 cylinders;
> +		__virtio16 cylinders;
>  		__u8 heads;
>  		__u8 sectors;
>  	} geometry;
>  
>  	/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
> -	__u32 blk_size;
> +	__virtio32 blk_size;
>  
>  	/* the next 4 entries are guarded by VIRTIO_BLK_F_TOPOLOGY  */
>  	/* exponent for physical block per logical block. */
> @@ -78,42 +78,42 @@ struct virtio_blk_config {
>  	/* alignment offset in logical blocks. */
>  	__u8 alignment_offset;
>  	/* minimum I/O size without performance penalty in logical blocks. */
> -	__u16 min_io_size;
> +	__virtio16 min_io_size;
>  	/* optimal sustained I/O size in logical blocks. */
> -	__u32 opt_io_size;
> +	__virtio32 opt_io_size;
>  
>  	/* writeback mode (if VIRTIO_BLK_F_CONFIG_WCE) */
>  	__u8 wce;
>  	__u8 unused;
>  
>  	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> -	__u16 num_queues;
> +	__virtio16 num_queues;
>  
>  	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
>  	/*
>  	 * The maximum discard sectors (in 512-byte sectors) for
>  	 * one segment.
>  	 */
> -	__u32 max_discard_sectors;
> +	__virtio32 max_discard_sectors;
>  	/*
>  	 * The maximum number of discard segments in a
>  	 * discard command.
>  	 */
> -	__u32 max_discard_seg;
> +	__virtio32 max_discard_seg;
>  	/* Discard commands must be aligned to this number of sectors. */
> -	__u32 discard_sector_alignment;
> +	__virtio32 discard_sector_alignment;
>  
>  	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
>  	/*
>  	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
>  	 * one segment.
>  	 */
> -	__u32 max_write_zeroes_sectors;
> +	__virtio32 max_write_zeroes_sectors;
>  	/*
>  	 * The maximum number of segments in a write zeroes
>  	 * command.
>  	 */
> -	__u32 max_write_zeroes_seg;
> +	__virtio32 max_write_zeroes_seg;
>  	/*
>  	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
>  	 * deallocation of one or more of the sectors.
> -- 
> MST
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

