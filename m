Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81540C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577EF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tYjvTXZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBQIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:21:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24128 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgBQIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:21:33 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01H8DR2s003204;
        Mon, 17 Feb 2020 09:21:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=eeYePah8N20Fhz2BV0G/EU8+d/RYrV5o3pvxjTnWhtQ=;
 b=tYjvTXZR/+yVgJq4Q7/Q8BVNR4fg57US+2Lz2Rv12fLlnKMRkjd+xOhyAsK4CKhqyC9P
 ajb7XMJ/ERa17xR/QCtYS79B13JLRda0+BjSC1sCDOTeHO4++yTgshQ4zwKEUwaz2Pl+
 4o5moP2QRz+TXJNj01NOq2gBvNwim0410gQZjGsiWu+KiMZSeV5fWF3FHdu8Z8N78vKU
 jxPpUZ89F4XVR2XxVoSWYO9Kdxsl/JQHBPgdUWEhVuYi2JiUBb0HBfKWnrKO6vH+TC6J
 t/28ljTKWtjt73PMR+QJwTqcOLqsHr68cyFRWddll0XOHFcmbcKk5QRHyUyUb/bWPgxo Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y6705hmd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 09:21:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 839C7100038;
        Mon, 17 Feb 2020 09:21:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 74E0B221612;
        Mon, 17 Feb 2020 09:21:10 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 09:21:09 +0100
Subject: Re: [PATCH] MAINTAINERS: adjust to stm32 timer dt-bindings conversion
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Rob Herring <robh@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        Joe Perches <joe@perches.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200216130841.4187-1-lukas.bulwahn@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <d24f8983-1d68-11d3-280e-a632ba618460@st.com>
Date:   Mon, 17 Feb 2020 09:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200216130841.4187-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_04:2020-02-14,2020-02-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 2:08 PM, Lukas Bulwahn wrote:
> The commit 56fb34d86e87 ("dt-bindings: mfd: Convert stm32 timers bindings
> to json-schema") and commit b88091f5d84a ("dt-bindings: mfd: Convert stm32
> low power timers bindings to json-schema") converted some files from txt to
> yaml format in ./Documentation/devicetree/bindings/, but they missed to
> adjust MAINTAINERS.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   no file matches F: Documentation/devicetree/bindings/*/stm32-*timer*
>   no file matches F: Documentation/devicetree/bindings/pwm/pwm-stm32*
> 
> So, repair the MAINTAINERS entry now.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Hi Lukas,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> ---
> Benjamin, Fabrice, please ack.
> Rob, please pick this patch.
> applies cleanly on current master and on next-20200214
> 
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0d86490c2c6..9175b59e2b4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15923,8 +15923,7 @@ F:	drivers/*/stm32-*timer*
>  F:	drivers/pwm/pwm-stm32*
>  F:	include/linux/*/stm32-*tim*
>  F:	Documentation/ABI/testing/*timer-stm32
> -F:	Documentation/devicetree/bindings/*/stm32-*timer*
> -F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
> +F:	Documentation/devicetree/bindings/mfd/st,stm32-*timer*.yaml
>  
>  STMMAC ETHERNET DRIVER
>  M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
