Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D43C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0CB20678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnfdUpuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgDFAeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 20:34:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727841AbgDFAeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 20:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586133264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/vU8MPciUEqUMtuOa12EqTvgqLpKqD2sEwuhY285Sk=;
        b=OnfdUpuOW/zwoZCf8RZ+i9RoDvIZvt8Eotq4i0jn7CvV+59zdyBq7XE3A84jlfZDQLPf61
        PSA8fnoG67vPuHbyGSEz0oaYtCW5HR1UZZlaoCaAMjZVEGV6FxwRdVbwIcs25qhz/s/nDL
        2LdiZVQhmtSc8aN38/IKCYZ4WmDRyG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-C48CUeNuPK-LR6V2Au67Vw-1; Sun, 05 Apr 2020 20:34:22 -0400
X-MC-Unique: C48CUeNuPK-LR6V2Au67Vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3396F1005513;
        Mon,  6 Apr 2020 00:34:21 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF78385;
        Mon,  6 Apr 2020 00:34:17 +0000 (UTC)
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200405081355.2870-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6e2ad3e3-c4cb-98cb-e15d-8d9e7aa14f50@redhat.com>
Date:   Mon, 6 Apr 2020 08:34:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/5 =E4=B8=8B=E5=8D=884:14, Michael S. Tsirkin wrote:
> set_dma_ops isn't available on all architectures:
>
>          make ARCH=3Dum
> ...
>
>     drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
>>> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration o=
f function 'set_dma_ops'; did you mean 'set_groups'?
> +[-Werror=3Dimplicit-function-declaration]
>       set_dma_ops(dev, &vdpasim_dma_ops);
>       ^~~~~~~~~~~
>       set_groups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vdpa/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 08b615f2da39..d0cb0e583a5d 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -14,7 +14,7 @@ if VDPA_MENU
>  =20
>   config VDPA_SIM
>   	tristate "vDPA device simulator"
> -	depends on RUNTIME_TESTING_MENU
> +	depends on RUNTIME_TESTING_MENU && HAS_DMA
>   	select VDPA
>   	select VHOST_RING
>   	select VHOST_IOTLB


Acked-by: Jason Wang <jasowang@redhat.com>


