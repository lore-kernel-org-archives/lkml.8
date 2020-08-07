Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2890C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93D22177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/WafUrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHGDhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:37:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgHGDhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596771455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJmVwYKYH9OYU5nifyyFiwbUHIzwYs48cjjAmAqd4Ak=;
        b=D/WafUrZDE/FeyZO6hjOx9jIvJ0ZOr1KQ5E2w3Y9cdp9BCE6+tZ/t5XSH5UYwLq30lBNtT
        uykituP9V5VTZFvthnp/AaXbikgTpAWJGmiIOEHmxjrdZUO3BLHRF1R3x8s8jMShV3JOZw
        PjyOynnxXnbAGTuL/RX2gCROooRGL4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-3YYVa6ZLPMigqQOdgYyetg-1; Thu, 06 Aug 2020 23:37:34 -0400
X-MC-Unique: 3YYVa6ZLPMigqQOdgYyetg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA2B98017FB;
        Fri,  7 Aug 2020 03:37:32 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F27FC2DE8C;
        Fri,  7 Aug 2020 03:37:26 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
To:     Alex Dewar <alex.dewar90@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Date:   Fri, 7 Aug 2020 11:37:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806191849.82189-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/7 上午3:18, Alex Dewar wrote:
> In alloc_inout() in net/mlx5_vnet.c, there are a few places where memory
> is allocated to *in and *out, but only the values of in and out are
> null-checked (i.e. there is a missing dereference). Fix this.
>
> Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3ec44a4f0e45..bcb6600c2839 100644
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

