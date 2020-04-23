Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF917C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADC22098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="eNDACs8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgDWPmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:42:15 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:48172 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbgDWPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:42:14 -0400
X-Greylist: delayed 1290 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 11:42:14 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 3B09646279
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:20:44 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id RdeejEi9Z8vkBRdeejzNCB; Thu, 23 Apr 2020 10:20:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lVr7d+CAP5nOq9QPmRmWkdHKDvdbA359gdwduj7bBvE=; b=eNDACs8MYJ6ttfA8OGNvduU9Ou
        0Cc3NDeYo3BG1LAi5SJ4V0GvVE4Fdw3xAzkGWMumjpwSSf53SjVL4pV+hKQXaStcLe/5LOXlUHgu0
        I7Mc1wSKfy3GJbmlo98jro3UKy+BD3wca9xLh3I+38LiQHiYmRZ3ZphMP46heRkxt+nmeSHvIuxTj
        bT4H0zxs9L6FO9rzIesmA5WaWhhs2g+yhdEUPt5IHi0W3mf+9acIa8Ky+XjrUBcVHyhjl1Wyxo+VN
        NpCCbw7KtqaFvf7P/eaT1wku2PFqzhG9RVfv7Hecz4iVgJDmW4NxHSVSITYi9PhEaugyXwU1vGYRE
        L3Y6C2EQ==;
Received: from [191.31.203.120] (port=55674 helo=[192.168.15.3])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jRded-000yw3-SL; Thu, 23 Apr 2020 12:20:44 -0300
Subject: Re: [PATCH v3 3/3] ARM: dts: Add Caninos Loucos Labrador
To:     afaerber@suse.de
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-4-matheus@castello.eng.br>
 <20200405065137.GC8912@Mani-XPS-13-9360>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <df32c750-a097-9210-6e13-db7db49836b5@castello.eng.br>
Date:   Thu, 23 Apr 2020 12:20:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200405065137.GC8912@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.203.120
X-Source-L: No
X-Exim-ID: 1jRded-000yw3-SL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.3]) [191.31.203.120]:55674
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 9
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Em 4/5/20 3:51 AM, Manivannan Sadhasivam escreveu:
> On Fri, Mar 20, 2020 at 12:51:04AM -0300, Matheus Castello wrote:
>> Add Device Trees for Caninos Loucos Labrador CoM and base board.
>> Based on the work of Andreas Färber on Lemaker Guitar device tree.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Will queue the series for v5.8 once Andreas is happy with it.
> 

do you have any more concerns about these patches? Let me know.

BR,
Matheus Castello

> Nit: Please keep linux-actions@lists.infradead.org in CC for all future
> patches/replies.
> 
> Thanks,
> Mani
> 
>> ---
>>   arch/arm/boot/dts/Makefile                  |  1 +
>>   arch/arm/boot/dts/owl-s500-labrador-bb.dts  | 34 +++++++++++++++++++++
>>   arch/arm/boot/dts/owl-s500-labrador-v2.dtsi | 21 +++++++++++++
>>   3 files changed, 56 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
>>   create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index d6546d2676b9..99f633460833 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -842,6 +842,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>>   dtb-$(CONFIG_ARCH_ACTIONS) += \
>>   	owl-s500-cubieboard6.dtb \
>>   	owl-s500-guitar-bb-rev-b.dtb \
>> +	owl-s500-labrador-bb.dtb \
>>   	owl-s500-sparky.dtb
>>   dtb-$(CONFIG_ARCH_PRIMA2) += \
>>   	prima2-evb.dtb
>> diff --git a/arch/arm/boot/dts/owl-s500-labrador-bb.dts b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
>> new file mode 100644
>> index 000000000000..91012b4a4c30
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Caninos Labrador Base Board
>> + *
>> + * Copyright (c) 2019-2020 Matheus Castello
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "owl-s500-labrador-v2.dtsi"
>> +
>> +/ {
>> +	compatible = "caninos,labrador-bb", "caninos,labrador", "actions,s500";
>> +	model = "Caninos Labrador Base Board M v1.0";
>> +
>> +	aliases {
>> +		serial3 = &uart3;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial3:115200n8";
>> +	};
>> +
>> +	uart3_clk: uart3-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <921600>;
>> +		#clock-cells = <0>;
>> +	};
>> +};
>> +
>> +&uart3 {
>> +	status = "okay";
>> +	clocks = <&uart3_clk>;
>> +};
>> diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
>> new file mode 100644
>> index 000000000000..0b54f1ef3ec0
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Caninos Labrador CoM V2
>> + *
>> + * Copyright (c) 2019-2020 Matheus Castello
>> + */
>> +
>> +#include "owl-s500.dtsi"
>> +
>> +/ {
>> +	compatible = "caninos,labrador", "actions,s500";
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x80000000>;
>> +	};
>> +};
>> +
>> +&timer {
>> +	clocks = <&hosc>;
>> +};
>> --
>> 2.25.0
>>
