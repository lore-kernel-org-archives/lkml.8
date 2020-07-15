Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53BB2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB781OHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgGOOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:02:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727822AbgGOOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594821764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvHDwOoLbdSaOIDbTqIso84H/Gr3/SW89Du8SzMSm1c=;
        b=MB781OHZ2jB0ROJWdNwp4VMIUZlnqcWNnFT/x0wbwCeFytwG2f8+4HgAVXtcELhNivIluD
        5jhxpUwpLY0wG1zG9SuK0R2rknXVKKkLxG8AHJWMf89bfMPxr1qYN/ZIAk1bMG7FzdxblL
        TpXm4p8YkcrbtR4pYcZd9Y3Ituq1m9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-X7wHNdWnOBqDZp5sCk_oAw-1; Wed, 15 Jul 2020 10:02:42 -0400
X-MC-Unique: X7wHNdWnOBqDZp5sCk_oAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3334880572E;
        Wed, 15 Jul 2020 14:02:41 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4900B19C4F;
        Wed, 15 Jul 2020 14:02:35 +0000 (UTC)
Subject: Re: [PATCH RFC don't apply] vdpa_sim: endian-ness for config space
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200715135540.22832-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8f39dcc1-0899-7ed8-8a6e-75672417b9e3@redhat.com>
Date:   Wed, 15 Jul 2020 22:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715135540.22832-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/15 下午9:58, Michael S. Tsirkin wrote:
> VDPA sim stores config space as native endian, but that
> is wrong: modern guests expect LE.
> I coded up the following to fix it up, but it is wrong too:
> vdpasim_create is called before guest features are known.
>
> So what should we do? New ioctl to specify the interface used?
> More ideas?
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Can we do the endian conversion in set_config/get_config()?

Thanks


>
>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index a9bc5e0fb353..cc754ae0ec15 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -24,6 +24,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/vringh.h>
>   #include <linux/vdpa.h>
> +#include <linux/virtio_byteorder.h>
>   #include <linux/vhost_iotlb.h>
>   #include <uapi/linux/virtio_config.h>
>   #include <uapi/linux/virtio_net.h>
> @@ -72,6 +73,23 @@ struct vdpasim {
>   	u64 features;
>   };
>   
> +/* TODO: cross-endian support */
> +static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
> +{
> +	return virtio_legacy_is_little_endian() ||
> +		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
> +}
> +
> +static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
> +{
> +	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
> +}
> +
> +static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
> +{
> +	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
> +}
> +
>   static struct vdpasim *vdpasim_dev;
>   
>   static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> @@ -332,8 +350,8 @@ static struct vdpasim *vdpasim_create(void)
>   		goto err_iommu;
>   
>   	config = &vdpasim->config;
> -	config->mtu = 1500;
> -	config->status = VIRTIO_NET_S_LINK_UP;
> +	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> +	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>   	eth_random_addr(config->mac);
>   
>   	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);

