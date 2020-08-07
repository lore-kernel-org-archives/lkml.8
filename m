Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63965C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485702177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR+z0pyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHGDyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:54:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgHGDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596772464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DD+5YaxG5kafQGDO3acMANf5Iwxl41vTIRFwMojQUI=;
        b=XR+z0pyzpmpdHRxx94xpq0EWDwkym32D13XJRvXmdRbcnbgqr5yg0txVCbYNDq7tQn+Y8c
        nJ915aTP4VpGoj2MDzE6wHntpdRU1HhgG37448MDza8tDLOyYp/FoMFk2dNXZT/r8tti61
        DXm9UgtChaup/vVj+71sIwfdd0am34c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-Q7A8Z20-NoSg2T-18Pwq2Q-1; Thu, 06 Aug 2020 23:54:22 -0400
X-MC-Unique: Q7A8Z20-NoSg2T-18Pwq2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A71F80046C;
        Fri,  7 Aug 2020 03:54:21 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5711D5F9DB;
        Fri,  7 Aug 2020 03:54:16 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix uninitialised variable in core/mr.c
To:     Alex Dewar <alex.dewar@gmx.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <307a57f1-7038-f042-a786-bee636509a7b@redhat.com>
Date:   Fri, 7 Aug 2020 11:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/7 上午2:56, Alex Dewar wrote:
> If the kernel is unable to allocate memory for the variable dmr then
> err will be returned without being set. Set err to -ENOMEM in this
> case.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Addresses-Coverity: ("Uninitialized variables")
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/mlx5/core/mr.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index f5dec0274133..ef1c550f8266 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -319,8 +319,10 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
>   	while (size) {
>   		sz = (u32)min_t(u64, MAX_KLM_SIZE, size);
>   		dmr = kzalloc(sizeof(*dmr), GFP_KERNEL);
> -		if (!dmr)
> +		if (!dmr) {
> +			err = -ENOMEM;
>   			goto err_alloc;
> +		}
>
>   		dmr->start = st;
>   		dmr->end = st + sz;
> --
> 2.28.0
>

