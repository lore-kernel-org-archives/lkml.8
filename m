Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629EA221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQjMvGzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgHGD6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:58:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgHGD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596772714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trd6XzNAFWlVlhnF00AGLAJ//+tyUA5NEjUQzobqU08=;
        b=MQjMvGzyHpIfecOASrhi8Mr9viyxzrBMZ/IPaCWFcM2i8HBb2Q5mISn3zlYlSnK6lTLOYU
        1jYariUWLjlOA/Oeikrlqcs0ExtRaJiPcVZsk/UhCh5D8JaPxGncHQQ/ekFfvIHRl6i3Wj
        LN4+TFHR/6cW6XsFDG3nfJTcBIe6VvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-fVW1eGtFPm-D5zEmWHR_nA-1; Thu, 06 Aug 2020 23:58:30 -0400
X-MC-Unique: fVW1eGtFPm-D5zEmWHR_nA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974998017FB;
        Fri,  7 Aug 2020 03:58:29 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12EA15F1EF;
        Fri,  7 Aug 2020 03:58:23 +0000 (UTC)
Subject: Re: [PATCH][next] vdpa/mlx5: fix memory allocation failure checks
To:     Colin King <colin.king@canonical.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Eli Cohen <eli@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806160828.90463-1-colin.king@canonical.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bca8c1ef-1e21-cd05-4a91-ca136de5ae1e@redhat.com>
Date:   Fri, 7 Aug 2020 11:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806160828.90463-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/7 上午12:08, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The memory allocation failure checking for in and out is currently
> checking if the pointers are valid rather than the contents of what
> they point to. Hence the null check on failed memory allocations is
> incorrect.  Fix this by adding the missing indirection in the check.
> Also for the default case, just set the *in and *out to null as
> these don't have any thing allocated to kfree. Finally remove the
> redundant *in and *out check as these have been already done on each
> allocation in the case statement.
>
> Addresses-Coverity: ("Null pointer dereference")
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3ec44a4f0e45..55bc58e1dae9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -867,7 +867,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>   		*outlen = MLX5_ST_SZ_BYTES(qp_2rst_out);
>   		*in = kzalloc(*inlen, GFP_KERNEL);
>   		*out = kzalloc(*outlen, GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>   			goto outerr;
>   
>   		MLX5_SET(qp_2rst_in, *in, opcode, cmd);
> @@ -879,7 +879,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>   		*outlen = MLX5_ST_SZ_BYTES(rst2init_qp_out);
>   		*in = kzalloc(*inlen, GFP_KERNEL);
>   		*out = kzalloc(MLX5_ST_SZ_BYTES(rst2init_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>   			goto outerr;
>   
>   		MLX5_SET(rst2init_qp_in, *in, opcode, cmd);
> @@ -896,7 +896,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>   		*outlen = MLX5_ST_SZ_BYTES(init2rtr_qp_out);
>   		*in = kzalloc(*inlen, GFP_KERNEL);
>   		*out = kzalloc(MLX5_ST_SZ_BYTES(init2rtr_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>   			goto outerr;
>   
>   		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd);
> @@ -914,7 +914,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>   		*outlen = MLX5_ST_SZ_BYTES(rtr2rts_qp_out);
>   		*in = kzalloc(*inlen, GFP_KERNEL);
>   		*out = kzalloc(MLX5_ST_SZ_BYTES(rtr2rts_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>   			goto outerr;
>   
>   		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
> @@ -927,16 +927,15 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>   		MLX5_SET(qpc, qpc, rnr_retry, 7);
>   		break;
>   	default:
> -		goto outerr;
> +		goto outerr_nullify;
>   	}
> -	if (!*in || !*out)
> -		goto outerr;
>   
>   	return;
>   
>   outerr:
>   	kfree(*in);
>   	kfree(*out);
> +outerr_nullify:
>   	*in = NULL;
>   	*out = NULL;
>   }

