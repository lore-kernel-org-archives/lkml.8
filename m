Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04507C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E4420842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZpO4pu5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgBJQo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:44:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51916 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgBJQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:44:57 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AGiDoS014892;
        Mon, 10 Feb 2020 17:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=y/PsKaEIAkDWo0E4iGUAxR/ykQZZiBUEkyx2cOtntI4=;
 b=ZpO4pu5okIN50MHtP4levL3gzyz1HEvsLzvb0Fd8627ucLGLU9zZs5MXG0AmIz1+SFov
 3d0S37HJjpka9xAn44y/lB2Og90ZbwoPvIBEKiJGiOkVH9iydW7F5w6us2KzaXzI9KG+
 AYUOk/84dWrE+y6ZQtF6ctGdm3pPhdWiwABsk60UVE7izEK7UgM+W9TSnGTL++j+el/Q
 eF55Rw4pXdkrbVZNNP1vm7bHZsHfVsA0QMSvdN+1500lrMdgmwaa2GalLfOBCUPdcOdE
 qDTubkRJ7h7ajCQAvIy1Y8ROVChTbpKUA10aamtr+pWQTEumohUx0qDBuOAMGctkR2X/ qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9c65t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 17:44:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 103A810002A;
        Mon, 10 Feb 2020 17:44:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05FAC2AE224;
        Mon, 10 Feb 2020 17:44:45 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb
 2020 17:44:44 +0100
Subject: Re: [PATCH] ARM: dts: stm32: remove useless properties in
 stm32mp157a-avenger96 stmpic node
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200130135304.27842-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5cc061cb-d506-cddc-74e1-419ac6b76343@st.com>
Date:   Mon, 10 Feb 2020 17:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130135304.27842-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 1/30/20 2:53 PM, Benjamin Gaignard wrote:
> Theses 3 properties are not coded in driver so remove them from the DTS.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157a-avenger96.dts | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> index 628c74a45a25..e2d9febaa661 100644
> --- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> @@ -134,10 +134,6 @@
>   		#interrupt-cells = <2>;
>   		status = "okay";
>   
> -		st,main-control-register = <0x04>;
> -		st,vin-control-register = <0xc0>;
> -		st,usb-control-register = <0x30>;
> -
>   		regulators {
>   			compatible = "st,stpmic1-regulators";
>   
> 

Applied on stm32-next.

Thanks
Alex
