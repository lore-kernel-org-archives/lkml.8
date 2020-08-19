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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6212BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB372078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg4bH26Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHSCzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:55:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727870AbgHSCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597805742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzuFejnUa6/7SvIdePc4Dxw6u4PQ7TGHV2322mPlU3g=;
        b=Zg4bH26Y8rjqSJ6sWS3hcd01p32P0fCt6lGVs8Gkyo2PpNVsYQEBJ1IQnIpPdHCFDywBn0
        XpZ6SyvwSMU6Cp+KkmMrfMN31FszRWnF074ZaootkGWK9KthTjBMeuMfTjVsL6widEQdWM
        XD6SeyhwgQrmZ/W1sTaWyYGualwu09M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-oPiGWvAuMPyaXe1nKkF9KA-1; Tue, 18 Aug 2020 22:55:40 -0400
X-MC-Unique: oPiGWvAuMPyaXe1nKkF9KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817141DDF4;
        Wed, 19 Aug 2020 02:55:39 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22C73BA63;
        Wed, 19 Aug 2020 02:55:33 +0000 (UTC)
Subject: Re: [PATCH -next] vdpa: Remove duplicate include
To:     YueHaibing <yuehaibing@huawei.com>, mst@redhat.com,
        tiwei.bie@intel.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200818114906.58304-1-yuehaibing@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <13e0a08e-abda-9b0d-53b0-03f6948a80f3@redhat.com>
Date:   Wed, 19 Aug 2020 10:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818114906.58304-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/18 下午7:49, YueHaibing wrote:
> Remove duplicate include file
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/vhost/vdpa.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f88894..95e2b8307a2a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -22,7 +22,6 @@
>   #include <linux/nospec.h>
>   #include <linux/vhost.h>
>   #include <linux/virtio_net.h>
> -#include <linux/kernel.h>
>   
>   #include "vhost.h"
>   


Acked-by: Jason Wang <jasowang@redhat.com>


