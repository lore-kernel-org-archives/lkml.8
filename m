Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C68C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205E220769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkCrzYWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDJCbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:31:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgDJCbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586485914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReY0zPHNpW7Jzyke6wRlOB3aMGGtHD3+Ak3PVHlfvWQ=;
        b=OkCrzYWDCY+2sWxJ4CQ3bOqopTXbR8kB/f8aQk7MLec4n0a3ZcfwyvuK/RXs1zFkOzIuMS
        SyNtZJPu/zg6Fg45PuDeuhCIhFkb89P7GdFZDRITsZs3VtpH8v4iLbyDOaYxe4CU5Ay51U
        +WNduHsxwHngUq3vGZH4rE+SG6r4KxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-gdLCRZsxOdup0vSP7zyKJw-1; Thu, 09 Apr 2020 22:31:52 -0400
X-MC-Unique: gdLCRZsxOdup0vSP7zyKJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA251800D4A;
        Fri, 10 Apr 2020 02:31:51 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9350D5C1C3;
        Fri, 10 Apr 2020 02:31:46 +0000 (UTC)
Subject: Re: [PATCH] vdpa: allow a 32 bit vq alignment
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org
References: <20200409202825.10115-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dc49858e-a71d-7bb4-29db-5cb5d1c3e181@redhat.com>
Date:   Fri, 10 Apr 2020 10:31:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200409202825.10115-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/10 =E4=B8=8A=E5=8D=884:28, Michael S. Tsirkin wrote:
> get_vq_align returns u16 now, but that's not enough for
> systems/devices with 64K pages. All callers assign it to
> a u32 variable anyway, so let's just change the return
> value type to u32.
>
> Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


>   drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   include/linux/vdpa.h             | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf=
_main.c
> index 28d9e5de5675..abf6a061cab6 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct vdpa_dev=
ice *vdpa_dev)
>   	return IFCVF_SUBSYS_VENDOR_ID;
>   }
>  =20
> -static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> +static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>   {
>   	return IFCVF_QUEUE_ALIGNMENT;
>   }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> index 72863d01a12a..7957d2d41fc4 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct vdpa_device =
*vdpa, u16 idx)
>   	return vrh->last_avail_idx;
>   }
>  =20
> -static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> +static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>   {
>   	return VDPASIM_QUEUE_ALIGN;
>   }
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 733acfb7ef84..5453af87a33e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -164,7 +164,7 @@ struct vdpa_config_ops {
>   	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
>  =20
>   	/* Device ops */
> -	u16 (*get_vq_align)(struct vdpa_device *vdev);
> +	u32 (*get_vq_align)(struct vdpa_device *vdev);
>   	u64 (*get_features)(struct vdpa_device *vdev);
>   	int (*set_features)(struct vdpa_device *vdev, u64 features);
>   	void (*set_config_cb)(struct vdpa_device *vdev,

