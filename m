Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354E206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkoW1qpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbgDBPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:01:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388739AbgDBPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585839688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIwTqVDSsfeWrRYzgLqwVlDvPStiUAQNxmE1Ql/H/f0=;
        b=GkoW1qpinFNbZdGt///OAhmZf0TGV4WtYId1BsU5MDbQXBd1poNRQO+3Zt1xrqQ0OKo9Kv
        quN/xDzvHd7a4ArQdEdmBk+Wt00HFWp5J6mz4MBkNwkXXqPVKgCGHOnCjfKJGc9WHGyqRp
        cBYj38CR1OMg2pKRuOkZ64Ss5FS2NTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-LfDGN9UIPmO-AL2Wbi6mkA-1; Thu, 02 Apr 2020 11:01:24 -0400
X-MC-Unique: LfDGN9UIPmO-AL2Wbi6mkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B342107B271;
        Thu,  2 Apr 2020 15:01:23 +0000 (UTC)
Received: from [10.72.12.172] (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F5385C1B0;
        Thu,  2 Apr 2020 15:01:15 +0000 (UTC)
Subject: Re: [PATCH v2] vhost: drop vring dependency on iotlb
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20200402144519.34194-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
Date:   Thu, 2 Apr 2020 23:01:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200402144519.34194-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/2 =E4=B8=8B=E5=8D=8810:46, Michael S. Tsirkin wrote:
> vringh can now be built without IOTLB.
> Select IOTLB directly where it's used.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Applies on top of my vhost tree.
> Changes from v1:
> 	VDPA_SIM needs VHOST_IOTLB


It looks to me the patch is identical to v1.

Thanks


>
>   drivers/vdpa/Kconfig  | 1 +
>   drivers/vhost/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 7db1460104b7..08b615f2da39 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -17,6 +17,7 @@ config VDPA_SIM
>   	depends on RUNTIME_TESTING_MENU
>   	select VDPA
>   	select VHOST_RING
> +	select VHOST_IOTLB
>   	default n
>   	help
>   	  vDPA networking device simulator which loop TX traffic back
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index f0404ce255d1..cb6b17323eb2 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -8,7 +8,6 @@ config VHOST_IOTLB
>  =20
>   config VHOST_RING
>   	tristate
> -	select VHOST_IOTLB
>   	help
>   	  This option is selected by any driver which needs to access
>   	  the host side of a virtio ring.

