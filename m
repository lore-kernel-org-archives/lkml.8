Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E04207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jc6mPT2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgHTIQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:16:51 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33661 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgHTINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:13:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07K86vFO007077;
        Thu, 20 Aug 2020 10:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=bypIudVjLD+BMgyLulgj0MddZ/EB2P+mWgfGr0rQwJo=;
 b=jc6mPT2/HmRJzmahbN2wVAYpofs2aGC3NhG3DJOgHC4DwUiBnL2fjYxjHgbqSLufFwcP
 OrPggsxjgfvK8Y285ICq5seBT/Eav0tWbnXhuHxZOcumnzFZkjhhz9JHtB3+wfPl+Z4+
 NQdji+vwQ/7/GPkrx6Yi0Q3j0pu5JpQ+LxjcVFRXsIQ1kUORBMyP8u7YsIn2wVRdOKmD
 wh3uznktpBVaxOKHseChr7unax3u+ypPEnICHS38gbD1KqvVydEwlLZDBCsKcE1BMqaW
 9ZdWmS4U0opvOoZgNPNVJs1byZZNTkZ0MvzpQxIj+CidlnIAHNzLNhQTR6gY/j1KTGbb ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 330jek8k2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 10:13:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9FF2010002A;
        Thu, 20 Aug 2020 10:13:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 331E921299C;
        Thu, 20 Aug 2020 10:13:14 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Aug
 2020 10:13:13 +0200
Subject: Re: [PATCH 11/12] regulator: stm32-vrefbuf: Fix W=1 build warning
 when CONFIG_OF=n
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Icenowy Zheng <icenowy@aosc.io>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200820152926.42c48840@xhacker.debian>
 <20200820154626.79d83157@xhacker.debian>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <20fc45ab-4daf-3855-5817-1898d50c9efc@st.com>
Date:   Thu, 20 Aug 2020 10:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820154626.79d83157@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_01:2020-08-19,2020-08-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 9:46 AM, Jisheng Zhang wrote:
> Fix below warning when CONFIG_OF=n:
> 
> drivers/regulator/stm32-vrefbuf.c:287:34: warning: ‘stm32_vrefbuf_of_match’ defined but not used [-Wunused-const-variable=]
>   287 | static const struct of_device_id stm32_vrefbuf_of_match[] = {
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/regulator/stm32-vrefbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
> index 992bc18101ef..5a5c12d9ea22 100644
> --- a/drivers/regulator/stm32-vrefbuf.c
> +++ b/drivers/regulator/stm32-vrefbuf.c
> @@ -284,11 +284,13 @@ static const struct dev_pm_ops stm32_vrefbuf_pm_ops = {
>  			   NULL)
>  };
>  
> +#ifdef CONFIG_OF

Hi Jisheng,

You could probably adopt "__maybe_unused" here ? E.g. like:

static const struct of_device_id __maybe_unused stm32_vrefbuf_of_match[] = {

I can see other drivers use this already for the same.

Thanks,
Best regards,
Fabrice

>  static const struct of_device_id stm32_vrefbuf_of_match[] = {
>  	{ .compatible = "st,stm32-vrefbuf", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_vrefbuf_of_match);
> +#endif
>  
>  static struct platform_driver stm32_vrefbuf_driver = {
>  	.probe = stm32_vrefbuf_probe,
> 
