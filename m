Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AAF208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 15:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFuJOl88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGDPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGDPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 11:47:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70087C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 08:47:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so16417097pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbJGmL/GT/RryX9bJANqO+8burLO+M6iii1/sXcpL8Y=;
        b=aFuJOl88J5YF63X3Nc3Zmfg/OZKoB1k6qA4dmQ6pilrTcDmHp9MOAjcdZj1GhkLtJr
         7tDM3xJLxv58i8BE20/OSQgO0T1kAegEKWn+q6m5GRn/T2QQJYuBH5Qg4NJu8/WW4XzD
         DvQojXVv3/TIznFSPeA/6NcnnkwVfrtbrdkb4KgGENz5NTSvgt8koGac5YXJjIlx9PVT
         quFpdKi4F+a6Nqipat0JrAUqYnqwNQh0u7Cq3uxu6pPPYInONp+Osf+G2RfzjF2nxgkJ
         Wya8a4LK6psikVX5MMbBn+zO7mXgUA5NWYyYpZ4LFt67UGdkeJnbbOCqur7ddiW7V691
         CN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbJGmL/GT/RryX9bJANqO+8burLO+M6iii1/sXcpL8Y=;
        b=UfJ/I8uV/kNsl6ns1yekYErJtgON1QO2sSN8y5WQ6Ex5gVTABMZ7J1HJHhngwsImlH
         7VS8LktC6jbAsHv9hH1jCcjgHWHn5joDEHnW/HxQN4hy8RUieDULqLFU5h+GjFG4471Y
         eLZRBkNr8hLqpNjUy0aQGFB+nGKyIN6VQiCophhoA84ZH7+YXRSRT19ueuZ4EWHvy71S
         1jQxcfOBUjRBUGIAFJDCKtknUj+HhCJ4UqUE1ihJk4bYg4GxtZeKV9zfEv1rfkW2A4Dr
         uF2noViSh+Sohq2wDNaiQ3C1fgEcNOIBXgCdY9y5VnOAJTTjRYrf/4nH987E01yN38VV
         GcOg==
X-Gm-Message-State: AOAM532EeAExALPCSldJ361gNfT8tAn0ILVmBdgDGsZwrw8zB2LPKixi
        9XdDofLYe5MJ/lE2uABmMSx6IJ4sxA==
X-Google-Smtp-Source: ABdhPJwws+NSx7/B9LRulDiPh9acFGl8Y2Exd9qvt5YXjr/TgKIXVnvC2kFcmJn/2pn7IO6Wd8RhQA==
X-Received: by 2002:a63:5a1a:: with SMTP id o26mr33016259pgb.420.1593877672856;
        Sat, 04 Jul 2020 08:47:52 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:680:29c6:d74:dc5c:e13f:c458])
        by smtp.gmail.com with ESMTPSA id i196sm15044123pgc.55.2020.07.04.08.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 08:47:52 -0700 (PDT)
Date:   Sat, 4 Jul 2020 21:17:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] bus: mhi: core: Read and save device hardware
 information from BHI
Message-ID: <20200704154745.GH3066@Mani-XPS-13-9360>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
 <1593448782-8385-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593448782-8385-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:41AM -0700, Bhaumik Bhatt wrote:
> Device hardware specific information such as serial number and the OEM
> PK hash can be read using BHI and saved on host to identify the
> endpoint.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 17 ++++++++++++++++-
>  include/linux/mhi.h         |  6 ++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 0b38014..24422f5 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -392,13 +392,28 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	void *buf;
>  	dma_addr_t dma_addr;
>  	size_t size;
> -	int ret;
> +	int i, ret;
>  
>  	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>  		dev_err(dev, "Device MHI is not in valid state\n");
>  		return;
>  	}
>  
> +	/* save hardware info from BHI */
> +	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
> +			   &mhi_cntrl->serial_number);
> +	if (ret)
> +		dev_err(dev, "Could not capture serial number via BHI\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
> +				   &mhi_cntrl->oem_pk_hash[i]);
> +		if (ret) {
> +			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
> +			break;
> +		}
> +	}
> +
>  	/* If device is in pass through, do reset to ready state transition */
>  	if (mhi_cntrl->ee == MHI_EE_PTHRU)
>  		goto fw_load_ee_pthru;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index b1e8b4f..dad6246 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -16,6 +16,8 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> +#define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
> +
>  struct mhi_chan;
>  struct mhi_event;
>  struct mhi_ctxt;
> @@ -315,6 +317,8 @@ struct mhi_controller_config {
>   * @device_number: MHI controller device number
>   * @major_version: MHI controller major revision number
>   * @minor_version: MHI controller minor revision number
> + * @serial_number: MHI controller serial number obtained from BHI
> + * @oem_pk_hash: MHI controller OEM PK Hash obtained from BHI
>   * @mhi_event: MHI event ring configurations table
>   * @mhi_cmd: MHI command ring configurations table
>   * @mhi_ctxt: MHI device context, shared memory between host and device
> @@ -394,6 +398,8 @@ struct mhi_controller {
>  	u32 device_number;
>  	u32 major_version;
>  	u32 minor_version;
> +	u32 serial_number;
> +	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
>  
>  	struct mhi_event *mhi_event;
>  	struct mhi_cmd *mhi_cmd;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
