Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA5C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1417207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABcJ4iWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMLIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:08:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59374 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbgAMLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578913687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHUwvC4V45pQBl3YOQgs1FSsgQ9Xms/WHSg7K9Kokh4=;
        b=ABcJ4iWv56tFlpv15B1BaU+J1SrHOArf94yDpihdmzIQP7b7U2Z0hPMDOnqe+B1UFCzzPK
        +WME1A02BN60UM2tjG3RKp0d7OzVxOyT5VsZywfaf6A+rdfPEJP+aEWZijkXT5sJikEs8H
        kAm+P6NUAQN/bqCqAfNfAFQijvikKvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-HyVeANQYPxm5Op4tY6G7AQ-1; Mon, 13 Jan 2020 06:08:06 -0500
X-MC-Unique: HyVeANQYPxm5Op4tY6G7AQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B7BB1005514;
        Mon, 13 Jan 2020 11:08:05 +0000 (UTC)
Received: from [10.72.12.51] (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209CE5C1BB;
        Mon, 13 Jan 2020 11:07:57 +0000 (UTC)
Subject: Re: [PATCH v2] virtio-net: Introduce extended RSC feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
References: <20200113081736.2340-1-yuri.benditovich@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bdc6cb05-30d1-b4fd-512e-740b2550c14e@redhat.com>
Date:   Mon, 13 Jan 2020 19:07:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200113081736.2340-1-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/13 =E4=B8=8B=E5=8D=884:17, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is negotiatede and 'gso_type' field in received packet is not
> GSO_NONE, the device reports number of coalesced packets in
> 'csum_start' field and number of duplicated acks in 'csum_offset'
> field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>


Hi Yuri:

Is the feature used by Linux? If yes, it's better to include the real use=
r.


> ---
>   include/uapi/linux/virtio_net.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> index a3715a3224c1..2bdd26f8a4ed 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,7 +56,7 @@
>   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> -
> +#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */


Is this better to keep the newline around?


>   #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another devic=
e
>   					 * with the same MAC.
>   					 */
> @@ -104,6 +104,7 @@ struct virtio_net_config {
>   struct virtio_net_hdr_v1 {
>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset =
*/
>   #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc_ext data in csum_ fields */
>   	__u8 flags;
>   #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
>   #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
> @@ -118,6 +119,13 @@ struct virtio_net_hdr_v1 {
>   	__virtio16 num_buffers;	/* Number of merged rx buffers */
>   };
>  =20
> +/*
> + * if VIRTIO_NET_F_RSC_EXT feature has been negotiated and
> + * VIRTIO_NET_HDR_F_RSC_INFO is set in RX packet
> + */
> +#define virtio_net_rsc_ext_num_packets	csum_start
> +#define virtio_net_rsc_ext_num_dupacks	csum_offset


This looks sub-optimal, it looks to me union is better?

Thanks


> +
>   #ifndef VIRTIO_NET_NO_LEGACY
>   /* This header comes first in the scatter-gather list.
>    * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it mu=
st

