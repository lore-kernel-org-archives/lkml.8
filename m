Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631DE2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:29:02 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:35488 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:29:01 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 9B5221581;
        Fri, 10 Jul 2020 09:28:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3129T139655160764160S1594344529928776_;
        Fri, 10 Jul 2020 09:28:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <47b3627cf396951821d8efe055bec5fc>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20200708144528.20465-1-jbx6244@gmail.com>
 <2f58b9df-9bcd-5639-65cc-306a6d36b310@rock-chips.com>
 <68073138-1f94-9d5b-ad48-e82bc538c915@gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <02cf9650-eef2-f3d1-4630-38e2d8381847@rock-chips.com>
Date:   Fri, 10 Jul 2020 09:28:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <68073138-1f94-9d5b-ad48-e82bc538c915@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/9 下午8:04, Johan Jonker 写道:
> Hi Elaine, Robin,
>
> Thank you for your help!
> This patch can go in the garbage bin.
> It turns out that with SERIAL_8250 also SERIAL_8250_DW must be
> selected... ;)
>
> It's not in the Kconfig help description.
> Shouldn't that be automatically be included for Rockchip?
> Example:
>
> config SERIAL_8250
> 	tristate "8250/16550 and compatible serial support"
> 	depends on !S390
> 	select SERIAL_CORE
> 	select SERIAL_MCTRL_GPIO if GPIOLIB
> 	select SERIAL_8250_DW if ARCH_ROCKCHIP

Our  Konfig:

config SERIAL_8250
	tristate "8250/16550 and compatible serial support"
	depends on !S390
	select SERIAL_CORE

config SERIAL_8250_DW
         tristate "Support for Synopsys DesignWare 8250 quirks"
         depends on SERIAL_8250

So SERIAL_8250 and SERIAL_8250_DW must be selected.

If you use select SERIAL_8250_DW if ARCH_ROCKCHIP, check the CONIF_ARCH_ROCKCHIP=y.
In our rockchip_defconfig the CONIF_ARCH_ROCKCHIP=y by default.

> Thank Robin for the introduction to FTRACE!
>
> mount -t tracefs tracefs /sys/kernel/tracing
>
> cd /sys/kernel/tracing
>
> # Without SERIAL_8250_DW
>
> /sys/kernel/tracing # cat trace | grep uart2
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
>         swapper/0-1     [002] d..1     1.916746: clk_disable: pclk_uart2
>
>
> /sys/kernel/tracing # cat trace | grep uart
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_div
>         swapper/0-1     [002] d..1     1.916746: clk_disable: pclk_uart2
>         swapper/0-1     [002] d..1     1.923959: clk_disable: pclk_uart1
>         swapper/0-1     [002] d..1     1.930741: clk_disable: pclk_uart0
>
> # With SERIAL_8250_DW
>
> /sys/kernel/tracing # cat trace | grep uart2
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
>         swapper/0-1     [002] d..1     0.923180: clk_enable: sclk_uart2
>         swapper/0-1     [002] d..1     0.923224: clk_enable: pclk_uart2
>         swapper/0-1     [002] d..1     0.925259: clk_disable: sclk_uart2
>         swapper/0-1     [002] d..1     0.925295: clk_enable: sclk_uart2
>         swapper/0-1     [003] d..1     2.208605: clk_disable: sclk_uart2
>         swapper/0-1     [003] d..1     2.208646: clk_enable: sclk_uart2
>
> /sys/kernel/tracing # cat trace | grep uart
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_div
>            <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_frac
>            <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_div
>         swapper/0-1     [002] d..1     0.920034: clk_enable: sclk_uart0
>         swapper/0-1     [002] d..1     0.920085: clk_enable: pclk_uart0
>       kworker/2:1-32    [002] d..1     0.922596: clk_disable: sclk_uart0
>       kworker/2:1-32    [002] d..1     0.922613: clk_disable: pclk_uart0
>         swapper/0-1     [002] d..1     0.923180: clk_enable: sclk_uart2
>         swapper/0-1     [002] d..1     0.923224: clk_enable: pclk_uart2
>         swapper/0-1     [002] d..1     0.925259: clk_disable: sclk_uart2
>         swapper/0-1     [002] d..1     0.925295: clk_enable: sclk_uart2
>         swapper/0-1     [003] d..1     1.914158: clk_disable: pclk_uart1
>         swapper/0-1     [003] d..1     2.208605: clk_disable: sclk_uart2
>         swapper/0-1     [003] d..1     2.208646: clk_enable: sclk_uart2
>
>
>
> On 7/9/20 3:32 AM, elaine.zhang wrote:
>> 在 2020/7/8 下午10:45, Johan Jonker 写道:
>>> The rk3328 uart2 port is used as boot console and to debug.
>>> During the boot pclk_uart2 is disabled by a clk_disable_unused
>>> initcall. Fix the uart2 function by marking pclk_uart2
>>> as critical on rk3328. Also add sclk_uart2 as that is needed
>>> for the same DT node.
>>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>    drivers/clk/rockchip/clk-rk3328.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/clk/rockchip/clk-rk3328.c
>>> b/drivers/clk/rockchip/clk-rk3328.c
>>> index c186a1985..cb7749cb7 100644
>>> --- a/drivers/clk/rockchip/clk-rk3328.c
>>> +++ b/drivers/clk/rockchip/clk-rk3328.c
>>> @@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[]
>>> __initconst = {
>>>        "aclk_gmac_niu",
>>>        "pclk_gmac_niu",
>>>        "pclk_phy_niu",
>>> +    "pclk_uart2",
>>> +    "sclk_uart2",
>>>    };
>>>    
>> Not need to mark the uart2 as critical clocks, the uart clk will enabled
>> by uart driver probe(dw8250_probe()).
>>
>> For your question,  Please check the uart2 dts node "status = okay".
>>
>> Or You can send me the complete log, I check the status of uart2.
>>
>>>    static void __init rk3328_clk_init(struct device_node *np)
>>
>
>
>


