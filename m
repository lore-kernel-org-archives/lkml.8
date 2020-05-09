Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57FC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655CC24953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fONoQbPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgEIFuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:50:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF54C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:50:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so5244847pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXjA0nvURjy8PRGkk87+AxvIoUVbdSXQcxu6xPodlzo=;
        b=fONoQbPXjYw8KBK+TSQXOs7370DHN6pOCSf6rkWLOGCqvix/OwIkrWu5FNYG9MSNcI
         1R2/ABoRhMZmu9SWuyCFbagzDjXNoTQ6P5vAwkhfxvf038dR6tsf5e16UzLmWgFu6gIP
         6YvLxH5tR4vl0WBYKOxAL4c5g4Tr8+qiI1s1NqnjpcqmFgmwUJdkW3AcFdJZrogcEAfL
         FhLrb1WSzX2odfVRjDzS1f9VZjktBg6neGmg+c4zzu1kXCVR3DvB0Gzphi1JO1U6VP/5
         c1Xhfdwwcim4pAMNcc4OyJVU1mhfHHni9n9USSIwTiDmVjjFmOQc0U/2Hm2HNzCTaNrX
         9ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXjA0nvURjy8PRGkk87+AxvIoUVbdSXQcxu6xPodlzo=;
        b=LJubIPPnacwoGaUHHRcf7crhPiKmenE8IjCrZzzK0IXqzDeYGrZFvlgyl0NObKO35r
         p6mun59D0MPEAkVUcnYWSGuAR3shs3aK+7apn/E4N4pSbxO7tpI9COKZwgy8QxmlebwI
         ldEkZP0KmvJC5UbYrieCwno23OW7T4y4wTKghVQU12Tn5kRibQcsxWUFc3TsM/tnlTff
         0NCJboTrzfZX1lmHfJ++Um4Esgs0/yXpQ5GgZ8wHYLjdhsdkCwbv8P2knl0CYWwxy18g
         MOVyPrSGIWFeYcnFmyAChwaC8Ak0GccjjkfhcxWVCgeQfcHGEBXTjeQePqOMRlmv9d1f
         mMIA==
X-Gm-Message-State: AGi0PuYC9x9Be9zA6m/DUF35788IhisEWlYcxFVbNozBvtiNT8f+WKLg
        Wbk2wGnf5JwJ1dPGZvgOlCyr
X-Google-Smtp-Source: APiQypLrvYfdntso+IhuvO5moRh1EiueSkMW2u2QMmP8NqvGG8v3e/kOdObLGnxqDIH1rkA6d2VjWQ==
X-Received: by 2002:a17:90b:3598:: with SMTP id mm24mr8912558pjb.132.1589003450259;
        Fri, 08 May 2020 22:50:50 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id nu10sm4149407pjb.9.2020.05.08.22.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:50:49 -0700 (PDT)
Date:   Sat, 9 May 2020 11:20:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 7/8] bus: mhi: core: Improve debug logs for loading
 firmware
Message-ID: <20200509055043.GG5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-8-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-8-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:47PM -0700, Bhaumik Bhatt wrote:
> Add log messages to track boot flow errors and timeouts in SBL or AMSS
> firmware loading to aid in debug.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index cf6dc5a..80e4d76 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -121,7 +121,8 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  		ee = mhi_get_exec_env(mhi_cntrl);
>  	}
>  
> -	dev_dbg(dev, "Waiting for image download completion, current EE: %s\n",
> +	dev_dbg(dev,
> +		"Waiting for RDDM image download via BHIe, current EE:%s\n",
>  		TO_MHI_EXEC_STR(ee));
>  
>  	while (retry--) {
> @@ -152,11 +153,14 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
>  {
>  	void __iomem *base = mhi_cntrl->bhie;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 rx_status;
>  
>  	if (in_panic)
>  		return __mhi_download_rddm_in_panic(mhi_cntrl);
>  
> +	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
> +
>  	/* Wait for the image download to complete */
>  	wait_event_timeout(mhi_cntrl->state_event,
>  			   mhi_read_reg_field(mhi_cntrl, base,
> @@ -174,6 +178,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  			    const struct mhi_buf *mhi_buf)
>  {
>  	void __iomem *base = mhi_cntrl->bhie;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
>  	u32 tx_status, sequence_id;
>  	int ret;
> @@ -184,6 +189,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  		return -EIO;
>  	}
>  
> +	dev_dbg(dev, "Starting AMSS download via BHIe\n");
>  	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
>  		      upper_32_bits(mhi_buf->dma_addr));
>  
> @@ -435,7 +441,12 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  		release_firmware(firmware);
>  
>  	/* Error or in EDL mode, we're done */
> -	if (ret || mhi_cntrl->ee == MHI_EE_EDL)
> +	if (ret) {
> +		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
> +		return;
> +	}
> +
> +	if (mhi_cntrl->ee == MHI_EE_EDL)
>  		return;
>  
>  	write_lock_irq(&mhi_cntrl->pm_lock);
> @@ -463,8 +474,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	if (!mhi_cntrl->fbc_download)
>  		return;
>  
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "MHI did not enter READY state\n");
>  		goto error_read;
> +	}
>  
>  	/* Wait for the SBL event */
>  	ret = wait_event_timeout(mhi_cntrl->state_event,
> @@ -482,6 +495,8 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	ret = mhi_fw_load_amss(mhi_cntrl,
>  			       /* Vector table is the last entry */
>  			       &image_info->mhi_buf[image_info->entries - 1]);
> +	if (ret)
> +		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
>  
>  	release_firmware(firmware);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
