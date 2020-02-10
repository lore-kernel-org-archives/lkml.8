Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FEC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D4920733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AMe9XJZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBJQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:50:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgBJQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:50:13 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AGmDCa031519;
        Mon, 10 Feb 2020 17:50:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=eBkGpkRko2BRohv8+fSQZ08+pRwJLd2qKeoxI/IMxyU=;
 b=AMe9XJZpA3R33TTPo2JG4NLTwXJVSH2UgLjhsqnhX84t82wAQfHAK65EaMX6YGn7O/1V
 VdExp851mQM/rlJZ8QvH+aDrMUOFbXZ3Di6+e3976aKQ2OMVmJWoOhB7LSt1STV5i6Jw
 g4AXzqyrD43NeQG7phbtXEDcnyt1GuPJ6JfDXk7z9/kIqYfzXXE0f/MZ+0PZGIiEEr8k
 AtcxXR/ufW4xArJ4cm9Fzg9idffrRTnlitZjWj26tavSnQjlvjRIR+sP+OE4PH0Wmzhg
 vdldDmys4B12PKOpwYcEyyj9DWVRSSOFsm0r13CWU64zhmpRMHMZv157RwWoBMsnZdI/ /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9c7mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 17:50:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1AA610002A;
        Mon, 10 Feb 2020 17:50:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 969FD2C0984;
        Mon, 10 Feb 2020 17:50:00 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb
 2020 17:49:59 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Correct stmfx node name on
 stm32mp157c-ev1 board
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200210134331.14039-1-benjamin.gaignard@st.com>
 <20200210134331.14039-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <fb300410-7ee8-d199-9ffa-a91da0f80c8d@st.com>
Date:   Mon, 10 Feb 2020 17:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210134331.14039-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 2/10/20 2:43 PM, Benjamin Gaignard wrote:
> Change stmfx node name to fit with yaml requirements.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index 228e35e16884..ffd4e0caeedc 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -210,7 +210,7 @@
>   		interrupt-parent = <&gpioi>;
>   		vdd-supply = <&v3v3>;
>   
> -		stmfx_pinctrl: stmfx-pin-controller {
> +		stmfx_pinctrl: pinctrl {
>   			compatible = "st,stmfx-0300-pinctrl";
>   			gpio-controller;
>   			#gpio-cells = <2>;
> 

Applied on stm32-next.

Thanks
Alex
