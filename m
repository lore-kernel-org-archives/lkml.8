Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA76C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79E821655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jJAC29Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgCKJvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:51:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57169 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728146AbgCKJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:51:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583920265; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wz4KJcKwKB++JF4TaEFks1Eptm0k/C2T0zysdRtFHVM=; b=jJAC29QfauoanllHEde2IhF3GVNMS3Q33nj1Vxam0pQ14hnqNTFiMVPxGWGXWaF/tqwQcZU/
 lVGS/swknPDQ6yBDsSTxC6e+OFV8c7wtPObYhGCMg77Wnm9ghA0ahSh14iB+ecJtt7cCJVeA
 zXjuFGVn9DpF9EdIfJgnM9SXVGA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e68b476.7f0ea770e6f8-smtp-out-n01;
 Wed, 11 Mar 2020 09:50:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC3A6C433D2; Wed, 11 Mar 2020 09:50:45 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E17FC432C2;
        Wed, 11 Mar 2020 09:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E17FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [RFT PATCH 3/9] drivers: qcom: rpmh-rsc: Fold tcs_ctrl_write()
 into its single caller
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306235951.214678-1-dianders@chromium.org>
 <20200306155707.RFT.3.Ie88ce5ccfc0c6055903ccca5286ae28ed3b85ed3@changeid>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <4a3cf9cb-b29f-47c3-d681-a855ab34aeb7@codeaurora.org>
Date:   Wed, 11 Mar 2020 15:20:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306155707.RFT.3.Ie88ce5ccfc0c6055903ccca5286ae28ed3b85ed3@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> I was trying to write documentation for the functions in rpmh-rsc and
> I got to tcs_ctrl_write().  The documentation for the function would
> have been: "This is the core of rpmh_rsc_write_ctrl_data(); all the
> caller does is error-check and then call this".
>
> Having the error checks in a separate function doesn't help for
> anything since:
> - There are no other callers that need to bypass the error checks.
> - It's less documenting.  When I read tcs_ctrl_write() I kept
>   wondering if I need to handle cases other than ACTIVE_ONLY or cases
>   with more commands than could fit in a TCS.  This is obvious when
>   the error checks and code are together.
> - The function just isn't that long, so there's no problem
>   understanding the combined function.
>
> Things were even more confusing because the two functions names didn't
> make it obvious (at least to me) their relationship.
>
> Simplify by folding one function into the other.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/rpmh-rsc.c | 39 ++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 0a409988d103..099603bf14bf 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -549,27 +549,6 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
>  	return 0;
>  }
>  
> -static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
> -{
> -	struct tcs_group *tcs;
> -	int tcs_id = 0, cmd_id = 0;
> -	unsigned long flags;
> -	int ret;
> -
> -	tcs = get_tcs_for_msg(drv, msg);
> -	if (IS_ERR(tcs))
> -		return PTR_ERR(tcs);
> -
> -	spin_lock_irqsave(&tcs->lock, flags);
> -	/* find the TCS id and the command in the TCS to write to */
> -	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
> -	if (!ret)
> -		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
> -	spin_unlock_irqrestore(&tcs->lock, flags);
> -
> -	return ret;
> -}
> -
>  /**
>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>   *
> @@ -580,6 +559,11 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>   */
>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>  {
> +	struct tcs_group *tcs;
> +	int tcs_id = 0, cmd_id = 0;
> +	unsigned long flags;
> +	int ret;
> +
>  	if (!msg || !msg->cmds || !msg->num_cmds ||
>  	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
>  		pr_err("Payload error\n");
> @@ -590,7 +574,18 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>  	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
>  		return -EINVAL;
>  
> -	return tcs_ctrl_write(drv, msg);
> +	tcs = get_tcs_for_msg(drv, msg);
> +	if (IS_ERR(tcs))
> +		return PTR_ERR(tcs);
> +
> +	spin_lock_irqsave(&tcs->lock, flags);
> +	/* find the TCS id and the command in the TCS to write to */
> +	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
> +	if (!ret)
> +		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
> +	spin_unlock_irqrestore(&tcs->lock, flags);
> +
> +	return ret;
>  }
>  
>  static int rpmh_probe_tcs_config(struct platform_device *pdev,
i am ok with this change.

Reviewed-by: Maulik Shah <mkshah@codeaurora.org>

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
