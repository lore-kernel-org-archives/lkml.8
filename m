Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0871C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD6321582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clE/VI4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEIFuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:50:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3DC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:50:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so2111859pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvjoP5aUxpQ4gOsr34/F6rHJJZ2e+2QDBWk2vWfDSO4=;
        b=clE/VI4iybQPCUY6guQF99wU0p/FvEMUFM1iyxfUX8WhNZo6t1nkAWScVdPX4mt3W/
         3VYh5zeVh9nopLCiDDTCEVmqYTxdMkRVhu39IaXDPVgXFSzdvXRLdbB3/TD0LYTX29v3
         +SoUIFhlqhYcRjQHFdDnkejxhgxPfWu612wsIHXq2OqRziBhIlWyy+ZB0eEvQlSNEafA
         x1vSl4LYhdfes0Iwos29kWCxRrysF+JQOvr0nhZkMJvtjgQgtNzRu5pQvlYnc29Uy8mO
         jjDnmx+0SfbMgGGGrc3dG7YAKbrSLgTRUtX3zvoWqWuAxFe9KL+LBkTTIsHCFEoTylcW
         0tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvjoP5aUxpQ4gOsr34/F6rHJJZ2e+2QDBWk2vWfDSO4=;
        b=josq8PcGhcPdoPEQenEWRVzxpLDtxctseknwrU/riEVrPzMmvdvkXfV2UP7IgNK2+l
         XrFYkQE/5kVr5uTpO05EK/rZ9k9/lphHTBCgZTcDen+mpzJ4Shu+cdMHrRDO74pifyBW
         RUdyP90RFnrpzhPL5MPvRq3RicmzmrDEB4pj04BAN9dNlvKbKrIzywbMVgr+kTTrMWTc
         X7qQBDnhnb6DdS0EWT10MVtiMkvx3t2wy+7NhcLTsa7iex+1kkcNwbuoYNxWeVngyFfx
         3y1WZ+RmhQ/ywfNbvmeChmOC+dVE/UxRyx10Eaqz+fUkcrNVRtHx2DxDKtITamwMEtwd
         W9Tg==
X-Gm-Message-State: AGi0PuaInBDzvECMfCAylWEDwlVWEMYwzGV5gM2sJAjz+7wxES9sRrpl
        8ujTak14b0IebEcTGjEpYDb6
X-Google-Smtp-Source: APiQypJA7i3xbkbsjSN7ofw84Yyrg3CCXVPU1ch0IhPHTk9OUl67+4nE701IKF0kM4id/TUuMdV2/w==
X-Received: by 2002:a63:e74f:: with SMTP id j15mr5262764pgk.153.1589003422125;
        Fri, 08 May 2020 22:50:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id e16sm2802154pgg.8.2020.05.08.22.50.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:50:21 -0700 (PDT)
Date:   Sat, 9 May 2020 11:20:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 6/8] bus: mhi: core: Return appropriate error codes
 for AMSS load failure
Message-ID: <20200509055014.GF5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-7-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:46PM -0700, Bhaumik Bhatt wrote:
> When loading AMSS firmware using BHIe protocol, return -ETIMEDOUT if no
> response is received within the timeout or return -EIO in case of a
> protocol returned failure or an MHI error state.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 17c636b..cf6dc5a 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -176,6 +176,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  	void __iomem *base = mhi_cntrl->bhie;
>  	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
>  	u32 tx_status, sequence_id;
> +	int ret;
>  
>  	read_lock_bh(pm_lock);
>  	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> @@ -198,19 +199,19 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  	read_unlock_bh(pm_lock);
>  
>  	/* Wait for the image download to complete */
> -	wait_event_timeout(mhi_cntrl->state_event,
> -			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> -			   mhi_read_reg_field(mhi_cntrl, base,
> -					      BHIE_TXVECSTATUS_OFFS,
> -					      BHIE_TXVECSTATUS_STATUS_BMSK,
> -					      BHIE_TXVECSTATUS_STATUS_SHFT,
> -					      &tx_status) || tx_status,
> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> -
> -	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
> +	ret = wait_event_timeout(mhi_cntrl->state_event,
> +				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> +				 mhi_read_reg_field(mhi_cntrl, base,
> +						   BHIE_TXVECSTATUS_OFFS,
> +						   BHIE_TXVECSTATUS_STATUS_BMSK,
> +						   BHIE_TXVECSTATUS_STATUS_SHFT,
> +						   &tx_status) || tx_status,
> +				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
> +	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> +	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
>  		return -EIO;
>  
> -	return (tx_status == BHIE_TXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
> +	return (!ret) ? -ETIMEDOUT : 0;
>  }
>  
>  static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
