Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B1DC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B01208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nMErF/Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgCKMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:02:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22069 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbgCKMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:02:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583928176; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EPwXWRLBatAS36UEQmnN9AxkJYR2loK0yjlgdQridsc=; b=nMErF/AogdDyQ4ytawArvw5v9t5OZ+y0vRV9VIzoM1BPHEGiykwfRJaTaIR++olqqWu9cVdp
 ysXRexsTWlYMK7hw1QMVE8sMp6vWhNtPwVuOQXnZogARcCBCPjWzdQY3EzYe78OdPnG92wzG
 PmYyY2aDVVsNV3xaGYmOsqB6HQg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e68d359.7fe690b577a0-smtp-out-n03;
 Wed, 11 Mar 2020 12:02:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D582C433CB; Wed, 11 Mar 2020 12:02:33 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FCAAC433BA;
        Wed, 11 Mar 2020 12:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FCAAC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [RFT PATCH 4/9] drivers: qcom: rpmh-rsc: Remove get_tcs_of_type()
 abstraction
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306235951.214678-1-dianders@chromium.org>
 <20200306155707.RFT.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <95770b22-f681-9801-5c5e-67aa16071267@codeaurora.org>
Date:   Wed, 11 Mar 2020 17:32:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306155707.RFT.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> The get_tcs_of_type() function doesn't provide any value.  It's not
> conceptually difficult to access a value in an array, even if that
> value is in a structure and we want a pointer to the value.  Having
> the function in there makes me feel like it's doing something fancier
> like looping or searching.  Remove it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/rpmh-rsc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 099603bf14bf..a1298035bcd2 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -169,17 +169,10 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>  	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
>  }
>  
> -static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
> -{
> -	return &drv->tcs[type];
> -}
> -
>  static int tcs_invalidate(struct rsc_drv *drv, int type)
>  {
>  	int m;
> -	struct tcs_group *tcs;
> -
> -	tcs = get_tcs_of_type(drv, type);
> +	struct tcs_group *tcs = &drv->tcs[type];
>  
>  	spin_lock(&tcs->lock);
>  	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
> @@ -245,9 +238,9 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>  	 * dedicated AMC, and therefore would invalidate the sleep and wake
>  	 * TCSes before making an active state request.
>  	 */
> -	tcs = get_tcs_of_type(drv, type);
> +	tcs = &drv->tcs[type];
>  	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs) {
> -		tcs = get_tcs_of_type(drv, WAKE_TCS);
> +		tcs = &drv->tcs[WAKE_TCS];
>  		if (tcs->num_tcs) {
>  			ret = rpmh_rsc_invalidate(drv);
>  			if (ret)
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
