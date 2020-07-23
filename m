Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF99BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FDF2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbgGWBtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:39 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:39588 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:39 -0400
Received: from localhost (unknown [192.168.167.225])
        by regular1.263xmail.com (Postfix) with ESMTP id D7FF0A54;
        Thu, 23 Jul 2020 09:49:36 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17824T139851630368512S1595468975533575_;
        Thu, 23 Jul 2020 09:49:36 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <556b12a816981c0b51110575844fb20a>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: kever.yang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v1] clk: Export __clk_lookup()
From:   "elaine.zhang" <zhangqing@rock-chips.com>
To:     Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
References: <20200722023230.10826-1-zhangqing@rock-chips.com>
 <14639646.VOZsFJ8Tpa@phil>
 <159546549321.3847286.4678382117195983280@swboyd.mtv.corp.google.com>
 <f3e7b8f3-e4d4-9965-703d-aa4b96f50f6d@rock-chips.com>
Organization: rockchip
Message-ID: <99eebfa5-e775-37a8-6c76-90ae2444b253@rock-chips.com>
Date:   Thu, 23 Jul 2020 09:49:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f3e7b8f3-e4d4-9965-703d-aa4b96f50f6d@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/23 上午9:42, elaine.zhang 写道:
>
> 在 2020/7/23 上午8:51, Stephen Boyd 写道:
>> Quoting Heiko Stuebner (2020-07-22 11:26:50)
>>> Hi Elaine,
>>>
>>> Am Mittwoch, 22. Juli 2020, 04:32:30 CEST schrieb Elaine Zhang:
>>>> Export __clk_lookup() to support user built as module.
>>>>
>>>> ERROR:
>>>> drivers/clk/rockchip/clk.ko: In function
>>>> `rockchip_clk_protect_critical':
>>>> drivers/clk/rockchip/clk.c:741:
>>>> undefined reference to `__clk_lookup'
>>> can you elaborate a bit more on why this would be needed?
>>>
>>> Because right now the Rockchip clocks are of course built into
>>> the main kernel image (especially due to them being needed during early
>>> boot) and __clk_lookup actually is a pretty deep part of the clock-
>>> framework itself, as probably also denoted by the "__" in the function
>>> name.
>>>
>> Can you stop using __clk_lookup()? The plan is to remove it.
>
> Rk use  __clk_lookup() as:
>
> drivers/clk/rockchip/clk.c
>
> void __init rockchip_clk_protect_critical(const char *const clocks[],
>                                           int nclocks)
> {
>         int i;
>
>         /* Protect the clocks that needs to stay on */
>         for (i = 0; i < nclocks; i++) {
>                 struct clk *clk = __clk_lookup(clocks[i]);
>
>                 if (clk)
>                         clk_prepare_enable(clk);
>         }
> }
> e.g:
>
> drivers/clk/rockchip/clk-rk3328.c
>
> static const char *const rk3328_critical_clocks[] __initconst = {
>         "aclk_bus",
>         "aclk_bus_niu",
>         "pclk_bus",
>         "pclk_bus_niu",
>         "hclk_bus",
>         "hclk_bus_niu",
>         "aclk_peri",
> ............
>
> };
>
> If have plan to remove the __clk_lookup, I need to replace the 
> rockchip_clk_protect_critical, and use the flag CLK_IS_CRITICAL.(but 
> use flag CLK_IS_CRITICAL, the enable count is always "0")
Use the CLK_IS_CRITICAL, there is no guarantee that the parent clk is 
enabled, So the flag CLK_IS_CRITICAL need to be added to all special 
clks according to the clk tree.
>
>>
>>


