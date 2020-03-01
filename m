Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DECC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8F20880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJn5T42U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAInh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:43:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgCAInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 03:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583052216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4wTuSY/YLFqa4TR/y7uU0KCTqcGFfatFFzWHxU3S9Q=;
        b=JJn5T42U/1yDOATo1ZyTce20lhnHB0YmbX4kudgLE7g0lUTqYYeJcFCAiMJw1AK/R9xIBo
        zQHG4LinndnQI2eNq2IGjbCmBVeSZ6d/S35MluaBugt7Jheizim1A42N1/fVpe9Ba22Gtg
        TK7EPUuMyzvd3gEUozqcrjF9eBG6D40=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-e-e395wgO7uX2zJeD8cysg-1; Sun, 01 Mar 2020 03:43:34 -0500
X-MC-Unique: e-e395wgO7uX2zJeD8cysg-1
Received: by mail-qk1-f198.google.com with SMTP id b22so1681248qkk.15
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 00:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4wTuSY/YLFqa4TR/y7uU0KCTqcGFfatFFzWHxU3S9Q=;
        b=kGgaiO8HNE/b9YvMyDv2nXB1egO3JAVOuJtjxD5MvnObPo35SaY53xbiTdngubiEvo
         PLuPMt3Za24N7nyeZNJ7DwOpytungqrryhZ9VYeGCe7bHEBsdGLz5Gd9V9F63Aybcji+
         /fQ0Em6QpE66y4+lep/4vXwkiLtg6NyTuzzKo93PL4cKJgiF6BAFbdAkMJrOeL8dMOwv
         ztkRx26rYpFabFte72+maW8QA1hVuTefsKi3hLQHilRVZ/De3/NJ41b0TKsj9fI/NszL
         MD8MbZHodd6gepaR6yXtbdXBCaYdqYekw/G2XziPf/LpRSVjVWbLO3pn2As/+ELWJ1h9
         mJmg==
X-Gm-Message-State: APjAAAW8JegaxbVW4mogG6Lp8vYR3y7ZYkBAZg+/u/WMaIFpYoVRxFex
        ui9NRP3WZPYHvQ4zmtb6cDf0X1NCrKvUKyeRi353tfyqgEp75s1cp7ZEl4fhlpWpRp/l8yhgySB
        a1/lMJVXGRugHbUHlM0/BmUD/
X-Received: by 2002:ac8:425a:: with SMTP id r26mr11076778qtm.138.1583052214394;
        Sun, 01 Mar 2020 00:43:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMYTqQtgFiyqEUCgJ67xL8NB+j4+rHKqXYLk2efsRK+7kOAVel5jQPLrgg19sJ2BFDuEog/g==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr11076767qtm.138.1583052214119;
        Sun, 01 Mar 2020 00:43:34 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id a141sm8249950qkb.50.2020.03.01.00.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 00:43:33 -0800 (PST)
Date:   Sun, 1 Mar 2020 03:43:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH 3/3] virtio-net: Introduce hash report feature
Message-ID: <20200301033900-mutt-send-email-mst@kernel.org>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
 <20200229171301.15234-4-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229171301.15234-4-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:13:01PM +0200, Yuri Benditovich wrote:
> The feature VIRTIO_NET_F_HASH_REPORT extends the
> layout of the packet and requests the device to
> calculate hash on incoming packets and report it
> in the packet header.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 7a342657fb6c..6d7230469c57 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> @@ -144,6 +145,23 @@ struct virtio_net_hdr_v1 {
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
>  
> +struct virtio_net_hdr_v1_hash {
> +	struct virtio_net_hdr_v1 hdr;
> +	__virtio32 hash_value;
> +#define VIRTIO_NET_HASH_REPORT_NONE            0
> +#define VIRTIO_NET_HASH_REPORT_IPv4            1
> +#define VIRTIO_NET_HASH_REPORT_TCPv4           2
> +#define VIRTIO_NET_HASH_REPORT_UDPv4           3
> +#define VIRTIO_NET_HASH_REPORT_IPv6            4
> +#define VIRTIO_NET_HASH_REPORT_TCPv6           5
> +#define VIRTIO_NET_HASH_REPORT_UDPv6           6
> +#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> +#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> +#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> +	__virtio16 hash_report;
> +	__virtio16 padding;
> +};
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> @@ -292,6 +310,24 @@ struct virtio_net_rss_config {
>  
>   #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
>  
> +/*
> + * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
> + * to include in the virtio header of the packet the value of the
> + * calculated hash and the report type of hash. It also provides
> + * parameters for hash calculation. The command requires feature
> + * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
> + * layout of virtio header as defined in virtio_net_hdr_v1_hash.
> + */
> +struct virtio_net_hash_config {
> +	__virtio32 hash_types;
> +	/* for compatibility with virtio_net_rss_config */
> +	__virtio16 reserved[4];

I expect these should all be le32/le16 respectively.

> +	__u8 hash_key_length;
> +	__u8 hash_key_data[/*hash_key_length*/];
> +};

Should be /* hash_key_length */ as per coding style.

> +
> + #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
> +
>  /*
>   * Control network offloads
>   *
> -- 
> 2.17.1

