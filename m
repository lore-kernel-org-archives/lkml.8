Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD9C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EDC20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584551640;
	bh=zhaVfKAZ9DWXovGE8g99UowHd7QWKaEhgZ8kbNHW5y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f2JBZNCevp8K+H5/TviNb6Rc0o3hJbvQpthZi1MApSuYvcK+YFxw8aKDl3KSbkIJE
	 EtrkVUtSIom4eama8uGqCQQ/6GGZbPXQ/8FX6TFO/oNBYV/OSueo1H/hFFLipsWUG5
	 efYAui+sDb8Xq3HlxwQioqlswbiUIMHg7RvcOgEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCRRN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCRRN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:13:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673D92071C;
        Wed, 18 Mar 2020 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584551639;
        bh=zhaVfKAZ9DWXovGE8g99UowHd7QWKaEhgZ8kbNHW5y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Li0LZeQVZ4Y+/0pUIJSWmkVPN6EAdJ4YA8shQ6emtUWMi8hEJQGHidj0itPCT5YjZ
         J/WugOmTS/lFVni8CuSA2eGGz3fW/At9p4z7XIE1RoDPRVvc5Gi5yl36aJNGAYM+Si
         JjcaPcSbvU32yOWlb3huoFMM9NS9gdzU+1RNkoeA=
Date:   Wed, 18 Mar 2020 19:13:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>
Subject: Re: [RFC 1/1] net/mlx5: Fix failing fw tracer allocation on s390
Message-ID: <20200318171355.GE126814@unreal>
References: <20200318164431.85948-1-schnelle@linux.ibm.com>
 <20200318164431.85948-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318164431.85948-2-schnelle@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:44:31PM +0100, Niklas Schnelle wrote:
> On s390 FORCE_MAX_ZONEORDER is 9 instead of 11, thus a larger kzalloc()
> allocation as done for the firmware tracer will always fail.
>
> Looking at mlx5_fw_tracer_save_trace(), it is actually the driver itself
> that copies the debug data into the trace array and there is no need for
> the allocation to be contiguous in physical memory. We can therefor use
> kvzalloc() instead of kzalloc() and get rid of the large contiguous
> allcoation.
>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
> index 94d7b69a95c7..eb2e57ff08a6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
> @@ -935,7 +935,7 @@ struct mlx5_fw_tracer *mlx5_fw_tracer_create(struct mlx5_core_dev *dev)
>  		return NULL;
>  	}
>
> -	tracer = kzalloc(sizeof(*tracer), GFP_KERNEL);
> +	tracer = kvzalloc(sizeof(*tracer), GFP_KERNEL);

Saeed, Moshe

Can we use vzalloc() instead of kvzalloc() here?

Thanks
