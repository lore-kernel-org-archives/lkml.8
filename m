Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7476CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5899F2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGCPnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:43:22 -0400
Received: from foss.arm.com ([217.140.110.172]:45726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgGCPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:43:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FBF431B;
        Fri,  3 Jul 2020 08:43:21 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F303F73C;
        Fri,  3 Jul 2020 08:43:19 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] clk: rockchip: rk3288: Handle clock tree for
 rk3288w
To:     Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
 <1793210.9Kb5SQUFvz@phil>
 <CAMty3ZB1n5uXmH=U4iXfgpyU-JZff74Rm2Mj+SS2LLtkM2fARQ@mail.gmail.com>
 <1847101.XIPLBOrDxk@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ebc6a0d-1c88-cf74-e19d-dd9f3cef728e@arm.com>
Date:   Fri, 3 Jul 2020 16:43:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1847101.XIPLBOrDxk@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-03 15:48, Heiko Stuebner wrote:
> Am Freitag, 3. Juli 2020, 16:23:27 CEST schrieb Jagan Teki:
>> On Fri, Jul 3, 2020 at 7:41 PM Heiko Stuebner <heiko@sntech.de> wrote:
>>>
>>> Hi Jagan,
>>>
>>> Am Montag, 29. Juni 2020, 21:11:03 CEST schrieb Jagan Teki:
>>>> On Tue, Jun 2, 2020 at 1:37 PM Mylène Josserand
>>>> <mylene.josserand@collabora.com> wrote:
>>>>>
>>>>> The revision rk3288w has a different clock tree about "hclk_vio"
>>>>> clock, according to the BSP kernel code.
>>>>>
>>>>> This patch handles this difference by detecting which device-tree
>>>>> we are using. If it is a "rockchip,rk3288-cru", let's register
>>>>> the clock tree as it was before. If the device-tree node is
>>>>> "rockchip,rk3288w-cru", we will apply the difference with this
>>>>> version of this SoC.
>>>>>
>>>>> Noticed that this new device-tree compatible must be handled in
>>>>> bootloader such as u-boot.
>>>>>
>>>>> Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
>>>>> ---
>>>>>   drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
>>>>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
>>>>> index cc2a177bbdbf..204976e2d0cb 100644
>>>>> --- a/drivers/clk/rockchip/clk-rk3288.c
>>>>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>>>>> @@ -425,8 +425,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>>>>>          COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
>>>>>                          RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DFLAGS,
>>>>>                          RK3288_CLKGATE_CON(3), 0, GFLAGS),
>>>>> -       DIV(0, "hclk_vio", "aclk_vio0", 0,
>>>>> -                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
>>>>>          COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
>>>>>                          RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
>>>>>                          RK3288_CLKGATE_CON(3), 2, GFLAGS),
>>>>> @@ -819,6 +817,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>>>>>          INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
>>>>>   };
>>>>>
>>>>> +static struct rockchip_clk_branch rk3288w_hclkvio_branch[] __initdata = {
>>>>> +       DIV(0, "hclk_vio", "aclk_vio1", 0,
>>>>> +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
>>>>> +};
>>>>> +
>>>>> +static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata = {
>>>>> +       DIV(0, "hclk_vio", "aclk_vio0", 0,
>>>>> +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
>>>>> +};
>>>>> +
>>>>>   static const char *const rk3288_critical_clocks[] __initconst = {
>>>>>          "aclk_cpu",
>>>>>          "aclk_peri",
>>>>> @@ -936,6 +944,14 @@ static void __init rk3288_clk_init(struct device_node *np)
>>>>>                                     RK3288_GRF_SOC_STATUS1);
>>>>>          rockchip_clk_register_branches(ctx, rk3288_clk_branches,
>>>>>                                    ARRAY_SIZE(rk3288_clk_branches));
>>>>> +
>>>>> +       if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
>>>>> +               rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
>>>>> +                                              ARRAY_SIZE(rk3288w_hclkvio_branch));
>>>>> +       else
>>>>> +               rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
>>>>> +                                              ARRAY_SIZE(rk3288_hclkvio_branch));
>>>>> +
>>>>
>>>> Sorry for the late query on this. I am a bit unclear about this
>>>> compatible change, does Linux expect to replace rockchip,rk3288-cru
>>>> with rockchip,rk3288w-cru in bootloader if the chip is RK3288w? or
>>>> append the existing cru compatible node with rockchip,rk3288w-cru?
>>>> because replace new cru node make clock never probe since the
>>>> CLK_OF_DECLARE checking rockchip,rk3288-cru
>>>
>>> I guess right now we'd expect "rockchip,rk3288w-cru", "rockchip,rk3288-cru",
>>>
>>> Thinking again about this, I'm wondering if we should switch to having
>>> only one per variant ... like on the two rk3188 variants,
>>> so declaring separate rk3288-cru and rk3288w-cru of-clks with shared
>>> common code.
>>
>> What if can check the root compatible instead cru compatible for revision W like
>>
>> -  if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
>> + if (of_device_is_compatible(np, "rockchip,rk3288w"))
> 
> you'd need to check against the root compatible.
> 
>>
>> This way we can have a single compatible update at bootloader that
>> makes Linux adjust revision W chips code.
>>
>> Doesn't it make sense?
> 
> The compatible describes the block and the rk3288w's cru isn't the same as
> the rk3288's ... as the clock routing is different, so it should have a
> different compatible value, I think.

Right, if two devices behave differently in a way that one behaviour is 
not a strict superset of the other, and there's no way to tell which is 
which by simply looking at the device itself, then by definition they 
are not compatible.

> As the DT sis supposed to be a _generic_ description of the hardware,
> we don't want to cement hacks to other implementations would need to copy.

Indeed it's a pain in the bum for driver developers to be given a new 
thing that's 99.9% compatible with the old thing but the one tiny 
difference fundamentally breaks it, and the temptation to look for an 
easy way out is strong, but c'est la vie ;)

The question I always bear in mind for cases like these is this: If a 
kernel without the driver patch runs on the new system with the expected 
new DTB, will it:

A) work entirely correctly
B) ignore the device (with or without an error), but the rest of the 
system still works fine
C) ignore the device and fail to boot at all (with or without an error) 
because it's critical to operation of the rest of the system
D) probe the device and superficially appear to be OK but actually be 
broken in weird and subtle ways

A and B are the ideal answers. C is a little unfortunate, but acceptable 
if neither A nor B is possible. D is a sign that you're doing something 
wrong, unless there are *very* specific circumstances that might justify 
it (e.g. the SoC is exclusively deployed in embedded devices with a 
controlled update mechanism such that users could never introduce this 
mismatch in the first place).

Robin.
