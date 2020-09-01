Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECF12073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFRfv6di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIADHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgIADHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598929626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiMSZ2Bp0rwp10xCJBRx9TIWLthoqJ/GxVfGBmzS4Dk=;
        b=FFRfv6dirw3flLTjWX2gtKolwSSfxl85VRGWxQQ9PTmQwpRDI3nivSpHJf8FxSO77UQ4ja
        ycSTy7ZGfgUEDR5wai/eIXDD1LtJplbo0zywQw99Ya5nWypUgJ7gAncQQH6Tx/bmHtm/pL
        YZ43wEGJE2mYCBwhq29Gj7alTlF+l24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-G9NcSATZMni7qWSgOVtv-A-1; Mon, 31 Aug 2020 23:07:04 -0400
X-MC-Unique: G9NcSATZMni7qWSgOVtv-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE84C1888A1E;
        Tue,  1 Sep 2020 03:07:02 +0000 (UTC)
Received: from [10.72.13.164] (ovpn-13-164.pek2.redhat.com [10.72.13.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B891A7EB8A;
        Tue,  1 Sep 2020 03:06:57 +0000 (UTC)
Subject: Re: [PATCH net-next] vhost: fix typo in error message
To:     Yunsheng Lin <linyunsheng@huawei.com>, mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <26f844a5-c7de-cb0b-35eb-e6e30425ed35@redhat.com>
Date:   Tue, 1 Sep 2020 11:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/1 上午10:39, Yunsheng Lin wrote:
> "enable" should be "disable" when the function name is
> vhost_disable_notify(), which does the disabling work.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   drivers/vhost/vhost.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5857d4e..b45519c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2537,7 +2537,7 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>   	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
>   		r = vhost_update_used_flags(vq);
>   		if (r)
> -			vq_err(vq, "Failed to enable notification at %p: %d\n",
> +			vq_err(vq, "Failed to disable notification at %p: %d\n",
>   			       &vq->used->flags, r);
>   	}
>   }


Acked-by: Jason Wang <jasowang@redhat.com>



