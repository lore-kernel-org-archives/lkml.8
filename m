Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 06:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D957120720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 06:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TZombwlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHWGKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 02:10:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10833 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHWGKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 02:10:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4207c90001>; Sat, 22 Aug 2020 23:08:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 22 Aug 2020 23:10:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 22 Aug 2020 23:10:06 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 23 Aug
 2020 06:09:54 +0000
Date:   Sun, 23 Aug 2020 09:09:51 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <eli@mellanox.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit
 platforms
Message-ID: <20200823060951.GA147797@mtl-vdi-166.wap.labs.mlnx>
References: <20200821225018.940798-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200821225018.940798-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598162889; bh=UQi/THUnpkMQGa3pyAFcoK62NCnVMUs9jsVEsWrDdzM=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=TZombwlkRr8Q9ivC7JDBu8vXs/LCdWnKHt1nNPSTo/wFB+4PKyQ4PoeBSzU15MiSs
         3u50P3rbMmbQHE6UqlXGfvIJGTHRQ1YDUr6WPZjlF9Tq/WVCBqJHNrP/4VFcMWhHCx
         H32oq/oyuZuLFltIoCFLgT6nP1djs0GbrXs0+5dl52QtB+IK1lZYjRH3GaJ2l9NkgK
         uE78k7PZD6Tb4eoXuW+WjBqoZZYS3yRixXHnND8jlHlEYt/583RHEqqWtdmbTc7jWy
         BoQZv8STAeu3sc1c8j1lwwwO6lr/CDpm7QsB6CeSf4Z3x5RyIbGHS6Sv3jzTpUuXSD
         bf/9Y91z8s2XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:50:19PM -0700, Nathan Chancellor wrote:
> Clang warns several times when building for 32-bit ARM along the lines
> of:
> 
> drivers/vdpa/mlx5/net/mlx5_vnet.c:1462:31: warning: shift count >= width
> of type [-Wshift-count-overflow]
>                 ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This is related to the BIT macro, which uses an unsigned long literal,
> which is 32-bit on ARM so having a shift equal to or larger than 32 will
> cause this warning, such as the above, where VIRTIO_F_VERSION_1 is 32.
> To avoid this, use BIT_ULL, which will be an unsigned long long. This
> matches the size of the features field throughout this driver, which is
> u64 so there should be no functional change.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1140
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Acked-by: Eli Cohen <elic@nvidia.com>

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9df69d5efe8c..70676a6d1691 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -16,19 +16,19 @@
>  #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
>  
>  #define VALID_FEATURES_MASK                                                                        \
> -	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> -	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
> -	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
> -	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
> -	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
> -	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
> -	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> -	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> -	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
> -	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
> -	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> -	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
> -	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
> +	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> +	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) | BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |                             \
> +	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) | BIT_ULL(VIRTIO_NET_F_GUEST_UFO) | BIT_ULL(VIRTIO_NET_F_HOST_TSO4) | \
> +	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) | BIT_ULL(VIRTIO_NET_F_HOST_ECN) | BIT_ULL(VIRTIO_NET_F_HOST_UFO) |   \
> +	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | BIT_ULL(VIRTIO_NET_F_STATUS) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |      \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) | BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> +	 BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |  \
> +	 BIT_ULL(VIRTIO_NET_F_RSS) | BIT_ULL(VIRTIO_NET_F_RSC_EXT) | BIT_ULL(VIRTIO_NET_F_STANDBY) |           \
> +	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) | BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> +	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) | BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |      \
> +	 BIT_ULL(VIRTIO_F_RING_PACKED) | BIT_ULL(VIRTIO_F_ORDER_PLATFORM) | BIT_ULL(VIRTIO_F_SR_IOV))
>  
>  #define VALID_STATUS_MASK                                                                          \
>  	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
> @@ -149,7 +149,7 @@ static bool mlx5_vdpa_debug;
>  
>  #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
>  	do {                                                                                       \
> -		if (features & BIT(_feature))                                                      \
> +		if (features & BIT_ULL(_feature))                                                  \
>  			mlx5_vdpa_info(mvdev, "%s\n", #_feature);                                  \
>  	} while (0)
>  
> @@ -750,10 +750,10 @@ static bool vq_is_tx(u16 idx)
>  
>  static u16 get_features_12_3(u64 features)
>  {
> -	return (!!(features & BIT(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> -	       (!!(features & BIT(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> -	       (!!(features & BIT(VIRTIO_NET_F_CSUM)) << 7) |
> -	       (!!(features & BIT(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> +	return (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << 7) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
>  }
>  
>  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> @@ -1439,13 +1439,13 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>  	u64 result = 0;
>  
>  	if (dev_features & MLX5_VIRTIO_NET_F_GUEST_CSUM)
> -		result |= BIT(VIRTIO_NET_F_GUEST_CSUM);
> +		result |= BIT_ULL(VIRTIO_NET_F_GUEST_CSUM);
>  	if (dev_features & MLX5_VIRTIO_NET_F_CSUM)
> -		result |= BIT(VIRTIO_NET_F_CSUM);
> +		result |= BIT_ULL(VIRTIO_NET_F_CSUM);
>  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO6)
> -		result |= BIT(VIRTIO_NET_F_HOST_TSO6);
> +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO6);
>  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO4)
> -		result |= BIT(VIRTIO_NET_F_HOST_TSO4);
> +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO4);
>  
>  	return result;
>  }
> @@ -1459,15 +1459,15 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>  	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
>  	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
>  	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
> -		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
> -	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ACCESS_PLATFORM);
> +		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
>  	print_features(mvdev, ndev->mvdev.mlx_features, false);
>  	return ndev->mvdev.mlx_features;
>  }
>  
>  static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>  {
> -	if (!(features & BIT(VIRTIO_F_ACCESS_PLATFORM)))
> +	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
>  		return -EOPNOTSUPP;
>  
>  	return 0;
> 
> base-commit: 8a7c3213db068135e816a6a517157de6443290d6
> -- 
> 2.28.0
> 
