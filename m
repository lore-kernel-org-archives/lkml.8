Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5E920784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bjveDkYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgDAIvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:51:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55164 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgDAIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:51:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318n08e009311;
        Wed, 1 Apr 2020 10:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=1rCMuLCvnLZNatxXIIxnqYRt75OvA+RZrvrTvHgGw2M=;
 b=bjveDkYbrYq985QKvUcsGxSgwEB6kI3RynOjf+BgmY6JcHcmsjz1vvfpCAwKlgQumLXf
 qoqoEVl3a+LqMc+6rFqMsfMa02ESV6BADRflliof5gAtGEcm/Zwp02fmmrtBCgsYlOG3
 tVfXipak/whlCqaFFueVXQReQyElivj0SiOFJg2ldTNWzI2x+Baz4ZQWgL0sHSEvbcRg
 Dk637If6+MD7hjTEUoLGOIIEo76lRrq0XVvq7uKnpwNDehfIu0eX1TQsg+C9hMa958fU
 uw1JhYK7XY2wuiSCfllM1GP1yw7+FNqZxcHN+5sKRN4o5gp/y9wfQtOqxKXo3T8/L5Bf /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y53x4g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:51:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E12610002A;
        Wed,  1 Apr 2020 10:51:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F92121CA7C;
        Wed,  1 Apr 2020 10:51:21 +0200 (CEST)
Received: from [10.211.14.17] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 10:51:19 +0200
Subject: Re: [PATCH v6 1/6] dt-bindings: mfd: Document STM32 low power timer
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
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
 <20200401083909.18886-2-benjamin.gaignard@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <2e3814e2-f6fc-038f-4fb0-87432d99edfb@st.com>
Date:   Wed, 1 Apr 2020 10:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401083909.18886-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 10:39 AM, Benjamin Gaignard wrote:
> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> version 6:
> - only use one interrupt
> 
> version 5:
> - the previous has been acked-by Rob but since I have docummented
>   interrupts and interrupt-names properties I haven't applied it here.
> 
> version 4:
> - change compatible and subnode names
> - document wakeup-source property
> 
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Hi Benjamin,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice

> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> index 1a4cc5f3fb33..2a99b2296d2b 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> @@ -33,12 +33,17 @@ properties:
>      items:
>        - const: mux
>  
> +  interrupts:
> +    maxItems: 1
> +
>    "#address-cells":
>      const: 1
>  
>    "#size-cells":
>      const: 0
>  
> +  wakeup-source: true
> +
>    pwm:
>      type: object
>  
> @@ -81,6 +86,16 @@ patternProperties:
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
> @@ -94,11 +109,13 @@ additionalProperties: false
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
> @@ -115,6 +132,10 @@ examples:
>        counter {
>          compatible = "st,stm32-lptimer-counter";
>        };
> +
> +      timer {
> +        compatible = "st,stm32-lptimer-timer";
> +      };
>      };
>  
>  ...
> 
