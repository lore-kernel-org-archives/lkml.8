Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28674C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9D620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW8YMfVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgCaILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:11:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729624AbgCaILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585642275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzpvZIJ+CRLVofZ/PwFWXaCWdz97NICG/y5tEVt3YUQ=;
        b=GW8YMfVu1PTt52/GGYDBaWEgDGB8wL7VX5DNxcbm3nU+2KtaR3q6KJhjdS43q6NnkMX3q4
        Xf2rJPkJ26e6gaUM4V8tCtrwv7ww3l4B5R8jF6MZ2gapXhxTPyJ3KWPMIcv/plyRgGOdVK
        40J/DrUoPCC4J9DrBGJZdhhKew5BOA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ZYcL_ET-MAaE6ZBAqMMkRw-1; Tue, 31 Mar 2020 04:11:11 -0400
X-MC-Unique: ZYcL_ET-MAaE6ZBAqMMkRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D5E8017CC;
        Tue, 31 Mar 2020 08:11:09 +0000 (UTC)
Received: from [10.72.12.115] (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAE2619C58;
        Tue, 31 Mar 2020 08:11:04 +0000 (UTC)
Subject: Re: [PATCH -next] virtio: vdpa: remove unused variables 'ifcvf' and
 'ifcvf_lm'
To:     YueHaibing <yuehaibing@huawei.com>, mst@redhat.com,
        tiwei.bie@intel.com, lingshan.zhu@intel.com, xiao.w.wang@intel.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200331080259.33056-1-yuehaibing@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a69f59a7-f0cc-6b8b-6c3d-61ef72b3ec38@redhat.com>
Date:   Tue, 31 Mar 2020 16:11:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331080259.33056-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/31 =E4=B8=8B=E5=8D=884:02, YueHaibing wrote:
> drivers/virtio/vdpa/ifcvf/ifcvf_main.c:34:24:
>   warning: variable =E2=80=98ifcvf=E2=80=99 set but not used [-Wunused-=
but-set-variable]
> drivers/virtio/vdpa/ifcvf/ifcvf_base.c:304:31:
>   warning: variable =E2=80=98ifcvf_lm=E2=80=99 set but not used [-Wunus=
ed-but-set-variable]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/virtio/vdpa/ifcvf/ifcvf_base.c | 2 --
>   drivers/virtio/vdpa/ifcvf/ifcvf_main.c | 2 --
>   2 files changed, 4 deletions(-)
>
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/virtio/vd=
pa/ifcvf/ifcvf_base.c
> index b61b06ea26d3..e24371d644b5 100644
> --- a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> @@ -301,12 +301,10 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 q=
id, u64 num)
>  =20
>   static int ifcvf_hw_enable(struct ifcvf_hw *hw)
>   {
> -	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
>   	struct virtio_pci_common_cfg __iomem *cfg;
>   	struct ifcvf_adapter *ifcvf;
>   	u32 i;
>  =20
> -	ifcvf_lm =3D (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
>   	ifcvf =3D vf_to_adapter(hw);
>   	cfg =3D hw->common_cfg;
>   	ifc_iowrite16(IFCVF_MSI_CONFIG_OFF, &cfg->msix_config);
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/virtio/vd=
pa/ifcvf/ifcvf_main.c
> index 8d54dc5b08d2..28d9e5de5675 100644
> --- a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> @@ -31,11 +31,9 @@ static irqreturn_t ifcvf_intr_handler(int irq, void =
*arg)
>   static int ifcvf_start_datapath(void *private)
>   {
>   	struct ifcvf_hw *vf =3D ifcvf_private_to_vf(private);
> -	struct ifcvf_adapter *ifcvf;
>   	u8 status;
>   	int ret;
>  =20
> -	ifcvf =3D vf_to_adapter(vf);
>   	vf->nr_vring =3D IFCVF_MAX_QUEUE_PAIRS * 2;
>   	ret =3D ifcvf_start_hw(vf);
>   	if (ret < 0) {

