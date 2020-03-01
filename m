Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FBF214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT4Mg/8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCALbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:31:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725812AbgCALbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583062279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5xDhBGVr9c1BXhYRdm31X1rXWV39DILtVF22GzCedds=;
        b=iT4Mg/8YQ7X/g8aF19palL2RcOxRL8OD0wffl1TWiDHHiHsZang0UIdd4x8xFepOY044f/
        kiVZtPDph+zNoy5Jf29VdRdWaJXL7UJVFICiLn0NLBeaou1JHUjtoWHG///HsF2lxSPWdM
        pjWSCfWJTxA7wTjiv08eISiVu8DyiWk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-dUYF-b7BPpq5OckarP-thQ-1; Sun, 01 Mar 2020 06:31:17 -0500
X-MC-Unique: dUYF-b7BPpq5OckarP-thQ-1
Received: by mail-qv1-f69.google.com with SMTP id f17so6636006qvi.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xDhBGVr9c1BXhYRdm31X1rXWV39DILtVF22GzCedds=;
        b=mvco8e/+mnIceZIsxeKmijq8kqH5D6LVTPmqHoY+mG3V3ri5v9/HoBR/EhOhWjprIT
         TJA4zuRJbzgATIXoKf1G8IHWIeGUTn1ap11ZlnpZwY0rhTsxIPd1/Clx4qnHrAyB8vEr
         NI+uNpCIxvN1MTt3hgVbWhGSpxxcQ5oqrH0Jco6cxGLkpmL6Q7P7dU/bApre6DMqNxU6
         SRZMsLdyjwcU2NcMrlzYg6NNX9z2f9hYB4NSQ6WLPT4igvAC8qZrE6dKO6hI9wTLqCw3
         wiM/FYC8Y0tmHe12qSNlnxrvePZ1FJrqNFugIrgt+7rP/JrG56mPiEiRAdmRibTvvIHU
         n/vw==
X-Gm-Message-State: APjAAAUW/HAYbEie5gQZoIZQ95dm9uHyOgu/RUFY0hfIG9pjbuS+9eC2
        3nXfr5kRxhzs2GqzWRMbLXVfNXTy+V8PCLVYEf8JuwS9qApp2ngT9JZ0ymcGcc3ss62wbrZAfzn
        e7hv+KzL/pqxVMt3qEmO2b0op
X-Received: by 2002:a37:947:: with SMTP id 68mr11969984qkj.227.1583062276724;
        Sun, 01 Mar 2020 03:31:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBaNBC3EsSqJsn96nKXNvoVQHpYbPD8ZeiLij0I5FhJABuYT3C2FsJzahz5IjDClPNrmkA5Q==
X-Received: by 2002:a37:947:: with SMTP id 68mr11969960qkj.227.1583062276419;
        Sun, 01 Mar 2020 03:31:16 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id b25sm8236813qkh.6.2020.03.01.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 03:31:15 -0800 (PST)
Date:   Sun, 1 Mar 2020 06:31:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH v2 1/3] virtio-net: Introduce extended RSC feature
Message-ID: <20200301061745-mutt-send-email-mst@kernel.org>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
 <20200301110733.20197-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301110733.20197-2-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 01:07:31PM +0200, Yuri Benditovich wrote:
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
> index a3715a3224c1..536152fad3c4 100644
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
> +		__le16 rsc_ext_num_packets; /* num of coalesced packets */
> +	};
> +	union {
> +		__virtio16 csum_offset;	/* Offset after that to place checksum */
> +		__le16 rsc_ext_num_dupacks; /* num of duplicated acks */

dupacks -> dup_acks ?

Also wouldn't it be cleaner to have an rsc struct? And "num" is kind of
extraneous, right?
So how about we group the fields:

union {
	/* Unnamed struct for compatiblity. */
	struct {
		csum_start
		csum_offset
	};
	struct {
		virtio16 start;
		virtio16 offset;
	} csum;
	struct {
		le16 packets;
		le16 dup_acks;
	} rsc;
};


what do you think?


> +	};
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };



> -- 
> 2.17.1

