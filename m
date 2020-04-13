Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2154C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BC92072B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htorcfDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BC92072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgDMD6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgDMD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:58:00 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0972CC008681
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586750274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N50RfIS2nCxFimWzt9WF72+xwJQvZPe8nfXlTQ11ak=;
        b=htorcfDPth6FL8HzeDImEy0Hy8Ho2mBEekvEuszT2F8xmx1++jepy6PRbWBNuS8Fvrtl5v
        W66wRzV4h0CSx4VKRn35RSgcjAzPaBoRzW/t2kwqA0US8CCs3M8MaMlDNezYEM7DoObI8v
        fWpS5woy8ZeBKnMXVQMoWgGEZJK5dH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-9CvYkBqvNYWoIq_BU-OEfg-1; Sun, 12 Apr 2020 23:57:52 -0400
X-MC-Unique: 9CvYkBqvNYWoIq_BU-OEfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5E68017F3;
        Mon, 13 Apr 2020 03:57:51 +0000 (UTC)
Received: from [10.72.13.79] (ovpn-13-79.pek2.redhat.com [10.72.13.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D35497AE9;
        Mon, 13 Apr 2020 03:57:46 +0000 (UTC)
Subject: Re: [PATCH v2] vdpa: make vhost, virtio depend on menu
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20200412125018.74964-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1ccf929a-99fc-55ad-3613-146186399c2c@redhat.com>
Date:   Mon, 13 Apr 2020 11:57:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200412125018.74964-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/12 =E4=B8=8B=E5=8D=888:50, Michael S. Tsirkin wrote:
> If user did not configure any vdpa drivers, neither vhost
> nor virtio vdpa are going to be useful. So there's no point
> in prompting for these and selecting vdpa core automatically.
> Simplify configuration by making virtio and vhost vdpa
> drivers depend on vdpa menu entry. Once done, we no longer
> need a separate menu entry, so also get rid of this.
> While at it, fix up the IFC entry: VDPA->vDPA for consistency
> with other places.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>
> changes from v1:
> 	fix up virtio vdpa Kconfig
>
>   drivers/vdpa/Kconfig   | 16 +++++-----------
>   drivers/vhost/Kconfig  |  2 +-
>   drivers/virtio/Kconfig |  2 +-
>   3 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index d0cb0e583a5d..71d9a64f2c7d 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -1,21 +1,16 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -config VDPA
> -	tristate
> +menuconfig VDPA
> +	tristate "vDPA drivers"
>   	help
>   	  Enable this module to support vDPA device that uses a
>   	  datapath which complies with virtio specifications with
>   	  vendor specific control path.
>  =20
> -menuconfig VDPA_MENU
> -	bool "VDPA drivers"
> -	default n
> -
> -if VDPA_MENU
> +if VDPA
>  =20
>   config VDPA_SIM
>   	tristate "vDPA device simulator"
>   	depends on RUNTIME_TESTING_MENU && HAS_DMA
> -	select VDPA
>   	select VHOST_RING
>   	select VHOST_IOTLB
>   	default n
> @@ -25,9 +20,8 @@ config VDPA_SIM
>   	  development of vDPA.
>  =20
>   config IFCVF
> -	tristate "Intel IFC VF VDPA driver"
> +	tristate "Intel IFC VF vDPA driver"
>   	depends on PCI_MSI
> -	select VDPA
>   	default n
>   	help
>   	  This kernel module can drive Intel IFC VF NIC to offload
> @@ -35,4 +29,4 @@ config IFCVF
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called ifcvf.
>  =20
> -endif # VDPA_MENU
> +endif # VDPA
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index cb6b17323eb2..e79cbbdfea45 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -64,7 +64,7 @@ config VHOST_VDPA
>   	tristate "Vhost driver for vDPA-based backend"
>   	depends on EVENTFD
>   	select VHOST
> -	select VDPA
> +	depends on VDPA
>   	help
>   	  This kernel module can be loaded in host kernel to accelerate
>   	  guest virtio devices with the vDPA-based backends.
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 2aadf398d8cc..395c3f4d49cb 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -45,7 +45,7 @@ config VIRTIO_PCI_LEGACY
>  =20
>   config VIRTIO_VDPA
>   	tristate "vDPA driver for virtio devices"
> -	select VDPA
> +	depends on VDPA
>   	select VIRTIO
>   	help
>   	  This driver provides support for virtio based paravirtual

