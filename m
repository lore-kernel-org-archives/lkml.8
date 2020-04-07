Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A36C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B1020748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4LH1noL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDGF6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:58:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33364 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgDGF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:58:16 -0400
Received: by mail-pj1-f67.google.com with SMTP id cp9so823725pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mkkw7HsdsJ8ydDnLOtRctgaXg7Haji601TbSqQUyjew=;
        b=T4LH1noLUmRLe2l2HO15LEtgTf4lyQiuoIRXqKDmj9g6n9SvAQGTMugQrNhl75a42C
         /iz9SFRSo4ZqSL/jxCXQQTgjvxYkpuIrM8Oy18cR8Lw3TxKKRV64/Hh8K8Tw5UuUa7H4
         2Awb5m2UhpSifx0B2gznOlTDcgw0OMB87F7mMN1GMw1A+D27giVr1XOU8CemGd1DLdaM
         Q3TrHETs3KdMVYJ9jb2HcT4p/J/l/qCX9tuMm4fixZzncSXSL5jMVT4cndH6DxMlvV+t
         Y52EYcvsPiD6pxXmizTO4TjwgnC8B4uM+dlBi7Sx3SCyIFZYs3YEW+ASg6HYZMsa8lBg
         l88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkkw7HsdsJ8ydDnLOtRctgaXg7Haji601TbSqQUyjew=;
        b=dZM4fcQkkxXoqqNRoJCfFTQOCmuxKl4XJXMdXxc0BjVnwa+1ObTlTIlmafx6hVUUdX
         Vlm84RecXX/n7+ftWk+ReZdjyE/8wwBMCU29Rp6lQBI13rRB2/FVks9tMhRtLJasQPaY
         3Fdjw6qDpv88VptNchs5qhBQzP4Gi7yI7AHEVPVZypvBUvhqhzQVvpTW3e3kbnloQpEW
         5+I26T2fVIl44VLSFSU+8guRBRQhgfbbkgjE1GxSVKzjp+wADDidPapItCeTf07x9i71
         93dhcdU1qvqFkRgMs/rEmoSEC3tp/0dcA9BuWngJ6Ml6qe0HmHMsagFeoH/oyPbbl9h9
         4Q1w==
X-Gm-Message-State: AGi0Puafdyc+NIBEXzF8PdvZID29WqSPIZuuZ/IpQZSe4BSKBz8008Fu
        RLH7FEXBDaM2ah9I7Ttpkugs
X-Google-Smtp-Source: APiQypKJvimi7K4OYZ1ob9edTMz1xawkbUnf1BMEqllLXelvAPrGFk7X7/IadWa+IrHsVoNjWE/aww==
X-Received: by 2002:a17:90a:bf84:: with SMTP id d4mr822823pjs.82.1586239094202;
        Mon, 06 Apr 2020 22:58:14 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e86:d03b:80dc:a9ff:fe0a:9bd3])
        by smtp.gmail.com with ESMTPSA id b133sm13264940pfb.180.2020.04.06.22.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 22:58:13 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:28:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] bus: mhi: core: Remove link_status() callback
Message-ID: <20200407055809.GA2442@Mani-XPS-13-9360>
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
 <1586207077-22361-4-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586207077-22361-4-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Mon, Apr 06, 2020 at 03:04:37PM -0600, Jeffrey Hugo wrote:
> If the MHI core detects invalid data due to a PCI read, it calls into
> the controller via link_status() to double check that the link is infact
> down.  All in all, this is pretty pointless, and racy.  There are no good
> reasons for this, and only drawbacks.
> 
> Its pointless because chances are, the controller is going to do the same
> thing to determine if the link is down - attempt a PCI access and compare
> the result.  This does not make the link status decision any smarter.
> 
> Its racy because its possible that the link was down at the time of the
> MHI core access, but then recovered before the controller access.  In this
> case, the controller will indicate the link is not down, and the MHI core
> will precede to use a bad value as the MHI core does not attempt to retry
> the access.
> 
> Retrying the access in the MHI core is a bad idea because again, it is
> racy - what if the link is down again?  Furthermore, there may be some
> higher level state associated with the link status, that is now invalid
> because the link went down.
> 
> The only reason why the MHI core could see "invalid" data when doing a PCI
> access, that is actually valid, is if the register actually contained the
> PCI spec defined sentinel for an invalid access.  In this case, it is
> arguable that the MHI implementation broken, and should be fixed, not
> worked around.
> 
> Therefore, remove the link_status() callback before anyone attempts to
> implement it.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

LGTM. But as per the IRC discussion I'd like the mhi_reg_read() to be
implemented as a callback in mhi_controller struct inorder to truly make MHI
a PCI agnostic bus.

Since we don't have any controller driver in mainline, I think it is the
good time to do this change.

For this,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 6 ++----
>  drivers/bus/mhi/core/main.c | 5 ++---
>  include/linux/mhi.h         | 2 --
>  3 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index b38359c..2af08d57 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -812,10 +812,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	if (!mhi_cntrl)
>  		return -EINVAL;
>  
> -	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put)
> -		return -EINVAL;
> -
> -	if (!mhi_cntrl->status_cb || !mhi_cntrl->link_status)
> +	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
> +	    !mhi_cntrl->status_cb)
>  		return -EINVAL;
>  
>  	ret = parse_config(mhi_cntrl, config);
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index eb4256b..473278b8 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -20,9 +20,8 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>  {
>  	u32 tmp = readl(base + offset);
>  
> -	/* If there is any unexpected value, query the link status */
> -	if (PCI_INVALID_READ(tmp) &&
> -	    mhi_cntrl->link_status(mhi_cntrl))
> +	/* If the value is invalid, the link is down */
> +	if (PCI_INVALID_READ(tmp))
>  		return -EIO;
>  
>  	*out = tmp;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index ad19960..be704a4 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -335,7 +335,6 @@ struct mhi_controller_config {
>   * @syserr_worker: System error worker
>   * @state_event: State change event
>   * @status_cb: CB function to notify power states of the device (required)
> - * @link_status: CB function to query link status of the device (required)
>   * @wake_get: CB function to assert device wake (optional)
>   * @wake_put: CB function to de-assert device wake (optional)
>   * @wake_toggle: CB function to assert and de-assert device wake (optional)
> @@ -417,7 +416,6 @@ struct mhi_controller {
>  
>  	void (*status_cb)(struct mhi_controller *mhi_cntrl,
>  			  enum mhi_callback cb);
> -	int (*link_status)(struct mhi_controller *mhi_cntrl);
>  	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
>  	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
>  	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
