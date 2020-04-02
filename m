Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F432063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgDBN7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:59:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgDBN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:59:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 91248280125
Subject: Re: [PATCH 2/3] phy-rockchip-dphy-rx0: Drop unneeded CONFIG_OF
 dependency
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>
References: <20200401213721.24173-1-ezequiel@collabora.com>
 <20200401213721.24173-3-ezequiel@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <7ced1203-cdea-ad26-f46b-8873bfb85043@collabora.com>
Date:   Thu, 2 Apr 2020 10:59:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200401213721.24173-3-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 6:37 PM, Ezequiel Garcia wrote:
> The driver is perfectly capable of being built without CONFIG_OF.
> Remove this dependency, which is useful for compile-only tests.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

> ---
>  drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig b/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
> index bd0147624de1..fb74df829371 100644
> --- a/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
> +++ b/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config PHY_ROCKCHIP_DPHY_RX0
>  	tristate "Rockchip MIPI Synopsys DPHY RX0 driver"
> -	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	select GENERIC_PHY_MIPI_DPHY
>  	select GENERIC_PHY
>  	help
> 
