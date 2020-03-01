Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0303C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734E124697
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSBMPB1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAT6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:58:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgCAT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583092709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rcjko7dGicYuc4H1pc5fh3ajPyPhlRFezJ328nwLSZw=;
        b=gSBMPB1Wr9GII9m7XA3Gw8ehBbtqfHQOhT3/3rcbK2C6+cCNSD6xkcEjt+WxzvHTszl13u
        Kpfu234Y94/FPEKafaHtGa8KMjF8pqLuZYuuYNi5fnBgmhqk+3XWb5q6deyOhx5Q1wZrh+
        bGau6odkdXIL3U3Dhrdt1S5cgSMjZ+Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-cUqN8sO-NR6ztFj0XLXDlQ-1; Sun, 01 Mar 2020 14:58:26 -0500
X-MC-Unique: cUqN8sO-NR6ztFj0XLXDlQ-1
Received: by mail-qv1-f70.google.com with SMTP id v19so7250545qvk.16
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 11:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rcjko7dGicYuc4H1pc5fh3ajPyPhlRFezJ328nwLSZw=;
        b=RMgKLV743gFBeIcpjLJe6nDbqjYl+Y0Kca16AnR36Yldqo4My/w/Q6FiUieAvrzSs4
         sPXlTKdGqPBM9y7ulSzHwoNA12SXQH2THLTIxi1I+EAl3Q9XuML9/eEcNaIEFcZQvNV3
         1zyxTAOcGtmbpVTZivH5f/Ervq+AgTeeguzrJchEz6nJlTiBn+rM2iMB064RjQtyade+
         mCHG84k7YWZSkm4VXBQLscT89gqT62kmuoR2jtmK1aEvXyNAbC8NmYuG//KgdMRXF6W6
         5SSEQuY6SOStqPY5FP2g5gQP0p+SwJK44COfUWJ7c7FJlPxllDORf83cUMbmT5d6tWXr
         c3Ig==
X-Gm-Message-State: APjAAAX23N2WmC5ap6pV3MuLoaHsUnnbnpBHFq31rT2U11edtU5WbSvw
        PAuDaLSorYPhAuRUixVQVoutm+oTtpBAUAS0CJ1PvqW+FH1W7ZXi4FC74LFBfKNG32guOGiIWh5
        OT+Zw/upJhlx7WZBa934K1UCH
X-Received: by 2002:ad4:4f47:: with SMTP id eu7mr12303443qvb.69.1583092705768;
        Sun, 01 Mar 2020 11:58:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXrQGv3bBrObwtPqn+kKYqGLtVs9FDBgQfagcgmNj36YA9iidB7EomiUjDi11v7/laoEZkBQ==
X-Received: by 2002:ad4:4f47:: with SMTP id eu7mr12303431qvb.69.1583092705563;
        Sun, 01 Mar 2020 11:58:25 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id x44sm7508250qtc.88.2020.03.01.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 11:58:24 -0800 (PST)
Date:   Sun, 1 Mar 2020 14:58:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3 2/3] virtio-net: Introduce RSS receive steering feature
Message-ID: <20200301145811-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301143302.8556-3-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
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
> index 19e76b3e3a64..188ad3eecdc8 100644
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
> +	/* maximum size of RSS key */
> +	__u8 rss_max_key_size;
> +	/* maximum number of indirection table entries */
> +	__le16 rss_max_indirection_table_length;
> +	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +	__le32 supported_hash_types;
>  } __attribute__((packed));
>  
>  /*
> @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
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
> @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
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
> +	__le32 hash_types;
> +	__le16 indirection_table_mask;
> +	__le16 unclassified_queue;
> +	__le16 indirection_table[1/* + indirection_table_mask */];
> +	__le16 max_tx_vq;
> +	__u8 hash_key_length;
> +	__u8 hash_key_data[/* hash_key_length */];
> +};
> +
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +


Extra space here.

>  /*
>   * Control network offloads
>   *
> -- 
> 2.17.1

