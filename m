Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687472087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxW9JQar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgIJNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgIJNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:12:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:12:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so6688235wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bq+U/roPoyR+PFGiWvFpI6j3vo6m28j+pYae81Oydrk=;
        b=LxW9JQardfe6ovRqT818t4MTPCbypCYUo6YFqdrT244gD5a1S0M2FecEI0fJMIgCzr
         Ar89gXm/TIGENRR2BL49FoHZo7vujerVPjd5M+e2s3HXP4Wo7+O2P4figtbf5/nmwDS/
         Q2R1sft6rUH2GuRa5ewLVT4dLProx4KzE35qEa4E6nG7xI6czJpWrd4mlBvx4KBv1Ccz
         A73yWuTvok4lQOj7F9He312DDKguKWTUTaFTwJ9WMRqZBv5IIXVbgFL3+SKSF4xaBQqF
         6f2aAKtqQ+uZhXhgjIwYfEadfGfIDAA1hYNVQFQSDpaEu0fH3OPF+Cxvx5kbZQoNIkpH
         Yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bq+U/roPoyR+PFGiWvFpI6j3vo6m28j+pYae81Oydrk=;
        b=Uci+QvLkMqfIUi+bwDyPoL0p8n3Ae5wXJP5bHkSDPw5siVL8vU57u91dOPLjmfQhBc
         AKJRv650UDf1j/uIG0HOSwHGuU6aBvPIXhP1Ylz448smvowHIUHHL+E1+9J1wUTG1fIZ
         lBnlCtrq24MqBGV8rlEjIug7vPvX3eO+nkYF2bRIcf17qAsXGvg79GW8mHGMv3FXcV+c
         5RF9YJk59mnV3quXZBVP9sl1TvMGESCPXS8krvcsBz6yQK+xFWC3E2tPiO3JZ2R0Hf6o
         iWQ0XJlHiYluyYgXVNbWucXOBrdGYV/q03SkVy00jutqUytzeuN6pzoQQtL6Miz2DXzX
         ObKA==
X-Gm-Message-State: AOAM532A968/F4Jykc6iF8Y3o1v7Y2c3agKfJhGm299uZvh3T+IVg79M
        3umaMhW2GlBXkvB75Cy4pjMJ4A==
X-Google-Smtp-Source: ABdhPJx2Dvf8nFJMefE2zEyQsiA8oS3cus97b9p96If1Q7HdqZx1B5j3NrbyrLIFhtzFYQ1R++dhWQ==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr8482460wru.323.1599743535091;
        Thu, 10 Sep 2020 06:12:15 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j14sm3301883wmj.19.2020.09.10.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:12:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 14:12:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Message-ID: <20200910131212.wm7zskxvcesl652c@holly.lan>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
 <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:21:45PM +0800, Chunfeng Yun wrote:
> Use readl_poll_timeout_atomic() to simplify code
> 
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  drivers/usb/host/xhci-rcar.c | 43 ++++++++++++-------------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index c1025d3..74f836f 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> @@ -127,8 +128,7 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
>  	void __iomem *regs = hcd->regs;
>  	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
>  	const struct firmware *fw;
> -	int retval, index, j, time;
> -	int timeout = 10000;
> +	int retval, index, j;
>  	u32 data, val, temp;
>  	u32 quirks = 0;
>  	const struct soc_device_attribute *attr;
> @@ -166,32 +166,19 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
>  		temp |= RCAR_USB3_DL_CTRL_FW_SET_DATA0;
>  		writel(temp, regs + RCAR_USB3_DL_CTRL);
>  
> -		for (time = 0; time < timeout; time++) {
> -			val = readl(regs + RCAR_USB3_DL_CTRL);
> -			if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) == 0)
> -				break;
> -			udelay(1);
> -		}
> -		if (time == timeout) {
> -			retval = -ETIMEDOUT;
> +		retval = readl_poll_timeout_atomic(regs + RCAR_USB3_DL_CTRL,
> +				val, !(val & RCAR_USB3_DL_CTRL_FW_SET_DATA0),
> +				1, 10000);
> +		if (retval < 0)
>  			break;
> -		}
>  	}
>  
>  	temp = readl(regs + RCAR_USB3_DL_CTRL);
>  	temp &= ~RCAR_USB3_DL_CTRL_ENABLE;
>  	writel(temp, regs + RCAR_USB3_DL_CTRL);
>  
> -	for (time = 0; time < timeout; time++) {
> -		val = readl(regs + RCAR_USB3_DL_CTRL);
> -		if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> -			retval = 0;
> -			break;
> -		}
> -		udelay(1);
> -	}
> -	if (time == timeout)
> -		retval = -ETIMEDOUT;
> +	retval = readl_poll_timeout_atomic((regs + RCAR_USB3_DL_CTRL),
> +			val, (val & RCAR_USB3_DL_CTRL_FW_SUCCESS), 1, 10000);

Directly assigning to retval at this point will clobber a previous
-ETIMEDOUT error.

In other words if there is a timeout waiting for FW_SET_DATA0, but not for
DW_SUCCESS, then we will return the wrong return value.


Daniel.


>  
>  	release_firmware(fw);
>  
> @@ -200,18 +187,12 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
>  
>  static bool xhci_rcar_wait_for_pll_active(struct usb_hcd *hcd)
>  {
> -	int timeout = 1000;
> +	int retval;
>  	u32 val, mask = RCAR_USB3_AXH_STA_PLL_ACTIVE_MASK;
>  
> -	while (timeout > 0) {
> -		val = readl(hcd->regs + RCAR_USB3_AXH_STA);
> -		if ((val & mask) == mask)
> -			return true;
> -		udelay(1);
> -		timeout--;
> -	}
> -
> -	return false;
> +	retval = readl_poll_timeout_atomic(hcd->regs + RCAR_USB3_AXH_STA,
> +			val, ((val & mask) == mask), 1, 1000);
> +	return !!retval;

This function returns a bool so !! is either wrong or redundant... I
think in this case it is wrong and should be a single ! .


Daniel.
