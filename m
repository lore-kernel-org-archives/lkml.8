Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6EDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068262177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lA9GohKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgH0MeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:34:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14976 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgH0MIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:08:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47a2130000>; Thu, 27 Aug 2020 05:07:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:08:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 05:08:30 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:08:15 +0000
Date:   Thu, 27 Aug 2020 15:08:11 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <eli@mellanox.com>,
        <dan.carpenter@oracle.com>, <parav@mellanox.com>,
        <natechancellor@gmail.com>, <colin.king@canonical.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Remove duplicate include
Message-ID: <20200827120811.GA101680@mtl-vdi-166.wap.labs.mlnx>
References: <20200827120547.83997-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827120547.83997-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598530067; bh=inb6WrN6PDof0nfJ5667HKoyHeUwp4PxtBynk5WzLuc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=lA9GohKbA93UxQrNvrs29Zh99t6x1Eq3kxrjNcvbRPAEPG4lIBoyywiBwKZGdl9eC
         HVEyTfn4LdQC8tDEH0+uLwnGTv/0ZmOK5w8/mc5RG+xpATbDvzi5r298LjEuXlCQCe
         Ip+1aRIgxXVxpO0jK6v5g+UhE9WUxe/lAdp8Bw5mNwexvpKWgXJVvbqePxwGpn8ucU
         Yqlb465QVCdCX4AlkFJ2k5iZZghSec1QmSdeG3XMVV91LV3tLTg0xGZAy5oiGtaD2Q
         at5esiCNRV3DLC0ypAvUx2TfNIFGDoAt9KRps/zd0mtxGcr3wagwraONeGwCIT35VK
         Q4nUerEnHqN2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:05:47PM +0800, Jing Xiangfeng wrote:
> Remove linux/mlx5/device.h which is included more than once
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Acked-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 70676a6d1691..b4bdbe062b7c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -8,7 +8,6 @@
>  #include <linux/mlx5/device.h>
>  #include <linux/mlx5/vport.h>
>  #include <linux/mlx5/fs.h>
> -#include <linux/mlx5/device.h>
>  #include "mlx5_vnet.h"
>  #include "mlx5_vdpa_ifc.h"
>  #include "mlx5_vdpa.h"
> -- 
> 2.26.0.106.g9fadedd
> 
