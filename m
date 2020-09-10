Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5FA207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIJSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:30:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIJS1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:27:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E7F5AC24;
        Thu, 10 Sep 2020 18:27:49 +0000 (UTC)
Subject: Re: [PATCH 07/12] soc: mediatek: pm-domains: Add extra sram control
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-8-enric.balletbo@collabora.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <277b1656-4a64-4fdd-865d-88cf253b7b0e@suse.com>
Date:   Thu, 10 Sep 2020 20:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910172826.3074357-8-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2020 19:28, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> For some power domains like vpu_core on MT8183 whose sram need to do clock
> and internal isolation while power on/off sram. We add a cap
> "MTK_SCPD_SRAM_ISO" to judge if we need to do the extra sram isolation
> control or not.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 3aa430a60602..0802eccc3a0b 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -21,6 +21,7 @@
>   
>   #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>   #define MTK_SCPD_FWAIT_SRAM		BIT(1)
> +#define MTK_SCPD_SRAM_ISO		BIT(2)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
> @@ -42,6 +43,8 @@
>   #define PWR_ON_BIT			BIT(2)
>   #define PWR_ON_2ND_BIT			BIT(3)
>   #define PWR_CLK_DIS_BIT			BIT(4)
> +#define PWR_SRAM_CLKISO_BIT		BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
>   
>   #define PWR_STATUS_DISP			BIT(3)
>   #define PWR_STATUS_MFG			BIT(4)
> @@ -162,6 +165,14 @@ static int scpsys_sram_enable(struct scpsys_domain *pd, void __iomem *ctl_addr)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO))	{
> +		val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
> +		writel(val, ctl_addr);
> +		udelay(1);
> +		val &= ~PWR_SRAM_CLKISO_BIT;
> +		writel(val, ctl_addr);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -171,8 +182,15 @@ static int scpsys_sram_disable(struct scpsys_domain *pd, void __iomem *ctl_addr)
>   	u32 val;
>   	int tmp;
>   
> -	val = readl(ctl_addr);
> -	val |= pd->data->sram_pdn_bits;
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO))	{
> +		val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
> +		writel(val, ctl_addr);
> +		val &= ~PWR_SRAM_ISOINT_B_BIT;
> +		writel(val, ctl_addr);
> +		udelay(1);
> +	}
> +
> +	val = readl(ctl_addr) | pd->data->sram_pdn_bits;

Nit, I'd prefer:
val = readl(ctl_addr);
val |= pd->data->sram_pdn_bits;


>   	writel(val, ctl_addr);
>   
>   	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
> 
