Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C36C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5864F2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOm7jvz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgFSHyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:54:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729548AbgFSHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592553270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bryp9+XYVmgJRh4PMhNskE1wuXqIjMfjYcFoobgkJo4=;
        b=dOm7jvz0s4gxSWMPdcn6uyRgZEnBIkLKe6uzT6tiHE3QrkrQRRS5xlDRfQ/1FtGHgz4XL/
        85I9C5WbEGjtw0EsOSxtmsnAqIoNA56xwIyLFOwxBRkQmYxUf6A3Mim1ZpGlb6RldI5kLK
        /89sKd0DA/DwrmhRiZEOFMklSf+5QF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-jVicbQ_XMoyMczAOJrkecQ-1; Fri, 19 Jun 2020 03:54:27 -0400
X-MC-Unique: jVicbQ_XMoyMczAOJrkecQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B191B873074;
        Fri, 19 Jun 2020 07:54:26 +0000 (UTC)
Received: from [10.72.13.200] (ovpn-13-200.pek2.redhat.com [10.72.13.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6BD45C1BB;
        Fri, 19 Jun 2020 07:54:20 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: Fix build error due to improper use 'select'
To:     Weilong Chen <chenweilong@huawei.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org, lizefan@huawei.com
Cc:     linux-kernel@vger.kernel.org
References: <20200619080333.194753-1-chenweilong@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <953448d3-9e7c-3a96-b28b-edaf8b775e4d@redhat.com>
Date:   Fri, 19 Jun 2020 15:54:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619080333.194753-1-chenweilong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/19 下午4:03, Weilong Chen wrote:
> As noted in:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
> "select should be used with care. select will force a symbol to a
> value without visiting the dependencies."
> Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
> Otherwise it will cause an error:
> https://bugzilla.kernel.org/show_bug.cgi?id=208245
>
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
>   drivers/virtio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..5c92e4a50882 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -85,7 +85,7 @@ config VIRTIO_MEM
>   	depends on VIRTIO
>   	depends on MEMORY_HOTPLUG_SPARSE
>   	depends on MEMORY_HOTREMOVE
> -	select CONTIG_ALLOC
> +	depends on CONTIG_ALLOC
>   	help
>   	 This driver provides access to virtio-mem paravirtualized memory
>   	 devices, allowing to hotplug and hotunplug memory.


Acked-by: Jason Wang <jasowang@redhat.com>

