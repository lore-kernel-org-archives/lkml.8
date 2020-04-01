Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB87C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B4B20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="L8xIjD8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbgDAJHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:07:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34378 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgDAJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:07:09 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03192xIJ005415;
        Wed, 1 Apr 2020 11:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pUAdDfLled6exIm4UEQprNwjkf9bN4q2badOB4c9Qto=;
 b=L8xIjD8MknhHPdT0rYy8MHIoHmlmI1rzGA91bzR/kSpQLIGCIB++70TZcLOkQUAL/5f0
 wqt3IXVbg6WG2RPqtp3KtS1Weiv5FeWtwBXDcAUFCHKxaU9l9sjyUyL6W7l+ZllirYON
 liszlxjdtfxgpQ7kykCuFWC68Nxmh4YOlO6EL/Bijt0jcEGi9nvT1YfRw99xQlGZBceR
 hmpxZnTGkwAiQ/joABX5oyyc/z57neg/RZClbtgP2xzrA/pmufv0AsHXxBGWu/UOGA4a
 yPqmudtlIVqLZ87RjHjqjpYfNcxtAzTclnzgSNos+qbSaV6yeuSx2Tz/RcNxWZm34uz+ RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmm2xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 11:06:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7597310002A;
        Wed,  1 Apr 2020 11:06:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5871221D6FA;
        Wed,  1 Apr 2020 11:06:44 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr
 2020 11:06:39 +0200
Subject: Re: [PATCH v2 8/8] dt-bindings: arm: stm32: document
 lxa,stm32mp157c-mc1 compatible
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200326220213.28632-1-a.fatoum@pengutronix.de>
 <20200326220213.28632-8-a.fatoum@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c0be1d2f-8e89-6786-86be-0f851e8b3441@st.com>
Date:   Wed, 1 Apr 2020 11:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326220213.28632-8-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 3/26/20 11:02 PM, Ahmad Fatoum wrote:
> Document the STM32MP157 based Linux Automation MC-1 device tree
> compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---

Sorry my mailer has lost the cover-letter mail, so consider I respond to 
to the whole series.

Thanks for adding a new stm32 board and more importantly to have 
standardize pins name, I appreciate it.

Series applied on stm32-next.

Regards
Alex


>   v1 -> v2:
>   - Added Rob's Ack
> ---
>   Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 1fcf306bd2d1..71ea3f04ab9c 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -38,6 +38,7 @@ properties:
>         - items:
>             - enum:
>                 - arrow,stm32mp157a-avenger96 # Avenger96
> +              - lxa,stm32mp157c-mc1
>                 - st,stm32mp157c-ed1
>                 - st,stm32mp157a-dk1
>                 - st,stm32mp157c-dk2
> 
