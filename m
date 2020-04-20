Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4472C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24AE20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sNGjbZ0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDTJfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:35:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54974 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgDTJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:35:03 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K9Xodh030718;
        Mon, 20 Apr 2020 11:34:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=a05mT9cvrGwq02jpMc/AFPdAz6oDSD/XlNg9F8frg1U=;
 b=sNGjbZ0q5b1ryKnFWcYEDuUXzdzoocENayMtfTKmenh5r13POZB1Uh+vuHfHCCaT5hyY
 31INmIl6kwo1UibKvqE0EJ3hkLDaQDE9oVKwkLpH7TOuR2vM5AGctAwGbnBvmui1ByDb
 x2sVmN/aBciCpI5m+ts/dSN7jFwx5dpf03DL287gUJNmrh/nxg4hXM4MbTfoeuGlaAQq
 9vnbqF+JCsl2uX+uJjI7D/YPsNEde9SVgOpHgWphHJKpENrYqBw5SVYI/n/9oIKrrHpX
 dnJxlcLQeRBfjZQVysYvFknk8gxgsl25niIPIwhREAQzceAjB5fXEAtH590Jfc6TaKb/ mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq119ggr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 11:34:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26CBA10003A;
        Mon, 20 Apr 2020 11:34:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 034CE2C0BE8;
        Mon, 20 Apr 2020 11:34:46 +0200 (CEST)
Received: from [10.211.6.74] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 11:34:44 +0200
Subject: Re: [RESEND v6 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200420085930.26989-1-benjamin.gaignard@st.com>
 <20200420085930.26989-2-benjamin.gaignard@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <f9d41617-797e-15d4-a058-a0a9e6669cdc@st.com>
Date:   Mon, 20 Apr 2020 11:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420085930.26989-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-17,2020-04-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 10:59 AM, Benjamin Gaignard wrote:
> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> index ddf190cb800b..64bab1c3bdac 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> @@ -33,6 +33,9 @@ properties:
>      items:
>        - const: mux
>  
> +  interrupts:
> +    maxItems: 1
> +
>    "#address-cells":
>      const: 1
>  
> @@ -93,6 +96,16 @@ patternProperties:
>      required:
>        - compatible
>  
> +  timer:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: st,stm32-lptimer-timer
> +
> +    required:
> +      - compatible
> +
>  required:
>    - "#address-cells"
>    - "#size-cells"
> @@ -106,11 +119,13 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>      timer@40002400 {
>        compatible = "st,stm32-lptimer";
>        reg = <0x40002400 0x400>;
>        clocks = <&timer_clk>;
>        clock-names = "mux";
> +      interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> @@ -131,6 +146,10 @@ examples:
>        timer {
>          compatible = "st,stm32-lptimer-timer";
>        };
> +
> +      timer {
> +        compatible = "st,stm32-lptimer-timer";
> +      };

Hi Benjamin,

It looks like the compatible is duplicated in this example.
Also, from "PATCH v6" I don't see the wakeup-source flag in your resend.
Can you double-check ?

Thanks,
Best Regards,
Fabrice

>      };
>  
>  ...
> 
