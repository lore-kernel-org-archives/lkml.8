Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D676C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0814D20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emDhVk99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGUFfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:35:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgGUFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595309716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZjxOuuUV4o3h7MOrSFtriNZrlOkqkWFhvhjNDp5Ej0=;
        b=emDhVk99XuFuBdHpfbhJNXwFGgQUb+JtDg+IBLK/a6xEiZ4s4JodzPrHUKccgwYCTwX/9Z
        wTTEaLLpt04HE5EeU66bGyUccR4N0MLXC+herWp4cRGm30JJeDW+KdC507I7PGY4uxdluI
        6za8RHUB/MtWbz3EysOMysCXfEdPop0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-GDSThcsLNlyMS6kolGBV8w-1; Tue, 21 Jul 2020 01:35:12 -0400
X-MC-Unique: GDSThcsLNlyMS6kolGBV8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731B858;
        Tue, 21 Jul 2020 05:35:11 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3981260BF1;
        Tue, 21 Jul 2020 05:35:04 +0000 (UTC)
Subject: Re: [PATCH V2 vhost next 05/10] vhost: Fix documentation
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
References: <20200720071416.32112-1-eli@mellanox.com>
 <20200720071416.32112-6-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7c323cac-fa03-bc46-1c41-ee7d37f350cf@redhat.com>
Date:   Tue, 21 Jul 2020 13:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720071416.32112-6-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/20 下午3:14, Eli Cohen wrote:
> Fix documentation to match actual function prototypes.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/iotlb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 1f0ca6e44410..0d4213a54a88 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_free);
>    * vhost_iotlb_itree_first - return the first overlapped range
>    * @iotlb: the IOTLB
>    * @start: start of IOVA range
> - * @end: end of IOVA range
> + * @last: last byte in IOVA range
>    */
>   struct vhost_iotlb_map *
>   vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
> @@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
>    * vhost_iotlb_itree_first - return the next overlapped range
>    * @iotlb: the IOTLB
>    * @start: start of IOVA range
> - * @end: end of IOVA range
> + * @last: last byte IOVA range
>    */
>   struct vhost_iotlb_map *
>   vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)

