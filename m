Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6302076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIjjkgQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgFHF77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:59:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFHF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591595997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEx8ZqL8ihg/Wp01+GT3ORMPuHVkx1qLDRLe1b2G/YM=;
        b=MIjjkgQmmtGUVwTAbCE1+ib8Wou8DWJe/jhaTbLRfVYOnt2dBFRKt5ak/fYPJDxDEoCOvL
        Z3tMvmwI35Zq3CbcDulgtfPzjF24Pk6kP8RswLpRC8Fnmt+q9Y+3dIOQ1Xub6vE/lIiPmN
        JMIeOnhRSpfX5gp8R/lCMYqTS+n7N6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-uAPymGhDMT-eKX29LkcFSA-1; Mon, 08 Jun 2020 01:59:55 -0400
X-MC-Unique: uAPymGhDMT-eKX29LkcFSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D7818A8220;
        Mon,  8 Jun 2020 05:59:54 +0000 (UTC)
Received: from [10.72.13.71] (ovpn-13-71.pek2.redhat.com [10.72.13.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBCA1A927;
        Mon,  8 Jun 2020 05:59:42 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: drop unnecessary initialization
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org
References: <20200608054517.708167-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5d00d5e0-0430-dabd-9486-ca363453928f@redhat.com>
Date:   Mon, 8 Jun 2020 13:59:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608054517.708167-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/8 下午1:45, Michael S. Tsirkin wrote:
> rc is initialized to -ENIVAL but that's never used. Drop it.
>
> Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149be..2f357142ea5e 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1768,7 +1768,7 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
>   static int virtio_mem_probe(struct virtio_device *vdev)
>   {
>   	struct virtio_mem *vm;
> -	int rc = -EINVAL;
> +	int rc;
>   
>   	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
>   	BUILD_BUG_ON(sizeof(struct virtio_mem_resp) != 10);


Acked-by: Jason Wang <jasowang@redhat.com>


