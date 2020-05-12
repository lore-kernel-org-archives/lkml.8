Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF76C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB7F20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sL2FkhX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgELGzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:55:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:55:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so5924598pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=thG0NdAjl/JWYqpa7xMECyjYXc//YQa3pk594o/Fmy0=;
        b=sL2FkhX8UO15y2kAB9YOFayWTQgfadxV+JnLDYuaUtuQruo+Ft+E+dGf9dmGePTcv4
         tSm8DoukgPWphY5yZafHBXhjpMIcSu6iRIRnyCAf+51DjiGmBEg+0sGYn0jlnC0D0SmK
         kxV3EoCqFpNJIOP8MSOd57mF76O5sVy63myXRjgkiD7hamjLldv/1sDN+lTIOtUvxY17
         rAT25K9934EEoAdEeSa7qTKjUpgSyXFAWwm9HOc2X178YxSQhqkqBR6QJn+rTf9TgpVE
         6vrVx94d4a0tlIgopJ34GxzcAgG/ONyK2+wExi22+vXMyQ719XZDVy9N2WfakX7bQHBK
         Npjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=thG0NdAjl/JWYqpa7xMECyjYXc//YQa3pk594o/Fmy0=;
        b=keqcl/1HqxN7JcuUvDJ5bUUFgfo+n8iZGQArEp60ziOI2SX6HfhYGJiaj213nXeOOR
         uZD84enhtgGwwImZLL6m0rDBNtM2NK6c/Z+by36EydRI+rdANhDBl+NBqwI+OtoQgk3H
         nHIWxvXQqoj7OwFVFjkZZ3X02z7nGRc5xn3N/nvoOgZPurnZTMOiSUS1H/Ec4Kp/TkQT
         F+o645HKUdahGdg+PJgxfhEtstcFKAzIlECyUd9u21svHMIgH6Qr5VvnNRNHejEOFaij
         AJo5HzWS3UBgSi3Sqoa9JPOhccoaVY6H1KdsLqEzaz6VwL9QpQz1on//F/GNJNQnCHay
         Vh8A==
X-Gm-Message-State: AGi0PuZ1ZQWs6+Gm8/+MOV2YCNdRUzAyDYynjKvE1CK2NOoyDD2eL1xt
        v809/6Ncws4+Y8ns/4/K2klO
X-Google-Smtp-Source: APiQypIwxrllsz0oRpxXUO8wWz8cLjRl8MQ2jCdKf2yGJpbDO0qUEcWyXtdwuSs8FUqqzflA7f+Jwg==
X-Received: by 2002:a63:e843:: with SMTP id a3mr18433249pgk.383.1589266511099;
        Mon, 11 May 2020 23:55:11 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id w192sm11466011pff.126.2020.05.11.23.55.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:55:10 -0700 (PDT)
Date:   Tue, 12 May 2020 12:25:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 4/5] bus: mhi: core: Do not process SYS_ERROR if RDDM
 is supported
Message-ID: <20200512065504.GF4928@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-5-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-5-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:08PM -0700, Hemant Kumar wrote:
> Devices that support RDDM do not require processing SYS_ERROR as it is
> deemed redundant. Avoid SYS_ERROR processing if RDDM is supported by
> the device.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 467c0ba..1f622ce 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -397,9 +397,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  	}
>  	write_unlock_irq(&mhi_cntrl->pm_lock);
>  
> -	/* If device in RDDM don't bother processing SYS error */
> -	if (mhi_cntrl->ee == MHI_EE_RDDM) {
> -		if (mhi_cntrl->ee != ee) {
> +	 /* If device supports RDDM don't bother processing SYS error */
> +	if (mhi_cntrl->rddm_image) {
> +		if (mhi_cntrl->ee == MHI_EE_RDDM && mhi_cntrl->ee != ee) {
>  			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
>  			wake_up_all(&mhi_cntrl->state_event);
>  		}
> @@ -735,6 +735,11 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  			{
>  				enum mhi_pm_state new_state;
>  
> +				/* skip SYS_ERROR handling if RDDM supported */
> +				if (mhi_cntrl->ee == MHI_EE_RDDM ||
> +				    mhi_cntrl->rddm_image)
> +					break;
> +
>  				dev_dbg(dev, "System error detected\n");
>  				write_lock_irq(&mhi_cntrl->pm_lock);
>  				new_state = mhi_tryset_pm_state(mhi_cntrl,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
