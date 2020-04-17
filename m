Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC22C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB3B20780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgDQLvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:51:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgDQLvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E1530E;
        Fri, 17 Apr 2020 04:51:18 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984933F6C4;
        Fri, 17 Apr 2020 04:51:17 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: dts: rockchip: add core devicetree for rk3318
To:     Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200417105739.3718-1-jbx6244@gmail.com>
 <2141402.AJMLQ3pQEO@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d5a1d27-8d32-eca2-007c-aa0bed81af46@arm.com>
Date:   Fri, 17 Apr 2020 12:51:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2141402.AJMLQ3pQEO@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 12:05 pm, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Freitag, 17. April 2020, 12:57:39 CEST schrieb Johan Jonker:
>> The rk3318 is basically a rk3328 with improved gpu,
>> so add a dtsi based on that.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Please don't add dangling dtsi files.
> I'd expect at least a board dts to actually use that and
> also the updated gpu node.
> 
>  From a cursory glance it looks like it gets upgraded from
> 450-MP2 to 450MP3 or so, so that would at least mean
> another set of interrupts.

I'm not sure anything's "improved" - as far as the internet can tell 
it's a special low-cost variant of RK3328 for low-end TV box vendors 
that Rockchip don't want to talk about. The DTB for my H96 Max 3318 
shows no appreciable difference from the BSP DT for RK3328, although I 
wouldn't be surprised if some of the unused stuff like the external GMAC 
was actually missing or broken. The board itself is the exact same one 
used in a lot of other cheap RK3328 boxes (and I mean literally, it's 
silkscreened "RK3328_8D4_V1.2").

Thanks to one unexpectedly honest Aliexpress listing I stumbled across, 
the "penta-core GPU" apparently translates from TV-box-marketing-speak 
to mean Mali-450 MP2 (1GP + 2PP) plus the RGA plus the VOP ;)

Robin.

> 
> Heiko
> 
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3318.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3318.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3318.dtsi b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
>> new file mode 100644
>> index 000000000..a32f771bc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3328.dtsi"
>>
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
