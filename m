Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB1AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A13206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbgGWDga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:36:30 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:41462 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbgGWDg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:36:29 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id D0411626;
        Thu, 23 Jul 2020 11:36:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26708T140361068414720S1595475377813196_;
        Thu, 23 Jul 2020 11:36:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <456395a23dbaab454e0c8d02710fb0dc>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: kever.yang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v1] clk: Export __clk_lookup()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
References: <20200722023230.10826-1-zhangqing@rock-chips.com>
 <14639646.VOZsFJ8Tpa@phil>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <ecff8b61-f16e-c1ca-3b92-9c90867e73a7@rock-chips.com>
Date:   Thu, 23 Jul 2020 11:36:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14639646.VOZsFJ8Tpa@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/7/23 ÉÏÎç2:26, Heiko Stuebner Ð´µÀ:
> Hi Elaine,
>
> Am Mittwoch, 22. Juli 2020, 04:32:30 CEST schrieb Elaine Zhang:
>> Export __clk_lookup() to support user built as module.
>>
>> ERROR:
>> drivers/clk/rockchip/clk.ko: In function
>> `rockchip_clk_protect_critical':
>> drivers/clk/rockchip/clk.c:741:
>> undefined reference to `__clk_lookup'
> can you elaborate a bit more on why this would be needed?
>
> Because right now the Rockchip clocks are of course built into
> the main kernel image (especially due to them being needed during early
> boot) and __clk_lookup actually is a pretty deep part of the clock-
> framework itself, as probably also denoted by the "__" in the function
> name.

Rockchip clocks are of course support to built as module(to support GKI),These changes will be pushed soon.
In drivers/clk/rockchip/clk.c and drivers/clk/rockchip/clk-cpu.c use the __clk_lookup.

>
>
> Heiko
>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   drivers/clk/clk.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 3f588ed06ce3..600284fbb257 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -618,6 +618,7 @@ struct clk *__clk_lookup(const char *name)
>>   
>>   	return !core ? NULL : core->hw->clk;
>>   }
>> +EXPORT_SYMBOL_GPL(__clk_lookup);
>>   
>>   static void clk_core_get_boundaries(struct clk_core *core,
>>   				    unsigned long *min_rate,
>>
>
>
>
>
>


