Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F8BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B072072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqEwaOgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHAGMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHAGMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 02:12:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032C1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:12:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so5390226plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s0yZ31Y1og5WC+SYnZUUw+JkY/JZOfRQjunLLr2IqHc=;
        b=wqEwaOgM7Y/z335BrNSqKI/zDfwjvvNRgzqa6M2dylWeKPJP5fOM9MuSWO/EHgI7oW
         LxQN2zKt0PMLEGX6Lfm472zAtv/H63GrlGVFJ5or/eKDDNS64mgMeg+aw72Xynenbjnd
         YrhwEkHhGpXsz2rBSwXzijedXSs2UQMr2vHivIuE2P6JYLWBtS8mhyi2Yj4CEAm4q0zI
         InpL/59rDSC0Nj9D4bdZaAJEro46doF0O5eXtPZA5KeOMm+BAjKEG+0lt1kKh8rqGlOy
         twUMQZOwHrzGJbouUyUGUyfPcQhK083NhRA8zf/z0Za3bwBZLuWi2P2MlhGxFz9IEICI
         1WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s0yZ31Y1og5WC+SYnZUUw+JkY/JZOfRQjunLLr2IqHc=;
        b=sKOG5guf5CLzp42vU3NOFl2NlzBHozwDMMvhUKIquXkmj2aWYKGkanF9DkWzmzam62
         KXqftDfcRGGLvacVJDx1QeTwoovkyU6SMiCRWYfOwllgdOqlF7NK9AYVu7B2FQ7+puKm
         mD9zlshRxOwIQus7pzv6ALT5LsgM1ivNU4h8+5gpjMaW+j0XdHs+dVPB1+F+vKJ5z76e
         Z8gnmq/Co9Gh5DodU53lm2HrPuVlmO2gNV+i4mqUuD9/LFaqu+7wR6Oom9qTyrWI/wrW
         qGHueFWO/ad2xIQKR2b8C1U2egKVHpPBrTwGfRq+/bwLYG4DWZWdhiMCXzOUmyGZuK+O
         IyCQ==
X-Gm-Message-State: AOAM533j2C/HYFizrwrLwRALV/cz0aPnNnl0UoXgwhU7Nt8buSzlas5s
        RBss7Zpf2Mm7tyvEDNlzurL7WU0wX/A=
X-Google-Smtp-Source: ABdhPJxC9gYtLWmGjwEvOjUTZyNZiEeifgE8FCVhRNRlS6FoMJEt0eLT4MbcIieY/Zs08rsnNWFK3Q==
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr7731457pjq.4.1596262351376;
        Fri, 31 Jul 2020 23:12:31 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id fy11sm10800429pjb.2.2020.07.31.23.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 23:12:29 -0700 (PDT)
Date:   Fri, 31 Jul 2020 23:12:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        "Angelo G . Del Regno" <kholk11@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_spmi: Improve readability for setting up
 enable/mode pin control
Message-ID: <20200801061227.GG61202@yoga>
References: <20200801054820.134859-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801054820.134859-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 Jul 22:48 PDT 2020, Axel Lin wrote:

> By checking data->pin_ctrl_enable / data->pin_ctrl_hpm flags first, then
> use switch-case to improve readability.
> 

Nice!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 70 ++++++++++++-------------
>  1 file changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index 5ee7c5305d95..05080483fe1b 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -1633,45 +1633,43 @@ static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
>  		return ret;
>  
>  	/* Set up enable pin control. */
> -	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
> -	     || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO
> -	     || type == SPMI_REGULATOR_LOGICAL_TYPE_VS)
> -	    && !(data->pin_ctrl_enable
> -			& SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT)) {
> -		ctrl_reg[SPMI_COMMON_IDX_ENABLE] &=
> -			~SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
> -		ctrl_reg[SPMI_COMMON_IDX_ENABLE] |=
> -		    data->pin_ctrl_enable & SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
> +	if (!(data->pin_ctrl_enable & SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT)) {
> +		switch (type) {
> +		case SPMI_REGULATOR_LOGICAL_TYPE_SMPS:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_LDO:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_VS:
> +			ctrl_reg[SPMI_COMMON_IDX_ENABLE] &=
> +				~SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
> +			ctrl_reg[SPMI_COMMON_IDX_ENABLE] |=
> +				data->pin_ctrl_enable & SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	/* Set up mode pin control. */
> -	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
> -	    || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO)
> -		&& !(data->pin_ctrl_hpm
> -			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
> -			~SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
> -			data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
> -	}
> -
> -	if (type == SPMI_REGULATOR_LOGICAL_TYPE_VS
> -	   && !(data->pin_ctrl_hpm & SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
> -			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
> -		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> -	}
> -
> -	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS
> -		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS
> -		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO)
> -		&& !(data->pin_ctrl_hpm
> -			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
> -			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> -		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
> -		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> +	if (!(data->pin_ctrl_hpm & SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
> +		switch (type) {
> +		case SPMI_REGULATOR_LOGICAL_TYPE_SMPS:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_LDO:
> +			ctrl_reg[SPMI_COMMON_IDX_MODE] &=
> +				~SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
> +			ctrl_reg[SPMI_COMMON_IDX_MODE] |=
> +				data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
> +			break;
> +		case SPMI_REGULATOR_LOGICAL_TYPE_VS:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS:
> +		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO:
> +			ctrl_reg[SPMI_COMMON_IDX_MODE] &=
> +				~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> +			ctrl_reg[SPMI_COMMON_IDX_MODE] |=
> +				data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	/* Write back any control register values that were modified. */
> -- 
> 2.25.1
> 
