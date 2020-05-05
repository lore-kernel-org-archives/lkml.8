Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D4C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16D2206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xJnwGeMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgEELwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:52:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEELwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:52:36 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045BnN8o019017;
        Tue, 5 May 2020 13:52:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=3SOp8PhNdW4IrWYxqJrQCRdEteG7eOQ26e42CGGjuAA=;
 b=xJnwGeMBKd93uRpJLbpprI7VkgCllwAGNZ81JG8prq/cV4mA+UX6aNb/YRrT0Or53xgj
 uAFYinEeYsQilCi6R/IcWGXhdLjgLqpmqiKG/CZhC7LiZLa4ufizmVUtUeGaLNMB2xSq
 4rvNbn0ZjfPZWu2ctwjI5kIldQ4GyCa0r1sFg8rITCzBNf7SHaam7goJ5OTWx2ut1ZDT
 5CD6T7z8JvFCWpV7y7pwH4Su8aoU1N+SmXfhcdbOSBk4KVdAuatBkEbXBlSHc7l4hy4g
 KY2kcpfrHnvrrUZUPxAFK+vz/9lXG3GPIfUuVkOYB/I4UddIi10YGkB2dbei0rGDhwVt 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxmvfse6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 13:52:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44ABF10002A;
        Tue,  5 May 2020 13:52:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 160F22B8A14;
        Tue,  5 May 2020 13:52:26 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 May
 2020 13:52:21 +0200
Subject: Re: [PATCH] ARM: dts: stm32: Enable thermal sensor support on
 stm32mp15xx-dkx
To:     Pascal Paillet <p.paillet@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200430130235.23979-1-p.paillet@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <264b0346-736e-91a0-c9c2-4f1a53627363@st.com>
Date:   Tue, 5 May 2020 13:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200430130235.23979-1-p.paillet@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_06:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal

On 4/30/20 3:02 PM, Pascal Paillet wrote:
> Enable STM32 Digital Thermal Sensor driver for stm32mp15xx-dkx boards.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> index f6672e87aef3..203f7742e054 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> @@ -116,6 +116,10 @@
>   	status = "okay";
>   };
>   
> +&dts {
> +	status = "okay";
> +};
> +
>   &ethernet0 {
>   	status = "okay";
>   	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> 

Applied on stm32-next.

Thanks.
Alex
