Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29953C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0156B20752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmvWvZgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgELGx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgELGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:53:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:53:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s20so4990533plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wyNaJ3zN4Vkp26MdzcthIVdng2NufArv0F1CXYz6F90=;
        b=fmvWvZgbgLMar4pR1vmLZAtNWuAKGDNiThvpBT8BeYvKCG+/zU0Dxw6mDEEAz3ndcs
         1yhQlafBLMcvEqRlYnE0fpQa+Jz9jAWnTtvSPP007//HMIhEfwypWvAYJyaPVPP60smb
         s8GubIMYXMXKb6D1yvyDQ0QbEVEbMy8fM8BiJWC7opUuA9hPFmzw50VoM+UhspjjxkVB
         0DQ8LrbTuJl/LyJxaLQg6xLDAc797YJVBNCdVBqNLpFlnlgcRpmDoFgZ8kjATzG8egGR
         1Rk2xncKIwHkeyGrq6L7XLXLvUDxhTP1tb9pu/ZQ5qQVcify7A6RqiKELb51aVhsju4l
         zfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyNaJ3zN4Vkp26MdzcthIVdng2NufArv0F1CXYz6F90=;
        b=dx6APqoHyNSS54X1uj8jJY5Yk/fNDro140EY8HuG7jwX2/DkmlYeYuIpR6Uh2zvZ/v
         GFy5QnfHyuJvL8Yc/HqmWb0qG+R+4WLYNXtjKRdLCoVMtt7OLu+ZV6cgsB75+HqvqP/l
         DwN8a65YB/NpbfR0PaNsI+EuMuGBe1BBxdLLq0OeGkNjk9c9mk0qum0IIopltFhtBFn3
         OzLkBjWpULd5lzkiOiHpXgMhySLcEiEHXwAvD8R8z7l7H3TDQazvG8Bi0jgsQaA3RQ1k
         T3OOW7IAMJLTX/205NSjkYJ3pdbCclrBy2F0SRUtgGIxIGNq7Axs/0mWqUiu8X7wOmzx
         v1aQ==
X-Gm-Message-State: AGi0PuZtQlJIu0EVPZDi8Cd982tWVnGE8UyGLoxLPi/O+YU2PB8EbeKb
        i2HrL2xwHing2QjPeHt6EFYU
X-Google-Smtp-Source: APiQypLd4Q8FRQeSS4aja8UQ+rcrF6uwdIZBUbTxU4Ll1+49mUWasLX1xXwdr42uvVfHoS4giHEaMg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr18607769plp.117.1589266435964;
        Mon, 11 May 2020 23:53:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id g74sm11157775pfb.69.2020.05.11.23.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:53:55 -0700 (PDT)
Date:   Tue, 12 May 2020 12:23:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 3/5] bus: mhi: core: Skip handling BHI irq if MHI reg
 access is not allowed
Message-ID: <20200512065349.GE4928@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-4-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-4-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:07PM -0700, Hemant Kumar wrote:
> Driver continues handling of BHI interrupt even if MHI register access
> is not allowed. By doing so it calls the status call back and performs
> early notification for the MHI client. This is not needed when MHI
> register access is not allowed. Hence skip the handling in this case and
> return. Also add debug log to print device state, local EE and device EE
> when reg access is valid.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 9ec9b36..467c0ba 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -369,22 +369,29 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> -irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
> +irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  {
> -	struct mhi_controller *mhi_cntrl = dev;
> +	struct mhi_controller *mhi_cntrl = priv;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	enum mhi_state state = MHI_STATE_MAX;
>  	enum mhi_pm_state pm_state = 0;
>  	enum mhi_ee_type ee = 0;
>  
>  	write_lock_irq(&mhi_cntrl->pm_lock);
> -	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> -		state = mhi_get_mhi_state(mhi_cntrl);
> -		ee = mhi_cntrl->ee;
> -		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
> +	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> +		write_unlock_irq(&mhi_cntrl->pm_lock);

write_lock is only used for protecting 'mhi_cntrl->ee' but here we are not
updating it if reg access is not valid. So there is no reason to hold this lock.

> +		goto exit_intvec;
>  	}
>  
> +	state = mhi_get_mhi_state(mhi_cntrl);
> +	ee = mhi_cntrl->ee;
> +	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);

But it is needed here.

Thanks,
Mani

> +	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
> +		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
> +		TO_MHI_STATE_STR(state));
> +
>  	if (state == MHI_STATE_SYS_ERR) {
> -		dev_dbg(&mhi_cntrl->mhi_dev->dev, "System error detected\n");
> +		dev_dbg(dev, "System error detected\n");
>  		pm_state = mhi_tryset_pm_state(mhi_cntrl,
>  					       MHI_PM_SYS_ERR_DETECT);
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
