Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C186C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D297121D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4zjHySO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgIJCyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:54:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730193AbgIJB4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599702992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0C1QtHwLo5ZP+Ar8+ErpMK60qaWJInbsQRohKM7A1QA=;
        b=b4zjHySOiKU+WfwFqg08c1d546JSHBRhPhv+QR5crm4IZB0Htw/xPiVmSilit8D//rG9/R
        6kmt0Ju/ZkRJwpY9A2BZ6yhxwtcSGE1hU8R5Zdf7gr0vgO4hEFeKxXCvkxLtHyZaK0yctQ
        c5gPBfQ8FXS6w77GRJJPPAk7PUCqA3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-ZMZwJTTFNGOE9gvdtSDulw-1; Wed, 09 Sep 2020 21:56:28 -0400
X-MC-Unique: ZMZwJTTFNGOE9gvdtSDulw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D6F593B2;
        Thu, 10 Sep 2020 01:56:24 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0B3B60BF1;
        Thu, 10 Sep 2020 01:56:06 +0000 (UTC)
Subject: Re: [PATCH] vhost-vdpa: fix memory leak in error path
To:     Li Qiang <liq3ea@163.com>, mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        liq3ea@gmail.com
References: <20200909154120.363209-1-liq3ea@163.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bfae5c35-355a-8d8a-5057-a970db24ee41@redhat.com>
Date:   Thu, 10 Sep 2020 09:56:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909154120.363209-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/9 下午11:41, Li Qiang wrote:
> Free the 'page_list' when the 'npages' is zero.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   drivers/vhost/vdpa.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f88894..6a9fcaf1831d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -609,8 +609,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   		gup_flags |= FOLL_WRITE;
>   
>   	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
> -	if (!npages)
> -		return -EINVAL;
> +	if (!npages) {
> +		ret = -EINVAL;
> +		goto free_page;
> +	}
>   
>   	mmap_read_lock(dev->mm);
>   
> @@ -666,6 +668,8 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   		atomic64_sub(npages, &dev->mm->pinned_vm);
>   	}
>   	mmap_read_unlock(dev->mm);
> +
> +free_page:
>   	free_page((unsigned long)page_list);
>   	return ret;
>   }


Cc: stable@vger.kernel.org

Acked-by: Jason Wang <jasowang@redhat.com>



