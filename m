Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1D2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ6FUdTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgDAGdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:33:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731860AbgDAGdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585722786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JU2gGDmlwnwGl6ycj3faEZggWtmCNjTPrCPYS6/C+MQ=;
        b=BJ6FUdTrs5DZq0zdgox0x9YwgNk5Kbku7SsP2DV2RVsE5z7/9uaIJoMgOqR21Oijc+pg4U
        bwSMiVQz6WuXO4HjukIBIFcH+jCl7MGSTk02PbxJIWrYL2LHWW1RU09g5l6IiQ4n3cFyfr
        /eu0/MDfp48ccEqrnAS9rJkrhQRO+o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-G9nP1vRIPQObXvBF-F-xEg-1; Wed, 01 Apr 2020 02:33:03 -0400
X-MC-Unique: G9nP1vRIPQObXvBF-F-xEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627CF19057B8;
        Wed,  1 Apr 2020 06:33:02 +0000 (UTC)
Received: from [10.72.12.139] (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8305DA0F2;
        Wed,  1 Apr 2020 06:32:57 +0000 (UTC)
Subject: Re: [PATCH] vdpa: move to drivers/vdpa
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        virtualization@lists.linux-foundation.org
References: <20200331191825.249436-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ee5c17e0-0e28-8979-ff6a-5ea1659a24e0@redhat.com>
Date:   Wed, 1 Apr 2020 14:32:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331191825.249436-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/1 =E4=B8=8A=E5=8D=883:19, Michael S. Tsirkin wrote:
> We have both vhost and virtio drivers that depend on vdpa.
> It's easier to locate it at a top level directory otherwise
> we run into issues e.g. if vhost is built-in but virtio
> is modular.  Let's just move it up a level.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>
> Randy I'd say the issue you are reporting (vhost=3Dy, virtio=3Dm)
> is esoteric enough not to require a rebase for this.
> So I'd just apply this on top.
> Do you agree?
>
>   MAINTAINERS                                   | 1 +
>   drivers/Kconfig                               | 2 ++
>   drivers/Makefile                              | 1 +
>   drivers/{virtio =3D> }/vdpa/Kconfig             | 0
>   drivers/{virtio =3D> }/vdpa/Makefile            | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/Makefile      | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.c  | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.h  | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_main.c  | 0
>   drivers/{virtio =3D> }/vdpa/vdpa.c              | 0
>   drivers/{virtio =3D> }/vdpa/vdpa_sim/Makefile   | 0
>   drivers/{virtio =3D> }/vdpa/vdpa_sim/vdpa_sim.c | 0
>   drivers/virtio/Kconfig                        | 2 --
>   13 files changed, 4 insertions(+), 2 deletions(-)
>   rename drivers/{virtio =3D> }/vdpa/Kconfig (100%)
>   rename drivers/{virtio =3D> }/vdpa/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.h (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_main.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa_sim/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa_sim/vdpa_sim.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 70c47bc55343..7cfa55c765fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17695,6 +17695,7 @@ L:	virtualization@lists.linux-foundation.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/virtio/
>   F:	drivers/virtio/
> +F:	drivers/vdpa/
>   F:	tools/virtio/
>   F:	drivers/net/virtio_net.c
>   F:	drivers/block/virtio_blk.c
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 7a6d8b2b68b4..ac23d520e916 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
>  =20
>   source "drivers/virtio/Kconfig"
>  =20
> +source "drivers/vdpa/Kconfig"
> +
>   source "drivers/vhost/Kconfig"
>  =20
>   source "drivers/hv/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 31cf17dee252..21688f3b1588 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+=3D dma/
>   obj-y				+=3D soc/
>  =20
>   obj-$(CONFIG_VIRTIO)		+=3D virtio/
> +obj-$(CONFIG_VDPA)		+=3D vdpa/
>   obj-$(CONFIG_XEN)		+=3D xen/
>  =20
>   # regulators early, since some subsystems rely on them to initialize
> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/vdpa/Kconfig
> similarity index 100%
> rename from drivers/virtio/vdpa/Kconfig
> rename to drivers/vdpa/Kconfig
> diff --git a/drivers/virtio/vdpa/Makefile b/drivers/vdpa/Makefile
> similarity index 100%
> rename from drivers/virtio/vdpa/Makefile
> rename to drivers/vdpa/Makefile
> diff --git a/drivers/virtio/vdpa/ifcvf/Makefile b/drivers/vdpa/ifcvf/Ma=
kefile
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/Makefile
> rename to drivers/vdpa/ifcvf/Makefile
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcv=
f/ifcvf_base.c
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> rename to drivers/vdpa/ifcvf/ifcvf_base.c
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcv=
f/ifcvf_base.h
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.h
> rename to drivers/vdpa/ifcvf/ifcvf_base.h
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcv=
f/ifcvf_main.c
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> rename to drivers/vdpa/ifcvf/ifcvf_main.c
> diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa.c
> rename to drivers/vdpa/vdpa.c
> diff --git a/drivers/virtio/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_=
sim/Makefile
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa_sim/Makefile
> rename to drivers/vdpa/vdpa_sim/Makefile
> diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdp=
a_sim/vdpa_sim.c
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
> rename to drivers/vdpa/vdpa_sim/vdpa_sim.c
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 99e424570644..2aadf398d8cc 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -109,5 +109,3 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>   	 If unsure, say 'N'.
>  =20
>   endif # VIRTIO_MENU
> -
> -source "drivers/virtio/vdpa/Kconfig"

