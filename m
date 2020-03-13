Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE6206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCMMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:02:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMMCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:02:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E127930E;
        Fri, 13 Mar 2020 05:02:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77EA03F534;
        Fri, 13 Mar 2020 05:02:11 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:02:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, olof@lixom.net,
        vkoul@kernel.org, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] arm64: defconfig: buildin FSL DDR PMU
Message-ID: <20200313120209.GF42546@lakrids.cambridge.arm.com>
References: <1584090348-28910-1-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584090348-28910-1-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:05:48PM +0800, Joakim Zhang wrote:
> Buildin FSL DDR PMU since it is used quite often.

Generally. we should only build in stuff that's critical to getting a
system up-and-running, or cannot be built as a module. I don't think
that applies here.

Thanks,
Mark.

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0f212889c931..9a84ef613c7d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -833,7 +833,7 @@ CONFIG_PHY_UNIPHIER_USB2=y
>  CONFIG_PHY_UNIPHIER_USB3=y
>  CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_ARM_SMMU_V3_PMU=m
> -CONFIG_FSL_IMX8_DDR_PMU=m
> +CONFIG_FSL_IMX8_DDR_PMU=y
>  CONFIG_HISI_PMU=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
> -- 
> 2.17.1
> 
