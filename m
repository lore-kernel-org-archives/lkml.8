Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8DA20880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxdLBxxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCAIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:44:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgCAIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 03:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583052263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ve4baa/uoWtpciHy4RZw3e9cVkoIzMaeirVE4vAjmt8=;
        b=RxdLBxxi/ZWuQ881lKMmWaP7CzvsiwqgcmP+8OHtwAM/W7GPKLLNJVezCyic8jzkaBigLv
        R+pKL0V1/DELwGXR0jDL1xuhP3Tx//+W5Jgv6LpA6KDn374Y5Lir6I7drTIb1icDvfxEIf
        /YrXa7YvAzixvvXMUOGw+jTaqJLyNqg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-33p8hbirNIal_K9hNaMdaQ-1; Sun, 01 Mar 2020 03:44:22 -0500
X-MC-Unique: 33p8hbirNIal_K9hNaMdaQ-1
Received: by mail-qv1-f72.google.com with SMTP id d7so6427893qvq.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 00:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ve4baa/uoWtpciHy4RZw3e9cVkoIzMaeirVE4vAjmt8=;
        b=Jig9HpBftXyY52jkLSI9jHHvycevUFsWiHf0gQQSdRZcVXRjfFY2jhJBAqs6TiLtm8
         sKZRLUSSXVJ8YiCwYQ8iuCg3qjuztCEk2zjcR4i5c21RolosKZ2OmGjCypEL+R1qimok
         9g8phA5C64JdXS9URFO0f1pETu2GRnSmU3OAfF/yBXW2pzLblaDfWghaZt+Zkxw8s5bq
         y54Lsex+fQ8nL+sH4RfYO4bvtZMzjzaLn4UQk0ZDp1gAX5pYeWtVkU8ZdZdQwgzdGblY
         ghyu5w+4nQarGZk9wALawN6y2zEXWbH1D+NPX4rowdtQfHP/dD3+tAigaPqtPFQ+O/YJ
         W57Q==
X-Gm-Message-State: APjAAAU2q7WnvSRnEZAw/ZfgrU7RJ7PX5DAD2CCv3G2j5m8oXVQoZFB7
        fpCVOenjDnDocAKFXpGlzbsKz8h9/5cYNjJ+B67IcD3YDwbmsVm6gqPxjsaLAX68GvkiP6CY/At
        pXs26G6HtJQMmcxEsDbd8kJ3H
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr10858784qtg.314.1583052261584;
        Sun, 01 Mar 2020 00:44:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQZwRK6FPvg3UgljEJZXn2zM3KbSiAn5tKLShK+MTwZKzyxU90cXow/tz9ciBgVdmnpo9eYA==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr10858775qtg.314.1583052261317;
        Sun, 01 Mar 2020 00:44:21 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id q1sm545806qtp.81.2020.03.01.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 00:44:20 -0800 (PST)
Date:   Sun, 1 Mar 2020 03:44:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH 1/3] virtio-net: Introduce extended RSC feature
Message-ID: <20200301034337-mutt-send-email-mst@kernel.org>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
 <20200229171301.15234-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229171301.15234-2-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:12:59PM +0200, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is negotiatede and 'gso_type' field in received packet is not
> GSO_NONE, the device reports number of coalesced packets in
> 'csum_start' field and number of duplicated acks in 'csum_offset'
> field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..6e26a2cc6ad0 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
>  					 */
> @@ -104,6 +105,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
>  	__u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
> @@ -113,8 +115,14 @@ struct virtio_net_hdr_v1 {
>  	__u8 gso_type;
>  	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
>  	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
> -	__virtio16 csum_start;	/* Position to start checksumming from */
> -	__virtio16 csum_offset;	/* Offset after that to place checksum */
> +	union {
> +		__virtio16 csum_start;	/* Position to start checksumming from */
> +		__virtio16 rsc_ext_num_packets; /* num of coalesced packets */
> +	};
> +	union {
> +		__virtio16 csum_offset;	/* Offset after that to place checksum */
> +		__virtio16 rsc_ext_num_dupacks; /* num of duplicated acks */
> +	};
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };


New fields should all be __le, not __virtio.

>  
> -- 
> 2.17.1

