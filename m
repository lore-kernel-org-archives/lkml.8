Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244BE20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgGQEQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:16:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:8495 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgGQEQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:16:26 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 17 Jul 2020 13:16:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 307C2180117;
        Fri, 17 Jul 2020 13:16:25 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 17 Jul 2020 13:16:25 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B541E403AE;
        Fri, 17 Jul 2020 13:16:24 +0900 (JST)
Received: from [10.212.2.196] (unknown [10.212.2.196])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 59A65120488;
        Fri, 17 Jul 2020 13:16:24 +0900 (JST)
Subject: Re: [PATCH] net: ethernet: ave: Fix error returns in ave_init
To:     Wang Hai <wanghai38@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, p.zabel@pengutronix.de,
        yamada.masahiro@socionext.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200717025049.43027-1-wanghai38@huawei.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <ca44d4aa-b65c-adac-334a-85e54816e9e3@socionext.com>
Date:   Fri, 17 Jul 2020 13:16:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717025049.43027-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 2020/07/17 11:50, Wang Hai wrote:
> When regmap_update_bits failed in ave_init(), calls of the functions
> reset_control_assert() and clk_disable_unprepare() were missed.
> Add goto out_reset_assert to do this.
> 
> Fixes: 57878f2f4697 ("net: ethernet: ave: add support for phy-mode setting of system controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   drivers/net/ethernet/socionext/sni_ave.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
> index f2638446b62e..81b554dd7221 100644
> --- a/drivers/net/ethernet/socionext/sni_ave.c
> +++ b/drivers/net/ethernet/socionext/sni_ave.c
> @@ -1191,7 +1191,7 @@ static int ave_init(struct net_device *ndev)
>   	ret = regmap_update_bits(priv->regmap, SG_ETPINMODE,
>   				 priv->pinmode_mask, priv->pinmode_val);
>   	if (ret)
> -		return ret;
> +		goto out_reset_assert;
>   
>   	ave_global_reset(ndev);
>   
> 

Thank you for pointing out.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

---
Best Regards
Kunihiko Hayashi
