Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB2C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A584320738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TKFlbEvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG0Hzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:55:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44501 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbgG0Hzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:55:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595836553; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=gUQnuzeMx0G2OHWIdwKvAsh0TfCZ+tz43jXXFrsOTLU=; b=TKFlbEvXUBUGHbZZdjQb1a1fp3s7M6lOleE9RQuaaKuJqTPlcRIdze5Er1EEv51WgVm0sBFB
 nOEhebR//FQNwpztAh7pBH3TPUBX3P6H8rnf0bqqdBD4lBXkWGqTud52cXg7EoZwLYNtQQZY
 7UGnlAVO/HIRDEWvPD3ECWKaTPQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f1e88701db0b33fd8c326a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 07:55:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D55BC433C6; Mon, 27 Jul 2020 07:55:27 +0000 (UTC)
Received: from [192.168.0.13] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC1A1C433CA;
        Mon, 27 Jul 2020 07:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC1A1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] i2c: qcom-geni: fix spelling mistake "unepxected" ->
 "unexpected"
To:     Colin King <colin.king@canonical.com>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191103212204.13606-1-colin.king@canonical.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <74e71d14-9f27-6a44-f253-4756ba124695@codeaurora.org>
Date:   Mon, 27 Jul 2020 13:25:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20191103212204.13606-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/4/2019 2:52 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an error message string, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 17abf60c94ae..387fb5a83471 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -98,7 +98,7 @@ static const struct geni_i2c_err_log gi2c_log[] = {
>   	[GP_IRQ0] = {-EIO, "Unknown I2C err GP_IRQ0"},
>   	[NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},
>   	[GP_IRQ2] = {-EIO, "Unknown I2C err GP IRQ2"},
> -	[BUS_PROTO] = {-EPROTO, "Bus proto err, noisy/unepxected start/stop"},
> +	[BUS_PROTO] = {-EPROTO, "Bus proto err, noisy/unexpected start/stop"},
>   	[ARB_LOST] = {-EAGAIN, "Bus arbitration lost, clock line undriveable"},
>   	[GP_IRQ5] = {-EIO, "Unknown I2C err GP IRQ5"},
>   	[GENI_OVERRUN] = {-EIO, "Cmd overrun, check GENI cmd-state machine"},

The patch is still applying cleanly on tip.

Reviewed-by: Akash Asthana <akashast@codeauror.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

