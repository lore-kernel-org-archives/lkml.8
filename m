Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499BB2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n4aeXeNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgFXEmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:42:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgFXEmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:42:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592973722; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0dYginMgi1k67n62RpmbKWeGpkiw6FuM0+tyuL4cBzo=; b=n4aeXeNgtOW4ZB4vVk9f9ESiQrBB9ZP8qNXSh84lvd5e/StMTRzSeV2PNb5Va98XD/e//A5u
 0d3jy5c1wMR7u1Fk+4DdiWmXaSixakxJEdJKih/bnk4OlnOjO0/NylgDM26qK8jwn44UOlua
 WzEWG+UYkJzD8Xxtw0ysi3vyq98=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ef2d9953a8a8b20b8f36001 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 04:41:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D510BC433CB; Wed, 24 Jun 2020 04:41:56 +0000 (UTC)
Received: from [192.168.29.129] (unknown [49.36.73.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 411B9C433C6;
        Wed, 24 Jun 2020 04:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 411B9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Don't use ktime for timeout in
 write_tcs_reg_sync()
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <2eb7c28e-d7af-8bc8-c308-46f4df5c995c@codeaurora.org>
Date:   Wed, 24 Jun 2020 10:11:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Maulik Shah <mkshah@codeaurora.org>

Thanks,
Maulik

On 5/28/2020 8:18 PM, Douglas Anderson wrote:
> The write_tcs_reg_sync() may be called after timekeeping is suspended
> so it's not OK to use ktime.  The readl_poll_timeout_atomic() macro
> implicitly uses ktime.  This was causing a warning at suspend time.
>
> Change to just loop 1000000 times with a delay of 1 us between loops.
> This may give a timeout of more than 1 second but never less and is
> safe even if timekeeping is suspended.
>
> NOTE: I don't have any actual evidence that we need to loop here.
> It's possibly that all we really need to do is just read the value
> back to ensure that the pipes are cleaned and the looping/comparing is
> totally not needed.  I never saw the loop being needed in my tests.
> However, the loop shouldn't hurt.
>
> Fixes: 91160150aba0 ("soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()")
> Reported-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/soc/qcom/rpmh-rsc.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 076fd27f3081..906778e2c1fa 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -175,13 +175,21 @@ static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
>   static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
>   			       u32 data)
>   {
> -	u32 new_data;
> +	int i;
>   
>   	writel(data, tcs_reg_addr(drv, reg, tcs_id));
> -	if (readl_poll_timeout_atomic(tcs_reg_addr(drv, reg, tcs_id), new_data,
> -				      new_data == data, 1, USEC_PER_SEC))
> -		pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
> -		       data, tcs_id, reg);
> +
> +	/*
> +	 * Wait until we read back the same value.  Use a counter rather than
> +	 * ktime for timeout since this may be called after timekeeping stops.
> +	 */
> +	for (i = 0; i < USEC_PER_SEC; i++) {
> +		if (readl(tcs_reg_addr(drv, reg, tcs_id)) == data)
> +			return;
> +		udelay(1);
> +	}
> +	pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
> +	       data, tcs_id, reg);
>   }
>   
>   /**

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

