Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FAFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370B20880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEVzAaFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCAIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:49:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbgCAIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 03:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583052568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpMXUuCEusmBp5p4Be+qaN8/mGgM9hkv0auM9sJUxy8=;
        b=SEVzAaFQLYWqS6lr30mdbo2OWGR+ZoFtbVhBxhqndk6uWD26nkRoOuoJtBj9t0/A9nvvim
        H4E0Xkvmc3BL2vCf92Rw2ZfII0OAN2GTBQ3GWk7qm45HgJHefikAjr7aAqe1SSi0ZWUGca
        Lfwf3pf3DHNhdKVY9wpvytmg5oRq3Ts=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-P7kXONOyOAWepk203OhZ3A-1; Sun, 01 Mar 2020 03:49:26 -0500
X-MC-Unique: P7kXONOyOAWepk203OhZ3A-1
Received: by mail-qv1-f71.google.com with SMTP id h17so1875336qvc.18
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 00:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PpMXUuCEusmBp5p4Be+qaN8/mGgM9hkv0auM9sJUxy8=;
        b=HlBm9cfBrjDvGON/wRdkUK5rdHXAB+GOX8Rm4FqjbBqS3qJJY8Ar0YW4PZT5tKAkNM
         5PLywXThJTf4OqLif9gU5ikiQolT3BfnbRG6XlIrpvyp/j2naMcYGO+rSYVw18Sqe8Pj
         3IOsADvawuuUg3OsL68Pk9Xv/DyG1hcEQRVBuYsZgjysZT4N88L3rv6wSoCaITYjRjmN
         aSWuThB4k0OYOMkseoV4F9m3b1LZ5Bgkbo3hQJp7qN3FVha48fdqnIy0gDoiEOXjy3oi
         vHhSL0wIuWflrAEnCq88Jvf8OAvgEAxIoJ6w4G9nMMsGePJOpJtdYPRx2TWlVS6f8Ck5
         lXbw==
X-Gm-Message-State: APjAAAV2VwlpIMo9lZAe4djJMsp5/txpeUzZVksCYG4Q73z+LdDf0Xf+
        5m52qLI2WUBIH57O01cJY4TbHrcR0ixExGeovm3llARfG4h6LaaTs5HSZFdeUr9kX2v2YAkCzKP
        ED1jqu0iWAM6o+EwIvd2JvMaq
X-Received: by 2002:a37:b4c5:: with SMTP id d188mr11102795qkf.27.1583052565499;
        Sun, 01 Mar 2020 00:49:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyT5tnpzAk6rh1bz+ewje7fgHhLTiqcVEVL7qiAadXPfxOeOPRbcHVosMdabNJgyx1vqnIYDQ==
X-Received: by 2002:a37:b4c5:: with SMTP id d188mr11102783qkf.27.1583052565250;
        Sun, 01 Mar 2020 00:49:25 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id y62sm8072235qka.19.2020.03.01.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 00:49:24 -0800 (PST)
Date:   Sun, 1 Mar 2020 03:49:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH 2/3] virtio-net: Introduce RSS receive steering feature
Message-ID: <20200301034703-mutt-send-email-mst@kernel.org>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
 <20200229171301.15234-3-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229171301.15234-3-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:13:00PM +0200, Yuri Benditovich wrote:
> RSS (Receive-side scaling) defines hash calculation
> rules and decision on receive virtqueue according to
> the calculated hash, provided mask to apply and
> provided indirection table containing indices of
> receive virqueues. The driver sends the control
> command to enable multiqueue and provide parameters
> for receive steering.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 6e26a2cc6ad0..7a342657fb6c 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
> @@ -70,6 +71,17 @@
>  #define VIRTIO_NET_S_LINK_UP	1	/* Link is up */
>  #define VIRTIO_NET_S_ANNOUNCE	2	/* Announcement is needed */
>  
> +/* supported/enabled hash types */
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> +
>  struct virtio_net_config {
>  	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  	__u8 mac[ETH_ALEN];
> @@ -93,6 +105,12 @@ struct virtio_net_config {
>  	 * Any other value stands for unknown.
>  	 */
>  	__u8 duplex;
> +	/* maximal size of RSS key */
> +	__u8 rss_max_key_size;
> +	/* maximal number of indirection table entries */
> +	__u16 rss_max_indirection_table_length;

This mirrors spec language. However I just stumbled upon this:

https://en.wikipedia.org/wiki/Maximal_and_minimal_elements

which seems to say maximal means "local maximum".
So I think we should fix both the spec and this header to
say "maximum" instead of "maximal".

Thanks!



> +	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +	__u32 supported_hash_types;
>  } __attribute__((packed));
>  
>  /*
> @@ -236,7 +254,9 @@ struct virtio_net_ctrl_mac {
>  
>  /*
>   * Control Receive Flow Steering
> - *
> + */
> +#define VIRTIO_NET_CTRL_MQ   4
> +/*
>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>   * enables Receive Flow Steering, specifying the number of the transmit and
>   * receive queues that will be used. After the command is consumed and acked by
> @@ -249,11 +269,29 @@ struct virtio_net_ctrl_mq {
>  	__virtio16 virtqueue_pairs;
>  };
>  
> -#define VIRTIO_NET_CTRL_MQ   4
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
>  
> +/*
> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> + * the receive steering to use a hash calculated for incoming packet
> + * to decide on receive virtqueue to place the packet. The command
> + * also provides parameters to calculate a hash and receive virtqueue.
> + */
> +struct virtio_net_rss_config {
> +	__virtio32 hash_types;
> +	__virtio16 indirection_table_mask;
> +	__virtio16 unclassified_queue;
> +	__virtio16 indirection_table[1/* + indirection_table_mask*/];
> +	__virtio16 max_tx_vq;
> +	__u8 hash_key_length;
> +	__u8 hash_key_data[/*hash_key_length*/];
> +};


Should use __le and not __virtio.
__virtio is for legacy types which sometimes have variable endian-ness.


> +
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +
>  /*
>   * Control network offloads
>   *
> -- 
> 2.17.1

