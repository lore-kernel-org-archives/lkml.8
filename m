Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2078F2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9lP0Aqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHSCyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:54:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgHSCyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597805680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahx8zbWbxakgvDf9IO2/ggdi+fLoNSHfDPszQBbqkgk=;
        b=H9lP0AqiqT3o9bbUjm2r3VD/cFD/Z3AYuLjVc3F33AYVIdgIJJVdymeq+5qVjl9CX+k/EA
        ARGDCMYZmKAFAbtK/lt1grLFFhcQisHkcMsDv4gPwdSK1GZ3vI2Mrf8wlVU4m43CXBHO1Y
        r9qe+mIDIE/34R4ZVcaoex7RAV52Ez0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-gf9ngqChPNuCN9cJndog3A-1; Tue, 18 Aug 2020 22:54:38 -0400
X-MC-Unique: gf9ngqChPNuCN9cJndog3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 064BA18686FD;
        Wed, 19 Aug 2020 02:54:37 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE8165C88B;
        Wed, 19 Aug 2020 02:54:31 +0000 (UTC)
Subject: Re: [PATCH -next] vdpa/mlx5: Remove duplicate include
To:     YueHaibing <yuehaibing@huawei.com>, mst@redhat.com,
        eli@mellanox.com, colin.king@canonical.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200818114601.21656-1-yuehaibing@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <905318ea-d48a-7110-9476-da2670382614@redhat.com>
Date:   Wed, 19 Aug 2020 10:54:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818114601.21656-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/18 下午7:46, YueHaibing wrote:
> Remove duplicate include file
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9df69d5efe8c..12fb83dc1de9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -8,7 +8,6 @@
>   #include <linux/mlx5/device.h>
>   #include <linux/mlx5/vport.h>
>   #include <linux/mlx5/fs.h>
> -#include <linux/mlx5/device.h>
>   #include "mlx5_vnet.h"
>   #include "mlx5_vdpa_ifc.h"
>   #include "mlx5_vdpa.h"


Acked-by: Jason Wang <jasowang@redhat.com>


