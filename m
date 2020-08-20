Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A956C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160452078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oeRopF5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHTD4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:56:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30117 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHTD4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:56:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597895798; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0Ene2rVOMV4n1dEpM6kT25mhCOM8ZBLpeIVDWoHFH6U=; b=oeRopF5MSusebGlyXI3enl7z1y3IOp1XgacyMicf+B+TxMIlACGU8xAszZXipLzgle9WyM9N
 2VkRge99jjieg1znwr3LpZBK8j6VFuiW/NG7EAsKl6FiFgSWOt8CkmbwCJJ2wQ8U3BvwXFE2
 gnCL18p8EZQabYMRADieTDJF1tA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3df45bb8eb275bd5a9a425 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 03:56:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E32EC433A1; Thu, 20 Aug 2020 03:56:10 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3759EC433CA;
        Thu, 20 Aug 2020 03:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3759EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH][next] ASoC: qcom: add missing out of memory check on
 drvdata->clks allocation
To:     Colin King <colin.king@canonical.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819160103.164893-1-colin.king@canonical.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <82bb39d1-c3a9-a8d1-9d96-f4d6d6b0f042@codeaurora.org>
Date:   Thu, 20 Aug 2020 09:25:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819160103.164893-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/19/2020 9:31 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently drvdata->clks is not being checked for an allocation failure,
> leading to potential null pointer dereferencing. Fix this by adding a
> check and returning -ENOMEM if an error occurred.
>
> Addresses-Coverity: ("Dereference null return value")
> Fixes: 1220f6a76e77 ("ASoC: qcom: Add common array to initialize soc based core clocks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks for the fix.

Reviewed-by: Rohit kumar <rohitkr@codeaurora.org>

>   sound/soc/qcom/lpass-apq8016.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
> index dd9e3dd014f6..5c8ae225cd5d 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c
> @@ -168,6 +168,8 @@ static int apq8016_lpass_init(struct platform_device *pdev)
>   
>   	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
>   				     sizeof(*drvdata->clks), GFP_KERNEL);
> +	if (!drvdata->clks)
> +		return -ENOMEM;
>   	drvdata->num_clks = variant->num_clks;
>   
>   	for (i = 0; i < drvdata->num_clks; i++)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

