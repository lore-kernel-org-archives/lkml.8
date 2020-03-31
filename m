Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C407720714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaRCHTaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgCaCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:30:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24957 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgCaCac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585621831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsl49OvShhmWZCf+bSTPRyE+QTl5dWx0SrA+7/pmPto=;
        b=VaRCHTaMDTRhvPV1C19ao4Z6LrAyjFL8pEAbImhMsBQPBh17A/lEqdIZbtOK8EpqKDNj2q
        vadzJ3CirTY64yN+nC6r0y02Kjjv+OBM/fCVfOChze0p1el3JzJ/YWE5LwOvhtuR3+DTq3
        sRZCdOb9gTHdsIPQ3FyVOIcTUjCMwVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-y--Ksd8yOb2LclOISZ3Log-1; Mon, 30 Mar 2020 22:30:27 -0400
X-MC-Unique: y--Ksd8yOb2LclOISZ3Log-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85EB518C8C01;
        Tue, 31 Mar 2020 02:30:26 +0000 (UTC)
Received: from [10.72.12.115] (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 426F460BE2;
        Tue, 31 Mar 2020 02:30:20 +0000 (UTC)
Subject: Re: [PATCH][next] virtio: fix spelling mistake "confiugration" ->
 "configuration"
To:     Colin King <colin.king@canonical.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>, tiwei.bie@intel.com,
        Wang Xiao <xiao.w.wang@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330101901.162407-1-colin.king@canonical.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cb50bee4-5051-945b-cb62-87708f5d4083@redhat.com>
Date:   Tue, 31 Mar 2020 10:30:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200330101901.162407-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/30 =E4=B8=8B=E5=8D=886:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two spelling mistakes of configuration in IFCVF_ERR error
> messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/virtio/vdpa/ifcvf/ifcvf_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/virtio/vd=
pa/ifcvf/ifcvf_main.c
> index 8d54dc5b08d2..111ac12f6c8e 100644
> --- a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> @@ -340,14 +340,14 @@ static int ifcvf_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  =20
>   	ret =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>   	if (ret) {
> -		IFCVF_ERR(pdev, "No usable DMA confiugration\n");
> +		IFCVF_ERR(pdev, "No usable DMA configuration\n");
>   		return ret;
>   	}
>  =20
>   	ret =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
>   	if (ret) {
>   		IFCVF_ERR(pdev,
> -			  "No usable coherent DMA confiugration\n");
> +			  "No usable coherent DMA configuration\n");
>   		return ret;
>   	}
>  =20


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

