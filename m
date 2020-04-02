Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E6AC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C3F206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgDBGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:35:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDBGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:35:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id AC1E528ED5B
Subject: Re: [PATCH v2 2/2] clk: rockchip: rk3288: Handle clock tree for
 rk3288w
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        kever.yang@rock-chips.com
References: <20200401153513.423683-1-mylene.josserand@collabora.com>
 <20200401153513.423683-3-mylene.josserand@collabora.com>
 <CAMuHMdXvFOKqmZ-MLJV4SAeLN-PDzqPvMvbVpcD=jyip9tbdnA@mail.gmail.com>
From:   Mylene Josserand <mylene.josserand@collabora.com>
Message-ID: <7c21a7d6-a24f-dbc6-4eaa-548ddfc0f73e@collabora.com>
Date:   Thu, 2 Apr 2020 08:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXvFOKqmZ-MLJV4SAeLN-PDzqPvMvbVpcD=jyip9tbdnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 4/1/20 6:56 PM, Geert Uytterhoeven wrote:
> Hi Mylène,
> 
> On Wed, Apr 1, 2020 at 5:35 PM Mylène Josserand
> <mylene.josserand@collabora.com> wrote:
>> The revision rk3288w has a different clock tree about
>> "hclk_vio" clock, according to the BSP kernel code.
>>
>> This patch handles this difference by detecting which SOC it is
>> and creating the div accordingly. Because we are using
>> soc_device_match function, we need to delay the registration
>> of this clock later than others to have time to get SoC revision.
>>
>> Otherwise, because of CLK_OF_DECLARE uses, clock tree will be
>> created too soon to have time to detect SoC's revision.
>>
>> Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
> 
> Thanks for your patch!

Thanks for your review!

> 
>> --- a/drivers/clk/rockchip/clk-rk3288.c
>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>> @@ -914,10 +923,15 @@ static struct syscore_ops rk3288_clk_syscore_ops = {
>>          .resume = rk3288_clk_resume,
>>   };
>>
>> +static const struct soc_device_attribute rk3288w[] = {
>> +       { .soc_id = "RK32xx", .revision = "RK3288w" },
>> +       { /* sentinel */ }
>> +};
>> +
>> +static struct rockchip_clk_provider *ctx;
>> +
>>   static void __init rk3288_clk_init(struct device_node *np)
>>   {
>> -       struct rockchip_clk_provider *ctx;
>> -
>>          rk3288_cru_base = of_iomap(np, 0);
>>          if (!rk3288_cru_base) {
>>                  pr_err("%s: could not map cru region\n", __func__);
>> @@ -955,3 +969,17 @@ static void __init rk3288_clk_init(struct device_node *np)
>>          rockchip_clk_of_add_provider(np, ctx);
>>   }
>>   CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
>> +
>> +static int __init rk3288_hclkvio_register(void)
>> +{
> 
> This function will always be called, even when running a (multi-platform)
> kernel on a non-rk3288 platform.  So you need some protection against
> that.

erg, good point, I didn't think about that.

> 
>> +       /* Check for the rk3288w revision as clock tree is different */
>> +       if (soc_device_match(rk3288w))
>> +               rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
>> +                                              ARRAY_SIZE(rk3288w_hclkvio_branch));
>> +       else
>> +               rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
>> +                                              ARRAY_SIZE(rk3288_hclkvio_branch));
> 
> Note that soc_device_match() returns a struct soc_device_attribute
> pointer.  If you would store the rockchip_clk_branch array pointer and
> size in rk3288w[...].data (i.e. a pointer to a struct containing that
> info), for both the r83288w and normal rk3288 variants, you could
> simplify this to:
> 
>      attr = soc_device_match(rk3288w);
>      if (attr) {
>              struct rk3288_branch_array *p = attr->data;
>              rockchip_clk_register_branches(ctx, p->branches, p->len);
>      }
> 
> That would handle the not-running-on-rk3288 issue as well.

Nice, thank you for the explanation and the code, very useful :)

Best regards,

Mylène
