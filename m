Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A387BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2B21556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAHoZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 02:44:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36789 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCAHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 02:44:24 -0500
X-Originating-IP: 90.112.224.173
Received: from pc-39.home (lfbn-gre-1-269-173.w90-112.abo.wanadoo.fr [90.112.224.173])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6C1A9FF809;
        Sun,  1 Mar 2020 07:44:21 +0000 (UTC)
Date:   Sun, 01 Mar 2020 08:44:19 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200229230648.GA21220@plvision.eu>
References: <20200209212016.27062-1-vadym.kochan@plvision.eu> <20200229230648.GA21220@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] arm64: dts: marvell: fix non-existed cpu referrence in armada-ap806-dual.dtsi
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
Message-ID: <647B367B-4278-4D00-98D3-1FCA76D87488@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 1 mars 2020 00:06:56 GMT+01:00, Vadym Kochan <vadym.kochan@plvision.eu> a écrit :
>Hi,
>

Hello
>Just softly ping if I sent it to the right direction.
It looks ok, and was on the list of patches to apply 

Sorry for the delay
>
>On Sun, Feb 09, 2020 at 11:20:30PM +0200, Vadym Kochan wrote:
>> armada-ap806-dual.dtsi includes armada-ap806.dtsi which describes
>> thermal zones for 4 cpus but only cpu0 and cpu1 only exists for dual
>> configuration, this makes dtb compilation fail. Fix it by removing
>> thermal zone nodes for non-existed cpus for dual configuration.
>> 
>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
>b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
>> index 09849558a776..fcab5173fe67 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
>> @@ -53,4 +53,9 @@
>>  			cache-sets = <512>;
>>  		};
>>  	};
>> +
>> +	thermal-zones {
>> +		/delete-node/ ap-thermal-cpu2;
>> +		/delete-node/ ap-thermal-cpu3;
>> +	};
>>  };
>> -- 
>> 2.17.1
>> 
>
>Regards,
>Vadym Kochan

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
