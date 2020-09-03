Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5671BC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E002086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgICKKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:10:08 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:35214 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:03 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id B24E611BC;
        Thu,  3 Sep 2020 18:02:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140609272846080S1599127348778064_;
        Thu, 03 Sep 2020 18:02:29 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a01c7cbd79e0e79cf896393d9e23060f>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 2/6] clk: rockchip: Export
 rockchip_clk_register_ddrclk()
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063147.10237-3-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <e2e3d0c0-1334-b823-b1a1-dfeee8ce9430@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:02:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063147.10237-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/3 下午2:31, Elaine Zhang wrote:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module..
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-ddr.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
> index 9273bce4d7b6..282b6f22eb22 100644
> --- a/drivers/clk/rockchip/clk-ddr.c
> +++ b/drivers/clk/rockchip/clk-ddr.c
> @@ -136,3 +136,4 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>   
>   	return clk;
>   }
> +EXPORT_SYMBOL(rockchip_clk_register_ddrclk);

This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



