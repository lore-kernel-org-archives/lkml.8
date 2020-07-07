Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECA7206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="bZ5qsaBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgGGVFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:05:52 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:52713 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGGVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=HQwHsSLOGbbfu+RvJtKph55JfGztos9/1WaHqc0svfo=;
        b=bZ5qsaBAKMZZ64pVaN68mfU5j8qdhWrokgn3LEURbYhAlwfK6DxCuhwFAii+ttnc8YGJ
        cv0e/NIYsPG+PW5cL/Fpkaqf+xU9a5ewEeei0RquGZHMyISyMmqMWwGKmRGn/JHmChlkWs
        HePE9KZnRymYbN/BcRxmBAZxPS17BQ3Hw=
Received: by filterdrecv-p3las1-7754f7d4cc-blxz6 with SMTP id filterdrecv-p3las1-7754f7d4cc-blxz6-19-5F04E3AD-65
        2020-07-07 21:05:49.733146971 +0000 UTC m=+1047129.013300829
Received: from [192.168.1.14] (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id VzyOxLf3TS-z3j0rGr7bLQ
        Tue, 07 Jul 2020 21:05:49.292 +0000 (UTC)
Subject: Re: [PATCH v2 14/14] phy/rockchip: inno-hdmi: Support more pre-pll
 configuration
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20200108210740.28769-15-jonas@kwiboo.se>
 <425e10c2-ed03-be64-8153-9bc3657da10e@gmail.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <3124cfc2-8561-beff-5963-63f8f42bc644@kwiboo.se>
Date:   Tue, 07 Jul 2020 21:05:49 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <425e10c2-ed03-be64-8153-9bc3657da10e@gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyw1I00a5pC6Cn8Pg?=
 =?us-ascii?Q?VuGIRzrvNwwRCA4W3FGC9+j7OAlpVlG7MqBEPmB?=
 =?us-ascii?Q?QrRLojx7WqK6rWFzELAiMtWrLWD7by9pmODglll?=
 =?us-ascii?Q?hiOBk8U7B268bYhiyPxhXXSbLQULPX+J16aFlGQ?=
 =?us-ascii?Q?EPYz5owr14ry1OenCxhc4kayzbLjOpITNEwXqK2?=
 =?us-ascii?Q?eyhBvs5yyBMe0F5CLAYMw=3D=3D?=
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Algea Cao <algea.cao@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: sv
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-07 21:53, Johan Jonker wrote:
> 
> Hi,
> 
> What's the status for this patch?
> This is just what I needed for A95X Z2 to get the vop+hdmi and monitor
> working. ;)
> 
> Could this become applied to mainline already?
> The ack is already there.

I will send a v3 of the phy/rockchip parts of this series later tonight/tomorrow.

The drm side still need work and I have some pending patches that also
improve rk3288/rk3399 hdmi support for up to 4k@30hz, should make its way
onto the list in a few days.

Regards,
Jonas

> 
> Thanks,
> 
> Johan Jonker
> 
> https://lore.kernel.org/lkml/20200620134659.4592-1-jbx6244@gmail.com/
> 
> On 1/8/20 10:07 PM, Jonas Karlman wrote:
>> From: Algea Cao <algea.cao@rock-chips.com>
>>
>> Adding the following freq cfg in 8-bit and 10-bit color depth:
>>
>> {
>>   40000000,  65000000,  71000000,  83500000, 85750000,
>>   88750000, 108000000, 119000000, 162000000
>> }
>>
>> New freq has been validated by quantumdata 980.
>>
>> For some freq which can't be got by only using integer freq div,
>> frac freq div is needed, Such as 88.75Mhz 10-bit. But The actual
>> freq is different from the target freq, We must try to narrow
>> the gap between them. RK322X only support integer freq div.
>>
>> The VCO of pre-PLL must be more than 2Ghz, otherwise PLL may be
>> unlocked.
>>
>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 74 ++++++++++++-------
>>  1 file changed, 49 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> index 3719309ad0d0..bb8bdf5e3301 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> @@ -291,32 +291,56 @@ struct inno_hdmi_phy_drv_data {
>>  	const struct phy_config		*phy_cfg_table;
>>  };
>>  
>> +/*
>> + * If only using integer freq div can't get frequency we want, frac
>> + * freq div is needed. For example, pclk 88.75 Mhz and tmdsclk
>> + * 110.9375 Mhz must use frac div 0xF00000. The actual frequency is different
>> + * from the target frequency. Such as the tmds clock 110.9375 Mhz,
>> + * the actual tmds clock we get is 110.93719 Mhz. It is important
>> + * to note that RK322X platforms do not support frac div.
>> + */
>>  static const struct pre_pll_config pre_pll_cfg_table[] = {
>> -	{ 27000000,  27000000, 1,  90, 3, 2, 2, 10, 3, 3, 4, 0, 0},
>> -	{ 27000000,  33750000, 1,  90, 1, 3, 3, 10, 3, 3, 4, 0, 0},
>> -	{ 40000000,  40000000, 1,  80, 2, 2, 2, 12, 2, 2, 2, 0, 0},
>> -	{ 59341000,  59341000, 1,  98, 3, 1, 2,  1, 3, 3, 4, 0, 0xE6AE6B},
>> -	{ 59400000,  59400000, 1,  99, 3, 1, 1,  1, 3, 3, 4, 0, 0},
>> -	{ 59341000,  74176250, 1,  98, 0, 3, 3,  1, 3, 3, 4, 0, 0xE6AE6B},
>> -	{ 59400000,  74250000, 1,  99, 1, 2, 2,  1, 3, 3, 4, 0, 0},
>> -	{ 74176000,  74176000, 1,  98, 1, 2, 2,  1, 2, 3, 4, 0, 0xE6AE6B},
>> -	{ 74250000,  74250000, 1,  99, 1, 2, 2,  1, 2, 3, 4, 0, 0},
>> -	{ 74176000,  92720000, 4, 494, 1, 2, 2,  1, 3, 3, 4, 0, 0x816817},
>> -	{ 74250000,  92812500, 4, 495, 1, 2, 2,  1, 3, 3, 4, 0, 0},
>> -	{148352000, 148352000, 1,  98, 1, 1, 1,  1, 2, 2, 2, 0, 0xE6AE6B},
>> -	{148500000, 148500000, 1,  99, 1, 1, 1,  1, 2, 2, 2, 0, 0},
>> -	{148352000, 185440000, 4, 494, 0, 2, 2,  1, 3, 2, 2, 0, 0x816817},
>> -	{148500000, 185625000, 4, 495, 0, 2, 2,  1, 3, 2, 2, 0, 0},
>> -	{296703000, 296703000, 1,  98, 0, 1, 1,  1, 0, 2, 2, 0, 0xE6AE6B},
>> -	{297000000, 297000000, 1,  99, 0, 1, 1,  1, 0, 2, 2, 0, 0},
>> -	{296703000, 370878750, 4, 494, 1, 2, 0,  1, 3, 1, 1, 0, 0x816817},
>> -	{297000000, 371250000, 4, 495, 1, 2, 0,  1, 3, 1, 1, 0, 0},
>> -	{593407000, 296703500, 1,  98, 0, 1, 1,  1, 0, 2, 1, 0, 0xE6AE6B},
>> -	{594000000, 297000000, 1,  99, 0, 1, 1,  1, 0, 2, 1, 0, 0},
>> -	{593407000, 370879375, 4, 494, 1, 2, 0,  1, 3, 1, 1, 1, 0x816817},
>> -	{594000000, 371250000, 4, 495, 1, 2, 0,  1, 3, 1, 1, 1, 0},
>> -	{593407000, 593407000, 1,  98, 0, 2, 0,  1, 0, 1, 1, 0, 0xE6AE6B},
>> -	{594000000, 594000000, 1,  99, 0, 2, 0,  1, 0, 1, 1, 0, 0},
>> +	{ 27000000,  27000000, 1,  90, 3, 2, 2, 10, 3, 3,  4, 0, 0},
>> +	{ 27000000,  33750000, 1,  90, 1, 3, 3, 10, 3, 3,  4, 0, 0},
>> +	{ 40000000,  40000000, 1,  80, 2, 2, 2, 12, 2, 2,  2, 0, 0},
>> +	{ 40000000,  50000000, 1, 100, 2, 2, 2,  1, 0, 0, 15, 0, 0},
>> +	{ 59341000,  59341000, 1,  98, 3, 1, 2,  1, 3, 3,  4, 0, 0xE6AE6B},
>> +	{ 59400000,  59400000, 1,  99, 3, 1, 1,  1, 3, 3,  4, 0, 0},
>> +	{ 59341000,  74176250, 1,  98, 0, 3, 3,  1, 3, 3,  4, 0, 0xE6AE6B},
>> +	{ 59400000,  74250000, 1,  99, 1, 2, 2,  1, 3, 3,  4, 0, 0},
>> +	{ 65000000,  65000000, 1, 130, 2, 2, 2,  1, 0, 0, 12, 0, 0},
>> +	{ 65000000,  81250000, 3, 325, 0, 3, 3,  1, 0, 0, 10, 0, 0},
>> +	{ 71000000,  71000000, 3, 284, 0, 3, 3,  1, 0, 0,  8, 0, 0},
>> +	{ 71000000,  88750000, 3, 355, 0, 3, 3,  1, 0, 0, 10, 0, 0},
>> +	{ 74176000,  74176000, 1,  98, 1, 2, 2,  1, 2, 3,  4, 0, 0xE6AE6B},
>> +	{ 74250000,  74250000, 1,  99, 1, 2, 2,  1, 2, 3,  4, 0, 0},
>> +	{ 74176000,  92720000, 4, 494, 1, 2, 2,  1, 3, 3,  4, 0, 0x816817},
>> +	{ 74250000,  92812500, 4, 495, 1, 2, 2,  1, 3, 3,  4, 0, 0},
>> +	{ 83500000,  83500000, 2, 167, 2, 1, 1,  1, 0, 0,  6, 0, 0},
>> +	{ 83500000, 104375000, 1, 104, 2, 1, 1,  1, 1, 0,  5, 0, 0x600000},
>> +	{ 85750000,  85750000, 3, 343, 0, 3, 3,  1, 0, 0,  8, 0, 0},
>> +	{ 88750000,  88750000, 3, 355, 0, 3, 3,  1, 0, 0,  8, 0, 0},
>> +	{ 88750000, 110937500, 1, 110, 2, 1, 1,  1, 1, 0,  5, 0, 0xF00000},
>> +	{108000000, 108000000, 1,  90, 3, 0, 0,  1, 0, 0,  5, 0, 0},
>> +	{108000000, 135000000, 1,  90, 0, 2, 2,  1, 0, 0,  5, 0, 0},
>> +	{119000000, 119000000, 1, 119, 2, 1, 1,  1, 0, 0,  6, 0, 0},
>> +	{119000000, 148750000, 1,  99, 0, 2, 2,  1, 0, 0,  5, 0, 0x2AAAAA},
>> +	{148352000, 148352000, 1,  98, 1, 1, 1,  1, 2, 2,  2, 0, 0xE6AE6B},
>> +	{148500000, 148500000, 1,  99, 1, 1, 1,  1, 2, 2,  2, 0, 0},
>> +	{148352000, 185440000, 4, 494, 0, 2, 2,  1, 3, 2,  2, 0, 0x816817},
>> +	{148500000, 185625000, 4, 495, 0, 2, 2,  1, 3, 2,  2, 0, 0},
>> +	{162000000, 162000000, 1, 108, 0, 2, 2,  1, 0, 0,  4, 0, 0},
>> +	{162000000, 202500000, 1, 135, 0, 2, 2,  1, 0, 0,  5, 0, 0},
>> +	{296703000, 296703000, 1,  98, 0, 1, 1,  1, 0, 2,  2, 0, 0xE6AE6B},
>> +	{297000000, 297000000, 1,  99, 0, 1, 1,  1, 0, 2,  2, 0, 0},
>> +	{296703000, 370878750, 4, 494, 1, 2, 0,  1, 3, 1,  1, 0, 0x816817},
>> +	{297000000, 371250000, 4, 495, 1, 2, 0,  1, 3, 1,  1, 0, 0},
>> +	{593407000, 296703500, 1,  98, 0, 1, 1,  1, 0, 2,  1, 0, 0xE6AE6B},
>> +	{594000000, 297000000, 1,  99, 0, 1, 1,  1, 0, 2,  1, 0, 0},
>> +	{593407000, 370879375, 4, 494, 1, 2, 0,  1, 3, 1,  1, 1, 0x816817},
>> +	{594000000, 371250000, 4, 495, 1, 2, 0,  1, 3, 1,  1, 1, 0},
>> +	{593407000, 593407000, 1,  98, 0, 2, 0,  1, 0, 1,  1, 0, 0xE6AE6B},
>> +	{594000000, 594000000, 1,  99, 0, 2, 0,  1, 0, 1,  1, 0, 0},
>>  	{ /* sentinel */ }
>>  };
>>  
>>
> 
