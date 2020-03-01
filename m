Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945C924697
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGGYvBFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAUGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:06:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgCAUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583093168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILXO2eXZPASOoI7MkLPdupz0F1Xu1tLIw+lHAxhsHxE=;
        b=AGGYvBFZjFkXF6/aG8XT5U2RtaCxQ3PQLXrFssn62fB7RCYABqOuARS+XzMvE5smmUe7oB
        xIgEkAE+9LBbcj15NaO8ePXJAgXrBgXaG5acM2iDNOl8Qm5GCF0Sbq0hBpSZLb57VLyvt4
        lyVBZzAk0faUSOBRKJ8tK4zV7qCucFA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-RLExHw3MO4eA-OId0Q0ayQ-1; Sun, 01 Mar 2020 15:06:06 -0500
X-MC-Unique: RLExHw3MO4eA-OId0Q0ayQ-1
Received: by mail-qt1-f200.google.com with SMTP id r13so7500130qtn.18
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 12:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILXO2eXZPASOoI7MkLPdupz0F1Xu1tLIw+lHAxhsHxE=;
        b=lR3bzmpxTwHYpUEZcUdHKwA0ktHilhHXgc9Qt48F3xFQDx2qLpehUL1+q3atvN6HWk
         jnt5Wc9UvRJgQn0zN71t1gaHKJX4UZGc+LkYmWn/K24esmx5eWyibym6InWpweKxhuf9
         lIdUv0SLsw+nJP34F3z+SZs2QKaFep1ocnb+fRMdj3HoG76m+QK96/A/S1ZUtgRvkyXh
         QVdogAAdTY8XzwIcrn+svb6ETNuL462TNzOENSxHIMNWoi0OkV63rFR3c2xhWgnOmVzR
         P2pxCVUFhZAf4Nd0dXKtZ/kSPXzPAyRFz+rf7+/XBWuyPCp79iFkqTs8WbqEeQoiVYL2
         ZZ6w==
X-Gm-Message-State: ANhLgQ0Idt8jmSnLqTrgd1Pv5iCK9c+SkQhxOsxfe+Za5NoRNPfm8Cfy
        1ztW+djAy2kd80r29oFO9Zx/HT50jNsQALzeyfmrxppWNWOcSzNB7gRZHYtaxaC85WBkoNjqT7z
        /ZWeiKiv3IM+CUC7es/ZYipnY
X-Received: by 2002:a0c:cdc7:: with SMTP id a7mr3159173qvn.33.1583093166038;
        Sun, 01 Mar 2020 12:06:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtGqdq15wkvnSqxM2yybu5grrNXTMhrlBqJgAsLezYpWNDwvB4n42onnk2g6v6fgEux8vlQpQ==
X-Received: by 2002:a0c:cdc7:: with SMTP id a7mr3159160qvn.33.1583093165836;
        Sun, 01 Mar 2020 12:06:05 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id x34sm4591428qta.82.2020.03.01.12.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 12:06:04 -0800 (PST)
Date:   Sun, 1 Mar 2020 15:06:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3 1/3] virtio-net: Introduce extended RSC feature
Message-ID: <20200301145828-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301143302.8556-2-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:33:00PM +0200, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is negotiatede and 'gso_type' field in received packet is not
> GSO_NONE, the device reports number of coalesced packets in
> 'csum_start' field and number of duplicated acks in 'csum_offset'
> field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..19e76b3e3a64 100644
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
> @@ -113,8 +115,24 @@ struct virtio_net_hdr_v1 {
>  	__u8 gso_type;
>  	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
>  	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
> -	__virtio16 csum_start;	/* Position to start checksumming from */
> -	__virtio16 csum_offset;	/* Offset after that to place checksum */
> +	union {
> +		struct {
> +			__virtio16 csum_start;
> +			__virtio16 csum_offset;
> +		};


Pls add comments for this one as well.

> +		struct {
> +			/* Position to start checksumming from */
> +			__virtio16 start;
> +			/* Offset after that to place checksum */
> +			__virtio16 offset;
> +		} csum;

Can we add a comment for csum field pls? E.g.
	/* Checksum calculation */

> +		struct {
> +			/* num of coalesced packets */


num -> Number? Don't abbreviate and upper case for consistency.

> +			__le16 packets;

packets -> coalesced_packets? Or is coalesced segments in fact better?

> +			/* num of duplicated acks */

num -> Number? Don't abbreviate and upper case for consistency.


> +			__le16 dup_acks;
> +		} rsc;

/* Receive Segment Coalescing report */

> +	};
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
>  
> -- 
> 2.17.1

