Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F0C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C437206E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgICKK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:10:29 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:38748 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:04 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 8116DF03;
        Thu,  3 Sep 2020 18:03:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140608763062016S1599127388444849_;
        Thu, 03 Sep 2020 18:03:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d3018c1042ed8c5abd5c98892315d0c2>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 5/6] clk: rockchip: fix the clk config to support
 module build
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063221.10500-1-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <2ee0e288-ae7f-5c6a-a5d4-5cee33a05e9e@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:03:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063221.10500-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/3 下午2:32, Elaine Zhang wrote:
> use CONFIG_COMMON_CLK_ROCKCHIP for Rk common clk drivers.
> use CONFIG_CLK_RKXX for Rk soc clk driver.
> Mark configuration to "tristate",
> to support building Rk SoCs clock driver as module.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/Kconfig           |  1 +
>   drivers/clk/rockchip/Kconfig  | 78 +++++++++++++++++++++++++++++++++++
>   drivers/clk/rockchip/Makefile | 42 ++++++++++---------
>   3 files changed, 101 insertions(+), 20 deletions(-)
>   create mode 100644 drivers/clk/rockchip/Kconfig
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4026fac9fac3..b41aaed9bd51 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -373,6 +373,7 @@ source "drivers/clk/meson/Kconfig"
>   source "drivers/clk/mvebu/Kconfig"
>   source "drivers/clk/qcom/Kconfig"
>   source "drivers/clk/renesas/Kconfig"
> +source "drivers/clk/rockchip/Kconfig"
>   source "drivers/clk/samsung/Kconfig"
>   source "drivers/clk/sifive/Kconfig"
>   source "drivers/clk/sprd/Kconfig"
> diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
> new file mode 100644
> index 000000000000..53a44396bc35
> --- /dev/null
> +++ b/drivers/clk/rockchip/Kconfig
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for ROCKCHIP SoC family.
> +
> +config COMMON_CLK_ROCKCHIP
> +	tristate "Rockchip clock controller common support"
> +	depends on ARCH_ROCKCHIP
> +	default ARCH_ROCKCHIP
> +	help
> +	  Say y here to enable common clock controller.
> +
> +if COMMON_CLK_ROCKCHIP
> +config CLK_PX30
> +	tristate "Rockchip Px30 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Px30 Clock Driver.
> +
> +config CLK_RV110X
> +	tristate "Rockchip Rv110x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rv110x Clock Driver.
> +
> +config CLK_RK3036
> +	tristate "Rockchip Rk3036 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3036 Clock Driver.
> +
> +config CLK_RK312X
> +	tristate "Rockchip Rk312x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk312x Clock Driver.
> +
> +config CLK_RK3188
> +	tristate "Rockchip Rk3188 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3188 Clock Driver.
> +
> +config CLK_RK322X
> +	tristate "Rockchip Rk322x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk322x Clock Driver.
> +
> +config CLK_RK3288
> +	tristate "Rockchip Rk3288 clock controller support"
> +	depends on ARM
> +	default y
> +	help
> +	  Build the driver for Rk3288 Clock Driver.
> +
> +config CLK_RK3308
> +	tristate "Rockchip Rk3308 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3308 Clock Driver.
> +
> +config CLK_RK3328
> +	tristate "Rockchip Rk3328 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3328 Clock Driver.
> +
> +config CLK_RK3368
> +	tristate "Rockchip Rk3368 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3368 Clock Driver.
> +
> +config CLK_RK3399
> +	tristate "Rockchip Rk3399 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3399 Clock Driver.
> +endif
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index 7c5b5813a87c..a99e4d9bbae1 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -3,24 +3,26 @@
>   # Rockchip Clock specific Makefile
>   #
>   
> -obj-y	+= clk.o
> -obj-y	+= clk-pll.o
> -obj-y	+= clk-cpu.o
> -obj-y	+= clk-half-divider.o
> -obj-y	+= clk-inverter.o
> -obj-y	+= clk-mmc-phase.o
> -obj-y	+= clk-muxgrf.o
> -obj-y	+= clk-ddr.o
> -obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
> +obj-$(CONFIG_COMMON_CLK_ROCKCHIP) += clk-rockchip.o
>   
> -obj-y	+= clk-px30.o
> -obj-y	+= clk-rv1108.o
> -obj-y	+= clk-rk3036.o
> -obj-y	+= clk-rk3128.o
> -obj-y	+= clk-rk3188.o
> -obj-y	+= clk-rk3228.o
> -obj-y	+= clk-rk3288.o
> -obj-y	+= clk-rk3308.o
> -obj-y	+= clk-rk3328.o
> -obj-y	+= clk-rk3368.o
> -obj-y	+= clk-rk3399.o
> +clk-rockchip-y += clk.o
> +clk-rockchip-y += clk-pll.o
> +clk-rockchip-y += clk-cpu.o
> +clk-rockchip-y += clk-half-divider.o
> +clk-rockchip-y += clk-inverter.o
> +clk-rockchip-y += clk-mmc-phase.o
> +clk-rockchip-y += clk-muxgrf.o
> +clk-rockchip-y += clk-ddr.o
> +clk-rockchip-$(CONFIG_RESET_CONTROLLER) += softrst.o
> +
> +obj-$(CONFIG_CLK_PX30)          += clk-px30.o
> +obj-$(CONFIG_CLK_RV110X)        += clk-rv1108.o
> +obj-$(CONFIG_CLK_RK3036)        += clk-rk3036.o
> +obj-$(CONFIG_CLK_RK312X)        += clk-rk3128.o
> +obj-$(CONFIG_CLK_RK3188)        += clk-rk3188.o
> +obj-$(CONFIG_CLK_RK322X)        += clk-rk3228.o
> +obj-$(CONFIG_CLK_RK3288)        += clk-rk3288.o
> +obj-$(CONFIG_CLK_RK3308)        += clk-rk3308.o
> +obj-$(CONFIG_CLK_RK3328)        += clk-rk3328.o
> +obj-$(CONFIG_CLK_RK3368)        += clk-rk3368.o
> +obj-$(CONFIG_CLK_RK3399)        += clk-rk3399.o

This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



